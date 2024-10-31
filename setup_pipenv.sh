#!/usr/bin/bash

# create an architecture dependent pip environment to run shxarray tutorials and install the jupyter kernels as a user 
#  Run this script in the folder where you want to create the pip environments
#R.Rietbroek Dec 2024


envname=pysh_`uname -m`

scriptpath=`dirname -- "$0"`


if [ -d "$envname" ]; then
    echo "Environment $envname  already exists"
    
else
    echo "$envname creating new pip environment, this can take a while"
    python -m venv $envname --system-site-packages
     # upgrade pip before installing shxarray (may fail in building the wheel otherwise)
    echo "upgrading pip"
    ${envname}/bin/pip install --upgrade pip
    #install required software
    echo "installing shxarray"
    ${envname}/bin/pip install -r $scriptpath/requirements.txt
fi

# now we can isntall a jupyter kernel so it can be used in notebooks
kerneldir=${HOME}/.local/share/jupyter/kernels/$envname

#Uncomment in case you want to delete the earlier kernel
#jupyter kernelspec uninstall ${envname}


if [ -d "$kerneldir" ]; then
    echo "Jupyter kernel $kerneldir already exists"
else
    echo "installing new Jupyter kernel for the current user"
    ${envname}/bin/python -m ipykernel install --user --name ${envname} 

fi


