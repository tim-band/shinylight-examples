makePlot <- function(x, y, type, pch, bg) {
  plot(x, y, type=type, pch=pch, bg=bg)
  data.frame(
    sum=x+y,
    diff=x-y
  )
}

freeformServer <- function(port=NULL) {
  appDir <- R.utils::getAbsolutePath("freeform-app/inst/www")
  shinylight::slServer(host='0.0.0.0', port=port, appDir=appDir, daemonize=TRUE,
    interface=list(
      makePlot=makePlot
    )
  )
}

freeformServer(8000)
