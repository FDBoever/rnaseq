#-----------------------------------
#	COUNTING FEATURES
#-----------------------------------

NANNO_BAMs=`find ./splitted_STAR/ -type f  | grep NAX | tr '\n' ' '`

echo "--------------------------------------------------"
echo "FEATURE COUNTING for NANNO"
echo "BAM files:"
echo "$NANNO_BAMs"
./subread-1.6.3-Linux-x86_64/bin/featureCounts -t exon -g ID -a ./Hologenomes//Nanoce1779_GeneCatalog_20170119.gff3 -o NANNO2_counts.txt ${NANNO_BAMs}
echo "----------------------DONE------------------------"



