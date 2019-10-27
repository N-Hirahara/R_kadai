# 3-1
library(igraph)
g <- read.graph("3/japangraph_pajek_xy2_eng.net", format="pajek")
kyoto <- which(V(g)$id=="Kyoto")
from_Kyoto <- shortest.paths(g, v=kyoto, mode="all")
png("3/from_Kyoto_original.png")
barplot(from_Kyoto, las=2, xlab='city', ylab='from Kyoto', cex.names=.6, ylim=c(0,800) )
dev.off()

# 3-2 データファイルの編集、移動時間の変更、辺の追加
osaka <- which(V(g)$id=="Osaka")
tokyo <- which(V(g)$id=="Tokyo")
sapporo <- which(V(g)$id=="Sapporo")
hakata <- which(V(g)$id=="Hakata")
g_fixed <- add_edges(g, c(osaka, tokyo, tokyo, sapporo, osaka, hakata), weight=c(50, 100, 100))		# ここで負の値を入れたらエラー出る
from_Kyoto_fixed <- shortest.paths(g_fixed, v=kyoto, mode="all")
png("3/from_Kyoto_fixed.png")
barplot(from_Kyoto_fixed, las=2, xlab='city', ylab='from Kyoto', cex.names=.6,  ylim=c(0,800))
dev.off()

png("3/comparing.png")
barplot(from_Kyoto, las=2, xlab='city', ylab='from Kyoto', cex.names=.6, ylim=c(0,800), col="#00000040")
barplot(from_Kyoto_fixed, las=2, xlab='city', ylab='from Kyoto', cex.names=.6,  ylim=c(0,800), add=TRUE)
dev.off()

# 3-3
p <- get.shortest.paths(g, from=kyoto, to=tokyo)$vpath
E(g)$color <- "gray"
E(g)$width <- 1
E(g, path=p[[1]])$color <- "red"
E(g, path=p[[1]])$width <- 3
png("3/kyoto-tokyo_path_orig.png")
plot(g, vertex.size=4, vertex.label.cex=.5)
dev.off()

p_fixed <- get.shortest.paths(g_fixed, from=kyoto, to=tokyo)$vpath
E(g_fixed)$color <- "gray"
E(g_fixed)$width <- 1
E(g_fixed, path=p_fixed[[1]])$color <- "red"
E(g_fixed, path=p_fixed[[1]])$width <- 3
png("3/kyoto-tokyo_path_fixed.png")
plot(g_fixed, vertex.size=4, vertex.label.cex=.5)
dev.off()
