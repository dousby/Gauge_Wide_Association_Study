install.packages("rvest")
library(rvest)

substrRight<- function(x, n, m){
  substr(x,nchar(x)-n+1, nchar(x)-m+1)
}

hurley.flow <- numeric()

hurley <- function(){
hurley.web <- html("http://mrcstats.azurewebsites.net/default")
hurley.current.flow <- html_nodes(hurley.web, "#table1 td:nth-child(3)")
current.hurley.flow <- substring(as(hurley.current.flow[[4]],"character"), 5,6)
hurley.current.date <- html_nodes(hurley.web, "#table1 td:nth-child(1)")
current.hurley.date <- substring(as(hurley.current.date[[5]],"character"), 5,14)
hurley.flow <<- c(current.hurley.date, current.hurley.flow)
}

Gauge.list <- matrix(c("Mapledurham_downstream", "http://apps.environment-agency.gov.uk/river-and-sea-levels/136495.aspx?StationId=7109&Sensor=D&RegionId=0&AreaId=0&CatchmentId=0",
              "Mapledurham_upstream", "http://apps.environment-agency.gov.uk/river-and-sea-levels/136495.aspx?StationId=7109&Sensor=U&RegionId=0&AreaId=0&CatchmentId=0",
              "Marsh_downstream", "http://apps.environment-agency.gov.uk/river-and-sea-levels/136496.aspx?StationId=7155&Sensor=D&RegionId=0&AreaId=0&CatchmentId=0",
              "Marsh_upstream", "http://apps.environment-agency.gov.uk/river-and-sea-levels/136496.aspx?StationId=7155&Sensor=U&RegionId=0&AreaId=0&CatchmentId=0",
              "Shepperton_downstream", "http://apps.environment-agency.gov.uk/river-and-sea-levels/136496.aspx?StationId=7216&Sensor=D&RegionId=0&AreaId=0&CatchmentId=0",
              "Shepperton_upstream", "http://apps.environment-agency.gov.uk/river-and-sea-levels/136496.aspx?StationId=7216&Sensor=U&RegionId=0&AreaId=0&CatchmentId=0",
              "Itchen_Riverside_Park", "http://apps.environment-agency.gov.uk/river-and-sea-levels/136478.aspx?stationId=1056",
              "Itchen_Bishopstoke", "http://apps.environment-agency.gov.uk/river-and-sea-levels/136478.aspx?stationId=1049",
              "Itchen_Allbrook_Weir","http://apps.environment-agency.gov.uk/river-and-sea-levels/136478.aspx?stationId=1048",
              "Hurley_downstream", "http://apps.environment-agency.gov.uk/river-and-sea-levels/riverstation.aspx?StationId=7156&Sensor=D&RegionId=9&AreaId=20&CatchmentId=135",
              "Hurley_upstream", "http://apps.environment-agency.gov.uk/river-and-sea-levels/riverstation.aspx?StationId=7156&RegionId=9&AreaId=20&CatchmentId=135"),
              ncol=2, byrow=TRUE)

getGaugeEA <- function(x,y){  ## x = name, y = link
  EA.Gauge.DL <- html(y)
  EA.Gauge.DL <- html_nodes(EA.Gauge.DL, "#station-detail-left p")
  x <- toString(x)
  assign(x,c(substrRight(as(EA.Gauge.DL[[1]],"character"), 16,13), 
             substrRight(as(EA.Gauge.DL[[2]],"character"), 15,6),
             substrRight(as(EA.Gauge.DL[[2]],"character"), 24,20)), envir = globalenv())
}

for(i in seq(1,dim(Gauge.list)[1])){
getGaugeEA(Gauge.list[i,1],Gauge.list[i,2])
}

for(i in seq(1,dim(Gauge.list)[1])){
  print(Gauge.list[i,1])
  print(get(Gauge.list[i,1]))
}

print(hurley())
