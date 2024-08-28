#!/bin/bash

# Shortcuts are only supported starting at menuinst v2.1.1
# Copying the v1 file won't create shortcuts, but conda expects
# there to be a menu file.

# Determine menuinst version.
if [[ -z "${CONDA_PYTHON_EXE}" ]]; then
    # menuinst in the base environment is used to create the shortcuts,
    # so use the python binary in the base environment.
    PYTHON_CMD="${CONDA_PYTHON_EXE}"
elif [[ -f "${PREFIX}/_conda" ]]; then
    # The CONDA_PYTHON_EXE variable is not set for installers, so use conda-standalone.
    PYTHON_CMD="${PREFIX}/_conda python"
else
    cp "${MENU_DIR}/${PKG_NAME}_menu-v1.json.bak" "${MENU_DIR}/${PKG_NAME}_menu.json"
    exit 0
fi

MENU_DIR="${PREFIX}/Menu"
USE_V1=$(${PYTHON_CMD} -c 'import menuinst; print(tuple(int(x) for x in menuinst.__version__.split("."))[:3] < (2, 1, 1))')
if [[ "${USE_V1}" == "True" ]]; then
    cp "${MENU_DIR}/${PKG_NAME}_menu-v1.json.bak" "${MENU_DIR}/${PKG_NAME}_menu.json"
    cat <<EOF >> ${PREFIX}/.messages.txt
Shortcuts are now supported using menuinst 2.1.1 or newer.
Please update menuinst in the base environment and reinstall ${PKG_NAME}.
EOF
else
    # Determine if the shortcut is installed into the base environment
    IS_BASE=$(${PYTHON_CMD} -c "import os, sys; from pathlib import Path; from menuinst.utils import _default_prefix; print(Path(os.environ['PREFIX']).samefile(_default_prefix(which='base')))")
    if [[ "${IS_BASE}" == "True" ]]; then
        replace=""
    else
        replace=" ({{ENV_NAME}})"
    fi
    sed "s/__ENV_PLACEHOLDER__/${replace}/" "${MENU_DIR}/${PKG_NAME}_menu-v2.json.bak" > "${MENU_DIR}/${PKG_NAME}_menu.json"
fi
