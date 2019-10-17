# ２つのサイコロを振る
set.seed(2)
d1 <- sample(1:6, 100, replace=TRUE)
set.seed(8)
d2 <- sample(1:6, 100, replace=TRUE)

# 出目のヒストグラムを同時に表示・保存
png("1/d1_d2_hist.png")
hist(d1, breaks=0:6, col="#ff00ff40", border="#ff00ff", ylim=c(0,30), main="dice1 & dice2", xlab="", ylab="Count")
hist(d2, breaks=0:6, col="#0000ff40", border="#0000ff", add=TRUE)
legend("topright", legend=c("dice1", "dice2"), col=c("#ff00ff40","#0000ff40"), pch=16)
dev.off()

# 出目の合計をヒストグラムで表示・保存
png("1/d1+d2_hist.png")
hist(d1+d2, breaks=0:12, ylim=c(0,20), main="dice1 + dice2", xlab="" ,ylab="Count")
dev.off()