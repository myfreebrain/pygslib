# build_package.ps1 - 一键构建 + 打包脚本 for PowerShell

Write-Host "Cleaning previous build artifacts..."
Remove-Item -Recurse -Force build, dist, *.egg-info, .mesonpy-* -ErrorAction SilentlyContinue

Write-Host "Installing required Python build tools..."
pip install --upgrade pip
pip install meson meson-python ninja cython numpy setuptools wheel

Write-Host "Configuring Meson project..."
meson setup build --reconfigure
if ($LASTEXITCODE -ne 0) {
    Write-Error "Meson setup failed"
    exit 1
}

Write-Host "Compiling with Meson..."
meson compile -C build
if ($LASTEXITCODE -ne 0) {
    Write-Error "Meson compile failed"
    exit 1
}

Write-Host "Building Python wheel and source distribution..."
python -m build
if ($LASTEXITCODE -ne 0) {
    Write-Error "Python build failed"
    exit 1
}

Write-Host "`n✅ Build completed successfully. Find your packages in the 'dist' folder."
