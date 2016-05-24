# genomeSearch.R
# Feb. 29, 2016
# Liu Lab, Harvard University
# Johnny Hu
# Imports Bioconductor, imports fasta file with sequences to match, and calls findDNAMatch to find matches in the genome

# Import Bioconductor pacakge and the hg38 build of the human genome
source("http://www.bioconductor.org/biocLite.R")
biocLite("BSgenome.Hsapiens.UCSC.hg38")
library(BSgenome.Hsapiens.UCSC.hg38.masked)

# Import findDNAMatch function
source("findDNAMatch.r")

# Open function that writes matches to output file
source("writeHits.R")

# Import fasta file containing the sequences that will be searched
searchSeqs <- readDNAStringSet("gix.fa", "fasta")

# Call findDNMatch to search for matches in the genome and output to file
findDNAMatch(searchSeqs, outfile="/Users/Johnny/Dropbox/Liu Lab/ForChaikind/Final Version/out.txt")
 
