export_png <- function(x, path) {
  png(path)
  x
  dev.off()
}
