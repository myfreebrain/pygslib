@echo off
REM build_package.cmd - 一键构建 + 打包脚本 for Windows CMD

echo Cleaning previous build artifacts...
rmdir /s /q build
rmdir /s /q dist
rmdir /s /q .mesonpy-*
for /d %%i in (*.egg-info) do rmdir /s /q "%%i"

echo Installing required Python build tools...
pip install --upgrade pip
pip install meson meson-python ninja cython numpy setuptools wheel

rem meson setup .. --native-file=../native.ini -Dbuildtype=release

echo Configuring Meson project...
meson setup build --native-file=native.ini -Dbuildtype=release --reconfigure
IF %ERRORLEVEL% NEQ 0 (
    echo Meson setup failed
    exit /b 1
)

echo Compiling with Meson...
meson compile -C build
IF %ERRORLEVEL% NEQ 0 (
    echo Meson compile failed
    exit /b 1
)

echo Building Python package...
python -m build
IF %ERRORLEVEL% NEQ 0 (
    echo Python build failed
    exit /b 1
)

echo.
echo ✅ Build completed successfully. See output in 'dist' directory.
