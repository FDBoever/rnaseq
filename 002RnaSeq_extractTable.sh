#-----------------------------------
#	SortMeRNA
#-----------------------------------
# PLEASE MAKE SURE YOU RAN SortMeRNA:


#cat /Users/sa01fd/Downloads/F33_1_1_reads_rRNA.log | tail -11 | head -8 | awk -v var='F33_1_1' -F'\t' '{print var, $3}' | rev | cut -c2- | rev

for f in ./out_SortMeRNA/*.log
do
	treatment=$(basename "$f" _reads_rRNA.log)
	fbname3=$(basename "$f" .gz)
	echo "--------------------------------------------------"
	echo "path2file: $f"
	echo "treatment: $treatment"
	cat $f | tail -11 | head -8 | awk -v var=${treatment} -F'\t' '{print var, $3, $1}' | rev | cut -c2- | rev >> ./outTable_SortMeRNA.txt

done


