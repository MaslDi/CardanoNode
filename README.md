# CardanoNode
Create Node, integrate mnemoric phrases (wallets) and send transactions

Minimal Cardano node requirements:
16 GB Memory / 50 GB Disk

If used less memory for the node it gets killed.



## Install dependencies
We need the following packages and tools on our Linux system to download the source code and build it:
- the version control system git,
- the gcc C-compiler,
- C++ support for gcc,
- developer libraries for the arbitrary precision library gmp,
- developer libraries for the compression library zlib,
- developer libraries for systemd,
- developer libraries for ncurses,
- ncurses compatibility libraries,
- the Haskell build tool cabal,
- the GHC Haskell compiler.

For Debian/Ubuntu use the following instead:
sudo apt-get update -y
sudo apt-get install build-essential pkg-config libffi-dev libgmp-dev -y
sudo apt-get install libssl-dev libtinfo-dev libsystemd-dev zlib1g-dev -y
sudo apt-get install make g++ tmux git jq wget libncursesw5 libtool autoconf -y


Download, unpack, install and update Cabal:
wget https://downloads.haskell.org/~cabal/cabal-install-3.2.0.0/cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz
tar -xf cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz
rm cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz cabal.sig
mkdir -p ~/.local/bin
mv cabal ~/.local/bin/

Verify that .local/bin is in your PATH

echo $PATH

If .local/bin is not in the PATH, you need to add the following line to your .bashrcfile
Navigate to your home folder:

cd

Open your .bashrc file with nano text editor

nano .bashrc

Go to the bottom of the file and add the following lines

export PATH="~/.local/bin:$PATH"

You need to restart your server or source your .bashrc file

source .bashrc
Update cabal
cabal update

Above instructions install Cabal version 3.2.0.0. You can check the version by typing

cabal --version


Download and install GHC: For Debian/Ubuntu systems:

wget https://downloads.haskell.org/~ghc/8.10.2/ghc-8.10.2-x86_64-deb9-linux.tar.xz
tar -xf ghc-8.10.2-x86_64-deb9-linux.tar.xz
rm ghc-8.10.2-x86_64-deb9-linux.tar.xz
cd ghc-8.10.2
./configure
sudo make install
cd ..

You can check that your default GHC version has been properly set:

ghc --version


Install Libsodium

export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"

git clone https://github.com/input-output-hk/libsodium
cd libsodium
git checkout 66f017f1
./autogen.sh
./configure
make
sudo make install

Add the following to your .bashrc file and source it.

export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"


Download the source code for cardano-node

cd
git clone https://github.com/input-output-hk/cardano-node.git

This creates the folder cardano-node and downloads the latest source code.
After the download has finished, we can check its content by

ls cardano-node

We change our working directory to the downloaded source code folder:

cd cardano-node

For reproducible builds, we should check out a specific release, a specific "tag". For the Mary Testnet, we will use tag 1.25.1, which we can check out as follows:

git fetch --all --tags
git tag
git checkout tags/1.25.1



Build and install the node
Now we build and install the node with cabal, which will take a few minutes the first time you do a build. Later builds will be much faster, because everything that does not change will be cached.

cabal clean
cabal update
cabal build all

Now we can copy the executables files to the .local/bin directory

cp -p dist-newstyle/build/x86_64-linux/ghc-8.10.2/cardano-node-1.25.1/x/cardano-node/build/cardano-node/cardano-node ~/.local/bin/
cp -p dist-newstyle/build/x86_64-linux/ghc-8.10.2/cardano-cli-1.25.1/x/cardano-cli/build/cardano-cli/cardano-cli ~/.local/bin/
cardano-cli --version

If you need to update to a newer version follow the steps below:

cd cardano-node
git fetch --all --tags
git tag
git checkout tags/<the-tag-you-want>
cabal update
cabal build cardano-node cardano-cli

Note: This is a good time to backup your current binaries (in case you have to revert to an earlier version). Something like this will work:

cd ~/.local/bin
mv cardano-cli cardano-cli-backup
mv cardano-node cardano-node-backup

Now copy your newly built binaries to the appropriate directory, with:

cp -p dist-newstyle/build/x86_64-linux/ghc-8.10.2/cardano-node-<NEW VERSION>/x/cardano-node/build/cardano-node/cardano-node ~/.local/bin/
cp -p dist-newstyle/build/x86_64-linux/ghc-8.10.2/cardano-cli-<NEW VERSION>/x/cardano-cli/build/cardano-cli/cardano-cli ~/.local/bin/

  
  
## Get configuration files
WARNING
In this course we use the CARDANO TESTNET, so let's get the configuration files for it.
DO NOT USE MAINNET DURING THIS COURSE. **
Starting the node and connecting it to the testnet requires 4 configuration files:
topology.json
BYRON genesis.json
SHELLEY genesis.json
config.json
In your home directory, create a new directory for the configuration files:
cd
mkdir relay
cd relay
Now download the latest testnet configuration files:
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/testnet-config.json
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/testnet-shelley-genesis.json
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/testnet-byron-genesis.json
wget https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/testnet-topology.json 
  
  




















