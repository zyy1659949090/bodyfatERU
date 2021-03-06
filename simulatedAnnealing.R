source('autoload.R')


ctrl <- safsControl(functions = caretSA,
                    method = "repeatedcv",
                    repeats = 10,
                    number=5,
                    ## What should we optimize? 
                    metric = c(internal = "RMSE",
                               external = "RMSE"),
                    maximize = c(internal = FALSE,
                                 external = FALSE),
                    improve = 25,
                    allowParallel = TRUE)
knn_sa <- lapply(genderDb, function(gdb) {
  safs(x = gdb[, get('inputCols')[-2]],
       y = gdb$DEXAyagyuz,
       iters = 500,
       safsControl = ctrl,
       method='knn'
       )
})


save(knn_sa, file='knn_sa.RData')

