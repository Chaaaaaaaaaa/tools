#!/usr/bin/env bash

#configure the system environment
#1. set apt-get source
#2. set pip source
#3. setup compiler 、lib and compiler

#set apt-get source
#show system information
clear
echo "***********************************"
echo "Current system OS version"              
lsb_release -a                             #view the current os version
echo "***********************************"
#select linux distribution
echo "Select current system version"
echo "  Ubuntu 18.04 Please input 1"
echo "  Ubuntu 16.04 Please input 2"
echo "  Ubuntu 14.04 Please input 3"
echo "  If you done't need to replace the apt-get source,Please input 0"
echo "*********************************"
read -p "Please input the number:" SYSTEM_VERSION   #read the specified os version

#Ubuntu-18.04 source
UBUNTU_1="deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse 

deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse 

deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse 

deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse"

#Ubuntu-16.04 source
UBUNTU_2="deb http://mirrors.aliyun.com/ubuntu/ xenial main
deb-src http://mirrors.aliyun.com/ubuntu/ xenial main

deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main

deb http://mirrors.aliyun.com/ubuntu/ xenial universe
deb-src http://mirrors.aliyun.com/ubuntu/ xenial universe
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates universe
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates universe

deb http://mirrors.aliyun.com/ubuntu/ xenial-security main
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main
deb http://mirrors.aliyun.com/ubuntu/ xenial-security universe
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security universe"

#Ubuntu-14.04 source
UBUNTU_3="deb https://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ trusty main restricted universe multiverse
deb https://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ trusty-security main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ trusty-updates main restricted universe multiverse

deb https://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse
deb-src https://mirrors.aliyun.com/ubuntu/ trusty-backports main restricted universe multiverse

## Not recommended
# deb https://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse
# deb-src https://mirrors.aliyun.com/ubuntu/ trusty-proposed main restricted universe multiverse"

if [ -z $SYSTEM_VERSION ];then
    echo "-->Input format error!"
    exit
else
    if [ ${SYSTEM_VERSION} == '1' ];then
        echo "${UBUNTU_1}" | sudo tee /etc/apt/sources.list > /dev/null   #by tee command to write the sources.list
        echo "-->Write apt-get source success!"
    elif [ ${SYSTEM_VERSION} == '2' ];then
        echo "${UBUNTU_2}" | sudo tee /etc/apt/sources.list > /dev/null
        echo "-->Write apt-get source success!"
    elif [ ${SYSTEM_VERSION} == '3' ];then
        echo "${UBUNTU_3}" | sudo tee /etc/apt/sources.list > /dev/null
        echo "-->Write apt-get source success!"
    elif [ ${SYSTEM_VERSION} == '0' ];then
        echo "-->Don't replace the apt-get source list!"
    else
        echo "-->Input format error!"
        exit
    fi
fi

#whether to update source list
if [ ${SYSTEM_VERSION} != '0' ];then
    echo "-->Start to update software list...."
    sudo apt-get update > /dev/null   #update software list and don't show the print information
    echo "-->Update software done!"
fi

#whether to upgrade sofrware
echo "***********************************"
echo "Whether to upgrade sofrware"
echo "If you need to upgrade your software,please input y"
echo "If you don't need to upgrade your software,please input n or any other characters"
read -p "Please input the number:" FLAG   #read the specified os version
if [ ${FLAG} == 'y' ];then
    echo "-->Start to upgrade software...."
    sudo apt-get upgrade -y            #upgrade the software
    echo "-->Upgrade software done!"
else
    echo "-->Don't upgrade!"
fi

#set pip source
if [ ! -d "~/.pip" ];then        #whether hava .pip directory
    mkdir -p ~/.pip
    sudo touch ~/.pip/pip.conf
fi
#pip source
PIP_SOURCE="[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
"
#write pip source
echo "${PIP_SOURCE}" | sudo tee ~/.pip/pip.conf > /dev/null   #by tee command to write the pip.conf
echo "-->Write pip source success!"

#3. setup compiler 、lib and compiler
#sudo apt-get install gcc g++ build-essential make 
PACKAGES="gcc g++ build-essential python3 python3-pip make autoconf automake autotools-dev net-tools cmake cmake-qt-gui git wget vim tree curl pkg-config zip unzip protobuf-compiler libprotobuf-dev  libncurses5-dev"

