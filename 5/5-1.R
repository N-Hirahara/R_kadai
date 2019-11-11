library(arules)
wd <- read.csv("5/weather_all.csv", header=TRUE, sep=",")

# csv作成
allmatched <- which(wd$city=="Nara" & 2005<=wd$year & wd$year<=2009)
w0 <- wd$weather[allmatched]
w1 <- wd$weather[allmatched-1]
w2 <- wd$weather[allmatched-2]
w3 <- wd$weather[allmatched-3]
wd.nara <- data.frame(month=wd$month[allmatched], weather=w0, weather1=w1, weather2=w2, weather3=w3)
write.table(wd.nara, file="5/weather_nara.csv", row.names=FALSE, col.names=TRUE, sep=",")

allmatched <- which(wd$city=="Hiroshima" & 2005<=wd$year & wd$year<=2009)
w0 <- wd$weather[allmatched]
w1 <- wd$weather[allmatched-1]
w2 <- wd$weather[allmatched-2]
w3 <- wd$weather[allmatched-3]
wd.hiroshima <- data.frame(month=wd$month[allmatched], weather=w0, weather1=w1, weather2=w2, weather3=w3)
write.table(wd.hiroshima, file="5/weather_hiroshima.csv", row.names=FALSE, col.names=TRUE, sep=",")

# 作成したcsvの読み込み
wNara <- read.csv("5/weather_nara.csv", header=TRUE, sep=",", colClasses="factor")
wHiroshima <- read.csv("5/weather_hiroshima.csv", header=TRUE, sep=",", colClasses="factor")

# 分析(Nara)
wtran_nara <- as(wNara, "transactions")
finerule_nara <- apriori(wtran_nara, parameter=list(maxlen=5, supp=0.06, conf=0.60, ext=TRUE), appearance=list(rhs="weather=Fine", default="lhs"))
# inspect(sort(finerule_nara, decreasing=TRUE, by="confidence")[1:5,])
# subsetの作成
finerule_nara.sub <- subset(finerule_nara, subset=(lift>1.0))
inspect(sort(finerule_nara.sub, decreasing=TRUE, by="confidence")[1:10,])

# 分析(Hiroshima)
wtran_hiroshima <- as(wHiroshima, "transactions")
finerule_hiroshima <- apriori(wtran_hiroshima, parameter=list(maxlen=5, supp=0.06, conf=0.60, ext=TRUE), appearance=list(rhs="weather=Fine", default="lhs"))
# inspect(sort(finerule_hiroshima, decreasing=TRUE, by="confidence")[1:5,])
# subsetの作成
finerule_hiroshima.sub <- subset(finerule_hiroshima, subset=(lift>1.0))
inspect(sort(finerule_hiroshima.sub, decreasing=TRUE, by="confidence")[1:10,])