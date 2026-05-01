#!/bin/bash
# ============================================================================
# Module: Redis
# Description: Ghee shortcuts and utilities for Redis.
# ============================================================================

# Redis

_GG_REGISTRY["rd"]="redis-cli ||| Redis CLI"]
_GG_REGISTRY["rdping"]="redis-cli ping ||| Ping Redis server"]
_GG_REGISTRY["rdinfo"]="redis-cli info ||| Redis server info"]
_GG_REGISTRY["rdmon"]="redis-cli monitor ||| Monitor Redis commands in real-time"]
_GG_REGISTRY["rdkeys"]="redis-cli keys '*' ||| List all Redis keys"]
_GG_REGISTRY["rdget"]="redis-cli get KEY ||| Get a Redis key value"]
_GG_REGISTRY["rdset"]="redis-cli set KEY VAL ||| Set a Redis key"]
_GG_REGISTRY["rddel"]="redis-cli del KEY ||| Delete a Redis key"]
_GG_REGISTRY["rdflush"]="redis-cli flushdb ||| Flush current Redis DB"]
_GG_REGISTRY["rdflushall"]="redis-cli flushall ||| Flush all Redis DBs"]
_GG_REGISTRY["rdsize"]="redis-cli dbsize ||| Show Redis DB key count"]
_GG_REGISTRY["rdshut"]="redis-cli shutdown ||| Shutdown Redis server"]

# 281. Redis CLI
alias rd='redis-cli'

# 282. Redis ping
alias rdping='redis-cli ping'

# 283. Redis info
alias rdinfo='redis-cli info'

# 284. Redis monitor
alias rdmon='redis-cli monitor'

# 285. Redis all keys
alias rdkeys='redis-cli keys "*"'

# 286. Redis get
alias rdget='redis-cli get'

# 287. Redis set
alias rdset='redis-cli set'

# 288. Redis delete
alias rddel='redis-cli del'

# 289. Redis flush current db
alias rdflush='redis-cli flushdb'

# 290. Redis flush all
alias rdflushall='redis-cli flushall'

# 291. Redis db size
alias rdsize='redis-cli dbsize'

# 292. Redis server shutdown
alias rdshut='redis-cli shutdown'

