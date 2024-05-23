%PYTHON% -m pip install . --no-deps --no-build-isolation --ignore-installed --no-cache-dir -vvv
if errorlevel 1 exit 1

set MENU_DIR=%PREFIX%\Menu
IF NOT EXIST (%MENU_DIR%) mkdir %MENU_DIR%

copy %RECIPE_DIR%\spyder.ico %MENU_DIR%\
if errorlevel 1 exit 1
copy %RECIPE_DIR%\menu.json %MENU_DIR%\%PKG_NAME%_menu.json
if errorlevel 1 exit 1

del %SCRIPTS%\spyder_win_post_install.py
del %SCRIPTS%\spyder.bat
del %SCRIPTS%\spyder
