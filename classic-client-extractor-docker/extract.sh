#!/bin/bash

cd /opt

# Cloning repos
git clone git://github.com/cmangos/mangos-classic.git mangos

# Creating build and run folders
mkdir build
mkdir run

# Compiling
cd /opt/build

# For some reason the extractors won't compile without building the game server...
cmake ../mangos -DCMAKE_INSTALL_PREFIX=\../run -DBUILD_EXTRACTORS=ON -DBUILD_GAME_SERVER=ON -DBUILD_LOGIN_SERVER=ON
make
make install

# Copying everything where they needs to be
cp /opt/run/bin/tools/* /opt/
cp /opt/mangos/contrib/extractor_scripts/* /opt/

# replace read line to be able to use the script automatically
sed -i s/read\ line/line=2/g /opt/ExtractResources.sh

chmod +x /opt/ExtractResources.sh
chmod +x /opt/MoveMapGen.sh

cd /opt
./ExtractResources.sh a
if [ $? != 0 ]; then echo "Extraction failed..."; done

mv vmaps output/
mv mmaps output/
mv maps  output/
mv dbc   output/

echo "Done!"
