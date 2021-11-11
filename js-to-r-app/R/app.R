# Set host='0.0.0.0' if running inside a docker container
js2rServer <- function(port=NULL, host='127.0.0.1') {
  # To use the latest versions of the files within the www directory
  appDir <- R.utils::getAbsolutePath("js-to-r-app/inst/www")
  # Or, if your app is a package, to use the files within the package (and
  # to be able to run it not from the source directory):
  # appDir <- system.file('www', package='mypackagename')
  shinylight::slRunRServer(
    host=host,
    port=port,
    appDir=appDir,
    # If the user has set a port, we will assume they want a free-running server;
    # if they have not, we will assume they want the function to exit.
    daemonize=!is.null(port),
    permittedSymbols=c(
      '<-', 'c', 'plot', 'data.frame', '+', '-', '*', '/', '^',
      ':', 'x', 'y', 'data', '$', 'one', 'two', 'list', 'stop'
    )
  )
}
js2rServer(8002)
