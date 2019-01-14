######
#Assemble with Trinity
######
#make sure that the output directory of a potential previous run is removed
rm ./trinity_out_dir
FILES=`ls -m ./BOWTIE/*.fastq.gz | tr -d ' '| tr -d '\n'`
echo $FILES
/opt/softwares/Trinity/2.2.0/Trinity --seqType fq --single $FILES --CPU 16 --max_memory 20G