dpkg -l gcc >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install gcc!"
    sudo apt-get install -y gcc > /dev/null
    if [ $? -eq 0 ];then
        echo "-->gcc installation success!"
    else
        echo "-->gcc installation failed!"
    fi
else
     echo "-->gcc have been existed on your system and don't need to install!"           #the software have been existed on your system
fi
    
dpkg -l g++ >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install g++!"
    sudo apt-get install -y g++ > /dev/null
    if [ $? -eq 0 ];then
        echo "-->g++ installation success!"
    else
        echo "-->g++ installation failed!"
    fi
else
     echo "-->g++ have been existed on your system and don't need to install!"           #the software have been existed on your system
fi

dpkg -l build-essential >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install build-essential!"
    sudo apt-get install -y build-essential > /dev/null
    if [ $? -eq 0 ];then
        echo "-->build-essential installation success!"
    else
        echo "-->build-essential installation failed!"
    fi
else
     echo "-->build-essential have been existed on your system and don't need to install!"           #the software have been existed on your system
fi

dpkg -l python3 >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install python3!"
    sudo apt-get install -y python3 > /dev/null
    if [ $? -eq 0 ];then
        echo "-->python3 installation success!"
    else
        echo "-->python3 installation failed!"
    fi
else
     echo "-->python3 have been existed on your system and don't need to install!"           #the software have been existed on your system
fi

dpkg -l python3-pip >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install python3-pip!"
    sudo apt-get install -y python3-pip > /dev/null
    if [ $? -eq 0 ];then
        echo "-->python3-pip installation success!"
    else
        echo "-->python3-pip installation failed!"
    fi
else
     echo "-->python3-pip have been existed on your system and don't need to install!"           #the software have been existed on your system
fi

dpkg -l make >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install make!"
    sudo apt-get install -y make > /dev/null
    if [ $? -eq 0 ];then
        echo "-->make installation success!"
    else
        echo "-->make installation failed!"
    fi
else
     echo "-->make have been existed on your system and don't need to install!"           #the software have been existed on your system
fi

dpkg -l automake >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install automake!"
    sudo apt-get install -y automake > /dev/null
    if [ $? -eq 0 ];then
        echo "-->automake installation success!"
    else
        echo "-->automake installation failed!"
    fi
else
     echo "-->automake have been existed on your system and don't need to install!"           #the software have been existed on your system
fi

dpkg -l autoconf >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install autoconf!"
    sudo apt-get install -y autoconf > /dev/null
    if [ $? -eq 0 ];then
        echo "-->autoconf installation success!"
    else
        echo "-->autoconf installation failed!"
    fi
else
     echo "-->autoconf have been existed on your system and don't need to install!"           #the software have been existed on your system
fi

dpkg -l autotools-dev >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install autotools-dev!"
    sudo apt-get install -y autotools-dev > /dev/null
    if [ $? -eq 0 ];then
        echo "-->autotools-dev installation success!"
    else
        echo "-->autotools-dev installation failed!"
    fi
else
     echo "-->autotools-dev have been existed on your system and don't need to install!"           #the software have been existed on your system
fi

dpkg -l net-tools >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install net-tools!"
    sudo apt-get install -y net-tools > /dev/null
    if [ $? -eq 0 ];then
        echo "-->net-tools installation success!"
    else
        echo "-->net-tools installation failed!"
    fi
else
     echo "-->net-tools have been existed on your system and don't need to install!"           #the software have been existed on your system
fi

dpkg -l cmake >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install cmake!"
    sudo apt-get install -y cmake > /dev/null
    if [ $? -eq 0 ];then
        echo "-->cmake installation success!"
    else
        echo "-->cmake installation failed!"
    fi
else
     echo "-->cmake have been existed on your system and don't need to install!"           #the software have been existed on your system
fi

dpkg -l cmake-qt-gui >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install cmake-qt-gui!"
    sudo apt-get install -y cmake-qt-gui > /dev/null
    if [ $? -eq 0 ];then
        echo "-->cmake-qt-gui installation success!"
    else
        echo "-->cmake-qt-gui installation failed!"
    fi
