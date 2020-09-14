#Script created by Matti Niissalo, 18. August 2020
#Pairwise comparison of genepop files from Stacks 1, to test for clonality: samples that share all heterozygotic loci are likely to be of the same clone (allowing a methodological error rate). Two values are calculated for each pair, as the number of heterozygotic loci varies between samples.
#Create a new directory and cd to that directory. Move this shell script and the associated R script ("Genepop_clonality_script.R") into the new folder.
#Example usage: /New/directory/Genepop_clonality_script.sh /path/to/inputfile1 /path/to/inputfile2
#Works with or without missing data, but any loci missing data for one of the pair are ignored
#Input file 1 = list of all the sample names for which pairwise values are needed. Have each sample in a separate line, with an empty line at the end. Assumes Unix line breaks.
#Input file 2 = a genepop file that has data for all the samples listed
#Requires a complementary Rscript file (Genepop_clonality_script.R) for output in csv format and for a sorted dot plot of all similarities. The R library "tidyverse" will be installed. The results are human readable without the R script.
#Assumes Stacks genepop format: nucleotides are in increasing order (01 to 04) and maximum of two nucleotides were called per locus. Expandable to include other nucleotide orders and a higher number of nucleotides.
FILE=./output.txt ; if test -f "$FILE" ; then echo "$FILE exists, delete it and restart." ; exit ; fi ; FILE=./output2.txt ; if test -f "$FILE" ; then echo "$FILE exists, delete it and restart." ; exit ; fi ; while read b ; do grep -F $b $2 > "$b".txt ; done < $1 ; \
while read a ; do while read b ; do paste <(tr '\t' '\n' < "$b".txt) <(tr '\t' '\n' < "$a".txt) | grep -Fv "0000" | tr -s '\t' ' ' > "$b"_"$a".txt ; paste <(echo $b $a) <(grep '0102 0102\|0103 0103\|0104 0104\|0203 0203\|0204 0204\|0304 0304' "$b"_"$a".txt | wc -l) <(grep '0102 0101\|0102 0202\|0103 0101\|0103 0303\|0104 0101\|0104 0404\|0203 0202\|0203 0303\|0204 0202\|0204 0404\|0304 0303\|0304 0404' "$b"_"$a".txt | wc -l) | tr -s ' ' '\t' >> output2.txt ; done < $1 ; done < $1 ; \
while read a b c d ; do paste <(echo $a $b) <(echo "scale=3; $c / ( $c + $d)" | bc -l 2> /dev/null) | tr ' ' '\t' >> output.txt ; done < ./output2.txt ; \
rm ./output2.txt ; \
while read a ; do while read b ; do rm ./"$b".txt 2> /dev/null ; rm ./"$b"_"$a".txt 2> /dev/null ; done < $1 ; done < $1 ; \
Rscript ./Genepop_clonality_script.R
