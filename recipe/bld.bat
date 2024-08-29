%PYTHON% -m pip install . --no-deps --no-build-isolation --ignore-installed --no-cache-dir -vvv
if errorlevel 1 exit 1

del %SCRIPTS%\spyder_win_post_install.py
del %SCRIPTS%\spyder.bat
del %SCRIPTS%\spyder

REM Prepare shortcuts. menuinst v2 shortcuts should only be used startings
REM at menuinst v2.1.1 due to bugs. The post-link script
REM will handle which shortcut to use. One file needs to be the default
REM menu file so that conda picks it up when running menuinst.
IF NOT EXIST %PREFIX%\Menu mkdir %PREFIX%\Menu
copy %RECIPE_DIR%\menu-v1.json %PREFIX%\Menu\%PKG_NAME%_menu-v1.json.bak
copy %RECIPE_DIR%\menu-v2.json %PREFIX%\Menu\%PKG_NAME%_menu-v2.json.bak
copy %RECIPE_DIR%\menu-v2.json %PREFIX%\Menu\%PKG_NAME%_menu.json
copy %SRC_DIR%\img_src\spyder.ico %MENU_DIR%\
