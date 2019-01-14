#-----------------------------------
#	STAR - READ MAPPING
#-----------------------------------
# BEFORE RUNNING PLEASE CONSIDER READING THIS:

# generate "hologenomes"

#The trick I am trying is to change bacterial CDS into exons, and so be able to feed STAR merged eukaryotic and bacterial gff files


#./STAR --runThreadN 16 --runMode genomeGenerate --genomeDir ./Hologenomes/$hologenome --genomeFastaFiles ./Genomes/Marinobacter_sp_FDB33.fna --sjdbGTFfile ./Genomes/Marinobacter_sp_FDB33.gff --sjdbOverhang 50 --sjdbGTFfeatureExon CDS --sjdbGTFtagExonParentTranscript ID   --sjdbGTFtagExonParentGene Parent

#COMPILING THE HOLOGENOMES

mkdir ./Hologenomes
mkdir ./Hologenomes/F33
cp ./Genomes/Marinobacter_sp_FDB33.fna ./Hologenomes/F33.fna
cp ./Genomes/Marinobacter_sp_FDB33.gff ./Hologenomes/F33_CDS.gff
sed 's/CDS/exon/g' <./Hologenomes/F33_CDS.gff >./Hologenomes/F33.gff

mkdir ./Hologenomes/F36
cp ./Genomes/Alteromonas_sp_FDB36.fna ./Hologenomes/F36.fna
cp ./Genomes/Alteromonas_sp_FDB36.gff ./Hologenomes/F36_CDS.gff
sed 's/CDS/exon/g' <./Hologenomes/F36_CDS.gff >./Hologenomes/F36.gff

mkdir ./Hologenomes/F3336
cat ./Genomes/Marinobacter_sp_FDB33.fna ./Genomes/Alteromonas_sp_FDB36.fna > ./Hologenomes/F3336.fna
cat ./Hologenomes/F33.gff ./Hologenomes/F36.gff > ./Hologenomes/F3336.gff

mkdir ./Hologenomes/NAX
cp ./Genomes/NoceanicaCCMP1779_genome_assembly.fasta ./Hologenomes/NAX.fna
cp ./Genomes/NoceanicaCCMP1779_annotation.gff ./Hologenomes/NAX.gff

mkdir ./Hologenomes/N33
cat ./Hologenomes/NAX.fna ./Hologenomes/F33.fna > ./Hologenomes/N33.fna
cat ./Hologenomes/NAX.gff ./Hologenomes/F33.gff > ./Hologenomes/N33.gff

mkdir ./Hologenomes/N36
cat ./Hologenomes/NAX.fna ./Hologenomes/F36.fna > ./Hologenomes/N36.fna
cat ./Hologenomes/NAX.gff ./Hologenomes/F36.gff > ./Hologenomes/N36.gff

mkdir ./Hologenomes/N3336
cat ./Hologenomes/NAX.fna ./Hologenomes/F33.fna ./Hologenomes/F36.fna > ./Hologenomes/N3336.fna
cat ./Hologenomes/NAX.gff ./Hologenomes/F33.gff ./Hologenomes/F36.gff > ./Hologenomes/N3336.gff

#F33
./STAR --runThreadN 16 --runMode genomeGenerate --genomeDir ./Hologenomes/F33 --genomeFastaFiles ./Hologenomes/F33.fna --sjdbGTFfile ./Hologenomes/F33.gff --sjdbOverhang 50 --sjdbGTFtagExonParentTranscript ID --sjdbGTFtagExonParentGene Parent --genomeSAindexNbases 6
#F36
./STAR --runThreadN 16 --runMode genomeGenerate --genomeDir ./Hologenomes/F36 --genomeFastaFiles ./Hologenomes/F36.fna --sjdbGTFfile ./Hologenomes/F36.gff --sjdbOverhang 50 --sjdbGTFtagExonParentTranscript ID --sjdbGTFtagExonParentGene Parent --genomeSAindexNbases 6
#F3336
./STAR --runThreadN 16 --runMode genomeGenerate --genomeDir ./Hologenomes/F3336 --genomeFastaFiles ./Hologenomes/F3336.fna --sjdbGTFfile ./Hologenomes/F3336.gff --sjdbOverhang 50 --sjdbGTFtagExonParentTranscript ID --sjdbGTFtagExonParentGene Parent --genomeSAindexNbases 6
#N33
./STAR --runThreadN 16 --runMode genomeGenerate --genomeDir ./Hologenomes/N33 --genomeFastaFiles ./Hologenomes/N33.fna --sjdbGTFfile ./Hologenomes/N33.gff --sjdbOverhang 50 --sjdbGTFtagExonParentTranscript ID --sjdbGTFtagExonParentGene Parent --genomeSAindexNbases 6
#N36
./STAR --runThreadN 16 --runMode genomeGenerate --genomeDir ./Hologenomes/N36 --genomeFastaFiles ./Hologenomes/N36.fna --sjdbGTFfile ./Hologenomes/N36.gff --sjdbOverhang 50 --sjdbGTFtagExonParentTranscript ID --sjdbGTFtagExonParentGene Parent --genomeSAindexNbases 6
#N3636
./STAR --runThreadN 16 --runMode genomeGenerate --genomeDir ./Hologenomes/N3336 --genomeFastaFiles ./Hologenomes/N3336.fna --sjdbGTFfile ./Hologenomes/N3336.gff --sjdbOverhang 50 --sjdbGTFtagExonParentTranscript ID --sjdbGTFtagExonParentGene Parent --genomeSAindexNbases 6
#NAX
./STAR --runThreadN 16 --runMode genomeGenerate --genomeDir ./Hologenomes/NAX --genomeFastaFiles ./Hologenomes/NAX.fna --sjdbGTFfile ./Hologenomes/NAX.gff --sjdbOverhang 50 --sjdbGTFtagExonParentTranscript ID --sjdbGTFtagExonParentGene Parent --genomeSAindexNbases 6


