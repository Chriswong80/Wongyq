
# R code for Xbar.one Control Chart
library(qcc)
library(ggplot2)
library(plotly)
library(htmlwidgets)

# Ensure 'X037' data is loaded
# X037 <- read.csv('path/to/your/X037.csv')

# Filter the data
filtered_data <- subset(X037, Machine == 1 & Temperature == 303 & Pressure == 100)

# Generate the qcc object (without plotting)
qcc_obj <- qcc(filtered_data$PartLength, type = 'xbar.one', plot = FALSE)

# Extract relevant data for ggplot
plot_data <- data.frame(
  Observation = 1:length(qcc_obj$data),
  PartLength = qcc_obj$data,
  CL = qcc_obj$center,
  LCL = qcc_obj$limits[1, 'LCL'],
  UCL = qcc_obj$limits[1, 'UCL']
)

# Create the ggplot object
plot_control_chart <- ggplot(plot_data, aes(x = Observation, y = PartLength)) +
  geom_line(color = '#0072B2') +
  geom_point(color = '#0072B2') +
  geom_hline(aes(yintercept = CL, linetype = 'CL'), color = 'red', size = 1) +
  geom_hline(aes(yintercept = LCL, linetype = 'LCL'), color = 'red', size = 0.8) +
  geom_hline(aes(yintercept = UCL, linetype = 'UCL'), color = 'red', size = 0.8) +
  scale_linetype_manual(name = 'Limits', values = c('CL' = 'solid', 'LCL' = 'dashed', 'UCL' = 'dashed')) +
  labs(
    title = 'Xbar.one Control Chart for PartLength',
    subtitle = 'Machine 1, Temperature 303, Pressure 100',
    x = 'Observation Number',
    y = 'PartLength'
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 18, face = 'bold'),
    plot.subtitle = element_text(size = 14),
    axis.title = element_text(size = 18),
    axis.text = element_text(size = 14),
    panel.background = element_rect(fill = 'white', colour = NA),
    legend.position = 'bottom'
  )

# Convert to interactive Plotly object
p_interactive_control_chart <- ggplotly(plot_control_chart) %>%
  layout(
    xaxis = list(title = list(text = 'Observation Number', font = list(size = 18)), tickfont = list(size = 14)),
    yaxis = list(title = list(text = 'PartLength', font = list(size = 18)), tickfont = list(size = 14)),
    plot_bgcolor = 'white',
    paper_bgcolor = 'white'
  )

htmlwidgets::saveWidget(
  p_interactive_control_chart,
  'media/plots/control_chart_machine1.html',
  selfcontained = TRUE
)

