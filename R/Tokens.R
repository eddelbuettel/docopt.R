Tokens <- setRefClass( "Tokens"
                       , fields=list(tokens="character", error="function")
                       , methods=list(
                         initialize = function(tokens=character(), error=stop){
                           .tokens <- gsub("^\\s+|\\s+$", "", tokens)
                           tokens <<- strsplit(.tokens, "\\s+")[[1]]
                           error <<- error
                         },
                         current = function(){
                           if (length(tokens)){
                             tokens[1]
                            } else {
                              ""
                            }
                         },
                         shift = function(){
                           h <- head(tokens, 1)
                           tokens <<- tail(tokens, -1)
                           if (length(h)) h else ""
                         },
                         #     toString: -> ([].slice.apply @).toString()
                         toString = function(){
                           tokens
                         },
                         show = function(){
                           cat("Tokens:", toString())
                         },
                         # 
                         #     join: (glue) -> ([].join.apply @, glue)
                         join = function(glue){
                           paste0(tokens, collapse=glue)
                         }
        )
)

setMethod("[",
          signature(x = "Tokens"),
          function (x, i, j, ..., drop = TRUE) 
          {
            x$tokens[i]
          }
)

setMethod("[<-",
          signature(x = "Tokens"),
          function (x, i, j, ..., value) 
          {
            x$tokens[i] <- value
          }
)


# # testing 1, 2, 3
# t <- Tokens(c("a", "b"))
# t$current()
# t$shift()
# t