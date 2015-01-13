
#load data file
spam.base.df<- read.csv("./data/spambase.data",header=FALSE)

# load header file
# MakeHeader.py 로 spambase.names 에 있는 헤더 정보를 추출하여 headers 파일로 기록해 두었음. 
spam.base.header <- read.csv("./data/headers",header=FALSE,stringsAsFactors = F)
headers <- make.names(spam.base.header[,1],unique=T)
headers <- c(headers,"spam") 

names(spam.base.df) <- headers
spam.base.df$spam <- as.factor(ifelse(spam.base.df$spam > 0.5, "spam","non-spam"))

#fitting model
## Data Split to Train/Test
require(caret)
set.seed(1234)
trainIdx <- createDataPartition(y=spam.base.df$spam, p=0.75,list=F)
trainData <- spam.base.df[trainIdx,]
testData<- spam.base.df[-trainIdx,]

# column 명에 특수문자가 포함되어 있으므로 make.names를 하지 않으면 as.formula에서 오류가 난다.
spamCols <- make.names(setdiff(colnames(trainData),list("spam")))
spam.fomula <- as.formula(paste('spam=="spam"',paste(spamCols,collapse=' + '),sep=' ~ '))

#모델 만들기
fit <- glm(spam.fomula,family = binomial(link='logit'),data=trainData)

trainData$pred <- predict(fit,newdata = trainData,teyp='response')
testData$pred <- predict(fit,newdata = testData,type='response')

#Confusion Matrix 
CM <- table(truth=testData$spam,predition=testData$pred > 0.5)
print(CM)
