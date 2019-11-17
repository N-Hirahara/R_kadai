wd <- read.csv("6/weather_all.csv", header=TRUE, sep=",")
# 晴れの割合，平均最高気温，平均最低気温，合計降水量からなるデータを作成
fr <- rep(0, 47)
hm <- rep(0, 47)
lm <- rep(0, 47)
sm <- rep(0, 47)
for(i in 1:47)
{
	wi <- wd[wd$prefid==i,]
	fr[i] <- nrow(wi[wi$weather=="Fine",])/nrow(wi)
	hm[i] <- mean(wi$temphigh)
	lm[i] <- mean(wi$templow)
	sm[i] <- sum(wi$precipitation)
}
wstat <- data.frame(fineratio=fr, highmean=hm, lowmean=lm, sumprecipitation=sm, row.names=unique(wd$city))
write.table(wstat, file="6/wstat.csv", row.names=TRUE, col.names=TRUE, sep=",")