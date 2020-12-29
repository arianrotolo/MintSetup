# Mint Setup

Idea from: [Alexander Michels](https://github.com/alexandermichels/MintSetup)

## Table of Contents
* <a href="#intro">Introduction</a>
* <a href="#instalation">Instalation</a>
* <a href="#faq">Frequently Asked Questions (FAQ)</a>

## <a id="intro">Introduction</a>

This is a Bash script that configure your [Linux Mint](https://www.linuxmint.com/)

## <a id="installation">Installation</a>

Run the script
```bash
bash setup.sh
```

For the full version, use the `-f` or `--full` flag:
```bash
bash setup.sh -f
```

***

## <a id="faq">Frequently Asked Questions (FAQ)</a>
* [How does it work?](#faq-howitworks)
* [Is anything installed that I can't disable?](#faq-required)
* [What is a distribution codename?](#faq-codename)
* [What software do I have the option to install?](#faq-options)
* [What software do I have the option to uninstall?](#faq-uninstall)

### <a id="faq-howitworks">How does it work?</a>

The `commands.json` acts a huge dictionary that maps the software to the commands to install. The Python3 app runs the GUI and records your choices, then uses this dictionary to compile all the commands into a Bash script `your_setup.sh` in the /bin folder.

### <a id="faq-required">Is anything installed that I can't disable?</a>

The app does a dist-upgrade and downloads [cURL](https://curl.haxx.se/) by default

### <a id="faq-codename">What is a distribution codename?</a>

It's kind of like a version for Ubuntu-based OSs. You can find yours by running:
```bash
alias upstream-lsb="grep DISTRIB_CODENAME /etc/upstream-release/lsb-release | grep -o --colour=never \"[a-z-]*$\""
```

### <a id="faq-options">What software do I have the option to install?</a>

#### Default Software
The default option installs the following packages:
*  **System Utilities:**
    * [CMake](https://cmake.org/)
    * [cURL](https://curl.haxx.se/)
    
*  **Default:**
    * [Python Tools]
    * [Python Pip)](https://pypi.org/project/pip/)
    * [Pip Packages(Grip, Virtualenv, Numpy)](https://github.com/joeyespo/grip)
    * [Uncomplicated Firewall o ufw(and enable it)](https://wiki.ubuntu.com/UncomplicatedFirewall)
    * [Git (and configuration)](https://git-scm.com/)
    * [dconf-editor]
    * [htop](https://github.com/htop-dev/htop)
    * [Neofetch](https://github.com/dylanaraps/neofetch)
    * [PuTTY](https://www.puttygen.com/)
    * [FileZilla](https://filezilla-project.org/)
    * [lm_sensors](https://github.com/tristanheaven/gtkhash)
    * [GtkHash](https://github.com/tristanheaven/gtkhash) 
    * [gnupg & Seahorse](https://gitlab.gnome.org/GNOME/seahorse) 

#### Full Software
The full option additionally installs the following packages:
* **Full:**
    * [Neovim](https://neovim.io/)
    * [Google Chrome](https://www.google.com/chrome/)
    * [Visual Studio Code](https://code.visualstudio.com/)
    * [Spotify](https://www.spotify.com/)
    * [Brave Browser](https://brave.com/)
    * [Calibre](https://calibre-ebook.com/)
    
* **Extra:**
    * [LAMP (Linux, Apache, MySQL, PHP)](https://www.apache.org/)
    * [Texmaker LaTeX IDE](https://www.xm1math.net/texmaker/)
    * [Spyder Scientific IDE for Python](https://github.com/spyder-ide/spyder)
    * [Gradle](https://gradle.org/)
    * [Maven](https://maven.apache.org/)
    * [Open MPI (libopenmpi-dev)](https://www.open-mpi.org/)
    * [Mesa 3D Graphics Library (libosmesa6-dev)](https://mesa3d.org/)
    * [mujoco-py](https://github.com/openai/mujoco-py#install-mujoco)
    * [PatchELF (utility to modify the dynamic linker and RPATH of ELF executables)](https://nixos.org/patchelf.html)
    * [OpenGL API (libgl1-mesa-dev)](https://www.mesa3d.org/)
    * [VLC](https://www.videolan.org/vlc/index.html)

### <a id="faq-uninstall">What software do I have the option to uninstall?</a>

You also have the option to remove some of the pre-installed software:
* [Hexchat](https://hexchat.github.io/)
* [Mopidy](https://www.mopidy.com/)
* [Pidgin](https://pidgin.im/)
* [Rhythmbox](https://wiki.gnome.org/Apps/Rhythmbox)
* [Xplayer](https://github.com/linuxmint/xplayer)
