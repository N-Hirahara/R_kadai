library(HMM)

hmm <- initHMM(
	c("Fair", "Unfair"),
	c("1","2","3","4","5","6"),
	startProbs=c(0.5,0.5),
	transProbs=matrix(
		c(0.95,0.05,0.1,0.9),
		byrow=T, nrow=2
	),
	emissionProbs=matrix(
		c(1/6,1/6,1/6,1/6,1/6,1/6,
		0.1,0.1,0.1,0.1,0.1,0.5),
		byrow=T,nrow=2
	)
)

simulate_viterbi <- function(hmm, trials){
	simulation <-simHMM(hmm,trials)
	guess <- viterbi(hmm, simulation$observation)
	print("== observations ==")
	print(simulation$observation)
	print("== states ==")
	print(simulation$states)
	print("== predictions (viterbi) ==")
	print(guess)
	
	print("== accuracy ==")
	print(accuracy <- sum(simulation$states==guess)/trials)
#	print("== rate of 6 ==")
#	print(rate_6 <- sum(simulation$observation=="6")/trials)
#	print("==Fair vs Unfair in predictions==")
#	paste(sum(guess=="Fair")/trials, sum(guess=="Unfair")/trials)
	return(accuracy)
}

accs_hist <- function(hmm_trials, simulate_trials){
	accs = list(1:simulate_trials)
	for(n in 1:simulate_trials){
		accs[n] <- simulate_viterbi(hmm, hmm_trials)
	}
	png("9/accs_hist.png")
	hist(unlist(accs, use.names=FALSE), breaks=seq(0,1,0.05),
		main="Histogram of accuracy", xlab="accuracy")
	dev.off()
}
