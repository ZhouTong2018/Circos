library(circlize)
library(dplyr)
df <- data.frame(factors = sample(letters[1:6], 100, replace = TRUE),
                 x = rnorm(100),
                 y = rnorm(100),
                 stringsAsFactors = FALSE)
#放大a，b区域
zoom_df <- df %>% dplyr::filter(factors %in% c("a","b"))
zoom_df$factors <- paste0("zoom_",zoom_df$factors)
df2 <- rbind(df,zoom_df)
xrange <- tapply(df2$x,df2$factors,function(x) max(x)-min(x))
normal_sector_index <- unique(df$factors)
zoomed_sector_index <- unique(zoom_df$factors)
sector.width <- c(xrange[normal_sector_index]/sum(xrange[normal_sector_index]),
                  xrange[zoomed_sector_index]/sum(xrange[zoomed_sector_index]))
#绘图
par(mar = c(1, 1, 1, 1))
circos.par(start.degree = 90)
circos.initialize(df2$factors, x = df2$x, sector.width = sector.width)
circos.trackPlotRegion(df2$factors, x = df2$x, y = df2$y,
                       panel.fun = function(x, y) {
                         circos.points(x, y, col = "red", pch = 16, cex = 0.5)
                         xlim = get.cell.meta.data("xlim")
                         ylim = get.cell.meta.data("ylim")
                         sector.index = get.cell.meta.data("sector.index")
                         circos.text(mean(xlim), mean(ylim), sector.index, niceFacing = TRUE)})
#添加links
circos.link("a",get.cell.meta.data("cell.xlim",sector.index = "a"),"zoom_a",
            get.cell.meta.data("cell.xlim",sector.index = "zoom_a"),border=NA,col = "red")
circos.clear()
