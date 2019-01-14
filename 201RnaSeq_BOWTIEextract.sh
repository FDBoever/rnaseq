#-----------------------------------/opt/software/bowtie2/2.3.1/bowtie-build ./Genomes/Marinobacter_sp_FDB33.fna FDB33
#	BOWTIE: EXTRACT HOST
#-----------------------------------
# BEFORE RUNNING PLEASE CONSIDER READING THIS:


#This script aims to extract bacterial (FDB33 and FDB36) from all co-culture samples and obtain the Nannochloropsis reads to be assembled denovo


mkdir ./BOWTIE
#build the bowtie databases
/opt/softwares/bowtie2/2.3.1/bowtie2-build ./Genomes/Marinobacter_sp_FDB33.fna FDB33
/opt/softwares/bowtie2/2.3.1/bowtie2-build ./Genomes/Alteromonas_sp_FDB36.fna FDB36
/opt/softwares/bowtie2/2.3.1/bowtie2-build ./Hologenomes/F3336.fna FDB3336

#USING BOWTIE AND SAMTOOLS 
#map reads against the bacterium
#/opt/software/bowtie2/2.3.1/bowtie2 -x FDB33 $f -S ./BOWTIE/${treatment}_mapped_and_unmapped.sam
#convert the SAM to BAM file
#samtools view -bS ./BOWTIE/${treatment}_mapped_and_unmapped.sam > ./BOWTIE/${treatment}_mapped_and_unmapped.bam
#sort the BAM file
#samtools sort ./BOWTIE/$treament_mapped_and_unmapped.bam - o ./BOWTIE/${treatment}_mapped_and_unmapped.bam
#index the BAM file
#samtools index ./BOWTIE/${treatment}_mapped_and_unmapped.bam
#filter out the unmapped reads (-f 4 ~ to extract the unmapped reads)
#samtools view -b -f 4 ./BOWTIE/${treatment}_mapped_and_unmapped.bam > ./BOWTIE/${treatment}_unmapped.bam
#convert BAM to fastq
#samtools bam2fq ./BOWTIE/${treatment}_unmapped.fastq

for f in ./out_SortMeRNA/*_reads_non_rRNA.fastq
do
	fbname=$(basename "$f" .fastq.gz)
	treatment=$(echo "$fbname" | awk -v RS='_' -v ORS='_' 'NR==1{print} NR==2{print} NR==3{print; printf"\n";exit}'| rev | cut -c 2- | rev)
	hologenome=$(echo "$fbname" | awk -v RS='_' -v ORS='_' 'NR==1{print} NR==2{print} NR==3{print; printf"\n";exit}'| rev | cut -c 6- | rev)
	echo "--------------------------------------------------"
	echo "path2file: $f"
	echo "treatment: ${treatment}"
	if [[ $treatment == *"NAX"* ]]; then
		echo "detected: Nannochloropsis"
		cp $f ./BOWTIE/${treatment}.fastq.gz
	fi
	if [[ $treatment == *"N33_"* ]]; then
		echo "detected: Nannochloropsis + FDB33"
		/opt/softwares/bowtie2/2.3.1/bowtie2 -x FDB33 $f -S ./BOWTIE/${treatment}_mapped_and_unmapped.sam
		samtools view -bS ./BOWTIE/${treatment}_mapped_and_unmapped.sam > ./BOWTIE/${treatment}_mapped_and_unmapped.bam
		samtools sort ./BOWTIE/$treament_mapped_and_unmapped.bam - o ./BOWTIE/${treatment}_mapped_and_unmapped.bam
		samtools index ./BOWTIE/${treatment}_mapped_and_unmapped.bam
		samtools view -b -f 4 ./BOWTIE/${treatment}_mapped_and_unmapped.bam > ./BOWTIE/${treatment}_unmapped.bam
		samtools bam2fq ./BOWTIE/${treatment}_unmapped.bam > ./BOWTIE/${treatment}_unmapped.fastq
		rm ./BOWTIE/${treatment}_mapped_and_unmapped.bam
		rm ./BOWTIE/${treatment}_mapped_and_unmapped.sam
		rm ./BOWTIE/${treatment}_unmapped.bam
		gzip ./BOWTIE/${treatment}_unmapped.fastq
	fi
	if [[ $treatment == *"N36_"* ]]; then
		echo "detected: Nannochloropsis + FDB36"
		/opt/softwares/bowtie2/2.3.1/bowtie2 -x FDB36 $f -S ./BOWTIE/${treatment}_mapped_and_unmapped.sam
		samtools view -bS ./BOWTIE/${treatment}_mapped_and_unmapped.sam > ./BOWTIE/${treatment}_mapped_and_unmapped.bam
		samtools sort ./BOWTIE/$treament_mapped_and_unmapped.bam - o ./BOWTIE/${treatment}_mapped_and_unmapped.bam
		samtools index ./BOWTIE/${treatment}_mapped_and_unmapped.bam
		samtools view -b -f 4 ./BOWTIE/${treatment}_mapped_and_unmapped.bam > ./BOWTIE/${treatment}_unmapped.bam
		samtools bam2fq ./BOWTIE/${treatment}_unmapped.bam > ./BOWTIE/${treatment}_unmapped.fastq
		rm ./BOWTIE/${treatment}_mapped_and_unmapped.bam
		rm ./BOWTIE/${treatment}_mapped_and_unmapped.sam
		rm ./BOWTIE/${treatment}_unmapped.bam
		gzip ./BOWTIE/${treatment}_unmapped.fastq
	fi
	if [[ $treatment == *"N3336_"* ]]; then
		echo "detected: Nannochloropsis + FDB33 + FDB36"
		/opt/softwares/bowtie2/2.3.1/bowtie2 -x FDB3336 $f -S ./BOWTIE/${treatment}_mapped_and_unmapped.sam
		samtools view -bS ./BOWTIE/${treatment}_mapped_and_unmapped.sam > ./BOWTIE/${treatment}_mapped_and_unmapped.bam
		samtools sort ./BOWTIE/${treatment}_mapped_and_unmapped.bam - o ./BOWTIE/${treatment}_mapped_and_unmapped.bam
		samtools index ./BOWTIE/${treatment}_mapped_and_unmapped.bam
		samtools view -b -f 4 ./BOWTIE/${treatment}_mapped_and_unmapped.bam > ./BOWTIE/${treatment}_unmapped.bam
		samtools bam2fq ./BOWTIE/${treatment}_unmapped.bam > ./BOWTIE/${treatment}_unmapped.fastq
		rm ./BOWTIE/${treatment}_mapped_and_unmapped.bam
		rm ./BOWTIE/${treatment}_mapped_and_unmapped.sam
		rm ./BOWTIE/${treatment}_unmapped.bam
		gzip ./BOWTIE/${treatment}_unmapped.fastq
	fi

done

#Assemble with Trinity
#make sure that the output directory of a potential previous run is removed
#rm ./trinity_out_dir
/opt/softwares/Trinity/2.2.0/Trinity --seqType fq --single ./BOWTIE/*.fastq.gz --CPU 16 --max_memory 20G

