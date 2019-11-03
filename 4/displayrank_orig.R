display_rank <- function(g, score, sep=10)
{
  n <- length(score)
  rnk <- n - rank(score)
  rcls <- rnk %/% sep
  cols <- heat.colors(n %/% sep + 1)
  for(i in 1:n)
  {
    V(g)[i]$color <- cols[rcls[i]+1]
  }
  xy <- cbind(V(g)$x, V(g)$y)
  tkplot(g, layout=xy, vertex.label=V(g)$id)
}
