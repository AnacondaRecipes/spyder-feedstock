%PYTHON% -m pip install . --no-deps --no-build-isolation --ignore-installed --no-cache-dir -vvv
if errorlevel 1 exit 1

REM Prepare shortcuts. The menuinst v2 json files are not compatible
REM with menuinst versions older than 2.1.0. The post-link script
REM will handle which shortcut to use. One file needs to be the default
REM menu file so that conda picks it up when running menuinst.
REM This can be deprecated once supported installers have newer menuinst versions.
set MENU_DIR=%PREFIX%\Menu
IF NOT EXIST (%MENU_DIR%) mkdir %MENU_DIR%
copy %RECIPE_DIR%\spyder.ico %MENU_DIR%\
if errorlevel 1 exit 1
copy %RECIPE_DIR%\menu-v1.json %PREFIX%\Menu\%PKG_NAME%_menu-v1.json.bak
copy %RECIPE_DIR%\menu-v2.json %PREFIX%\Menu\%PKG_NAME%_menu-v2.json.bak
copy %RECIPE_DIR%\menu-v2.json %PREFIX%\Menu\%PKG_NAME%_menu.json
if errorlevel 1 exit 1

del %SCRIPTS%\spyder_win_post_install.py
del %SCRIPTS%\spyder.bat
del %SCRIPTS%\spyder
