## intro to R: arithmatic

3 + 4 
2 * 5

## order of operation - use spaces to make more readable

4 + (8 * 3) ^ 2

## scientific notications

2/ 100000
4e3

## mathmatical functions
exp(1)
exp(3)
sqrt (4)

## help files - order of argument matters - lable all funcitons
?log
log(2,4)
log(4,2)
log(x=2, base=4)
log(x=4, base=2)

## add value to script by defining term or set
x <-1
log(base=4, x=2)
rm(x)

## nested functions
sqrt(exp(4))
log (exp(100))

## six comparison functions

mynumber <-6
## does my number equal 5 - using 2 equals asks a question 1 equal is the same at <-
mynumber == 5

## tab to auto complete

mynumber
## is my number?
mynumber !=5

mynumber >4
mynumber >=2
mynumber <=1

mynumber <-7
othernumber <- -3
mynumber * othernumber

## object name convention

numSapmles <- 50
num_samples <- 40

rm(num_samples)

## errors and warnings - read them and try to fix

log("a_word")
## cannot take the log of a word
log_of_word <- log ("a_word")
## this thing not found - cannot find object or does not exist

## warnings - 
log_of_negative <- log(-2)

## challenge
elephant1_kg <-3492
elephant2_lb <-7757

elephant1_lb <- elephant1_kg * 2.2
elephant2_lb > elephant1_lb
myelephants <- c(elephant1_lb, elephant2_lb)

which (myelephants == max(myelephants))
