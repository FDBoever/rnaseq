#TRIMMOMATIC -phred33 HEADCROP:12 CROP:61 LEADING:3 TRAILING:3 MINLEN:30
for f in ./RNAseq/*
do
	fbname=$(basename "$f" .fastq.gz)
	fbname2=$(echo "$fbname" | awk -v RS='_' -v ORS='_' 'NR==1{print} NR==2{print} NR==3{print; printf"\n";exit}'| rev | cut -c 2- | rev)
	echo "--------------------------------------------------"
	echo "path2file: $f"
	echo "treatment: $fbname2"
	if [[ $fbname2 == *"N"* ]]; then
  		echo "detected: Nannochloropsis"
	fi
	if [[ $fbname2 == *"33"* ]]; then
  		echo "detected: FDB33"
	fi
	if [[ $fbname2 == *"36"* ]]; then
  		echo "detected: FDB36"
	fi
	 java -jar /opt/softwares/Trimmomatic/0.35/trimmomatic.jar SE -threads 16 -phred33 $f ./TRIM/$fbname2.fastq.gz HEADCROP:12 CROP:61 LEADING:3 TRAILING:3 MINLEN:30 
done
