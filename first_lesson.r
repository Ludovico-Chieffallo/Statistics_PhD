#This is the first lesson of statistics (Mandatory exam PhD)
#list objects----
#To have a list of the objects currently present in the workspace – i.e. the current R session – type:
ls()

#remove objects----
#To remove objects, for example "z", type:
rm(z) 

#VECTORS---- 
#In R vectors are sets of ordered elements. These elements are called components of the vector.
#Similarly to variables, sectors may be composed by numeric values, characters, logical values or
#factorial values. However the content of a vector must be homogeneous. For instance, a vector cannot
#contain at the same time numbers and characters.
#Three main R functions are used to generate vectors: c, seq and rep. Functions c and rep can be used
#with any kind of vectors, while seq is specifically designed for numbers. 

#c command ----
v<-c(1,3,7) # “concatenates” numbers 1, 3 e 5 in a (numeric) vector called v
v1<-c(1:5) # shortcut for integer numbers from 1 to 5 (of course overwriting the previous version of v)
v2<-1:5 # as above
v3<-c(1:5,12:16,35:43) # concatenates different sequence of numbers
s<-c("a","j","o") # example with characters 


#seq command (only for numbers)----
w<-seq(4,10) # sequence from 4 to 10 with default increment (that is 1)
w1<-seq(4,10,2) # sequence from 4 to 10 with increment 2
w2<-seq(0.3,0.5,0.001) # example with decimals 

#rep command----
z<-rep(1,100) # generates 100 repetitions of the number 1
z1<-rep(c(7,9,13),3) # the sequence 7, 9, 13 is repeated 3 times. Note that we are using a function within another function.
z2<-rep(c(7,9,13),1:3) # The function rep(c(7,9,13),1:3) in R will repeat the elements of the vector c(7,9,13) a number of times 
                       #specified by the elements of the vector 1:3. The first element in the first vector (7) will be repeated once, the second element (9) will be repeated twice,
                       #and the third element (13) will be repeated three times. The output will be the following vector: c(7, 9, 9, 13, 13, 13).


#Built-in vectors----
#R contains some built-in vectors, for example:
letters # all lower case letters of the alphabet
LETTERS # all upper case letters of the alphabet
month.name # names of the months
#ecc


#paste function----
#The function paste can be used for pasting together, element-by-element, two vectors. The output of
#paste is a character vector. For example: 
labels<-paste(rep("A",10),1:10,sep="_") 
labels

#Factor function----
#Besides numbers and characters, vectors can also contain qualitative variables. These variables, which
#in R are called “factorial variables”, are not numerical and describe data by fitting them into categories.
#(For example the treatment type in medical trials). Since the different states of a factorial variables are
#usually described by characters (“treatmentA”, “treatmentB”, “treatmentC”, etc.), we must inform R
#that those characters are in fact the states of a qualitative variable. One way for doing this is to use the
#factor function as follows:
f<-factor(c(rep("treatmentA",5),rep("treatmentB",3),"treatmentC"))
f

#type of vector----
#How do we know the content type of a vector? For example using the class function.
class(labels) # character
class(v) # integer
class(w) # numeric
class(f) # factor
#exercise----
#Exercise 1: construct a vector containing integer odd numbers between 1 and 15, and repeat the
#sequence 5 times. Check the class of the vector.

es1<- rep(seq(1,15,2),5)
es1
class(es1)

#Exercise 2: paste element-by-element two vectors that respectively comprise: a) capital letters of the
#alphabet; b) the numeric sequence of integer numbers from 1 to 26. Check the class of the vector. 

es2<- paste(LETTERS, 1:26, sep = "-")
es2

