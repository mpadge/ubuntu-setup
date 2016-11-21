Ubuntu System Setup
===========================

Adapted from 
[ubuntu-post-install scripts of Sam Hewitt](https://github.com/snwh/ubuntu-post-install), to whom all credit is due.

##Usage

```
./setup.sh
```


##Note

`gsettings.list` and `dsettings.list` can be found by
```
> dconf watch /
```
Manually changing settings will then echo the corresponding `dconf` parameters.
Some of these can not be `gset`. To find out which, just use
```
> gsettings get ...
```
with autocomplete to find out.

Some tasks can nevertheless only be completed manually ... 

1. Enable `<super>-N` for moving windows between monitors in `compizconfig`:
    1a.  Window management -> Enable `Put`
    1b. Grab keys for `Put to next output`


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
3. `sfr` (not yet CRAN) requires `libgeos++-dev`

```
pkgs <- c ("codetools", "ggplot2", "sp", "spacetime", "XML", "data.table", "RCurl")
pkgs <- c (pkgs, "osmar", "quantreg", "fpc", "knitr", "rmarkdown", "yaml", "bitops")
pkgs <- c (pkgs, "spatstat", "adehabitatLT", "CircStats", "fields", "spatialkernel") 
pkgs <- c (pkgs, "tripack", "spdep", "plyr", "RANN", "combinat", "igraph", "raster") 
pkgs <- c (pkgs, "chron", "gridBase", "cubature", "R2Cuba", "devtools", "roxygen2") 
pkgs <- c (pkgs, "testthat", "rgdal", "rjson", "rgl", "rJava", "OpenStreetMap")
pkgs <- c (pkgs, "animation", "microbenchmark", "rgl", "extrafont", "Rcpp")
pkgs <- c (pkgs, "ggm", "rgeos", "changepoint", "readxl", "signal", "msm")
pkgs <- c (pkgs, "distr")
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

If latex folding does not work, the folds can be examined with `:echo &fdo` --
see `:h fdo` for more details.  (`install` may have to be repeated without
`-w`).

New folding environments can be defined by changing
`/usr/share/vim/addons/ftplugin/latex-suite/folding.vim` at around line#126 from

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

