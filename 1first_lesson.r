#general----
ls()#To have a list of the objects currently present in the workspace – i.e. the current R session – type:
rm(z) #To remove objects, for example "z", type:

#VECTORS---- 
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
#Factor----
f<-factor(c(rep("treatmentA",5),rep("treatmentB",3),"treatmentC"))
f

#type of vector----
class(labels) # character
class(v) # integer
class(w) # numeric
class(f) # factor
#NUMERICAL VECTORS – BASIC STATS----
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
         
#MATRICES ----
M=matrix(1:12,nrow=3,byrow=T) # the option ‘byrow=T’ implies that the matrix is filled by rows.

#We can edit row and column names of the matrix as follows:
rownames(M)=c("A","B","C")
colnames(M)=c("I","II","III","IV")
M
#We can transpose the matrix:

M2=t(M) #change the orientation

dim(M) # outputs the number of rows and columns
class(M) # identifies the class of the object M

#As for rbind and cbind:
a=1:7
b=8:14
abc=rbind(a,b) # combine vectors a and b as rows of a matrix
abr=cbind(a,b) # combine vectors a and b as columns of a matrix

abc
abr

#DATA FRAMES----
var1=c(1:10)
var2=c(16:25)
var3=c(rep("a",2), rep("b",5), rep("c",3))
DF=data.frame(var3,var2,var1) 
df

summary(DF)

class(DF) # class of the data frame
dim(DF) # number of observations and variables
names(DF) # extracts the column names
head(DF) # shows the first rows of the data frame (by default 6)
tail(DF) # shows the last columns of the data frame (by default 6)
str(DF) # information about the structure of the data
summary(DF) # summary statistics for each variable of the data frame (note the different behaviors with numeric and qualitative variables)

#DATA IMPORT/EXPORT----
getwd()
setwd("D:/Desktop/Statistics/first lesson")
data=read.table("alkfos.txt",header=T)
#OR
test<-read.csv("alkfos.csv")

write.table(data,file="alkfos.csv",row.names=F,col.names=T,quote=F,sep=",")

#SELECTING/MANIPULATING DATA FRAMES WITH INDEXES----

data[1,1] # extracts the first element of the first column of data
data[3,2] # extracts the third element of the second column of data
data[1:3,2:5] # extracts the first three elements of columns from 2 to 5
data[1,] # extracts all elements of first row
data[,1] # extracts all elements of first column
data[,c(1,3,5)] # extracts all elements from columns 1, 3 and 5
data[,-c(1,3,5)] # extracts all elements but those from columns 1, 3 and 5

#The same formats can be used for substituting elements of the data frame:
data[3,2]=100 # substitutes the selected element with 100
data[,4]=data[,6] # substitutes the content of column 4 with that of column 6
data$c18=data$c24 # substitutes the content of the column ‘c18’ with the one of column ‘c24’

#SAVING THE SESSION----
#After completing these operations, the current workspace has been populated by a series of objects. To
#have a list of them:
ls()
#If you wish to save a copy of the whole workspace, type:
save.image(file="TEST.RData")

#In order to save the history of the used commands, type:
savehistory("history.txt")
#which outputs a plain text file. 
