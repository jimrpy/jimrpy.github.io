df2max <- function(df, var.row, var.col, var.value){
  ## This function is for generating matrix from data.frame by given row and col
  ## Author: LI Jinming
  
  ## attach packages
  library(reshape2)
  library(dplyr)
  library(rlang)
  
  ## capture user-supplied expressions
  var.row <- enquo(var.row)
  var.col <- enquo(var.col)
  var.value <- enquo(var.value)
  ## formula, y ~ x, column ~ row
  formula = as.formula(paste(quo_text(var.col), "~ ", quo_text(var.row)))

  ## convert df to matrix
  df %>% dcast(formula = formula, value.var = quo_text(var.value)) %>% ## convert long format to wide format
    column_to_rownames(var = quo_text(var.col)) %>%                    ## column to rowname
    as.matrix()                                                        ## convert to matrix
}
