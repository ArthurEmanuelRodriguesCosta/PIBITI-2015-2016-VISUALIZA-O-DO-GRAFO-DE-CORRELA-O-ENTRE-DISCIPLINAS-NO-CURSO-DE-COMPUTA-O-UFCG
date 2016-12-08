library(dplyr)
library(ggplot2)
options(encoding = "UTF-8")

#Inserts newlines into strings every N interval
new_lines_adder = function(test.string, interval){
  #length of str
  string.length = nchar(test.string)
  #split by N char intervals
  split.starts = seq(1,string.length,interval)
  split.ends = c(split.starts[-1]-1,nchar(test.string))
  #split it
  test.string = substring(test.string, split.starts, split.ends)
  #put it back together with newlines
  test.string = paste0(test.string,collapse = "\n")
  return(test.string)
}

#a user-level wrapper that also works on character vectors, data.frames, matrices and factors
add_newlines = function(x, interval) {
  if (class(x) == "data.frame" | class(x) == "matrix" | class(x) == "factor") {
    x = as.vector(x)
  }
  
  if (length(x) == 1) {
    return(new_lines_adder(x, interval))
  } else {
    t = sapply(x, FUN = new_lines_adder, interval = interval) #apply splitter to each
    names(t) = NULL #remove names
    return(t)
  }
}

grafo <- read.csv("grafointeligivel.csv", sep=";")

grupos <- group_by(grafo, modularity_class) %>% summarise(mean(betweenesscentrality))

grupos1 <- group_by(grafo, modularity_class)

grafo2 <- grafo
grafo2 <- grafo2[order(grafo2$pageranks),]
ggplot(grafo2, aes(x = reorder(label, pageranks), y = pageranks)) + geom_bar(stat = "identity") + labs(x = "disciplinas") + coord_flip()
grafo2 <- grafo2[28:33,]
ggplot(grafo2, aes(x = reorder(label, pageranks), y = pageranks)) + geom_bar(stat = "identity") +
  scale_x_discrete(labels = add_newlines(grafo2$label, 13), name = "")


ggplot(grafo, aes(x = reorder(label, betweenesscentrality), y = betweenesscentrality, xlab("disciplinas"))) + geom_bar(stat = "identity") + labs(x = "disciplinas") + coord_flip()

grafo3 <- grafo
grafo3 <- grafo3[order(grafo3$betweenesscentrality),]
grafo3 <- grafo3[29:33,]
ggplot(grafo3, aes(x = reorder(label, betweenesscentrality), y = betweenesscentrality)) + geom_bar(stat = "identity")+
  scale_x_discrete(labels = add_newlines(grafo3$label, 15), name = "")
