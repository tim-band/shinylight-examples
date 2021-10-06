js2rServer <- function(port=NULL) {
  appDir <- R.utils::getAbsolutePath("js-to-r-app/inst/www")
  shinylight::slRunRServer(host='0.0.0.0', port=port, appDir=appDir, daemonize=TRUE,
    permittedSymbols=c(
      '<-', 'c', 'plot', 'data.frame', '+', '-', '*', '/', '^',
      ':', 'x', 'y', 'data', '$', 'one', 'two', 'list', 'stop'
    )
  )
}
js2rServer(8000)
