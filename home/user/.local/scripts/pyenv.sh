#!/usr/local/bin/bash

read -p "Enter Name Of Your Project: " NAME

PROJDIR="$HOME/.local/src/$NAME"
ENVDIR="$HOME/.local/lib/pyenvs/$NAME"

if [ ! -d "$ENVDIR" ]; then
	echo "Creating Your Project..."
	mkdir -p "$PROJDIR"
	touch "$PROJDIR/main.py"
	python3.7 -m venv "$ENVDIR" 2>&1 >/dev/null
fi

.  "$ENVDIR"/bin/activate
cd "$PROJDIR"
#clear
