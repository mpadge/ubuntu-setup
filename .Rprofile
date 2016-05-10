local ({r <- getOption("repos")
      r["CRAN"] <- "http://cran.uni-muenster.de"
      options(repos=r)})
 
#options (stringsAsFactors=FALSE)
options (max.print=100)
options (width = 80)
options (scipen=10)
options (editor="vim")
options (prompt="R> ", digits=4)

.env <- new.env()
.env$setpar <- function (mar=c(3, 3, 2, 1), mgp=c(1.7, 0.3, 0))
{
    par (mar=mar, mgp=mgp)
}
attach(.env)

.First <- function(){
    if(interactive()){
        message ("====================R====================")
        rv <- R.Version ()$version.string
        rn <- R.Version ()$nickname
        rpl <- R.Version ()$platform
        message (rv, " --- \"", rn, "\"")
        rsys <- Sys.info ()
        ss <- system (". /etc/os-release; echo ${VERSION}", intern=T)
        message ("Ubuntu ", ss, " (kernel ", rsys["release"], ")")
        message ("machine = ", rpl, ": ", rsys["nodename"])
        message (".Rprofile contains ", ls (name=".env"))
        message ("====================R====================")
    }
}

 
if(Sys.getenv("TERM") == "xterm-256color")
  library("colorout")
