library(circlize)
par(mar = c(1, 1, 1, 1))

factors <- letters[1:8]
#初始化# 绘制三个track，并显示具体信息
circos.initialize(factors = factors, xlim = c(0, 1)) 
for (i in 1:3){
  circos.trackPlotRegion(ylim = c(0,1))
}
circos.info(plot=TRUE)
#通过draw.sector（）高亮某一sector，比如a
draw.sector(get.cell.meta.data("cell.start.degree",sector.index = "a"),
            get.cell.meta.data("cell.end.degree",sector.index = "a"),
            rou1 = 1,col = "pink")
#高亮某一track，比如第一个track
draw.sector(0,360,rou1 = get.cell.meta.data("cell.top.radius",track.index = 1),
            rou2 = get.cell.meta.data("cell.bottom.radius",track.index = 1),
            col = "red")
#高亮某一sector
draw.sector(get.cell.meta.data("cell.start.degree",sector.index = "e"),
            get.cell.meta.data("cell.end.degree",sector.index = "f"),
            get.cell.meta.data("cell.top.radius",track.index = 2),
            get.cell.meta.data("cell.bottom.radius",track.index = 3),
            col="green")
circos.clear()
