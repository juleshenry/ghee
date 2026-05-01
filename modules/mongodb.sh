#!/bin/bash
# ============================================================================
# Module: Mongodb
# Description: Ghee shortcuts and utilities for Mongodb.
# ============================================================================

# MongoDB & Mongoose CLI Tools

_GG_REGISTRY["mongosh"]="mongosh ||| Launch MongoDB shell"
_GG_REGISTRY["mstart"]="brew services start mongodb-community ||| Start MongoDB (macOS Homebrew)"
_GG_REGISTRY["mstop"]="brew services stop mongodb-community ||| Stop MongoDB (macOS Homebrew)"
_GG_REGISTRY["mrestart"]="brew services restart mongodb-community ||| Restart MongoDB"
_GG_REGISTRY["mdump"]="mongodump --db DB --out ./dump ||| Dump a MongoDB database"
_GG_REGISTRY["mrestore"]="mongorestore --db DB ./dump/DB ||| Restore a MongoDB database"
_GG_REGISTRY["mexport"]="mongoexport --db DB --collection COL --out file.json ||| Export collection to JSON"
_GG_REGISTRY["mimport"]="mongoimport --db DB --collection COL --file file.json ||| Import JSON into collection"

alias mongosh='mongosh'
alias mstart='brew services start mongodb-community'
alias mstop='brew services stop mongodb-community'
alias mrestart='brew services restart mongodb-community'

mdump() {
    local db="${1:-test}"
    mongodump --db "$db" --out ./dump
    echo "Dumped $db to ./dump"
}

mrestore() {
    if [ -z "$1" ]; then echo "Usage: mrestore <db_name> [dump_path]"; return 1; fi
    mongorestore --db "$1" "${2:-./dump/$1}"
}

mexport() {
    if [ -z "$2" ]; then echo "Usage: mexport <db> <collection> [out.json]"; return 1; fi
    mongoexport --db "$1" --collection "$2" --out "${3:-$2.json}"
    echo "Exported $1.$2 -> ${3:-$2.json}"
}

mimport() {
    if [ -z "$2" ]; then echo "Usage: mimport <db> <collection> <file.json>"; return 1; fi
    mongoimport --db "$1" --collection "$2" --file "${3:-$2.json}" --jsonArray
}
