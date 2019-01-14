#-----------------------------------
#	STAR - READ MAPPING
#-----------------------------------
# BEFORE RUNNING PLEASE CONSIDER READING THIS:

# generate "Hologenomes_2"

#The trick I am trying is to change bacterial CDS into exons, and so be able to feed STAR merged eukaryotic and bacterial gff files
echo '--------------------------'
echo 'compiling the hologenomes'
#COMPILING THE Hologenomes_2
mkdir ./Hologenomes_2
mkdir ./Hologenomes_2/F33
cp ./Genomes/Marinobacter_sp_FDB33.fna ./Hologenomes_2/F33.fna
cp ./Genomes/Marinobacter_sp_FDB33.gff ./Hologenomes_2/F33_CDS.gff
sed 's/CDS/exon/g' <./Hologenomes_2/F33_CDS.gff >./Hologenomes_2/F33.gff
echo 'F33 completed'

mkdir ./Hologenomes_2/F36
cp ./Genomes/Alteromonas_sp_FDB36.fna ./Hologenomes_2/F36.fna
cp ./Genomes/Alteromonas_sp_FDB36.gff ./Hologenomes_2/F36_CDS.gff
sed 's/CDS/exon/g' <./Hologenomes_2/F36_CDS.gff >./Hologenomes_2/F36.gff
echo 'F36 completed'

mkdir ./Hologenomes_2/F3336
cat ./Genomes/Marinobacter_sp_FDB33.fna ./Genomes/Alteromonas_sp_FDB36.fna > ./Hologenomes_2/F3336.fna
cat ./Hologenomes_2/F33.gff ./Hologenomes_2/F36.gff > ./Hologenomes_2/F3336.gff
echo 'F3336 completed'

mkdir ./Hologenomes_2/NAX
cp ./trinity_out_dir/Trinity.fasta ./Hologenomes_2/NAX.fna
cp ./Trinity.fasta.transdecoder_dir/longest_orfs.gff3 ./Hologenomes_2/NAX.gff
echo 'NAX completed'

mkdir ./Hologenomes_2/N33
cat ./Hologenomes_2/NAX.fna ./Hologenomes_2/F33.fna > ./Hologenomes_2/N33.fna
cat ./Hologenomes_2/NAX.gff ./Hologenomes_2/F33.gff > ./Hologenomes_2/N33.gff
echo 'N33 completed'

mkdir ./Hologenomes_2/N36
cat ./Hologenomes_2/NAX.fna ./Hologenomes_2/F36.fna > ./Hologenomes_2/N36.fna
cat ./Hologenomes_2/NAX.gff ./Hologenomes_2/F36.gff > ./Hologenomes_2/N36.gff
echo 'N36 completed'

mkdir ./Hologenomes_2/N3336
cat ./Hologenomes_2/NAX.fna ./Hologenomes_2/F33.fna ./Hologenomes_2/F36.fna > ./Hologenomes_2/N3336.fna
cat ./Hologenomes_2/NAX.gff ./Hologenomes_2/F33.gff ./Hologenomes_2/F36.gff > ./Hologenomes_2/N3336.gff
echo 'N3336 completed'
echo ' '
echo '------------------------'
echo 'building bowtie databases'

#build bowtie databases for each of the "hologenomes"
/opt/softwares/bowtie2/2.3.1/bowtie2-build ./Hologenomes_2/F33.fna ./Hologenomes_2/F33
/opt/softwares/bowtie2/2.3.1/bowtie2-build ./Hologenomes_2/F36.fna ./Hologenomes_2/F36
/opt/softwares/bowtie2/2.3.1/bowtie2-build ./Hologenomes_2/F3336.fna ./Hologenomes_2/F3336
/opt/softwares/bowtie2/2.3.1/bowtie2-build ./Hologenomes_2/NAX.fna ./Hologenomes_2/NAX
/opt/softwares/bowtie2/2.3.1/bowtie2-build ./Hologenomes_2/N33.fna ./Hologenomes_2/N33
/opt/softwares/bowtie2/2.3.1/bowtie2-build ./Hologenomes_2/N36.fna ./Hologenomes_2/N36
/opt/softwares/bowtie2/2.3.1/bowtie2-build ./Hologenomes_2/N3336.fna ./Hologenomes_2/N3336

echo ''
echo '-----------------------'
echo 'done'

