#-----------------------------------
#	SortMeRNA
#-----------------------------------
# BEFORE RUNNING PLEASE CONSIDER READING THIS:
#silva-euk-28s-id98.fasta is not part of the binary - so please go and dig for it as it may be key to remove
#download:	https://raw.githubusercontent.com/biocore/sortmerna/master/rRNA_databases/silva-euk-28s-id98.fasta
#and move the file to the ./rRNA_databases/ directory in path_to_sortmerna

#MAKE THE DATABASES
#./sortmerna-2.1b/indexdb_rna --ref \
#./sortmerna-2.1b/rRNA_databases/silva-bac-16s-id90.fasta,./sortmerna-2.1b/index/silva-bac-16s-db:\
#./sortmerna-2.1b/rRNA_databases/silva-bac-23s-id98.fasta,./sortmerna-2.1b/index/silva-bac-23s-db:\
#./sortmerna-2.1b/rRNA_databases/silva-arc-16s-id95.fasta,./sortmerna-2.1b/index/silva-arc-16s-db:\
#./sortmerna-2.1b/rRNA_databases/silva-arc-23s-id98.fasta,./sortmerna-2.1b/index/silva-arc-23s-db:\
#./sortmerna-2.1b/rRNA_databases/silva-euk-18s-id95.fasta,./sortmerna-2.1b/index/silva-euk-18s-db:\
#./sortmerna-2.1b/rRNA_databases/silva-euk-28s-id98.fasta,./sortmerna-2.1b/index/silva-euk-28s:\
#./sortmerna-2.1b/rRNA_databases/rfam-5s-database-id98.fasta,./sortmerna-2.1b/index/rfam-5s-db:\
#./sortmerna-2.1b/rRNA_databases/rfam-5.8s-database-id98.fasta,./sortmerna-2.1b/index/rfam-5.8s-db


#DO THEY NEED TO BE UNZIPPED OR NOT!!!!????
mkdir ./out_SortMeRNA/
for f in ./TRIM/*.fastq.gz
do
	fbname2=$(basename "$f" .fastq.gz)
	fbname3=$(basename "$f" .gz)

	echo "--------------------------------------------------"
	echo "path2file: $f"
	echo "treatment: $fbname2"
	echo "generating: $fbname3"
	if [[ $fbname2 == *"N"* ]]; then
  		echo "detected: Nannochloropsis"
	fi
	if [[ $fbname2 == *"33"* ]]; then
  		echo "detected: FDB33"
	fi
	if [[ $fbname2 == *"36"* ]]; then
  		echo "detected: FDB36"
	fi
	gunzip $f
	#DO THE MAPPING
	./sortmerna-2.1b/sortmerna --ref ./sortmerna-2.1b/rRNA_databases/silva-bac-16s-id90.fasta,./sortmerna-2.1b/index/silva-bac-16s-db:./sortmerna-2.1b/rRNA_databases/silva-bac-23s-id98.fasta,./sortmerna-2.1b/index/silva-bac-23s-db:./sortmerna-2.1b/rRNA_databases/silva-arc-16s-id95.fasta,./sortmerna-2.1b/index/silva-arc-16s-db:./sortmerna-2.1b/rRNA_databases/silva-arc-23s-id98.fasta,./sortmerna-2.1b/index/silva-arc-23s-db:./sortmerna-2.1b/rRNA_databases/silva-euk-18s-id95.fasta,./sortmerna-2.1b/index/silva-euk-18s-db:./sortmerna-2.1b/rRNA_databases/silva-euk-28s-id98.fasta,./sortmerna-2.1b/index/silva-euk-28s:./sortmerna-2.1b/rRNA_databases/rfam-5s-database-id98.fasta,./sortmerna-2.1b/index/rfam-5s-db:./sortmerna-2.1b/rRNA_databases/rfam-5.8s-database-id98.fasta,./sortmerna-2.1b/index/rfam-5.8s-db --reads ./TRIM/${fbname3} --num_alignments 1 --fastx --aligned ./out_SortMeRNA/${fbname2}_reads_rRNA --other ./out_SortMeRNA/${fbname2}_reads_non_rRNA --log -a 8 -v -m 64000 # --paired_in -v
done


