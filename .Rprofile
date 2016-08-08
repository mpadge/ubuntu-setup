local ({r <- getOption('repos')
      r['CRAN'] <- 'https://cran.uni-muenster.de'
      options(repos=r)})
 
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

#utils::update.packages (ask=FALSE)

.First <- function(){
    if(interactive()){
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

        message ('')
        eq_half <- rep ('=', gap + nc / 2 - 1) # half line of '='
        message ('||', eq_half, 'R', eq_half, '=||')
        for (i in 1:length (lns))
            message ('||', rep (' ', gaplen [i]), lns [[i]], 
                rep (' ', gaplen [i]), '||')
        message ('||', eq_half, 'R', eq_half, '=||')
        message ('')

        old <- utils::old.packages ()
        if (!is.null (old)) 
            cat ('Updatable packages: ', old [,1], '\n', fill=TRUE) 
        else 
            cat ('All packages up to date\n')
        message ('')
    }
}


if(Sys.getenv('TERM') == 'xterm-256color')
    library('colorout')
