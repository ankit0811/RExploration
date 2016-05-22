
#install.packages('RTextTools')
library(RTextTools)


data <- read.csv(file="G:\\Study-Exploration\\TextClassificationR\\sunnyData.csv",
               header=T)

#Generating document term with create_matrix from RTextTools
dataMatrix<-create_matrix(data)

#Create and Train SVM
  #1. Configure the training data
  container <- create_container(matrix=dataMatrix,
                            labels=data$IsSunny, #Training data output column,
                            trainSize=1:11,
                            virgin=F)
  
  #2. Train the SVM Model
  model <- train_model(container=container,algorithm="SVM",kernel="linear",cost=1)


#Test the model for new samples
predicData <- list("sunny sunny","is rainy","sunny rainy","")

predMatrix <- create_matrix(textColumns=predicData, originalMatrix=dataMatrix)
#The above statement generates an error as the developers have used Acronym instead of acronym
#So use the below code and goto line no 42. Rename Acronym to acronym and the run the above statement
trace("create_matrix",edit=T)

predSize = length(predicData)
predictionContainer <- create_container(predMatrix,
                                        labels=rep(0,predSize),
                                        testSize=1:predSize,
                                        virgin=F)

result<-classify_model(predictionContainer, model)

