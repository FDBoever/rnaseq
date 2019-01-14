#-----------------------------------
#	SORTING THE HOLOMAPPING
#-----------------------------------
#first make the lookup files (simple txt files containing all contigs)
cat ./Genomes/Marinobacter_sp_FDB33.fna | grep '>' | cut -c 2- > FDB33_Scaffolds.txt
cat ./Genomes/Alteromonas_sp_FDB36.fna | grep '>' | cut -c 2- > FDB36_Scaffolds.txt
cat ./Genomes/NoceanicaCCMP1779_genome_assembly.fasta | grep '>' | cut -c 2- > NAX_Scaffolds.txt


#output directory
mkdir ./splitted_STAR

#run over al STAR outputs and split ~ hologenome
for f in ./out_STAR/*Aligned.out.bam
do
	fbname=$(basename "$f" Aligned.out.bam)
	treatment=${fbname}
	hologenome=$(echo "$fbname" | awk -v RS='_' -v ORS='_' 'NR==1{print} NR==2{print} NR==3{print}'| rev | cut -c 5- | rev)
	echo "--------------------------------------------------"
	echo "path2file: $f"
	echo "treatment: $treatment"
	echo "Hologenome: $hologenome"

	if [[ $treatment == *"NAX"* ]]; then
 		echo "detected: Nannochloropsis"
		cat NAX_Scaffolds.txt | xargs samtools view -b $f > ./splitted_STAR/NAX_${treatment}.bam
	fi
	if [[ $treatment == *"N33_"* ]]; then
  		echo "detected: Nannochloropsis + FDB33"
		cat NAX_Scaffolds.txt | xargs samtools view -b $f > ./splitted_STAR/NAX_${treatment}.bam
		cat FDB33_Scaffolds.txt | xargs samtools view -b $f > ./splitted_STAR/FDB33_${treatment}.bam
	fi
	if [[ $treatment == *"N36_"* ]]; then
  		echo "detected: Nannochloropsis + FDB36"
		cat NAX_Scaffolds.txt | xargs samtools view -b $f > ./splitted_STAR/NAX_${treatment}.bam
		cat FDB36_Scaffolds.txt | xargs samtools view -b $f > ./splitted_STAR/FDB36_${treatment}.bam
	fi
	if [[ $treatment == *"N3336"* ]]; then
  		echo "detected: Nannochloropsis + FDB33 + FDB36"
		cat NAX_Scaffolds.txt | xargs samtools view -b $f > ./splitted_STAR/NAX_${treatment}.bam
		cat FDB36_Scaffolds.txt | xargs samtools view -b $f > ./splitted_STAR/FDB36_${treatment}.bam
		cat FDB33_Scaffolds.txt | xargs samtools view -b $f > ./splitted_STAR/FDB33_${treatment}.bam
	fi
	if [[ $treatment == *"F33_"* ]]; then
  		echo "detected: FDB33"
		cat FDB33_Scaffolds.txt | xargs samtools view -b $f > ./splitted_STAR/FDB33_${treatment}.bam
	fi
	if [[ $treatment == *"F36_"* ]]; then
  		echo "detected: FDB36"
		cat FDB36_Scaffolds.txt | xargs samtools view -b $f > ./splitted_STAR/FDB36_${treatment}.bam
	fi
	if [[ $treatment == *"F3336_"* ]]; then
  		echo "detected: FDB33 + FDB36"
		cat FDB36_Scaffolds.txt | xargs samtools view -b $f > ./splitted_STAR/FDB36_${treatment}.bam
		cat FDB33_Scaffolds.txt | xargs samtools view -b $f > ./splitted_STAR/FDB33_${treatment}.bam
	fi
done
