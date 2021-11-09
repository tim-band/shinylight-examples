makePlot <- function(x, y, type, pch, bg) {
  shinylight::sendInfoText("processing...");
  shinylight::sendProgress(0, 3);
  Sys.sleep(0.2);
  shinylight::sendProgress(1, 3);
  Sys.sleep(0.1);
  shinylight::sendInfoText("we're about halfway through...");
  Sys.sleep(0.1);
  shinylight::sendProgress(2, 3);
  Sys.sleep(0.2);
  shinylight::sendProgress(3, 3);
  plot(x, y, type=type, pch=pch, bg=bg)
  data.frame(
    sum=x+y,
    diff=x-y
  )
}

freeformServer <- function(port=NULL) {
  # To use the latest versions of the files within the www directory
  appDir <- R.utils::getAbsolutePath("freeform-app/inst/www")
  # Or, if your app is a package, to use the files within the package (and
  # to be able to run it not from the source directory):
  # appDir <- system.file('www', package='mypackagename')
  shinylight::slServer(host='0.0.0.0', port=port, appDir=appDir, daemonize=TRUE,
    interface=list(
      # Add as many functions as you need to call from the client side
      makePlot=makePlot
    )
  )
}

freeformServer(8000)
