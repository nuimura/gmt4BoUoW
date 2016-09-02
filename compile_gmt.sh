#/bin/bash


GMT_VERSION=5.2.1
GSHHG_VERSION=2.3.6

GSHHG_ROOT=/home/$USER/gshhg-gmt-${GSHHG_VERSION}


cd /home/$USER
wget ftp://ftp.soest.hawaii.edu/gmt/gmt-${GMT_VERSION}-src.tar.gz
wget ftp://ftp.soest.hawaii.edu/gmt/gshhg-gmt-${GSHHG_VERSION}.tar.gz
tar xvzf gmt-${GMT_VERSION}-src.tar.gz
tar xvzf gshhg-gmt-${GSHHG_VERSION}.tar.gz


cd gmt-${GMT_VERSION}

cat ./cmake/ConfigUserTemplate.cmake | \
sed -e 's%\#set (GSHHG_ROOT "gshhg_path"%'"set (GSHHG_ROOT ${GSHHG_ROOT}"'%g' | \
sed -e 's/\#set (COPY_GSHHG TRUE)/set (COPY_GSHHG TRUE)/g' \
> ./cmake/ConfigUser.cmake


cp /home/$USER/d/Mydocument/Dropbox/program/gmt/ConfigUser.cmake ./cmake/ConfigUser.cmake
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=RelWithDebInfo ..
ncpu=$(nproc)
make -j${ncpu}
sudo make -j${ncpu} install
