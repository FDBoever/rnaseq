#-----------------------------------
#	out_pBOWTIE - PARALELL READ MAPPING
#-----------------------------------
# BEFORE RUNNING PLEASE CONSIDER READING THIS:


# The concept here is similar to genome-reference based mapping as in 102RnaSeq_STAR.sh
mkdir ./out_pBOWTIE
for f in ./out_SortMeRNA/*_reads_non_rRNA.fastq.gz
do
	fbname=$(basename "$f" .fastq.gz)
	treatment=$(echo "$fbname" | awk -v RS='_' -v ORS='_' 'NR==1{print} NR==2{print} NR==3{print; printf"\n";exit}'| rev | cut -c 2- | rev)
	hologenome=$(echo "$fbname" | awk -v RS='_' -v ORS='_' 'NR==1{print} NR==2{print} NR==3{print; printf"\n";exit}'| rev | cut -c 6- | rev)
	echo "--------------------------------------------------"
	echo "path2file: $f"
	echo "treatment: $treatment"
	echo "Hologenome: $hologenome"
	/opt/softwares/bowtie2/2.3.1/bowtie2 -x ./Hologenomes_2/${hologenome} $f -S ./out_pBOWTIE/${treatment}_mapped_and_unmapped.sam
	samtools view -bS ./out_pBOWTIE/${treatment}_mapped_and_unmapped.sam > ./out_pBOWTIE/${treatment}_mapped_and_unmapped.bam
	samtools sort ./out_pBOWTIE/${treatment}_mapped_and_unmapped.bam -o ./out_pBOWTIE/${treatment}_mapped_and_unmapped.bam
	samtools index ./out_pBOWTIE/${treatment}_mapped_and_unmapped.bam
	samtools view -b -F 4 ./out_pBOWTIE/${treatment}_mapped_and_unmapped.bam > ./out_pBOWTIE/${treatment}_mapped.bam
	rm ./out_pBOWTIE/${treatment}_mapped_and_unmapped.bam	
done