#NUMERICAL VECTORS – BASIC STATS----
#A number of functions implements all the basic statistics on a set of numbers:
length(z) # number of the vector’s elements (note that this works with all vectors)
min(z) # vector’s minimum value
max(z) # vector’s maximum value
sum(z) # sum of all vector’s values
mean(z) # mean of the vector’s values
median(z) # median of the vector’s values
var(z) # variance of the vector’s values
sd(z) # standard deviation of the vector’s values
quantile(z,0.25) # 25% quantile (i.e. first quartile) of the vector’s values
quantile(z,c(0.25,0.75) # 25% and 75% quantiles (i.e. first and third quartile) with a single command

#A nice way for having (almost) all these statistics with one line is:
summary(z)
        
#It is worth observing that summary works also – albeit in a different way – for factorial vectors:
summary(f) #we will receive the number of repetitions of the qualitative objects4


#NUMERICAL VECTORS – RANDOM SAMPLING AND SELECTION OF ELEMENTS----

#The function “sample” extracts random elements from a vector:
r=sample(1:10,6) # extracts 6 random numbers from the integer 1-10 sequence
r=sample(1:10,6,replace=T) # as above, but with replacement (i.e. the possibility of extracting a single element more than one time)

#The squared brackets [ ] are used in R for selecting specific elements from a vector or more complex objects. For instance:
r[1] # extracts the first element of the vector (works also with non-numeric vectors)
r[c(1,3)] # extracts the first and third elements of the vectors (also non-numeric)

#Importantly, squared brackets can be used for selecting elements that satisfy a given condition:

b=r>5 # generates a boolean vector (TRUE/FALSE) that identifies which elements of R satisfy (TRUE) or do not satisfy (FALSE) the condition of being higher than 5;
r1=r[b] # we extract (or filter) in r1 only the elements of r satisfying the condition.

#These two lines can be synthesized as:
r1=r[r>5]

#exercise----
#After generating a vector containing all numbers from 0.001 to 1 with an increment of 0.001
#(that is 0.001, 0.002, …, 0.999, 1), extract a new vector comprising 100 random elements from the
#previous one. Calculate the basic statistics (using the above functions) of the second vector. As for
#quantiles, calculate all deciles values (i.e. 10%, 20%, …, 80%, 90% quantiles). Finally, select (from the second vector) all elements lower than 0.3. 

es3<-seq(0.001,1,0.001)                   
sample_es3<-sample(es3,100, replace = T)
sample_es3

summary(sample_es3)
sd(sample_es3)
var(sample_es3)

quantile(sample_es3)
quantile(sample_es3,seq(0.10,1, 0.10))

#MATRICES ----
#In R matrices are sets of elements ordered according to two dimensions, i.e. rows and columns.
#Similarly to vectors, the content of matrices must be homogeneous, that is, for instance, all elements of
#a matrix are numbers or all elements are characters. In other words, a matrix cannot contain at the same
#time numbers and characters.
#There are a few functions for creating matrices in R, most notably functions matrix, rbind and cbind.
#The following line creates a matrix containing integer numbers from 1 to 12 according to 3 rows (and 4
                                                                                                 columns).
M=matrix(1:12,nrow=3,byrow=T) # the option ‘byrow=T’ implies that the matrix is filled by rows.

#We can edit row and column names of the matrix as follows:
rownames(M)=c("A","B","C")
colnames(M)=c("I","II","III","IV")
M
#We can transpose the matrix:

M2=t(M) #change the orientation
M2

#In addition, there are a couple of ‘exploratory’ functions useful for matrices:
dim(M) # outputs the number of rows and columns
class(M) # identifies the class of the object M

#As for rbind and cbind:
a=1:7
b=8:14
abc=rbind(a,b) # combine vectors a and b as rows of a matrix
abr=cbind(a,b) # combine vectors a and b as columns of a matrix

abc
abr

#Exercise DA FARE!!!----
#Generate a matrix containing: a) odd numbers from 1 to 10; b) even numbers from 2 to 10; c)
#five repetitions of the number zero. The matrix should have five rows and should be filled by columns.
#Finally, edit the row and columns names as you like. 
#DATA FRAMES----
#Data frames are probably the most important class of R objects, since they are designed to organize
#experimental data upon which statistical analyses are performed. In practice, they are two-dimensional
#objects with rows and columns, similarly to matrices. However, in data frames rows correspond to
#experimental observations and columns to the variables measured/described in the experiment. Since
#experiments may yield different classes of variables at the same time (numerical, qualitative/factorial,
#boolean…), data frames allow their co-existence in the same object (differently from matrices, that must be homogeneous).
#We can build simple data frames in R with the following procedure: 
var1=c(1:10)
var2=c(16:25)
var3=c(rep("a",2), rep("b",5), rep("c",3))
DF=data.frame(var3,var2,var1) 
df
summary(DF)

#Here, the function data.frame combines 3 vectors – that correspond to different variables, two numeric
#and one qualitative – in a single object in which variables by default are the columns of the data frame.
#In order to explore the content of the data frame, we can use these functions:
class(DF) # class of the data frame
dim(DF) # number of observations and variables
names(DF) # extracts the column names
head(DF) # shows the first rows of the data frame (by default 6)
tail(DF) # shows the last columns of the data frame (by default 6)
str(DF) # information about the structure of the data
summary(DF) # summary statistics for each variable of the data frame (note the different behaviors with numeric and qualitative variables)

#exercise----
#Generate a data frame with the following variables: a) integer numbers from 1 to 50, b) a
#logical variable with 30 TRUE instances and 20 FALSE instances, c) five repetitions of the last 10
#capital letters in alphabetical order. Explore the data frame using the above functions.

