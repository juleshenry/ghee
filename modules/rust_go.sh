#!/bin/bash
# ============================================================================
# Module: Rust Go
# Description: Ghee shortcuts and utilities for Rust Go.
# ============================================================================

# Rust & Go Developer Tools

_GG_REGISTRY["cb"]="cargo build ||| Build Rust project"
_GG_REGISTRY["cbr"]="cargo build --release ||| Build Rust project in release mode"
_GG_REGISTRY["cr"]="cargo run ||| Build and run Rust project"
_GG_REGISTRY["ct"]="cargo test ||| Run Rust tests"
_GG_REGISTRY["ccheck"]="cargo check ||| Fast syntax/type check (no compile)"
_GG_REGISTRY["cclippy"]="cargo clippy ||| Run Rust linter (clippy)"
_GG_REGISTRY["cfmt"]="cargo fmt ||| Format Rust code"
_GG_REGISTRY["cadd"]="cargo add CRATE ||| Add a Rust crate dependency"
_GG_REGISTRY["gbuild"]="go build ./...|||Build Go project"
_GG_REGISTRY["grun"]="go run .|||Run Go main package"
_GG_REGISTRY["gotst"]="go test ./...|||Run all Go tests"
_GG_REGISTRY["gvet"]="go vet ./...|||Run Go static analysis"
_GG_REGISTRY["gmod"]="go mod tidy|||Tidy Go module dependencies"
_GG_REGISTRY["gofm"]="gofmt -w .|||Format all Go files"
_GG_REGISTRY["gget"]="go get PACKAGE ||| Install a Go package"

# Rust
alias cb='cargo build'
alias cbr='cargo build --release'
alias cr='cargo run'
alias ct='cargo test'
alias ccheck='cargo check'
alias cclippy='cargo clippy'
alias cfmt='cargo fmt'
alias cclean='cargo clean'
alias cadd='cargo add'
alias cupd='cargo update'
alias cdoc='cargo doc --open'

# Go
alias gbuild='go build ./...'
alias grun='go run .'
alias gtest='go test ./...'
alias gtestv='go test -v ./...'
alias gvet='go vet ./...'
alias gmod='go mod tidy'
alias gfmt='gofmt -w .'
alias gget='go get'
alias ginstall='go install'
alias glint='golangci-lint run'
