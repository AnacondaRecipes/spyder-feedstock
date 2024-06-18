#!/bin/bash

# The menuinst v2 json file is not compatible with menuinst versions
# older than 2.1.0. Copy the appropriate file as the menu file.

MENU_DIR="${PREFIX}/Menu"
USE_V1=$(${CONDA_PYTHON_EXE} -c 'import menuinst; print(tuple(int(x) for x in menuinst.__version__.split("."))[:3] < (2, 1, 0))')
if [[ "${USE_V1}" == "True" ]]; then
    cp "${MENU_DIR}/${PKG_NAME}_menu-v1.json.bak" "${MENU_DIR}/${PKG_NAME}_menu.json"
    cat <<EOF >> ${PREFIX}/.messages.txt
Shortcuts are now supported using menuinst 2.1.0 or newer.
Please update menuinst in the base environment and reinstall ${PKG_NAME}.
EOF
else
    cp "${MENU_DIR}/${PKG_NAME}_menu-v2.json.bak" "${MENU_DIR}/${PKG_NAME}_menu.json"
fi
