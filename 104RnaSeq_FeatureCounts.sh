#-----------------------------------
#	COUNTING FEATURES
#-----------------------------------

FDB33_BAMs=`find ./splitted_STAR/ -type f  | grep FDB33 | tr '\n' ' '`
FDB36_BAMs=`find ./splitted_STAR/ -type f  | grep FDB36 | tr '\n' ' '`
NANNO_BAMs=`find ./splitted_STAR/ -type f  | grep NAX | tr '\n' ' '`

echo "--------------------------------------------------"
echo "FEATURE COUNTING for FDB33"
echo "BAM files:"
echo "$FDB33_BAMs"
./subread-1.6.3-Linux-x86_64/bin/featureCounts -t exon -g ID -a ./Hologenomes/F33.gff -o FDB33_counts.txt ${FDB33_BAMs}

echo "--------------------------------------------------"
echo "FEATURE COUNTING for FDB36"
echo "BAM files:"
echo "$FDB36_BAMs"
./subread-1.6.3-Linux-x86_64/bin/featureCounts -t exon -g ID -a ./Hologenomes/F36.gff -o FDB36_counts.txt ${FDB36_BAMs}

echo "--------------------------------------------------"
echo "FEATURE COUNTING for NANNO"
echo "BAM files:"
echo "$NANNO_BAMs"
./subread-1.6.3-Linux-x86_64/bin/featureCounts -t exon -g ID -a ./Hologenomes/NAX.gff -o NANNO_counts.txt ${NANNO_BAMs}
echo "----------------------DONE------------------------"



