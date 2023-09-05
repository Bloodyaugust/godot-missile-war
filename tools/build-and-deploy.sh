#!/bin/sh

# set -e

which butler

echo "Checking application versions..."
echo "-----------------------------"
cat ~/.local/share/godot/templates/4.0-rc2/version.txt
godot --version
butler -V
echo "-----------------------------"

mkdir build/
mkdir build/linux/
mkdir build/osx/
mkdir build/win/

echo "EXPORTING FOR LINUX"
echo "-----------------------------"
godot --headless --export-debug "Linux/X11" build/linux/missile-war-4.x86_64 -v
# echo "EXPORTING FOR OSX"
# echo "-----------------------------"
# godot --export "Mac OSX" build/osx/missile-war-4.dmg -v
echo "EXPORTING FOR WINDOZE"
echo "-----------------------------"
godot --headless --export-debug "Windows Desktop" build/win/missile-war-4.exe -v
echo "-----------------------------"

# echo "CHANGING FILETYPE AND CHMOD EXECUTABLE FOR OSX"
# echo "-----------------------------"
# cd build/osx/
# mv missile-war-4.dmg missile-war-4-osx-alpha.zip
# unzip missile-war-4-osx-alpha.zip
# rm missile-war-4-osx-alpha.zip
# chmod +x missile-war-4.app/Contents/MacOS/missile-war-4
# zip -r missile-war-4-osx-alpha.zip missile-war-4.app
# rm -rf missile-war-4.app
# cd ../../

ls -al
ls -al build/
ls -al build/linux/
ls -al build/osx/
ls -al build/win/

echo "ZIPPING FOR WINDOZE"
echo "-----------------------------"
cd build/win/
zip -r missile-war-4-win-alpha.zip missile-war-4.exe missile-war-4.pck
rm -r missile-war-4.exe missile-war-4.pck
cd ../../

echo "ZIPPING FOR LINUX"
echo "-----------------------------"
cd build/linux/
zip -r missile-war-4-linux-alpha.zip missile-war-4.x86_64 missile-war-4.pck
rm -r missile-war-4.x86_64 missile-war-4.pck
cd ../../

echo "Logging in to Butler"
echo "-----------------------------"
butler login

echo "Pushing builds with Butler"
echo "-----------------------------"
butler push build/linux/ synsugarstudio/missile-war:linux-alpha
# butler push build/osx/ synsugarstudio/missile-war:osx-alpha
butler push build/win/ synsugarstudio/missile-war:win-alpha
