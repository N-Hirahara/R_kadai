library(igraph)

# グラフ読み込み
g <- read.graph("2/japangraph_pajek_xy2_eng.net", format="pajek")
# グラフの各点の次数を取る
degs <- degree(g, V(g), mode="all")
# 次数のヒストグラム表示
png("2/degs_hist.png")
hist(degs, breaks=0:max(degs))
dev.off()
# 各点ごとの次数を棒グラフ表示
png("2/city_degs_plot.png")
barplot(degs, las=2, xlab='city', ylab='degrees', cex.names=.6)
dev.off()

# グラフを表示，次数が大きいほど点のサイズを大きく表示
png("2/degs_size_map.png")
plot(g, vertex.size=degs*1.5, vertex.label.cex=.5)
dev.off()
# 全ての点のうち次数が最大の点を赤色で示し，それらの点に限りidを付与して表示
png("2/visualize_max_degs.png")
V(g)$color <- "lightblue"
V(g)[which(degs==max(degs))]$color <- "red"
g_tmp <- g
V(g_tmp)$name = ""
V(g_tmp)[which(degs==max(degs))]$name <- V(g)[which(degs==max(degs))]$name
plot(g_tmp, vertex.size=degs*1.5, vertex.label.cex=1)
dev.off()