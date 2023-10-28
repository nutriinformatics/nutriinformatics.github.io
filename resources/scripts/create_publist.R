library(rcrossref)
library(zoo)

group_members <- c("Busche S", "Starke S",
                   "Zimmermann S",
                   "Harris D", "Harris DM", "Harris DMM",
                   "Tassiello O",
                   "Pisarevskaja A",
                   "Waschina S")

# retrieve pub info from crossref
dois <- readLines("resources/data/publication_dois.txt")
pub <- cr_cn(dois, format = "citeproc-json")

# extract dates for ordering
dates <- as.Date(unlist(lapply(pub, function(x) {
  x <- x$published$`date-parts`
  x <- c(x, rep(1, 3-length(x)))
  paste(x, collapse = "-")
})))

# re-order by date
ord <- order(dates, decreasing = TRUE)
pub <- pub[ord]
dates <- dates[ord]

# generate markdown format citation
md_pub <- function(pubi) {
  ref.authors <- paste(pubi$author$family, gsub("(?<=[A-Z])[^A-Z]+", "",
                                                pubi$author$given, perl = TRUE))
  ref.authors <- ifelse(ref.authors %in% group_members, paste0("<u>",ref.authors,
                                                               "</u>"), ref.authors)
  ref.authors <- paste(ref.authors, collapse = ", ")
  
  if(is.null(pubi$subtype) || pubi$subtype != "preprint") {
    ref.full <- paste0(ref.authors,".<br>",
                       "[**",pubi$title,"**](",pubi$URL,")<br>",
                       "*",pubi$`container-title`,"*. ", pubi$published$`date-parts`[1,1],". ",
                       pubi$volume,
                       ifelse("issue" %in% names(pubi),paste0("(",pubi$issue,")"),""),". ",
                       "doi: ", pubi$DOI)
  } else {
    ref.full <- paste0(ref.authors,".<br>",
                       "[**",pubi$title,"**](",pubi$URL,")<br>",
                       "(preprint) ",
                       "*",pubi$institution[1,"name"],"*. ", pubi$published$`date-parts`[1,1],". ",
                       "doi: ", pubi$DOI)
  }
  
  
  
  return(ref.full)
}

# generate iterated list of publications
out <- c()
current_year <- ""
for(i in 1:length(pub)) {
  year <- format(dates[i], format = "%Y")
  if(year != current_year) {
    out <- c(out, paste("###", year),"")
    current_year <- year
  }
  out <- c(out, md_pub(pub[[i]]),"")
} 

# add header
out <- c("---",
         "layout: infopage",
         "title: Publications",
         "---",
         out)

cat(out, sep = "\n", file = "publications.md")




