LoanData <- read.csv(file="/Users/HanLu/Documents/Unsorted/QMSS.Vis/hw4/LoanStatsNew.csv", header=T, skip=1)
LoanData <- LoanData[,c("loan_amnt", "grade", "home_ownership", "issue_d", "addr_state", "purpose", "dti", "fico_range_high", "fico_range_low", "open_acc","delinq_2yrs", "inq_last_6mths")]
LoanData <- na.omit(LoanData)

library(RJSONIO)
toJSONarray <- function(dtf){
  clnms <- colnames(dtf)
  name.value <- function(i){
    quote <- '';
    if(!class(dtf[, i]) %in% c('numeric', 'integer')){
      quote <- '"';
    }
    paste('"', i, '" : ', quote, dtf[,i], quote, sep='')
  }
  objs <- apply(sapply(clnms, name.value), 1, function(x){
    paste(x, collapse=', ')
  })
  objs <- paste('{', objs, '}')
  res <- paste('[', paste(objs, collapse=', '), ']')
  return(res)
}
cat(toJSONarray(LoanData), file="/Users/HanLu/Documents/Unsorted/QMSS.Vis/hw4/LoanData.json")
