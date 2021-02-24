install.packages(c("rvest","data.table","RCurl","DT","shiny","shinydashboard","leaflet","plotly","devtools"))
require(devtools)
install_github("khufkens/amerifluxr")


require(amerifluxr)

ameriflux.explorer()