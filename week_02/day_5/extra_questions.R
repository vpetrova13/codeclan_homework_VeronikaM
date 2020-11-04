#Extra week 2 questions.
#Q1
my_double <- c(10.5394080948, 4.903853499)
my_integer <- c(2L, 3L)
my_character <- c("na", "ma")
my_factor <- c("male", "female", "male", "female")
my_logical <- c(TRUE, FALSE)
class(my_factor)
is.factor(my_factor)

as.character(my_double)
numbers_character <- c("5", "4", "5")
as.factor(numbers_character)

#Q2
fib <- c(1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233)
fib + 377
sort(fib, decreasing = TRUE)
fib %% 2
sum(fib%%2)     
length(fib)
4/13*100
fib[10]

golden_ratio <- (1 + sqrt(5)) /2
golden_ratio

n_element <- (golden_ratio^10 - (1 - golden_ratio)^10)/sqrt(5)
n_element

one_element <- (golden_ratio^c(1:16) - (1 - golden_ratio)^c(1:16))/sqrt(5)
one_element

two_element <- (golden_ratio^c(1:17) - (1 - golden_ratio)^c(1:17))/sqrt(5)
two_element

ratio <- two_element/two_element
ratio

#Q3

input <- function(x) {
  if (x < 10) {
    print(paste("The answer is", x, sep = " "))}
  if (x>=10) {
    y <- x/10
    print(paste("The answer is", y, sep = " ")) } else {
      print("Invalid input")
    }
}

input(10)

equal <- function(vector1, vector2) {
  if (all(vector1 == vector2)) {
    return("Exactly the same")
  } if (all(sort(vector1) == sort(vector2))) {
    return("The same") } 
    return("Different") }

x<- c(1, 2, 3)
y<- c(2, 1, 5)

is_same_vector <- function(vector_1, vector_2) {
  if (all(vector_1 == vector_2)) {
    return("Exactly the same")
  }
  
  if (all(sort(vector_1) == sort(vector_2))) {
    return("The same")
  }
  
  return("Different")
}

is_same_vector(x, y)

characters <-
  list(
    list(name = "Homer", age = 36, gender = "Male"),
    list(name = "Marge", age = 36, gender = "Female"),
    list(name = "Bart", age = 10, gender = "Male"),
    list(name = "Lisa", age = 8, gender = "Female"),
    list(name = "Maggie", age = 1, gender = "Female")
  )


df <- data.frame(matrix(unlist(characters), ncol = 3, byrow = T)
                 , stringsAsFactors = FALSE)
df
class(df)
mean(df$X2)
