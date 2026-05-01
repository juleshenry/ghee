#!/bin/bash
# ============================================================================
# Module: Postgresql
# Description: Ghee shortcuts and utilities for Postgresql.
# ============================================================================

# PostgreSQL

_GG_REGISTRY["pg"]="psql ||| PostgreSQL CLI"]
_GG_REGISTRY["pgsu"]="sudo -u postgres psql ||| psql as postgres superuser"]
_GG_REGISTRY["pgls"]="psql -l ||| List PostgreSQL databases"]
_GG_REGISTRY["pgdb"]="psql -d DB [-U user] ||| Connect to a database"]
_GG_REGISTRY["pgdump"]="pg_dump DATABASE ||| Dump a database"]
_GG_REGISTRY["pgrestore"]="pg_restore FILE ||| Restore a database dump"]
_GG_REGISTRY["pgcreate"]="createdb DATABASE ||| Create a database"]
_GG_REGISTRY["pgdrop"]="dropdb DATABASE ||| Drop a database"]
_GG_REGISTRY["pgroles"]="psql -c '\\du' ||| List PostgreSQL roles"]
_GG_REGISTRY["pgconn"]="SELECT from pg_stat_activity ||| Show active connections"]
_GG_REGISTRY["pgsize"]="SELECT relname, pg_size_pretty(...) ||| Show table sizes"]
_GG_REGISTRY["pgrunning"]="SELECT from pg_stat_activity WHERE active ||| Show running queries"]
_GG_REGISTRY["pgvacuum"]="VACUUM FULL ||| Run full vacuum"]
_GG_REGISTRY["pgstatus"]="systemctl status postgresql ||| PostgreSQL service status"]
_GG_REGISTRY["pgver"]="psql --version ||| PostgreSQL version"]

# 293. psql shortcut
alias pg='psql'

# 294. psql as postgres user
alias pgsu='sudo -u postgres psql'

# 295. List databases
alias pgls='psql -l'

# 296. Connect to database
pgdb() {
    if [ -z "$1" ]; then
        echo "Usage: pgdb <database> [user]"
        return 1
    fi
    psql -d "$1" ${2:+-U "$2"}
}

# 297. pg_dump a database
alias pgdump='pg_dump'

# 298. pg_restore
alias pgrestore='pg_restore'

# 299. Create database
alias pgcreate='createdb'

# 300. Drop database
alias pgdrop='dropdb'

# 301. List roles
alias pgroles='psql -c "\\du"'

# 302. Show connections
alias pgconn='psql -c "SELECT pid, usename, datname, state FROM pg_stat_activity;"'

# 303. Show table sizes
alias pgsize='psql -c "SELECT relname, pg_size_pretty(pg_total_relation_size(relid)) FROM pg_catalog.pg_statio_user_tables ORDER BY pg_total_relation_size(relid) DESC;"'

# 304. Show running queries
alias pgrunning='psql -c "SELECT pid, now()-pg_stat_activity.query_start AS duration, query FROM pg_stat_activity WHERE state = '\''active'\'' ORDER BY duration DESC;"'

# 305. Vacuum full
alias pgvacuum='psql -c "VACUUM FULL;"'

# 306. PostgreSQL service status (Linux)
alias pgstatus='sudo systemctl status postgresql 2>/dev/null || brew services info postgresql 2>/dev/null'

# 307. PostgreSQL version
alias pgver='psql --version'

