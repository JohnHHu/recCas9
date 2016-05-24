# findDNAMatch.R
# Feb. 29, 2016
# Liu Lab, Harvard University
# Johnny Hu
# For all sequneces in the fasta file, scan genome to find matches. Write matches to output file. Helper file for genomeSearch.R

findDNAMatchPlus <- function(searchSeqs, outfile="")
{

  # Open and store genome and chromosome names
  genome <- BSgenome.Hsapiens.UCSC.hg38.masked
  chrnames <- seqnames(genome)

  # Start a new file at the beginning
  append <- FALSE
  
  # Loop through all of the chromosomes
  for (chrname in chrnames) {
  
    # Get sequence for chromosome
    subject <- genome[[chrname]]
    
    cat(">>> Finding all hits in chromosome", chrname, "...\n")
    
    # Loop through all of the sequences being matched
    for (i in seq_len(length(searchSeqs))) {
      
      # Get name and sequence of the  input being matched
      patternID <- names(searchSeqs)[i]
      pattern <- searchSeqs[[i]]
      
      # Only search (+) strand, since sequences in this case are palindromic, no need to search (-) strand
      plus_matches <- matchPattern(pattern, subject, fixed=FALSE)
      
      # Call function to write results to output file
      writeHits(seqname, plus_matches, "+", file=outfile, append=append)
      
      # Turn append on so that file is not overwritten each time a match is found
      append <- TRUE
    }
    
    cat(">>> DONE\n")
  }
  
}
