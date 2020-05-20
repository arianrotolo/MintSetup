# Mint Setup 2.0.0

```

MMMMMMMMMMMMMMMMMMMMMMMMMmds+.        
MMm----::-://////////////oymNMd+`     
MMd      /++                -sNMd:    
MMNso/`  dMM    `.::-. .-::.` .hMN:   
ddddMMh  dMM   :hNMNMNhNMNMNh: `NMm  
    NMm  dMM  .NMN/-+MMM+-/NMN` dMM            __  __ _       _   ____       _
    NMm  dMM  -MMm  `MMM   dMM. dMM           |  \/  (_)_ __ | |_/ ___|  ___| |_ _   _ _ __
    NMm  dMM  -MMm  `MMM   dMM. dMM           | |\/| | | '_ \| __\___ \ / _ \ __| | | | '_ \
    NMm  dMM  -MMm  `MMM   dMM. dMM           | |  | | | | | | |_ ___) |  __/ |_| |_| | |_) |   
    NMm  dMM  .mmd  `mmm   yMM. dMM           |_|  |_|_|_| |_|\__|____/ \___|\__|\__,_| .__/   
    NMm  dMM`  ..`   ...   ydm. dMM                                                   |_|    
    hMM- +MMd/-------...-:sdds  dMM   
    -NMm- :hNMNNNmdddddddddy/`  dMM   
     -dMNs-``-::::-------.``    dMM   
      `/dMNmy+/:-------------:/yMMM   
         ./ydNMMMMMMMMMMMMMMMMMMMMM
            \.MMMMMMMMMMMMMMMMMMM
```

Original Author: Alexander Michels
https://github.com/alexandermichels/MintSetup

***

## Table of Contents
* <a href="#intro">Introduction</a>
* <a href="#instalation">Instalation</a>
* <a href="#faq">Frequently Asked Questions (FAQ)</a>

## <a id="intro">Introduction</a>

This is Python App to build a Bash script that will help you configure your [Linux Mint](https://www.linuxmint.com/) computers with all of the applications you want in a single script. This is meant to be as general as possible (using your distro codename), but when I need to make a decision, I make it to work for the most recent version of Linux Mint Cinnamon, right now that is [Linux Mint 19 "Tara" Cinnamon](https://www.linuxmint.com/edition.php?id=254). The app gives you a wide variety of packages to choose from, pre-installed software to remove, and cleans up your setup in a quick and easy GUI.

***

## <a id="installation">Installation</a>

Running the app is super simple.

### Setup.sh

An older iteration of MintSetup without the GUI and without as many choices:

```bash
$ bash setup.sh
```

For the full version, use the `-f` or `--full` flag:

```bash
$ bash setup.sh -f
$ bash setup.sh --full
```

***

## <a id="faq">Frequently Asked Questions (FAQ)</a>
* [How does it work?](#faq-howitworks)
* [Is anything installed that I can't disable?](#faq-required)
* [What is a distribution codename?](#faq-codename)
* [What software do I have the option to install?](#faq-options)
* [What software do I have the option to uninstall?](#faq-uninstall)

### <a id="faq-howitworks">How does it work?</a>

The `commands.json` file acts a huge dictionary that maps the appropriate software to the appropriate commands to install them. The Python3 app runs the GUI and records your choices, then uses this dictionary to compile all the necessary commands you need into a Bash script called `your_setup.sh` in the /bin folder. Feel free to check out your setup script there.

### <a id="faq-required">Is anything installed that I can't disable?</a>

The app does a dist-upgrade and downloads [cURL](https://curl.haxx.se/) by default. Here is a full list of everything else you can download:

### <a id="faq-codename">What is a distribution codename?</a>

It's kind of like a version for Ubuntu-based OSs. You can find yours by running the following command in the terminal:

```bash
alias upstream-lsb="grep DISTRIB_CODENAME /etc/upstream-release/lsb-release | grep -o --colour=never \"[a-z-]*$\""
```

### <a id="faq-options">What software do I have the option to install?</a>

* **General Software:**
    * System Utilities
    * Python tools
    * [Gradle](https://gradle.org/)
    * [Grip](https://github.com/joeyespo/grip)
    * [Spyder Scientific IDE for Python](https://github.com/spyder-ide/spyder)
    * [Pip (for Python 2 and Python 3)](https://pypi.org/project/pip/)
    * [Uncomplicated Firewall o ufw]
    * [CMake](https://cmake.org/)
    * [Curl](https://curl.haxx.se/)
    * [Git (and configuration)](https://git-scm.com/)
    * [Google Chrome](https://www.google.com/chrome/)
    * [Spotify](https://www.spotify.com/)
    * [Visual Studio Code](https://code.visualstudio.com/)
    * [VLC](https://www.videolan.org/vlc/index.html)
    * [Neovim](https://neovim.io/)
    * [FileZilla] 
    * [PuTTY] 
    * [htop] 
    * [Neofetch]
    * [Seahorse] 
    * [GtkHash] 
    * [lm_sensors] 

#### Full

The full version additionally installs the following:

* **Included Packages:**
    * [Texmaker LaTeX IDE] https://www.xm1math.net/texmaker/
    * [Maven](https://maven.apache.org/)
    * [Open MPI (libopenmpi-dev)](https://www.open-mpi.org/)
    * [Mesa 3D Graphics Library (libosmesa6-dev)](https://mesa3d.org/)
    * [PatchELF (utility to modify the dynamic linker and RPATH of ELF executables)](https://nixos.org/patchelf.html)
    * [OpenGL API (libgl1-mesa-dev)](https://www.mesa3d.org/)

### <a id="faq-uninstall">What software do I have the option to uninstall?</a>

You also have the option to remove some of the pre-installed software:

* [Hexchat](https://hexchat.github.io/)
* [Mopidy](https://www.mopidy.com/)
* [Pidgin](https://pidgin.im/)
* [Rhythmbox](https://wiki.gnome.org/Apps/Rhythmbox)
* [Xplayer](https://github.com/linuxmint/xplayer)
