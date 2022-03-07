test1 <- function(c1, c2, type, units, factor, offset, pch, bg, lwd) {
  c1f <- c1 * factor
  c2o <- c2 + offset
  plot(c1f, c2o, type=type, pch=pch, bg=bg, lwd=lwd)
  df <- data.frame(
    lengths = c1f,
    weights = c2o
  )
  df
}

test2 <- function(x, y, c1, factor, offset, col) {
  stop("This does not work")
}

functions <- list(
  test1=list(
    params=list(
      c1="lengths",
      c2="weights",
      type="plot_param",
      units="test1_units"
    ),
    optiongroups=c("adjust", "plot_points")
  ),
  test2=list(
    params=list(
      x="a",
      y="a",
      c1="lengths"
    ),
    optiongroups=c("adjust", "color")
  )
)

params <- list(
  a=list(type="f", data="zero"),
  plot_param=list(type="plot_type", data="points"),
  test1_units=list(type="subheader", data="test1_units"),
  lengths=list(type="length_column", data="test1_length_inits"),
  weights=list(type="weight_column", data="test1_weight_inits")
)

optiongroups <- list(
  adjust=list(
    factor=list(type="f", initial=1.0),
    offset=list(type="f", initial=0.0)
  ),
  color=list(
    col=list(type="color", initial='#000')
  ),
  plot_points=list(
    pch=list(type="u8", initial=1),
    bg=list(type="color", initial='#FFF'),
    lwd=list(type="f", initial=1.0)
  ),
  framework=list(
    autorefresh=list(type="b", initial=FALSE)
  )
)

types <- list(
  length_column=list(
    kind="column",
    subtype="f",
    unittype="length_unit"
  ),
  weight_column=list(
    kind="column",
    subtype="f",
    unittype="weight_unit"
  ),
  length_unit=list(
    kind="enum",
    values=c("mm", "in"),
    factors=c(25.4, 1)
  ),
  weight_unit=list(
    kind="enum",
    values=c("kg", "lb"),
    factors=c(0.454, 1)
  ),
  # We can put an enum type into a structure by using list() instead of
  # c() for any level that contains submenus.
  plot_type=list(
    kind="enum",
    values=list(p="p", lines=c("l", "s", "b"), h="h")
  )
)

examples <- list(
  points="p",
  test1_units=list("mm", "kg"),
  test1_length_inits=list(15.0,24.1,13.2,8.3),
  test1_weight_inits=list(4.4, 4.2, 6.1, 1.0)
)

# Set host='0.0.0.0' if running inside a docker container
frameworkServer <- function(port=NULL, host='127.0.0.1') {
  shinylight::slServer(
    host=host,
    port=port,
    # A user running withinR will not set a port and we will return control
    # to them, so we set daemonize=FALSE. A script starting a server will
    # set a port and will not want this function to exit, so we set
    # daemonize=TRUE
    daemonize=!is.null(port),
    interface=list(
      test1=test1,
      test2=test2,
      getSchema=function() {
        list(
          # functiongroups is optional, only required if you want your function
          # menu to have a cascading structure. Miss it out and it will be flat.
          functiongroups=list(
            # The name here is irrelevant, but you must have a name to ensure
            # that the functions come out in the right order.
            dummy1="test1",
            dummy2="test2",
            # The name here is relevant as it will be used to find a translation
            # of the cascade in app.json
            cascade=c("test1", "test2", "test2")
          ),
          functions=functions, params=params, types=types,
          data=examples, optiongroups=optiongroups
        )
      }
    )
  )
}

frameworkServer(8001)
