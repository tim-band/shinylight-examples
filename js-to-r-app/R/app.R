js2rServer <- function(port=NULL) {
  # To use the latest versions of the files within the www directory
  appDir <- R.utils::getAbsolutePath("js-to-r-app/inst/www")
  # Or, if your app is a package, to use the files within the package (and
  # to be able to run it not from the source directory):
  # appDir <- system.file('www', package='mypackagename')
  shinylight::slRunRServer(host='0.0.0.0', port=port, appDir=appDir, daemonize=TRUE,
    permittedSymbols=c(
      '<-', 'c', 'plot', 'data.frame', '+', '-', '*', '/', '^',
      ':', 'x', 'y', 'data', '$', 'one', 'two', 'list', 'stop'
    )
  )
}
js2rServer(8000)
