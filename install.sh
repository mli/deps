#!/bin/bash
# sample usage:
#
# install_dir=/usr/local
# source install.sh
# install_glog
#

# set -x
dir=$PWD/`dirname $0`
echo $dir
if [ -z "$install_dir" ]; then
    install_dir=$dir
fi
if [ -z "$nthreads" ]; then
    nthreads=8
fi


# file_name dir_name log_file
st_install() {
    # get
    url=https://raw.githubusercontent.com/mli/deps/master/build
    mkdir -p $dir/build
    cur=$PWD
    cd $dir/build
    if [ ! -f $1 ]; then
        wget $url/$1
    fi
    tar -zxf $1

    echo "Install $1 to $install_dir"
    rm -f $3
    cd $2
    ./configure -prefix=$install_dir >>$3
    make -j $nthreads >>$3
    make install >>$3
    if [ $? -ne 0 ]; then
        echo "ERROR: failed to install $1, log is available at $3"
    fi
    cd $cur
    # rm -rf $dir/build/$2
}


install_gflags() {
    st_install gflags-2.0-no-svn-files.tar.gz gflags-2.0 $dir/gflags.log
}

install_protobuf() {
    st_install protobuf-2.5.0.tar.gz protobuf-2.5.0 $dir/protobuf.log
}

install_glog() {
    st_install glog-0.3.3.tar.gz glog-0.3.3 $dir/glog.log
}

install_zmq() {
    st_install zeromq-4.1.0-rc1.tar.gz zeromq-4.1.0 $dir/zmq.log
}
