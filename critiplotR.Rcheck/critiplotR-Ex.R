pkgname <- "critiplotR"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
base::assign(".ExTimings", "critiplotR-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('critiplotR')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("plot_grade")
### * plot_grade

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_grade
### Title: Generate a GRADE certainty-of-evidence plot
### Aliases: plot_grade

### ** Examples

## Don't show: 
if (reticulate::py_module_available("critiplot")) withAutoprint({ # examplesIf
## End(Don't show)
## Not run: 
##D   plot_grade(
##D     input_file = system.file("extdata", "sample_grade.csv", package = "critiplotR"),
##D     output_file = tempfile(fileext = ".png"),
##D     theme = "green"
##D   )
## End(Not run)
## Don't show: 
}) # examplesIf
## End(Don't show)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_grade", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot_jbi_case_report")
### * plot_jbi_case_report

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_jbi_case_report
### Title: Generate a JBI Case Report risk-of-bias plot
### Aliases: plot_jbi_case_report

### ** Examples

## Don't show: 
if (reticulate::py_module_available("critiplot")) withAutoprint({ # examplesIf
## End(Don't show)
## Not run: 
##D   plot_jbi_case_report(
##D     input_file = system.file("extdata", "sample_jbi_case_report.csv", package = "critiplotR"),
##D     output_file = tempfile(fileext = ".png"),
##D     theme = "default"
##D   )
## End(Not run)
## Don't show: 
}) # examplesIf
## End(Don't show)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_jbi_case_report", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot_jbi_case_series")
### * plot_jbi_case_series

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_jbi_case_series
### Title: Generate a JBI Case Series risk-of-bias plot
### Aliases: plot_jbi_case_series

### ** Examples

## Don't show: 
if (reticulate::py_module_available("critiplot")) withAutoprint({ # examplesIf
## End(Don't show)
## Not run: 
##D   plot_jbi_case_series(
##D     input_file = system.file("extdata", "sample_jbi_case_series.csv", package = "critiplotR"),
##D     output_file = tempfile(fileext = ".png"),
##D     theme = "blue"
##D   )
## End(Not run)
## Don't show: 
}) # examplesIf
## End(Don't show)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_jbi_case_series", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot_mmat")
### * plot_mmat

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_mmat
### Title: Generate MMAT (Mixed Methods Appraisal Tool) plots
### Aliases: plot_mmat

### ** Examples

## Don't show: 
if (reticulate::py_module_available("critiplot")) withAutoprint({ # examplesIf
## End(Don't show)
## Not run: 
##D   plot_mmat(
##D     input_file = system.file("extdata", "sample_mmat.csv", package = "critiplotR"),
##D     output_file = tempfile(fileext = ".png"),
##D     theme = "default"
##D   )
## End(Not run)
## Don't show: 
}) # examplesIf
## End(Don't show)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_mmat", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot_nos")
### * plot_nos

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_nos
### Title: Generate a NOS (Newcastle–Ottawa Scale) risk-of-bias plot
### Aliases: plot_nos

### ** Examples

## Don't show: 
if (reticulate::py_module_available("critiplot")) withAutoprint({ # examplesIf
## End(Don't show)
## Not run: 
##D   plot_nos(
##D     input_file = system.file("extdata", "sample_nos.csv", package = "critiplotR"),
##D     output_file = tempfile(fileext = ".png"),
##D     theme = "blue"
##D   )
## End(Not run)
## Don't show: 
}) # examplesIf
## End(Don't show)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_nos", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot_robis")
### * plot_robis

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_robis
### Title: Generate a ROBIS (Risk Of Bias In Systematic reviews) plot
### Aliases: plot_robis

### ** Examples

## Don't show: 
if (reticulate::py_module_available("critiplot")) withAutoprint({ # examplesIf
## End(Don't show)
## Not run: 
##D   plot_robis(
##D     input_file = system.file("extdata", "sample_robis.csv", package = "critiplotR"),
##D     output_file = tempfile(fileext = ".png"),
##D     theme = "smiley_blue"
##D   )
## End(Not run)
## Don't show: 
}) # examplesIf
## End(Don't show)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_robis", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
