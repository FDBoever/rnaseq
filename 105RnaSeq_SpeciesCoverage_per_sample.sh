#-----------------------------------
#	COVERAGE PER ORGANISM PER SAMPLE
#-----------------------------------

#run over al STAR outputs and split ~ hologenome
for f in ./splitted_STAR/*.bam
do
	fbname=$(basename "$f" Aligned.out.bam)
	treatment=${fbname}
	echo "--------------------------------------------------"
	echo "path2file: $f"
	echo "treatment: $treatment"

	samtools flagstat $f | head -n 1| awk -v var="$treatment" '{print var, $1}' >> 05RNA_seq_out.txt
	
done
