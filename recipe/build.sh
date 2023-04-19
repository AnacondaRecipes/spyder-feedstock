#!/bin/bash

$PYTHON -m pip install . --no-deps --no-build-isolation --ignore-installed --no-cache-dir -vvv

rm -rf $PREFIX/man
rm -f $PREFIX/bin/spyder_win_post_install.py
rm -rf $SP_DIR/Sphinx-*
