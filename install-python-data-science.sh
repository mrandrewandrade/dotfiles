#!/usr/bin/env bash

## create an ubuntu 14.04 hvm instance, then from your home directory:

# 1. download this script
# wget https://gist.githubusercontent.com/waylonflinn/506f563573600d944923/raw/install-python-data-science.sh

# 2. make it executable
# chmod a+x install-python-data-science.sh

# 3. run it (in screen)
# screen ./install-python-data-science.sh

# 4. respond to the first couple of prompts, then come back in about an hour
# if you get bored, hit `CTRL+A, D` to detach from the screen process
# when you want to reconnect type `screen -r` at the command line

# Create a certificate for later use in ipython notebook
mkdir certs
pushd certs
openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout data-science-server.pem -out data-science-server.pem
popd

# TODO: add SHA1 hashing of user supplied password for ipython notebook

# set memory limits. based on: http://wiki.vpslink.com/Compile_ANY_program
export CFLAGS='--param ggc-min-expand=0 --param ggc-min-heapsize=500000'

# make sure the apt repository index is up to date
sudo apt-get -y update

# OS
sudo apt-get -y install build-essential gfortran
sudo apt-get -y install git curl vim

# Python
sudo apt-get -y install python3-dev python3-pip
sudo apt-get -y install python-dev

# Set up virtual env
sudo pip3 install virtualenv
mkdir venv
pushd venv
virtualenv data-science
popd

# add virtualenv activation to bash_profile
echo "
source ~/venv/data-science/bin/activate
" >> ~/.bash_profile

# Download and install some dependencies
mkdir installs
pushd installs

# OpenBLAS
wget https://github.com/xianyi/OpenBLAS/archive/v0.2.14.tar.gz
tar -xvf v0.2.14.tar.gz
pushd OpenBLAS-0.2.14/
make FC=gfortran
sudo make PREFIX=/usr/local/ install
popd

# add OpenBLAS libraries to .bash_profile
echo "
export BLAS=/usr/local/lib/libopenblas.a
export LAPACK=/usr/local/lib/libopenblas.a
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/
" >> ~/.bash_profile

# activate virtualenv and add OpenBLAS library locations to shell environment
source ~/.bash_profile

# Install compilation requirements in python
pip install cython
pip install nose

# Numpy
wget https://github.com/numpy/numpy/archive/v1.8.2.tar.gz
tar -xvf v1.8.2.tar.gz
pushd numpy-1.8.2/
echo "
[default]
library_dirs = /usr/local/lib
[atlas]
atlas_libs = openblas
library_dirs = /usr/local/lib
[lapack]
lapack_libs = openblas
library_dirs = /usr/local/lib
" >> site.cfg
python setup.py build
python setup.py install
popd

# Scipy
wget https://github.com/scipy/scipy/archive/v0.15.1.tar.gz
tar -xvf v0.15.1.tar.gz
pushd scipy-0.15.1/
python setup.py build
python setup.py install
popd

# exit installs directory
popd

# Matplotlib
sudo apt-get -y install libfreetype6-dev libpng12-dev libjs-mathjax fonts-mathjax
pip install matplotlib


pip install scikit-learn

pip install numexpr
pip install bottleneck
pip install pandas

pip install --allow-all-external mysql-connector-python==1.2.2
pip install SQLAlchemy


# PyTables
#sudo apt-get install libhdf5-dev
#pip install tables==3.1.2

#pushd installs
#wget https://github.com/PyTables/PyTables/archive/v.3.1.1.tar.gz
#tar -xvf v.3.1.1.tar.gz
#pushd PyTables-v.3.1.1/
# in setup.py fix Cython.Compiler.Main -> Cython.Compiler
#python setup.py build
#python setup.py install


# Text processing
pip install nltk
pip install gensim

# IPython Notebook
pip install pyzmq
pip install jinja2
pip install tornado
pip install ipython[notebook]
ipython profile create data-science-server


# start ipython server
# ipython notebook --profile=data-science-server
# with screen (preserving LD_LIBRARY_PATH)
# screen bash -c "export LD_LIBRARY_PATH=/usr/local/lib; ipython notebook --profile=data-science-server"


# add ipython notebook output filter for git
mkdir bin
pushd bin
wget https://gist.githubusercontent.com/waylonflinn/010f0a1a66760adf914f/raw/ipynb_output_filter.py
chmod a+x ipynb_output_filter.py
popd

echo -e "*.ipynb \t filter=dropoutput_ipynb" >> .gitattributes
git config --global core.attributesfile ~/.gitattributes
git config --global filter.dropoutput_ipynb.clean ~/bin/ipynb_output_filter.py
git config --global filter.dropoutput_ipynb.smudge cat


# run unit tests
#python -c "import numpy; numpy.test(verbose=2)"
#python -c "import scipy; scipy.test(verbose=2)"
