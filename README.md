Ubuntu System Setup
===========================

Adapted from 
[ubuntu-post-install scripts of Sam Hewitt](https://github.com/snwh/ubuntu-post-install), to whom all credit is due.

## Usage

```
./setup.sh
```
or make an alias.

## Structure

There are six main `functions` in the directory of that name, some of which use
the `data` directory, and all of which use variables derined in
`functions/variables`.

1. `doall` enables all functions to be run **non-interactively** to build an
   entirely new system from scratch

2. `aptadd` adds `apt` keys (`/data/keys.list`) and repositories
   (`/data/repos.list`)

3. `apt` installs `packages.list` (and skips all those already installed)

4. `nonapt` opens a menu for the following additional functions

    i.  `pandoc` to install the latest version from source

    ii. `python` to install a host of additional python modules

    iii.`vim` to install or upgrade `vim` from source, along with a host of extensions

    iv. `R packages` to install those

    v.  `sourcecodepro` to install the font

    vi. `travis` to install the ruby gem for `travis-ci`

5. `configure` provides 3 configuration options, including installing dotfiles

6. `cleanup` removes obsolete packages, kernels, and the like


In addition, `check` performs initial checks for packages necessary to run this
script

------


## Note

The kinds of values given in `gsettings.list` and `dsettings.list` can be found by
```
> dconf watch /
```
Manually changing settings will then echo the corresponding `dconf` parameters.
Some of these can not be `gset`. To find out which, just use
```
> gsettings get ...
```
with autocomplete to find out. Alternatively `gsettings list-recursively` will
list all settings, or see the [compiz
wiki](https://wiki.archlinux.org/index.php/Compiz_configuration)

------

## Manual tasks

Some tasks can nevertheless only be completed manually ... 

### 1. Terminal font

```
profile -> general -> font -> SourceCodePro Light 9pt
```

### 2. gnome soliarized

Follow [this](https://gist.github.com/gmodarelli/5942850), but instead of
`./set_light.sh`, just run `./install_sh` to configure both light and dark
profiles

### 3. Computer name

If not set at install, just change both:
```
/etc/hosts
/etc/hostname
```

### 4. Desktop text

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



<!---

If `vim-latex` folding does not work, the folds can be examined with `:echo
&fdo` -- see `:h fdo` for more details.  (`install` may have to be repeated
without `-w`).

New folding environments can be defined by changing
`/usr/share/vim/addons/ftplugin/latex-suite/folding.vim` at around line#126 from

    let g:Tex_FoldedSections = 'part,chapter,section,'
                        \. 'subsection,subsubsection,paragraph'

to include `objective` and `subobjective` for example:

    let g:Tex_FoldedSections = 'part,chapter,section,'
                        \. 'subsection,subsubsection,paragraph,'
                        \. 'objective,subobjective'

-------

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
image processing
```
rawtherapee
rawstudio
darktable
```

--->
