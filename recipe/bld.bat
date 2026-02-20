"%PYTHON%" -m pip install . --no-deps --no-build-isolation --ignore-installed --no-cache-dir -vvv
if errorlevel 1 exit 1

del "%SCRIPTS%\spyder_win_post_install.py"
del "%SCRIPTS%\spyder.bat"
del "%SCRIPTS%\spyder"

REM Prepare shortcuts. menuinst v2 shortcuts should only be used starting
REM at menuinst v2.1.1 due to bugs. The post-link script
REM will handle which shortcut to use. One file needs to be the default
REM menu file so that conda picks it up when running menuinst.
SET "MENU_DIR=%PREFIX%\Menu"
IF NOT EXIST "%MENU_DIR%" MKDIR "%MENU_DIR%"
if errorlevel 1 exit 1
copy "%RECIPE_DIR%\menu-v1.json" "%MENU_DIR%\%PKG_NAME%_menu-v1.json.bak"
if errorlevel 1 exit 1
copy "%RECIPE_DIR%\menu-v3.json" "%MENU_DIR%\%PKG_NAME%_menu-v3.json.bak"
if errorlevel 1 exit 1
copy "%RECIPE_DIR%\menu-v3.json" "%MENU_DIR%\%PKG_NAME%_menu.json"
if errorlevel 1 exit 1
copy "%SRC_DIR%\img_src\spyder.ico" "%MENU_DIR%\spyder.ico"
if errorlevel 1 exit 1
