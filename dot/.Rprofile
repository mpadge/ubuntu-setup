local ({
        r <- getOption('repos')
        #r['CRAN'] <- 'https://cran.uni-muenster.de'
        r['CRAN'] <- 'https://cran.wu.ac.at'
        options(repos=r)
        })
.libPaths('/usr/local/lib/R/site-library')
.libPaths('~/R/x86_64-pc-linux-gnu-library/3.3')
 
#options (stringsAsFactors=FALSE)
#options (max.print=100)
options (width = 80)
options (scipen=10)
options (editor='vim')
#options (prompt='R> ', digits=4)

.env <- new.env()
.env$setpar <- function (mar=c(3, 3, 2, 1), mgp=c(1.7, 0.3, 0))
{
    par (mar=mar, mgp=mgp)
}
attach(.env)

.First <- function(){
    if(interactive()){
        # see :h nvimcom-not-loaded
        #if (Sys.getenv ("NVIMR_TMPDIR") == "")
        #        options (defaultPackages = c ("utils", "grDevices", "graphics",
        #            "stats", "methods"))
        #else
        #        options (defaultPackages = c ("utils", "grDevices", "graphics",
        #            "stats", "methods", "nvimcom"))

        if ('colorout' %in% rownames (utils::installed.packages ()))
            library (colorout)

        rv <- R.Version ()$version.string
        rn <- R.Version ()$nickname
        rpl <- R.Version ()$platform
        rsys <- Sys.info ()
        ss <- system ('. /etc/os-release; echo ${VERSION}', intern=T)

        lns <- list ()
        lns [[1]] <- paste0 (rv, '--- \'', rn, '\'')
        lns [[2]] <- paste0 ('Ubuntu ', ss, ' (kernel ', rsys ['release'], ')')
        lns [[3]] <- paste0 ('machine = ', rpl, ': ', rsys ['nodename'])
        lns [[4]] <- paste0 ('wd: ', getwd ())
        lns <- sapply (lns, function (i) 
                       {
                           if ((nchar (i) %% 2) != 0)
                               i <- paste0 (i, ' ')
                           return (i)
                       })
        nc <- max (sapply (lns, nchar))
        gap <- 2 # number of character before and after
        nci <- sapply (lns, nchar, USE.NAMES=FALSE)
        gaplen <- floor (nc + 2 * gap - nci) / 2

        #for (i in 2500:2600)
        #    cat(eval(parse(text=paste("\"\\u", i, "\"", sep=""))), " ")
        top <- "\u2583"
        bot <- "\u2580"
        vc <- "\u2588"

        bl <- '  ' # blanks at left side
        top_half <- paste0 (rep (top, gap + nc / 2 - 1))
        message (bl, top_half, ' R ', top_half, top)
        message (paste0 (bl, vc, paste0 (rep (' ', gap + nc + 1), collapse=''), ' ', vc))
        for (i in 1:length (lns))
        {
            gaps <- paste0 (rep (' ', gaplen [i]), collapse='')
            message (paste0 (bl, vc, gaps, lns [[i]], gaps, vc))
        }
        message (paste0 (bl, vc, paste0 (rep (' ', gap + nc + 1), collapse=''), ' ', vc))
        bot_half <- paste0 (rep (bot, gap + nc / 2 - 1))
        message (bl, bot_half, ' R ', bot_half, bot)
        message ('')

        if (curl::has_internet ())
        {
            old <- utils::old.packages ()
            if (!is.null (old)) 
                message ('Updatable packages: ', 
                         do.call (paste, as.list (rownames (old))), '\n')
            else 
                message ('All packages up to date\n')
        } else
            message ('nope, no internet\n')
    }
}


#if(Sys.getenv('TERM') == 'xterm-256color')
#    library('colorout')
