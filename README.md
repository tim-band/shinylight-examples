# ShinyLight Examples

Examples of how to use Shinylight to make lightweight servers for R calculations.

## Standard framework app

You can create a polished app with no JavaScript by using the standard framework.
You can find the example for this in the `framework-app` directory.

The standard framework will query your R code for a 'schema', which describes
the functions you have provided. The framework will provide the following elements:

* A function selector
* Inputs for the parameters the function needs
* An options pane for minor parameters to your functions
* An input grid for your input data
* The plot image if your function produced one
* An output grid for your functions' output data
* An error page for any errors your functions' produced
* A debugging page giving details of the raw inputs and outputs from the last function call
* Buttons for downloading PDFs of the plots and CSVs of the table data

To start this app, install the 'remotes' package (if it is not already installed), then
install `shinylight` from github, then run the `run.R` script:

```sh
Rscript -e "install.packages('remotes')"
Rscript -e "remotes::install_github('tim-band/shinylight')"
Rscript framework-app/R/app.R
```

and visit `http://localhost:8000`

## Freeform JavaScript app

If you do not want to use the standard framework, you can work with the lower-level
code and produce your own JavaScript/HTML frontend. You can find the example for this
in the `freeform-app` directory.

Again, start it like this:

```sh
Rscript -e "install.packages('remotes')"
Rscript -e "remotes::install_github('tim-band/shinylight')"
Rscript freeform-app/R/app.R
```

## Constructing R in JavaScript on the client side

It is possible to construct R on the client side, and pass it through to the server for
execution. If you want to do this, and particularly if you want to make such a
program available over the internet, please be aware that this cannot be secured
by validating the R on the client side, as the server will be available to be called
with a modified client you do not control. You must at least take the following
precautions:

* Validate the R on the server side, for example by using `shinylight::runR`, which takes a whitelist of permitted symbols
* Run the server in a container (such as a Docker container or VM)
* Firewall the server from the rest of your organization's network

You can find an example for this in the `js-to-r-app` directory.

Again, start it like this:

```sh
Rscript -e "install.packages('remotes')"
Rscript -e "remotes::install_github('tim-band/shinylight')"
Rscript js-to-r-app/R/app.R
```

and visit `http://localhost:8000`
