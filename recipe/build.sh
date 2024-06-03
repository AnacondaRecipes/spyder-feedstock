#!/bin/bash

$PYTHON -m pip install . --no-deps --no-build-isolation --ignore-installed --no-cache-dir -vvv

MENU_DIR="${PREFIX}/Menu"
mkdir -p "${MENU_DIR}"
sed "s/__PKG_VERSION__/${PKG_VERSION}/" "${RECIPE_DIR}/menu-v2.json" > "${MENU_DIR}/${PKG_NAME}_menu.json"
cp "${MENU_DIR}/${PKG_NAME}_menu.json" "${MENU_DIR}/${PKG_NAME}_menu-v2.json.bak"
cp "${RECIPE_DIR}/menu-v1.json" "${MENU_DIR}/${PKG_NAME}_menu-v1.json.bak"
if [[ $(uname) == Darwin ]]; then
    ICON_EXT="icns"
else
    ICON_EXT="png"
fi
cp "${RECIPE_DIR}/spyder.${ICON_EXT}" "${MENU_DIR}/"

rm -rf $PREFIX/man
rm -f $PREFIX/bin/spyder_win_post_install.py
rm -rf $SP_DIR/Sphinx-*
