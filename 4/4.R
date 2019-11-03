# 4-1
library(igraph)
source("4/displayrank.R")

# オリジナルのデータ
g_orig <- read.graph("4/japangraph_pajek_xy2_eng_orig.net", format="pajek")
rank_score_orig <- page.rank(g_orig, damping=0.85, weights=NA)$vector
png("4/img_rank_orig.png")
display_rank(g_orig, rank_score_orig, sep=5)
dev.off()
png("4/bar_rank_orig.png")
barplot(rank_score_orig, las=2, xlab='city', ylab='score', cex.names=.6, ylim=c(0,0.1))
dev.off()

# Edges → Arcs
g_arcs <- read.graph("4/japangraph_pajek_xy2_eng_arcs.net", format="pajek")
rank_score_arcs <- page.rank(g_arcs, damping=0.85, weights=NA)$vector
png("4/img_rank_arcs.png")
display_rank(g_arcs, rank_score_arcs, sep=5)
dev.off()
png("4/bar_rank_arcs.png")
barplot(rank_score_arcs, las=2, xlab='city', ylab='score', cex.names=.6, ylim=c(0,0.1))
dev.off()

# 辺の追加 大阪→東京(50)，東京→札幌(100)，大阪→博多(100)
g <- read.graph("4/japangraph_pajek_xy2_eng.net", format="pajek")
rank_score <- page.rank(g, damping=0.85, weights=NA)$vector
png("4/img_rank.png")
display_rank(g, rank_score, sep=5)
dev.off()
png("4/bar_rank.png")
barplot(rank_score, las=2, xlab='city', ylab='score', cex.names=.6, ylim=c(0,0.1))
dev.off()

# 次数(各頂点に向く辺の数)によって頂点のサイズを変更
degs_in <- degree(g, V(g), mode="in")
png("4/img_rank_w_degree.png")
display_rank_w_degs(g, rank_score, degs_in, sep=5)
dev.off()
