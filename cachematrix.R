## Put comments here that give an overall description of what your
## functions do

## These functions create a matrix and its inverse, caching the 
## inverse in the event that the original matrix is unchanged.

## Write a short comment describing this function

## The makeCacheMatrix function creates a matrix based on user input
## and caches an inverse of that matrix, assuming inputs do not change.

makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  setMat <- function(y) {
    x <<- y
    inv <<- NULL
  }
  getMat <- function() x
  setInv <- function(inverse) inv <<- inverse
  getInv <- function() inv
  list(setMat = setMat, getMat = getMat,
       setInv = setInv,
       getInv = getInv)
}

## Write a short comment describing this function
## Utilizes objects from the previous function to create the inverse Matrix to be cached in makeCacheMatrix
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  inv<- x$getInv()  
  if(!is.null(inv)) {
    message("getting cached data")
    return(inv)
  }
  data <- x$getMat()
  inv <- solve(data, ...)
  x$setInv(inv)
  inv
  }
