# setup-node-gpu

# Links

    https://unix.stackexchange.com/questions/218163/how-to-install-cuda-toolkit-7-8-9-on-debian-8-jessie-or-9-stretch
    https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1804&target_type=runfilelocal
    https://www.anaconda.com/distribution/#download-section
    https://github.com/fastai/fastai
    



Setup a CUDA enable node for pytorch etc


    sudo apt-get install gcc g++ gcc-4.9 g++-4.9 libxi libxi6 libxi-dev libglu1-mesa libglu1-mesa-dev libxmu6 libxmu6-dev linux-headers-amd64 linux-source


# what i did

    sudo apt install gcc g++
    # sudo apt install libglu1-mesa libx11-6 libxi6 libxmu6 # was already found


    wget https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda_10.0.130_410.48_linux

    sudo service lightdm stop

    sudo ./cuda_10.0.130_410.48_linux.run 
        > accept eula
        > accept unsupported config
        > accept graphics driver
        > accept opengl
        > deny nvidia-xconfig
        > deny toolkit
        > deny sample

    sudo reboot

    sudo ./cuda_10.0.130_410.48_linux.run 
        > accept eula
        > accept unsupported config
        > deny graphics driver
        > accept toolkit
        ..


Driver:   Not Selected
Toolkit:  Installed in /usr/local/cuda-10.0
Samples:  Installed in /home/charnley/opt/cuda, but missing recommended libraries

Please make sure that
 -   PATH includes /usr/local/cuda-10.0/bin
 -   LD_LIBRARY_PATH includes /usr/local/cuda-10.0/lib64, or, add /usr/local/cuda-10.0/lib64 to /etc/ld.so.conf and run ldconfig as root

To uninstall the CUDA Toolkit, run the uninstall script in /usr/local/cuda-10.0/bin

Please see CUDA_Installation_Guide_Linux.pdf in /usr/local/cuda-10.0/doc/pdf for detailed information on setting up CUDA.

***WARNING: Incomplete installation! This installation did not install the CUDA Driver. A driver of version at least 384.00 is required for CUDA 10.0 functionality to work.
To install the driver using this installer, run the following command, replacing <CudaInstaller> with the name of this run file:
    sudo <CudaInstaller>.run -silent -driver


# test cuda

    cd NVIDIA_CUDA-7.5_Samples/0_Simple/vectorAdd
    make
    ./vectorAdd


# setup anaconda / pytorch


    wget https://repo.anaconda.com/archive/Anaconda3-2018.12-Linux-x86_64.sh

    PREFIX=/home/charnley/opt/anaconda3

    bash Anaconda3-2018.12-Linux-x86_64.sh -b -p $HOME/opt/anaconda3

    $HOME/opt/anaconda3/bin/conda install pytorch torchvision cudatoolkit=10.0 -c pytorch

# test pytorch

    $HOME/opt/anaconda3/bin/python

    import torch
    x = torch.rand(5, 3)
    print(x)
    torch.cuda.is_available()


# jupyter notebook


    https://blog.godatadriven.com/write-less-terrible-notebook-code

    # use tmux to host your session

    HOSTIP=`ip route get 1 | awk '{print $NF;exit}'`
    $HOME/opt/anaconda3/bin/jupyter notebook --ip $HOSTIP --port 8888

    # echos something like
    http://131.152.106.192:8888/?token=0140c28484a03d7dc0a57732c7ec272c08bbbe6fc8173f42

    # replace the ip with hostname

    http://gpunode:8888/?token=0140c28484a03d7dc0a57732c7ec272c08bbbe6fc8173f42


# Done


# optional, install fastai


    $HOME/opt/anaconda3/bin/conda install -c fastai fastai



