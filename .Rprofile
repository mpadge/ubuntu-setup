local ({r <- getOption("repos")
      r["CRAN"] <- "https://cran.uni-muenster.de"
      options(repos=r)})
 
#options (stringsAsFactors=FALSE)
#options (max.print=100)
options (width = 80)
options (scipen=10)
options (editor="vim")
#options (prompt="R> ", digits=4)

.env <- new.env()
.env$setpar <- function (mar=c(3, 3, 2, 1), mgp=c(1.7, 0.3, 0))
{
    par (mar=mar, mgp=mgp)
}
attach(.env)

#utils::update.packages (ask=FALSE)

.First <- function(){
    if(interactive()){
        message ("")
        message ("||==============================R",
                 "===============================||")
        rv <- R.Version ()$version.string
        rn <- R.Version ()$nickname
        rpl <- R.Version ()$platform
        message ("|| ", rv, " --- \"", rn, "\"\t||")
        rsys <- Sys.info ()
        ss <- system (". /etc/os-release; echo ${VERSION}", intern=T)
        message ("|| Ubuntu ", ss, " (kernel ", rsys["release"], ")\t||")
        message ("|| \tmachine = ", rpl, ": ", rsys["nodename"], "\t\t\t||")
        message ("|| \t.Rprofile contains ", ls (name=".env"), "\t\t\t\t||")
        message ("||==============================R",
                 "===============================||")
        message ("\tcurrent dir:", getwd ())
        message ("")

        old <- utils::old.packages ()
        if (!is.null (old)) 
            cat ("Updatable packages: ", old [,1], "\n", fill=TRUE) 
        else 
            cat ("All packages up to date\n")
    }
}


if(Sys.getenv("TERM") == "xterm-256color")
    library("colorout")
