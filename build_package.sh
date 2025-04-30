#!/bin/bash

# Step 1: Clean previous builds
echo "Cleaning previous builds..."
rm -rf build dist pygslib.egg-info .mesonpy-* __pycache__ *.egg-info

# Step 2: Ensure virtual environment is activated (optional)
echo "Using Python from: $(which python)"

# Step 3: Install required build tools
echo "Installing build dependencies..."
pip install --upgrade pip
pip install meson meson-python ninja cython numpy setuptools wheel

# Step 4: Configure Meson project
echo "Configuring Meson project..."
meson setup build --reconfigure || { echo "Meson setup failed"; exit 1; }

# Step 5: Compile the extensions
echo "Compiling with Meson..."
meson compile -C build || { echo "Meson compile failed"; exit 1; }

# Step 6: Build the Python package (wheel + sdist)
echo "Building Python package..."
python -m build || { echo "Python build failed"; exit 1; }

echo "✅ Build and packaging complete. Find your package in the 'dist/' directory."
