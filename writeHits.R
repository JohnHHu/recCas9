# writeHits.R
# Feb. 29, 2016
# Liu Lab, Harvard University
# Johnny Hu
# Write matches to file. Helper function for genomeSearch.R.

writeHits <- function(seqname, matches, strand, file="", append=FALSE)
{
  # Wanings fr append state  
  if (file.exists(file) && !append)
    warning("existing file ", file, " will be overwritten with ✬append=FALSE✬")
  if (!file.exists(file) && append)
    warning("new file ", file, " will have no header with ✬append=TRUE✬")

  # Construct data
  hits <- data.frame(seqname=rep.int(seqname, length(matches)),
                     start=start(matches),
                     end=end(matches),
                     seq=as.character(matches),
                     strand=rep.int(strand, length(matches)),
                     patternID=names(matches),
                     check.names=FALSE)
  
  # Write to table
  write.table(hits, file=file, append=append, quote=FALSE, sep="\t",
              row.names=FALSE, col.names=!append)

}
