My system setup from scratch ...

Contents
--------

[1. `apt-get install` comands](#1-apt-get-install) ([1.1 vim](#1.1-vim); 
[1.2 Other stuff](#1.2-misc))

[2. Visual settings](#2-visual-settings) ([2.1 SourceCodePro](#2.1-sourcecodepro); 
[2.2 solarized](#2.2-solarized); [2.3 computer name](#2.3-computer-name))

[3. git](#3-git) ([3.1 travis](#3.1-travis))

[4. Miscellaneous system stuff](#4-misc-system-stuff)

[5. R](#5-R) ([5.1 R packages](#5.1-packages); 
[5.2 vim-r](#5.2-vim-r); [5.3 Nvim-r](#5.3-Nvim-r))

[6. Other `vim` plugins](#6-other-vim)

[7. `python`](#7-python) ([7.1 scipy & numpy](#7-scipy-numpy))

[8. Other packages](#8-other-packages) (
[8.1 Image processing](#8.1-image-processing))

[9. ruby & jekyll](#9-ruby-jekyll)


--------

# <a name="1-apt-get-install"></a>1. `apt-get install` copy-paste commands:

First enable canonical partners, then

```
sudo apt-get install ctags libx11-dev tmux libboost-all-dev texlive-full
sudo apt-get install git mc libxml2-dev imagemagick libcgal-dev jabref vlc pdftk
sudo apt-get install gsl-bin libgsl0-dev valgrind zathura
sudo apt-get install libcurl4-openssl-dev dos2unix python-bs4 libgeos-dev libglu1-mesa-dev
sudo apt-get install ubuntu-restricted-extras skype
sudo apt-get install libzip-dev libglu1-mesa-dev mesa-common-dev clang-3.8
sudo apt-get install htop python-regex cmake tree libeigen3-dev libgmp3-dev
```

`zathura` is needed by `Nvim-r`

## <a name="1.1-vim"></a>1.1 `vim`

`vim` can be compiled as described [here](http://www.vim.org/git.php) with these
lines: 
```
git clone https://github.com/vim/vim.git
cd vim/src
make
sudo make install
```
This will only work if `vim` has not yet been installed at all, that is if
```
dpkg --get-selections | grep vim 
```
returns nothing. Otherwise modify as described
[here](http://www.vim.org/git.php).  This also allows easy updating to any and
all future patches by simply updating the `git clone`.

## <a name="1.2-misc"></a>1.2 Other installation stuff

1. `Java` and `rJava`

    ```
    sudo apt-get install openjdk-8-jre # or 9?
    sudo apt-get install openjdk-8-jdk
    sudo apt-get install r-cran-rjava
    sudo R CMD javareconf # -e ?
    ```
2. [pandoc](github.com/jpg/pandoc) is best installed not by `apt-get`, rather by
    ```
    sudo wget https://github.com/jgm/pandoc/releases/download/1.16.0.2/pandoc-1.16.0.2-1-amd64.deb
    sudo dpkg -i pandoc-1.16.0.2-1-amd64.deb
    ```

--------


# <a name="2-visual-settings"></a>2 Visual settings

1. Appearance -> Look -> Launcher Icon Size = 32 
2. Appearance -> Behaviour -> Autohide Launcher
3. Install Gnome Tweak from software centre (not apt-get)
4. Advanced Settings -> Fonts -> All to 10, except Document = 11
5. To enable `<super>-N` for moving windows between monitors:

        sudo apt-get install compizconfig-settings-manager compiz-plugins-extra 
    5a. Window Management -> Enable `Put`

    5b. Grab keys for `Put to next output`
6. To make `alt-tab` only show current workspace: 

    In dconf-editor: org -> gnome -> shell -> app-switcher 
    
    set `current-workspace-only` to true
7. To add shutdown to list of power options:

    a. Install `dconf-editor`

    b. Under org -> gnome -> settings-daemon -> plugins -> power

    set `lid-close-ac-action` and `lid-close-battery-action`
8. Settings -> Keyboard -> Launch email client: Set key to `Ctrl+Alt+M`

-----

## <a name="2.1-sourcecodepro"></a>2.1 [SourceCodePro](https://github.com/adobe-fonts/source-code-pro)

1. Download [`.tar.gz`](https://github.com/adobe-fonts/source-code-pro)
2. Open each `.otf` with `font-viewer` and `install`
3. Advanced Settings -> Fonts -> Monospace font -> SourceCodePro Light 9pt
4. Set Terminal -> profile -> general -> font -> SourceCodePro Light 9pt

-----

## <a name="2.2-solarized"></a>2.2 [solarized](https://github.com/altercation/vim-colors-solarized)

1. See notes on `vim` install [below](#2.1-vim)
2. Install [`vim-pathogen`](https://github.com/tpope/vim-pathogen):
```
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
```
then
```
cd ~/.vim/bundle
git clone git://github.com/altercation/vim-colors-solarized.git
cd vim-colors-solarized
mv vim-colors-solarized ~/.vim/bundle/
```

Set up gnome to use solarized colour scheme thusly:
https://gist.github.com/gmodarelli/5942850
but instead of `./set_light.sh`, just run
```
./install_sh
```
to configure both light and dark profiles

-----

## <a name="2.3-computer-name"></a>2.3 Computer name

If not set at install, just change both:
```
/etc/hosts
/etc/hostname
```

Then to change the ["Ubuntu
Desktop"](http://askubuntu.com/questions/140742/how-do-i-change-the-desktop-name-on-the-unity-panel) text at top left:

1. `vim .junk.po` # (can be deleted afterward)
2. insert:

    ```
    msgid "Ubuntu Desktop"
    msgstr "whatever"
    ```
3.  then:

    ```
    cd /usr/share/locale/en/LC_MESSAGES
    sudo msgfmt -o unity.mo ~/.junk.po
    ```
4. log out to change it



-----

# <a name="3-git"></a>3. git setup:

```
git config --global user.name "mpadge"
git config --global user.email "mark.padgham@email.com"
git config --global core.autocrlf input
git config --global core.safecrlf true
```

Then in .gitconfig:

```
[alias]
    co = checkout
    ci = commit
    st = status -uno
    br = branch
    hist = log --graph --all --date=short --pretty=format:'%Cred%h%Creset%x09%ad - %Cgreen%d%Cblue%s%Creset'
    type = cat-file -t
    dump = cat-file -p
```


## <a name="3.1-travis"></a>3.1 [travis-ci client](https://github.com/travis-ci/travis.rb#installation)

Replace `1.8.2` with latest version
```
sudo apt-get install ruby-dev # if not already installed
sudo gem install travis -v 1.8.2 --no-rdoc --no-ri
```
and then to check it worked:
```
travis version
```

----------------

# <a name="4-misc-system-stuff"></a>4. Miscellaneous System Stuff

1. Set default editor

    ```
    echo $EDITOR
    export EDITOR='vim'
    ```
2. `tcolorbox` does **NOT** install as latest version, so has to be done manually in 

    ```
    /usr/share/texlive/texmf-dist/tex/latex/tcolorbox
    ```
3. To update `boost` to `>=LTS`:

    a. Check version

    ```
    dpkg -s libboost-all-dev | grep version
    ```
    b. Then update to downloaded version
    
    ```
    wget -O boost_1_xx_0.tar.gz http://sourceforge.net/projects/boost/files/boost/1.xx.0/boost_1_xx_0.tar.gz/download
    tar xzvf boost_1_xx_0.tar.gz
    cd boost_1_xx_0/
    sudo apt-get update
    sudo apt-get install build-essential g++ python-dev autotools-dev libicu-dev build-essential libbz2-dev libboost-all-dev
    ./bootstrap.sh --prefix=/usr/local
    ```
    c. The last of these gives instructions for install, then just need to 
    ```
    sudo copy boost_1_xx_0 /usr/include/ -r
    ```
    d. Finally add to compiler path `/usr/include/boost_1_xx_0` and to linker library path
`/usr/include/boost_1_xx_0/stage/lib`

------

# <a name="5-R"></a>5. `R`

Details [here](http://cran.r-project.org/bin/linux/ubuntu/)
```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
sudo add-apt-repository "deb http://cran.r-project.org/bin/linux/ubuntu xenial/"
sudo apt-get update
sudo apt-get install r-base r-base-dev
```

To list r-base version:
```
apt-cache showpkg r-base
```

To set a permenent mirror:
```
vim /usr/lib/R/library/base/R/Rprofile
```
search for `cran` and replace `@CRAN@` with `https://cran.r-project.org/`

------

## <a name="5.1-packages"></a>5.1 Package installation

In addition to the [`rJava`](#1.2-misc) requirements listed above, prior to
installation:

1. `httr` requires `libssl-dev`
2. `rgdal` requires `gdal-bin libgdal-dev libproj-dev`

```
pkgs <- c ("codetools", "ggplot2", "sp", "spacetime", "XML", "data.table", "RCurl")
pkgs <- c (pkgs, "osmar", "quantreg", "fpc", "knitr", "rmarkdown", "yaml", "bitops")
pkgs <- c (pkgs, "spatstat", "adehabitatLT", "CircStats", "fields", "spatialkernel") 
pkgs <- c (pkgs, "tripack", "spdep", "plyr", "RANN", "combinat", "igraph", "raster") 
pkgs <- c (pkgs, "chron", "gridBase", "cubature", "R2Cuba", "devtools", "roxygen2") 
pkgs <- c (pkgs, "testthat", "rgdal", "rjson", "rgl", "rJava", "OpenStreetMap")
pkgs <- c (pkgs, "animation", "microbenchmark", "rgl", "extrafont", "Rcpp")
pkgs <- c (pkgs, "ggm", "rgeos", "changepoint", "readxl", "signal", "msm")
new.pkgs <- pkgs [!(pkgs %in% rownames (installed.packages()))]
if(length(new.pkgs)) install.packages(new.pkgs)
```


------

## <a name="5.2-vim-r"></a>5.2 [`vim-r-plugin`](http://ubuntuforums.org/showthread.php?t=776492) (now obsolete)

```
sudo add-apt-repository "deb http://www.uft.uni-bremen.de/chemie/ranke/debs sid-jr/"
sudo apt-get update
sudo apt-get install vim-r-plugin
sudo vim-addons -w install r-plugin
```
[See also this link](http://manuals.bioinformatics.ucr.edu/home/programming-in-r/vim-r)

------

## <a name="5.3-Nvim-r"></a>5.3 `Nvim-r-plugin`


1. Get latest vim by as described above
2. Download [Nvim-r vimball](http://www.vim.org/scripts/script.php?script_id=2628)
3. [Install](https://github.com/jalvesaq/Nvim-R)  by `:so %` 

--------

# <a name="6-other-vim"></a>6. Other `vim` plugins


1 `vim-latex`

    sudo apt-get install vim-latexsuite
    sudo vim-addons status % prints status of all available addons
    sudo vim-addons install -w latex-suite # -w is flag for system-wide installation

New folding environments can be defined by changing
`/usr/share/vim/addons/ftplugin/latex-suite/folding.vim`
at around line#126 from

    let g:Tex_FoldedSections = 'part,chapter,section,'
                        \. 'subsection,subsubsection,paragraph'

to include `objective` and `subobjective` for example:

    let g:Tex_FoldedSections = 'part,chapter,section,'
                        \. 'subsection,subsubsection,paragraph,'
                        \. 'objective,subobjective'

Note that code folding can't be changed on the fly because these are loaded
prior to loading `vim-latex` itself, so this seems the easiest way to achieve the
desired result.

2 `vim-python`: Download `python.vim` script into `/.vim/syntax/`

3 [`vim-pathogen`](https://github.com/tpope/vim-pathogen) already described above ...

    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

4 Other vim plugins

    vim-vundle ditto
    vim-youcompleteme

-------

# <a name="7-python"></a>7. Python


[pip](https://pip.pypa.io/en/latest/installing.html):
```
sudo python get-pip.py
sudo pip install requests
```

## <a name="7-scipy-numpy"></a>7.1 scipy and numpy:

```
python-numpy 
python-scipy 
python-matplotlib 
ipython 
ipython-notebook 
python-pandas 
python-sympy 
python-nose
```
as well as
```
sudo apt-get python-psutil
sudo pip install slimit
```


--------------------


# <a name="8-other-packages"></a>8. Other interesting / useful packages

```
ardesia
lm-sensors
openlogos font
varishapes font
martin vogel's symbols font
poky font
stylebats font
apache2 # web server needed for routino
libjson-pp-perl # also for routino
tcl-dev # only for the R adehabitat package
tk-dev # ditto - maybe tcl-dev is not actually needed?
routino
pyparsing
```

----------------

## <a name="8.1-image-processing"></a>8.1 For image processing

```
rawtherapee
rawstudio
darktable
```

-------------------------------

# <a name="9-ruby-jekyll"></a>9 Ruby & jekyll stuff


Install [Ruby-Version-Manager](http://rvm.io) which is necessary for [jekyll](https://help.github.com/articles/using-jekyll-with-pages/)
```
ruby --version # lists current version
source /home/markus/.rvm/scripts/rvm
rvm list # lists current versions
```
Then install a javascript runtime
```
apt-get install nodejs
```
Then install jekyll:
```
get install jekyll
```
and run jekyll new:
```
jekyll new junk
cd junk
jekyll build
jekyll serve
```

Then for github pages:
```
gem install bundler
```
then added 'Gemfile' with the following 2 lines:
```
source 'https://rubygems.org'
gem 'github-pages'
```
then finally
```
bundle install
```
and to run it:
```
bundle exec jekyll serve
```

