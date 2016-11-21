Ubuntu System Setup
===========================

Adapted from 
[ubuntu-post-install scripts of Sam Hewitt](https://github.com/snwh/ubuntu-post-install), to whom all credit is due.

## Usage

```
./setup.sh
```


## Note

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

------

## Manual tasks

Some tasks can nevertheless only be completed manually ... 

### 1. Move windows

Enable `<super>-N` for moving windows between monitors in `compizconfig`:
    1.  Window management -> Enable `Put`
    2. Grab keys for `Put to next output`

### 2. Terminal font

```
profile -> general -> font -> SourceCodePro Light 9pt
```

### 3. `tcolorbox`

Manually update `tcolorbox` in `/usr/share/texlive/texmf-dist/tex/latex/tcolorbox`


### 4. gnome soliarized

Follow [this](https://gist.github.com/gmodarelli/5942850), but instead of
`./set_light.sh`, just run `./install_sh` to configure both light and dark
profiles

### 5. Computer name

If not set at install, just change both:
```
/etc/hosts
/etc/hostname
```

### 6. Desktop text

To change the 
["Ubuntu Desktop"](http://askubuntu.com/questions/140742/how-do-i-change-the-desktop-name-on-the-unity-panel) 
text at top left:

`vim .junk.po` (can be deleted afterward) and insert:
```
msgid "Ubuntu Desktop"
msgstr "whatever"
```
then:
```
cd /usr/share/locale/en/LC_MESSAGES
sudo msgfmt -o unity.mo ~/.junk.po
```
and log out to change it



### 7. git setup:

```
git config --global user.name "mpadge"
git config --global user.email "mark.padgham@email.com"
git config --global core.autocrlf input
git config --global core.safecrlf true
```

### 8. `Nvim-r-plugin`

Download [Nvim-r vimball](http://www.vim.org/scripts/script.php?script_id=2628)
and [Install](https://github.com/jalvesaq/Nvim-R)  by `:so %` 



------



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



<!---
Other interesting / useful packages:

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

and for image processing

```
rawtherapee
rawstudio
darktable
```

--->
