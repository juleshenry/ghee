#!/bin/bash
# Reads from stdin and logs to a timestamped file
cat - | tee "log_$(date +%Y-%m-%d_%H-%M-%S).txt"
