library("jsonlite")
# Wuhan-2019-nCoV.csv
# https://raw.githubusercontent.com/canghailan/Wuhan-2019-nCoV/master/Wuhan-2019-nCoV.csv
data <- read.csv("Wuhan-2019-nCoV.csv",header = TRUE, stringsAsFactors = FALSE, fileEncoding="utf8")
# range of date
d <- c(paste0("2020-01-0", 1:9),paste0("2020-01-", 10:31), paste0("2020-02-0", 1:9),paste0("2020-02-", 10:18))

province_data <- data[data$countryCode == "CN" & data$province!="" & data$city=="",c(1,4,8,10) ]
province_data$province <- sub("省", "", province_data$province)
province_data$province <- sub("自治区", "", province_data$province)
province_data$province <- sub("市", "", province_data$province)
province_data$province <- sub("特别行政区", "", province_data$province)
province_data$province <- sub("维吾尔", "", province_data$province)
province_data$province <- sub("壮族", "", province_data$province)
province_data$province <- sub("回族", "", province_data$province)
province_data$province <- sub(" ", "", province_data$province)
province_data$confirmed <- province_data$confirmed - province_data$cured

write(paste0("max_count=",length(d),";"),file="data.js", append = F)
write("var my_cate = [];",file="data.js", append = T)
write("var dead_rate = new Array();",file="data.js", append = T)
write("var my_data = new Array();",file="data.js", append = T)
write("var my_title = new Array();",file="data.js", append = T)
write("var my_confirm = new Array();",file="data.js", append = T)
write("var my_cure = new Array();",file="data.js", append = T)
write("var my_dead = new Array();",file="data.js", append = T)
write("var last_confirm = new Array();",file="data.js", append = T)
write("var last_cure = new Array();",file="data.js", append = T)
write("var last_dead = new Array();",file="data.js", append = T)
write("var dead_rate = new Array();",file="data.js", append = T)
write(paste0("my_cate=",toJSON(d),";"),file="data.js", append = T)

for (t in c(1:length(d))){
  temp_data <- province_data[province_data$date==d[t],c(2,3)]
  names(temp_data)[1] <- "name"
  names(temp_data)[2] <- "value"
  my_data <- paste0("my_data[",t,"]=",toJSON(temp_data),";")
  my_title <- paste0("my_title[",t,"]=[{ text: \"",d[t],"\"}];")
  write(my_data,file="data.js", append = T)
  write(my_title,file="data.js", append = T)
}

data <- read.csv("Wuhan-2019-nCoV.csv",header = TRUE, stringsAsFactors = FALSE, fileEncoding="utf8")
China_data <- data[data$countryCode == "CN" & data$province=="",c(1,8,10,11) ]
names(China_data)[2] <- "确诊"
names(China_data)[3] <- "治愈"
names(China_data)[4] <- "死亡"
#write.csv(China_data, file="china.csv",row.names = FALSE)
for (t in c(1:length(d))){
  temp_data <- China_data[c(32:(32+t)),]
  my_confirm=paste0("my_confirm[",t,"]=",toJSON(temp_data[,2]),";")
  my_cure=paste0("my_cure[",t,"]=",toJSON(temp_data[,3]),";")
  my_dead=paste0("my_dead[",t,"]=",toJSON(temp_data[,4]),";")
  
  last_confirm=paste0("last_confirm[",t,"]=",toJSON(temp_data[c(length(temp_data[,1])),2]),";")
  last_cure=paste0("last_cure[",t,"]=",toJSON(temp_data[c(length(temp_data[,1])),3]),";")
  last_dead=paste0("last_dead[",t,"]=",toJSON(temp_data[c(length(temp_data[,1])),4]),";")
  dead_rate= round(100*temp_data[c(length(temp_data[,1])),4]/(temp_data[c(length(temp_data[,1])),4]+temp_data[c(length(temp_data[,1])),3]),2)
  if (is.na(dead_rate)){
    dead_rate <- 0
  }
  write(paste0("dead_rate[",t,"]=[{value:",dead_rate,", name:\"死亡率\"}];"),file="data.js", append = T)
  write(my_confirm,file="data.js", append = T)
  write(my_cure,file="data.js", append = T)
  write(my_dead,file="data.js", append = T)
  write(last_confirm,file="data.js", append = T)
  write(last_cure,file="data.js", append = T)
  write(last_dead,file="data.js", append = T)
}
