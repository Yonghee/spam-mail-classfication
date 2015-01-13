
#load data file
spam.base.raw <- read.csv("./data/spambase.data",header=FALSE)

# load header file
# MakeHeader.py 로 spambase.names 에 있는 헤더 정보를 추출하여 headers 파일로 기록해 두었음. 
spam.base.header <- read.csv("./data/headers",header=FALSE,stringsAsFactors = F)
headers <- spam.base.header[,1]
headers <- c(headers,"spam") 
