#!/bin/bash

$PYTHON -m pip install . --no-deps --no-build-isolation --ignore-installed --no-cache-dir -vvv

mkdir -p "${PREFIX}/Menu"
sed "s/__PKG_VERSION__/${PKG_VERSION}/" "${RECIPE_DIR}/menu.json" > "${PREFIX}/Menu/${PKG_NAME}_menu.json"
if [[ $(uname) == Darwin ]]; then
    ICON_EXT="icns"
else
    ICON_EXT="png"
fi
cp "${SRC_DIR}/spyder.${ICON_EXT}" "${PREFIX}/Menu/"

rm -rf $PREFIX/man
rm -f $PREFIX/bin/spyder_win_post_install.py
rm -rf $SP_DIR/Sphinx-*
