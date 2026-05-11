library(plotly)
library(htmlwidgets)

save_slide_plot <- function(plot_obj, filename) {
  # 1. Strip margins
  p <- plot_obj %>% layout(margin = list(l=0, r=0, b=0, t=0, pad=0))
  
  # 2. Save with strict sizing policy
  saveWidget(
    p, 
    file.path("media/plots", filename),
    selfcontained = TRUE,
    sizingPolicy = sizingPolicy(padding = 0, browser.fill = TRUE)
  )
}