else
     echo "-->cmake-qt-gui have been existed on your system and don't need to install!"           #the software have been existed on your system
fi

dpkg -l git >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install git!"
    sudo apt-get install -y git > /dev/null
    if [ $? -eq 0 ];then
        echo "-->git installation success!"
    else
        echo "-->git installation failed!"
    fi
else
     echo "-->git have been existed on your system and don't need to install!"           #the software have been existed on your system
fi

dpkg -l wget >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install wget!"
    sudo apt-get install -y wget > /dev/null
    if [ $? -eq 0 ];then
        echo "-->wget installation success!"
    else
        echo "-->wget installation failed!"
    fi
else
     echo "-->wget have been existed on your system and don't need to install!"           #the software have been existed on your system
fi

dpkg -l vim >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install vim!"
    sudo apt-get install -y vim > /dev/null
    if [ $? -eq 0 ];then
        echo "-->vim installation success!"
    else
        echo "-->vim installation failed!"
    fi
else
     echo "-->vim have been existed on your system and don't need to install!"           #the software have been existed on your system
fi

dpkg -l tree >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install tree!"
    sudo apt-get install -y tree > /dev/null
    if [ $? -eq 0 ];then
        echo "-->tree installation success!"
    else
        echo "-->tree installation failed!"
    fi
else
     echo "-->tree have been existed on your system and don't need to install!"           #the software have been existed on your system
fi

dpkg -l curl >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install curl!"
    sudo apt-get install -y curl > /dev/null
    if [ $? -eq 0 ];then
        echo "-->curl installation success!"
    else
        echo "-->curl installation failed!"
    fi
else
     echo "-->curl have been existed on your system and don't need to install!"           #the software have been existed on your system
fi

dpkg -l pkg-config >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install pkg-config!"
    sudo apt-get install -y pkg-config > /dev/null
    if [ $? -eq 0 ];then
        echo "-->pkg-config installation success!"
    else
        echo "-->pkg-config installation failed!"
    fi
else
     echo "-->pkg-config have been existed on your system and don't need to install!"           #the software have been existed on your system
fi

dpkg -l zip >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install zip!"
    sudo apt-get install -y zip > /dev/null
    if [ $? -eq 0 ];then
        echo "-->zip installation success!"
    else
        echo "-->zip installation failed!"
    fi
else
     echo "-->zip have been existed on your system and don't need to install!"           #the software have been existed on your system
fi

dpkg -l unzip >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install unzip!"
    sudo apt-get install -y unzip > /dev/null
    if [ $? -eq 0 ];then
        echo "-->unzip installation success!"
    else
        echo "-->unzip installation failed!"
    fi
else
     echo "-->unzip have been existed on your system and don't need to install!"           #the software have been existed on your system
fi

dpkg -l protobuf-compiler >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install protobuf-compiler!"
    sudo apt-get install -y protobuf-compiler > /dev/null
    if [ $? -eq 0 ];then
        echo "--protobuf-compiler installation success!"
    else
        echo "-->protobuf-compiler installation failed!"
    fi
else
     echo "-->protobuf-compiler have been existed on your system and don't need to install!"           #the software have been existed on your system
fi

dpkg -l libprotobuf-dev >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install libprotobuf-dev!"
    sudo apt-get install -y libprotobuf-dev > /dev/null
    if [ $? -eq 0 ];then
        echo "-->libprotobuf-dev installation success!"
    else
        echo "-->libprotobuf-dev installation failed!"
    fi
else
     echo "-->libprotobuf-dev have been existed on your system and don't need to install!"           #the software have been existed on your system
fi

dpkg -l libncurses5-dev >& /dev/null   
if [ $? -ne 0 ];then                                             #the software have been not installed on your system
    echo "-->Start to install libncurses5-dev!"
    sudo apt-get install -y libncurses5-dev > /dev/null
    if [ $? -eq 0 ];then
        echo "-->libncurses5-dev installation success!"
    else
        echo "-->libncurses5-dev installation failed!"
    fi
else
     echo "-->libncurses5-dev have been existed on your system and don't need to install!"           #the software have been existed on your system
fi
echo "Done!"