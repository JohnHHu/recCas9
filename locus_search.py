# locus_search.ph
# May 24, 2016
# Liu Lab, Harvard University
# Jeffrey Bessen

#script can be run from command line in the working directory using the below syntax:
#python locus_search.py <INPUT FILEPATH> <OUTPUT FILEPATH>
from pyensembl import EnsemblRelease
import re
import sys
import time

def maybe_int(n): #workaround to pass X or Y chromosome as a string, not an integer, to gene_names_at_locus
	try:
		return int(n)
	except ValueError:
		return n
	
#function to generate chromosome number and position from file	
def strip_values(data):
	chr_num = re.search(r"chr([1234567890XY]{1,2})", data)
	if chr_num is None:
		return "nothing"
	chr_number = chr_num.group(1)
	position_start = data.rsplit(",")[1]
	position_end = data.rsplit(",")[2]
	parameters = [chr_number, position_start, position_end]
	int_param= [maybe_int(number) for number in parameters]
	return int_param

def main():
	ensembl_num = 81 #fetch before running program using command: pyensembl install --release <list of Ensembl release numbers> --species <species-name>
	gen_ref = EnsemblRelease(ensembl_num)
	
	output_file = open(sys.argv[2], "w") #output filename

	firstline = True
	input_file = open(sys.argv[1]).read().split("\r")
	for line in input_file:
		if firstline:
			output_file.write(line + "\r")
			firstline = False
			continue
		parameters = strip_values(line)
		if parameters == "nothing":
			output_file.write(line + "\r")
		else:
			gene_name = gen_ref.gene_names_at_locus(contig=parameters[0], position=parameters[1], end =parameters[2])
			for gene in gene_name[0:len(gene_name)]:
				line = line + "," + gene
			output_file.write(line + "\r")

	output_file.write("Generated on " + time.strftime("%m/%d/%Y") + " with Ensemble Release " + str(ensembl_num) + " and locus_serach.py v1." )

	output_file.close()

if __name__ == '__main__':
    main()