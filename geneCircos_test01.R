library(circlize)
Gene = c('TP53',"TP63","TP73")
start = c(7565097,189349205,3569084)
end = c(7590856,189615068,3652765)
Example = data.frame(Gene=Gene,start=start,end=end)
circos.initializeWithIdeogram(plotType = NULL)
circos.par('gap.degree' = 4)
circos.par('start.degree'=30)
circos.genomicInitialize(Example)
circos.genomicTrackPlotRegion(ylim=c(0,1),
                              bg.col=c("yellow","light blue","red"),
                              bg.border = 1,track.height = 0.05)
circos.clear()