primo<-c(1:50)
secondo<- c(rep("TRUE",30),rep("FALSE", 20)) #or HERE secondo<-n1<31
terzo<-rep(LETTERS [17:26],5) #or terzo<-LETTERS [17:26] or factor(LETTERS [17:26])
terzo

df1<-data.frame( primo,secondo,terzo)
df1

summary(df1)


#DATA IMPORT/EXPORT----
getwd()
setwd("D:/Desktop/Statistics/first lesson")
data=read.table("alkfos.txt",header=T)

#The argument ‘header=T’ indicates that the first row of the imported dataset contains the ‘headers’, that
#is the column/variable names. (The default is F).
#The function read.table has many other useful arguments (see ?read.table for a complete list) that can
#be used for correctly importing the data. For instance, if the text separator (i.e. what separates the data
#columns in the original file) is different from space or tab – which are the default options – this must be
#specified with the argument ‘sep’ (for example sep=";"). Similarly, the default decimal separator in R is
#a point (like in 0.23); if the input file has a different decimal separator, for instance the comma (e.g.
#0,23), this must be specified with the argument ‘dec’ (in this case dec=","). 

#OR
test<-read.csv("alkfos.csv") #the difference between read.csv and read.csv2 is the separator where in read.csv it is ","(decimal separator ".") 
#while in read.csv2 it is ";" (decimal separator",")

#Files in .csv format are particularly useful because they are easily generated (or imported) by
#spreadsheet programs such as Excel and LibreOffice, thus they can work as an intermediate between
#the spreadsheet and R. 

#The basic function for EXPORTING data from R is write.table. This function applies to a data frame and
#outputs a plain text file which is saved in the working directory. We can use this function to export the
#previously imported dataset (alkfos) with the format of a .csv file:
write.table(data,file="alkfos.csv",row.names=F,col.names=T,quote=F,sep=",")

#SELECTING/MANIPULATING DATA FRAMES WITH INDEXES----
#Analogously to vectors, elements of data frames (and matrices) can be selected using indexes
#surrounded by squared brackets according to the following format:
#my.data.frame[row_numbers,column_numbers]
#For example:
data[1,1] # extracts the first element of the first column of data
data[3,2] # extracts the third element of the second column of data
data[1:3,2:5] # extracts the first three elements of columns from 2 to 5
data[1,] # extracts all elements of first row
data[,1] # extracts all elements of first column
data[,c(1,3,5)] # extracts all elements from columns 1, 3 and 5
data[,-c(1,3,5)] # extracts all elements but those from columns 1, 3 and 5

#As for columns, it is possible to select them by names using the $ symbol, for example:
data$c0 # selects the column/variable named c0

#The same formats can be used for substituting elements of the data frame:
data[3,2]=100 # substitutes the selected element with 100
data[,4]=data[,6] # substitutes the content of column 4 with that of column 6
data$c18=data$c24 # substitutes the content of the column ‘c18’ with the one of column ‘c24’

#Exercise  DA FARE!!----
#Given the excel file “rats.xls”, 1) export its content as a plain text file (.txt or .csv), 2) import
#the file in R using the appropriate function, 3) calculate mean, variance and standard deviation for all
#the variables of the dataset, 4) remove the second column, 5) export the modified dataset as a plain text
#file (.csv file if the imported file was .txt, .txt if the imported file was .csv). 
setwd("D:/Desktop/Statistics/first lesson/R")
getwd()
install.packages("readxl")
library(readxl)
library(dplyr)
dati <- read_excel("rats.xls")
mean(dati$Glycogen)
mean(dati$Treatment)
mean(dati$Rat)
mean(dati$Liver)
#Use summary, is better
summary(dati)


var(dati)

sd(dati$Glycogen)
sd(dati$Treatment)
sd(dati$Rat)
sd(dati$Liver)
#or you can use apply() (is like a loop)
apply(dati,2, sd)


rats<-dati[,-2]
#or manually
dati<-dati %>% 
  select("Glycogen","Rat","Liver")

write.table(dati,file="dati.csv",row.names=F,col.names=T,quote=F,sep=",")



#SAVING THE SESSION----
#After completing these operations, the current workspace has been populated by a series of objects. To
#have a list of them:
ls()

#If you wish to save a copy of the whole workspace, type:
save.image(file="TEST.RData")
#Note that the .RData extension is mandatory in Windows, while the name of the file is of course your
#choice! Similarly to write.table, the workspace is saved in the current working directory.

#In order to save the history of the used commands, type:
savehistory("history.txt")
#which outputs a plain text file. 
