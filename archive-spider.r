removeArchivePath <- function(text){
  pattern <- "/web/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9].?/"
  return(gsub(pattern,"",text))
}


theURL <- "https://web.archive.org/web/20140106162203/http://icepackgames.com/"


spiderpage <- function(theURL){
  urlparse <- parse_url(theURL)
  relativepath <- paste(urlparse$scheme,"://",urlparse$hostname, sep = "")
  html <- getURL(theURL, .opts = list(ssl.verifypeer = FALSE))
  path <- urlparse$path
  rawhtml <- html
  filename <- paste(path,".html",sep="")
  HTML(rawhtml,filename)
  
  
  html <- htmlParse(html)
  body <- xpathSApply(html,"//body")
  title <- xpathSApply(html,"//title")
  robots <- xpathSApply(html,"//meta[@name='Robots']|//meta[@name='ROBOTS']|//meta[@name='robots']")
  page.data <- list(body,title,robots)
  urls <- as.vector(xpathSApply(html,"//a/@href"))
  urls <- unique(urls)
  urls.rel <- grep("^/",urls)
  urls[urls.rel] <- paste(relativepath,urls[urls.rel],sep="")
  return(list(urls,page.data))
}

urlcleanup <- function(vector,domain){
  ## Remove Non Archive URLs
  archivepattern <- "/web/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9].?/"
  vector <- vector[grep(archivepattern,vector)]
  ## Remove non-domain specific URLs
  domain <- sub("[.]","[.]",domain)
  vector <- vector[grep(domain,vector)]
  ## Remove 'Browse All' Archive URLs
  asterisk.pattern <- "/web/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][*]/"
  vector <- vector[-grep(asterisk.pattern,vector)]
  return(vector)
}

asterisk.pattern <- "/web/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][*]/"



extractArchivePattern <- function(theURL) {
  pattern <- "/web/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9].?/"
  x <- regexpr(pattern, theURL)
  start <- x[1]
  length <- attr(x, which = "match.length")
  end <- start + length - 1
  return(substr(theURL, start = start, stop = end))
}





if(!exists("masterurls")){
  masterurls <- NULL
}


for(i in urls){
  try(html <- getURL(i, .opts = list(ssl.verifypeer = FALSE)), silent=TRUE)
  try(html <- htmlParse(html),silent=TRUE)
  try(links <- as.vector(xpathSApply(html,"//a/@href")), silent=TRUE)
  try(masterurls <- append(masterurls,links), silent=TRUE)
  masterurls <- unique(masterurls)
}



removeArchivePath <- function(text){
pattern <- "^/web/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9].?/"
return(sub(pattern,"",text))
}

