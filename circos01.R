library(circlize)
set.seed(1000)
n <- 1000
a <- data.frame(factors = sample(letters[1:8], n, replace = TRUE), x = rnorm(n), y = runif(n)) 

par(mar = c(1, 1, 1, 1), lwd = 0.5, cex = 0.6)
circos.par(track.height = 0.1)
#初始化
circos.initialize(factors = a$factors, x = a$x)
#创建第一层track
circos.trackPlotRegion(factors = a$factors, y = a$y,
                       panel.fun = function(x,y){circos.axis()})
col <- rep(c("#FF0000", "#00FF00"), 4)
circos.trackPoints(a$factors, a$x, a$y, col = col, pch = 16, cex = 0.5)
#标记
circos.text(-1, 0.5, "left", sector.index = "a", track.index = 1)
circos.text(1, 0.5, "right", sector.index = "a")
bg.col <- rep(c("#EFEFEF", "#CCCCCC"), 4)
#第二层
circos.trackHist(a$factors, a$x, bg.col = bg.col, col = NA)
#第三层
circos.trackPlotRegion(factors = a$factors, x = a$x, y = a$y,
                       panel.fun = function(x,y){
                         grey=c("#FFFFFF","#CCCCCC","#999999")
                         sector.index = get.cell.meta.data("sector.index")
                         xlim = get.cell.meta.data("xlim")
                         ylim = get.cell.meta.data("ylim")
                         circos.text(mean(xlim),mean(ylim),sector.index)
                         circos.points(x[1:10],y[1:10],col="red",pch = 16,cex=0.6)
                         circos.points(x[11:20],y[11:20],col="blue",cex = 0.6)
                       })
#update第二个track中标记为d的sector
circos.updatePlotRegion(sector.index = "d",track.index = 2)
circos.points(x=-2:2,y=rep(0,5))
xlim <- get.cell.meta.data("xlim")
ylim <- get.cell.meta.data("ylim")
circos.text(mean(xlim),mean(ylim),"updated")
#第四层
circos.trackPlotRegion(factors = a$factors, y = a$y)
circos.trackLines(a$factors[1:100], a$x[1:100], a$y[1:100], type = "h")
#links
circos.link("a",0,"b",0,h=0.3)#点对点
#区域对区域
circos.link("c",c(-0.5,0.5),"d",c(-0.5,0.5),col="red",border = NA,h=0.2)
#点对区域
circos.link("e",0,"g",c(-1,1),col="green",border = "black",lwd = 2,lty = 2)
circos.clear()

