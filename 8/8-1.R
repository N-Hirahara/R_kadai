library(Biostrings)
data(BLOSUM62)

cycdata <- read.csv("8/cycsamples.csv", stringsAsFactors=FALSE)
scores <- matrix(0, nrow(cycdata), nrow(cycdata))
patterns <- matrix("", nrow(cycdata), nrow(cycdata))
subjects <- matrix("", nrow(cycdata), nrow(cycdata))

for(i in 1:nrow(cycdata)){
	for(j in 1:nrow(cycdata)){
		if(i==j) break
		else
		{
			p <- pairwiseAlignment(cycdata$sequence[i], cycdata$sequence[j], 
									substitutionMatrix=BLOSUM62, 
									gapOpening=-10, 
									gapExtension=-1, 
									type="global")
			scores[i,j] <- score(p)
			patterns[i,j] <- as.character(pattern(p))
			subjects[i,j] <- as.character(subject(p))
		}
	}
}

max_idx <- which(scores==max(scores), arr.ind=TRUE)
min_idx <- which(scores==min(scores[scores!=min(scores)]), arr.ind=TRUE)