library(rmarkdown)
Region <- c("Región de Antofagasta", "Región del Bío-Bío", "Región de La Araucanía")
lapply(X = Region, FUN = function(x) tryCatch(render(input = "code/lugares.Rmd", 
                                            output_dir = "output", 
                                            output_file = paste0("mall", x), 
                                            encoding = "utf-8"), 
                                            error = function(e) NULL
                                            )
       )
