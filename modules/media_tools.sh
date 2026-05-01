#!/bin/bash
# ============================================================================
# Module: Media Tools
# Description: Ghee shortcuts and utilities for Media Tools.
# ============================================================================

# Media & Image Tools (ffmpeg, imagemagick, yt-dlp)

_GG_REGISTRY["ytdl"]="yt-dlp URL ||| Download a YouTube video (best quality)"
_GG_REGISTRY["ytmp3"]="yt-dlp -x --audio-format mp3 URL ||| Download YouTube video as MP3"
_GG_REGISTRY["ytpl"]="yt-dlp -i URL ||| Download entire YouTube playlist"
_GG_REGISTRY["ffconv"]="ffmpeg -i INPUT OUTPUT ||| Convert video with ffmpeg"
_GG_REGISTRY["ff2mp4"]="ffmpeg -i INPUT -c:v libx264 output.mp4 ||| Convert any video to H.264 mp4"
_GG_REGISTRY["fftrim"]="ffmpeg -i INPUT -ss START -to END -c copy OUTPUT ||| Trim video by time range"
_GG_REGISTRY["ffcomp"]="ffmpeg -i INPUT -crf 28 -preset fast OUTPUT.mp4 ||| Compress video (CRF 28)"
_GG_REGISTRY["ffvid2gif"]="ffmpeg -i INPUT -vf scale=480:-1 OUTPUT.gif ||| Convert video to GIF"
_GG_REGISTRY["ffaudio"]="ffmpeg -i INPUT -vn -q:a 0 OUTPUT.mp3 ||| Extract audio from video"
_GG_REGISTRY["imgres"]="convert INPUT -resize WxH OUTPUT ||| Resize image with ImageMagick"
_GG_REGISTRY["imgstrip"]="convert INPUT -strip OUTPUT ||| Strip EXIF metadata from image"
_GG_REGISTRY["imgnorm"]="mogrify -auto-orient -strip FOLDER/*.jpg ||| Normalize images in folder"

# 410. Download YouTube video (best quality)
ytdl() {
    if [ -z "$1" ]; then echo "Usage: ytdl <URL>"; return 1; fi
    yt-dlp -f "bestvideo+bestaudio/best" "$1"
}

# 411. Download YouTube as MP3
ytmp3() {
    if [ -z "$1" ]; then echo "Usage: ytmp3 <URL>"; return 1; fi
    yt-dlp -x --audio-format mp3 --audio-quality 0 "$1"
}

# 412. Download full YouTube playlist
ytpl() {
    if [ -z "$1" ]; then echo "Usage: ytpl <playlist_URL>"; return 1; fi
    yt-dlp -i -o "%(playlist_index)s - %(title)s.%(ext)s" "$1"
}

# 413. Quick ffmpeg convert
ffconv() {
    if [ -z "$2" ]; then echo "Usage: ffconv <input> <output>"; return 1; fi
    ffmpeg -i "$1" "$2"
}

# 414. Convert any video to H.264 mp4
ff2mp4() {
    if [ -z "$1" ]; then echo "Usage: ff2mp4 <input>"; return 1; fi
    local out="${1%.*}.mp4"
    ffmpeg -i "$1" -c:v libx264 -c:a aac "$out"
    echo "Output: $out"
}

# 415. Trim video by time range
fftrim() {
    if [ -z "$3" ]; then echo "Usage: fftrim <input> <start> <end> (HH:MM:SS)"; return 1; fi
    local out="${1%.*}_trimmed.${1##*.}"
    ffmpeg -i "$1" -ss "$2" -to "$3" -c copy "$out"
    echo "Output: $out"
}

# 416. Compress video
ffcomp() {
    if [ -z "$1" ]; then echo "Usage: ffcomp <input> [crf=28]"; return 1; fi
    local crf="${2:-28}"
    local out="${1%.*}_compressed.mp4"
    ffmpeg -i "$1" -c:v libx264 -crf "$crf" -preset fast "$out"
    echo "Output: $out"
}

# 417. Convert video to GIF
ffvid2gif() {
    if [ -z "$1" ]; then echo "Usage: ffvid2gif <input> [width=480]"; return 1; fi
    local w="${2:-480}"
    local out="${1%.*}.gif"
    ffmpeg -i "$1" -vf "fps=15,scale=$w:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" "$out"
    echo "Output: $out"
}

# 418. Extract audio from video
ffaudio() {
    if [ -z "$1" ]; then echo "Usage: ffaudio <input>"; return 1; fi
    local out="${1%.*}.mp3"
    ffmpeg -i "$1" -vn -q:a 0 "$out"
    echo "Output: $out"
}

# 419. Resize image (requires ImageMagick)
imgres() {
    if [ -z "$2" ]; then echo "Usage: imgres <input> <WxH> [output]"; return 1; fi
    local out="${3:-${1%.*}_resized.${1##*.}}"
    convert "$1" -resize "$2" "$out"
}

# 420. Strip EXIF metadata from image
imgstrip() {
    if [ -z "$1" ]; then echo "Usage: imgstrip <image>"; return 1; fi
    convert "$1" -strip "${1%.*}_stripped.${1##*.}"
}

# 421. Normalize all jpgs in folder
alias imgnorm='mogrify -auto-orient -strip'
