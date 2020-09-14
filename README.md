# Genepop_clonality_script
#Script created by Matti Niissalo, 18. August 2020, bash and R

#Pairwise comparison of genepop files from Stacks 1, to test for clonality: samples that share all heterozygotic loci are likely to be of the same clone (allowing a methodological error rate). Two values are calculated for each pair, as the number of heterozygotic loci varies between samples. Assumes detectable heterozygosity within sampling.

#Create a new directory and cd to that directory. Move this shell script and the associated R script ("Genepop_clonality_script.R") into the new folder.

#Example usage: /New/directory/Genepop_clonality_script.sh /path/to/inputfile1 /path/to/inputfile2

#Works with or without missing data, but any loci missing data for one of the pair are ignored

#Input file 1 = list of all the sample names for which pairwise values are needed. Have each sample in a separate line, with an empty line at the end. Assumes Unix line breaks.

#Input file 2 = a genepop file that has data for all the samples listed

#Requires a complementary Rscript file (Genepop_clonality_script.R) for output in csv format and for a sorted dot plot of all similarities. The R library "tidyverse" will be installed. The results are human readable without the R script.

#Assumes Stacks genepop format: nucleotides are in increasing order (01 to 04) and maximum of two nucleotides were called per locus. Expandable to include other nucleotide orders and a higher number of nucleotides.
