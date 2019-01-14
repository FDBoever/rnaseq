#-----------------------------------
#	STAR - READ MAPPING
#-----------------------------------
# BEFORE RUNNING PLEASE CONSIDER READING THIS:


# maybe it is needed to set --genomeSAindexNbases 6 (found it, as I retrieved, Segmentation fault)
#./STAR --runThreadN 16 --runMode genomeGenerate --genomeDir ./Genomes/ --genomeFastaFiles ./Genomes/Marinobacter_sp_FDB33.fna --sjdbGTFfile ./Genomes/Marinobacter_sp_FDB33.gff --sjdbOverhang 50 --sjdbGTFfeatureExon CDS --sjdbGTFtagExonParentTranscript ID   --sjdbGTFtagExonParentGene Parent --genomeSAindexNbases 6


#./STAR --runMode alignReads --outSAMtype BAM Unsorted --genomeDir ./Genomes/  --outFileNamePrefix F33_STAR  --readFilesIn  ./out_SortMeRNA/F33_1_2_reads_non_rRNA.fastq

#
#samtools sort ../BOWTIE/FDB33_N33_1_1.bam -o ../BOWTIE/FDB33_N33_1_1.bam
#samtools index ../BOWTIE/FDB33_N33_1_1.bam


mkdir ./out_STAR

#./STAR --runMode alignReads --outSAMtype BAM Unsorted --genomeDir ./Genomes/  --outFileNamePrefix F33_STAR  --readFilesIn  ./out_SortMeRNA/F33_1_2_reads_non_rRNA.fastq

mkdir ./out_STAR
for f in ./out_SortMeRNA/*_reads_non_rRNA.fastq
do
	fbname=$(basename "$f" .fastq.gz)
	treatment=$(echo "$fbname" | awk -v RS='_' -v ORS='_' 'NR==1{print} NR==2{print} NR==3{print; printf"\n";exit}'| rev | cut -c 2- | rev)
	hologenome=$(echo "$fbname" | awk -v RS='_' -v ORS='_' 'NR==1{print} NR==2{print} NR==3{print; printf"\n";exit}'| rev | cut -c 6- | rev)
	echo "--------------------------------------------------"
	echo "path2file: $f"
	echo "treatment: $treatment"
	echo "Hologenome: $hologenome"
	./STAR --outSAMtype BAM Unsorted --genomeDir ./Hologenomes/$hologenome  --outFileNamePrefix ./out_STAR/$treatment  --readFilesIn  $f --runThreadN 20
	samtools sort ./out_STAR/${treatment}Aligned.out.bam -o ./out_STAR/${treatment}Aligned.out.bam
	samtools index ./out_STAR/${treatment}Aligned.out.bam
done
