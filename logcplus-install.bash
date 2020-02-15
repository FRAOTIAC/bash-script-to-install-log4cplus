#!/usr/bin/env bash
install_log4cplus() {
  mkdir -p tmp && cd tmp || exit
  git clone https://github.com/log4cplus/log4cplus.git  --recurse-submodules
  cd log4cplus || exit
  mkdir -p build && cd build || exit

  if cmake .. && make -j4 && sudo make install; then
    echo successed
    return 0
  else
    echo failed
    return 2
  fi
}

install_cmake_v16.2() {
  sudo apt purge --auto-remove cmake
  version=3.16
  build=2
  mkdir -p ~/temp
  cd ~/temp || exit
  wget https://cmake.org/files/v$version/cmake-$version.$build.tar.gz
  tar -xzvf cmake-$version.$build.tar.gz
  cd cmake-$version.$build/ || exit
  ./bootstrap
  make -j$(nproc)
  sudo make install
}

if install_log4cplus; then
  echo "Successfully installed log4cplus "
else
  if install_cmake_v16.2 && install_log4cplus; then
    echo "Successfully installed log4cplus "
    exit
  fi
  echo "Install log4cplus failed"

fi