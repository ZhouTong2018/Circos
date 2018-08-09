library(circlize)
set.seed(1234)
data <- matrix(rnorm(100 * 10), nrow = 10, ncol = 100)
col <- colorRamp2(c(-2, 0, 2), c("green", "black", "red"))
factors <- rep(letters[1:2], times = c(30, 70))
data_list <- list(a = data[, factors == "a"], b = data[, factors == "b"])
dend_list <- list(a = as.dendrogram(hclust(dist(t(data_list[["a"]])))),
                  b = as.dendrogram(hclust(dist(t(data_list[["b"]])))))
circos.par(cell.padding = c(0, 0, 0, 0), gap.degree = 5)
circos.initialize(factors = factors, xlim = cbind(c(0, 0), table(factors)))
#热图
circos.track(ylim = c(0, 10), bg.border = NA,
             panel.fun = function(x, y) {
               sector.index = get.cell.meta.data("sector.index")
               d = data_list[[sector.index]]
               dend = dend_list[[sector.index]]
               d2 = d[, order.dendrogram(dend)]
               col_data = col(d2)
               nr = nrow(d2)
               nc = ncol(d2)
               for (i in 1:nr) {
                 circos.rect(1:nc - 1, rep(nr - i, nc), 1:nc, rep(nr - i + 1, nc),
                             border = col_data[i, ], col = col_data[i, ]) }})
#进化树
max_height <- max(sapply(dend_list, function(x) attr(x, "height")))

circos.track(ylim = c(0, max_height),
             bg.border = NA, track.height = 0.3,
             panel.fun = function(x, y) {
               sector.index = get.cell.meta.data("sector.index")
               dend = dend_list[[sector.index]]
               circos.dendrogram(dend, max_height = max_height)})
circos.clear()
