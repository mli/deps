# sample usage:
#
# INSTALL_DIR=/usr/local
# source install.sh
# install_glog
#

set -x
dir=`dirname "$0"`
if [ -z "$INSTALL_DIR" ]; then
    INSTALL_DIR=$dir
fi
cd $dir
mkdir -p build

install_glog() {

    echo $INSTALL_DIR
}
