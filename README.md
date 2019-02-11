# setup-node-gpu

So you want to do machine learning on your fancy GPU machine? Going to build some nice neural-networks?
Here is a easy setup for Debian 9 (strech) GPU machine.

# I got my information from

    https://unix.stackexchange.com/questions/218163/how-to-install-cuda-toolkit-7-8-9-on-debian-8-jessie-or-9-stretch
    https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1804&target_type=runfilelocal
    https://www.anaconda.com/distribution/#download-section
    https://github.com/fastai/fastai


# Setup CUDA

    # install compiles and kernels
    sudo apt install -y gcc g++ linux-headers-amd64 linux-source

    # Download cuda installer
    wget https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda_10.0.130_410.48_linux

    # Stop display manager (x). Either gdm, kdm, lightdm ...
    sudo service lightdm stop

    # install the graphics drivers
    chmod +x ./cuda_10.0.130_410.48_linux.run
    # sudo <CudaInstaller>.run -silent -driver # should work instead of answering messages
    sudo ./cuda_10.0.130_410.48_linux.run
        > accept eula
        > accept unsupported config
        > accept graphics driver
        > accept opengl
        > deny nvidia-xconfig
        > deny toolkit
        > deny sample

    # restart the machine with the new drivers
    sudo reboot

    # install the cuda toolkit
    sudo ./cuda_10.0.130_410.48_linux.run 
        > accept eula
        > accept unsupported config
        > deny graphics driver
        > accept toolkit
        ..


# test cuda setup

    cd NVIDIA_CUDA-7.5_Samples/0_Simple/vectorAdd
    make
    ./vectorAdd


# setup anaconda / pytorch

    # Download anaconda / python3 installer
    wget https://repo.anaconda.com/archive/Anaconda3-2018.12-Linux-x86_64.sh

    # silently install it to a prefix
    bash Anaconda3-2018.12-Linux-x86_64.sh -b -p $HOME/opt/anaconda3

    # install pytorch using conda
    $HOME/opt/anaconda3/bin/conda install -y pytorch torchvision cudatoolkit=10.0 -c pytorch


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

    $HOME/opt/anaconda3/bin/conda install -y -c fastai fastai


# KNOWN ISSUES

## Boot halts with `/dev/sda1: clean .... files .. blocks`

    Fresh install of debian 9 and GeForce 2080 ti, i had the problem with debian wont boot

    stackoverflow suggested
    https://askubuntu.com/questions/882385/dev-sda1-clean-this-message-appears-after-i-startup-my-laptop-then-it-w

    that this is nvidias fault. and it was. I hope your motherboard has an alternativ VGA port or something

    then by-pass gdm and use tty to setup your computer

    or remove graphicscard and setup the computer first


## The driver installation is unable to locate the kernel source.

You forgot to install the linux-headers from the first line...



