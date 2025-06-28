#!/bin/bash
set -euo pipefail

git ls-files | entr -prc ./init.sh
