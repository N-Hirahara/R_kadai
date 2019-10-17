# ２つのベクトルの内積を求める関数
inner <- function(v1, v2){
	if(length(v1)==length(v2)){
		sum <- 0
		for(i in 1:length(v1)){
			sum <- sum + v1[i]*v2[i]
		}
		return(sum)
	} else {
		stop("Error: The lengths of the vectors are different. v1:", length(v1),", v2:",length(v2))
	}
}

# for test
v1 <- c(1,2,3)
v2 <- c(4,5,6)
v2_ <- c(4,5,6,7,8)

# good case
print(inner(v1, v2))
# bad case
print(inner(v1, v2_))

# inner product in R
# good case
print(v1 %*% v2)
# bad case
print(v2 %*% v2_)