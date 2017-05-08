#! /bin/bash

####################################################
#
# Freddolino Lab
# Author : Taeho Jo
#
####################################################

# M1655 fasta
F_FASTA="./data/mg1655_v2.fasta";

# script for sequence extract
M_SEQ="./scripts/01_extract-seq.py";
M_SEQ_30="./scripts/01_extract-seq-30.py";

# script for nucleotide composition
M_NUC="./scripts/02_nucleotide-features.py";

# script for gene distance calculation
D_GENE_P="./script/03_distance-features.py";
D_GENE_M="./script/03_distance-features-reverse.py";

# DNA stack energy
STACK="./scripts/04_dna-stack-energy.py";

#FIRE motif
MOTIF_LIST='./motif_results/FIRE.txt'
FIRE_LEN='./scripts/05_fire-len.py'

#meme motif
MEME_P='./motif_results/meme-plus.txt'
MEME_M='./motif_results/meme-minus.txt'

#glam2 motif
GLAM_P10='./motif_results/glam2-plus10.txt'
GLAM_M10='./motif_results/glam2-minus10.txt'
GLAM_P20='./motif_results/glam2-plus20.txt'
GLAM_M20='./motif_results/glam2-minus20.txt'

# kmer
KMER="/home/petefred/src/gkmsvm/gkmsvm_classify"
KMER_FA_P="./data/kmer/svm_kernel-k5l6.out_svseq.fa"
KMER_FA_M="./data/kmer/svm_kernel-minus-k5l6.out_svseq.fa"
KMER_OUT_P="./data/kmer/svm_kernel-k5l6.out_svalpha.out"
KMER_OUT_M="./data/kmer/svm_kernel-minus-k5l6.out_svalpha.out"

# mfold
MFOLD="/usr/local/bin/mfold";

# TEISER
TEISER="/home/petefred/src/teiser-dev/TEISER/"
TEISER_BIN="./data/BST-exp.optim.bin"
		

#####################################################

if [[ $# -ne 4 ]]; then
  echo "Usage: $0 <list> <Uniq-id> <Posneg : + if positive,  - if negative> <Strand : + or - >";   
  exit;
fi

S_LIST=$1;
OUTPUT=$2;
POSNEG=$3;
STRAND=$4;

# check script path and current path
pushd `dirname $0` > /dev/null
OUT_URL=`pwd -P`
popd > /dev/null
PWD=$(pwd)

if [ "$OUT_URL" != "$PWD" ]; then
   echo "ERROR: The script path and current path should be matched." 1>&2
   exit 1
fi

mkdir -p $OUT_URL/tmp-$OUTPUT
mkdir -p $OUT_URL/tmp-$OUTPUT/dataset
mkdir -p $OUT_URL/tmp-$OUTPUT/run

# make initial dataset
initfile=$S_LIST
while read line
do
python $M_SEQ $F_FASTA $line
done < "$initfile" > $OUT_URL/tmp-$OUTPUT/dataset/data-all

cp $MOTIF_LIST $OUT_URL/tmp-$OUTPUT/motif_list


# make list
sed 's/\t//g' $S_LIST | sed 's/^/>/' > $OUT_URL/tmp-$OUTPUT/t_list


###############################################################
# generate features
###############################################################
mkdir -p $OUT_URL/tmp-$OUTPUT/seq
mkdir -p $OUT_URL/tmp-$OUTPUT/seq-30
mkdir -p $OUT_URL/tmp-$OUTPUT/mfold
mkdir -p $OUT_URL/tmp-$OUTPUT/nuc
mkdir -p $OUT_URL/tmp-$OUTPUT/motif
mkdir -p $OUT_URL/tmp-$OUTPUT/motif_t
mkdir -p $OUT_URL/tmp-$OUTPUT/dist/
mkdir -p $OUT_URL/tmp-$OUTPUT/mid-result/

#seq set preperation
	paste -d'\n' $OUT_URL/tmp-$OUTPUT/t_list $OUT_URL/tmp-$OUTPUT/dataset/data-all > $OUT_URL/tmp-$OUTPUT/seq-fa
	seqfile=$OUT_URL/tmp-$OUTPUT/seq-fa
		while read line
		do
		if [[ ${line:0:1} == '>' ]]
    			then
        		outfile=${line#>}.fa
        		echo $line > $OUT_URL/tmp-$OUTPUT/seq/$outfile
		else
        		echo $line >> $OUT_URL/tmp-$OUTPUT/seq/$outfile
    		fi
		done < "$seqfile"

# make seq list
	awk -F'\t' '{print $1 $2 ".fa"}' $S_LIST > $OUT_URL/tmp-$OUTPUT/list-seq

#seq 30
	initfile30=$OUT_URL/tmp-$OUTPUT/list-seq
	while read line
	do
	python $M_SEQ_30  $OUT_URL/tmp-$OUTPUT/seq/$line >> $OUT_URL/tmp-$OUTPUT/dataset/data-all-30
	for i in {1..8} ; do echo $line$i >>$OUT_URL/tmp-$OUTPUT/list-seq-30 ; done
	done < "$initfile30" 

#make list30
	sed 's/^/>/' $OUT_URL/tmp-$OUTPUT/list-seq-30 > $OUT_URL/tmp-$OUTPUT/t_list-30

#seq set preperation
	paste -d'\n' $OUT_URL/tmp-$OUTPUT/t_list-30 $OUT_URL/tmp-$OUTPUT/dataset/data-all-30 > $OUT_URL/tmp-$OUTPUT/seq-fa-30

	seqfile=$OUT_URL/tmp-$OUTPUT/seq-fa-30
		while read line
		do
		if [[ ${line:0:1} == '>' ]]
    			then
        		outfile=${line#>}.fa
        		echo $line > $OUT_URL/tmp-$OUTPUT/seq-30/$outfile
		else
        		echo $line >> $OUT_URL/tmp-$OUTPUT/seq-30/$outfile
    		fi
		done < "$seqfile"

	ls -1v $OUT_URL/tmp-$OUTPUT/seq-30 > $OUT_URL/tmp-$OUTPUT/list-seq-30


# make mfold features
	mfoldfile=$OUT_URL/tmp-$OUTPUT/list-seq-30
		while read line
		do
		cd $OUT_URL/tmp-$OUTPUT/run
		$MFOLD SEQ=$OUT_URL/tmp-$OUTPUT/seq-30/$line | grep Minimum |awk -F' ' '{print $5}' >> $OUT_URL/tmp-$OUTPUT/mid-result/$line

		#number of stem loops
		NumL=$(tail -n +2 $OUT_URL/tmp-$OUTPUT/run/$line.plot |wc -l)
		#the length of the longest stem loop 
		NumM=$(tail -n +2 $OUT_URL/tmp-$OUTPUT/run/$line.plot | awk '{if(max<$2){max=$2;line=$2}}END{print line}')
		#total number of bp in the sequence that are part of stem loops 
		NumB=$(awk '{sum+=$2} END{print sum;}' $OUT_URL/tmp-$OUTPUT/run/$line.plot)
		#the average number of stem loops
		NumA=$(expr $NumB / $NumL)
		echo $NumL $NumM $NumB $NumA >> $OUT_URL/tmp-$OUTPUT/mid-result/$line
		rm $OUT_URL/tmp-$OUTPUT/run/*
		cd $OUT_URL
        	done < "$mfoldfile"

# make nucleotide 4, dinucleotide 16 features
		nucfile=$OUT_URL/tmp-$OUTPUT/list-seq-30
		while read line
		do
		python $OUT_URL/$M_NUC $OUT_URL/tmp-$OUTPUT/seq-30/$line >> $OUT_URL/tmp-$OUTPUT/mid-result/$line
		done < "$nucfile" 

# motif search agrep - FIRE
	# if bias ($11) is 3 or 0, check both direction, if 1 forward, and if 2 backward

	cat $OUT_URL/tmp-$OUTPUT/motif_list | awk -F'\t' '{print $1 "\t" $11}' | grep [30] | awk '{print $1}' > $OUT_URL/tmp-$OUTPUT/motif/both-1 
	cat $OUT_URL/tmp-$OUTPUT/motif_list | awk -F'\t' '{print $1 "\t" $11}' | grep [30] | rev | sed 's/\[/\@/g' | sed 's/\]/\#/g' |sed 's/\@/\]/g' |sed 's/\#/\[/g' |awk '{print $2}' | sed 's/A/1/g' | sed 's/C/2/g' | sed 's/T/3/g' | sed 's/G/4/g' |sed 's/1/T/g' | sed 's/2/G/g' | sed 's/3/A/g' | sed 's/4/C/g' > $OUT_URL/tmp-$OUTPUT/motif/both-2

	cat $OUT_URL/tmp-$OUTPUT/motif_list | awk -F'\t' '{print $1 "\t" $11}' | grep 1 | awk '{print $1}' > $OUT_URL/tmp-$OUTPUT/motif/forward
	cat $OUT_URL/tmp-$OUTPUT/motif_list | awk -F'\t' '{print $1 "\t" $11}' | grep 2 | rev | sed 's/\[/\@/g' | sed 's/\]/\#/g' |sed 's/\@/\]/g' |sed 's/\#/\[/g' |awk '{print $2}' | sed 's/A/1/g' | sed 's/C/2/g' | sed 's/T/3/g' | sed 's/G/4/g' |sed 's/1/T/g' | sed 's/2/G/g' | sed 's/3/A/g' | sed 's/4/C/g' > $OUT_URL/tmp-$OUTPUT/motif/back

	cat $OUT_URL/tmp-$OUTPUT/motif/both-1 $OUT_URL/tmp-$OUTPUT/motif/both-2 $OUT_URL/tmp-$OUTPUT/motif/forward $OUT_URL/tmp-$OUTPUT/motif/back > $OUT_URL/tmp-$OUTPUT/motif/list_new

# motif search - FIRE
python py/len.py $OUT_URL/tmp-$OUTPUT/dataset/data-all-30 $OUT_URL/tmp-$OUTPUT/motif/list_new > $OUT_URL/tmp-$OUTPUT/fire-motif

#motif search - meme
if [ $STRAND == + ] 
then 
	cp $MEME_P $OUT_URL/tmp-$OUTPUT/motif/list_meme
	python py/len.py $OUT_URL/tmp-$OUTPUT/dataset/data-all-30 $OUT_URL/tmp-$OUTPUT/motif/list_meme > $OUT_URL/tmp-$OUTPUT/meme-motif
	cp $GLAM_P10 $OUT_URL/tmp-$OUTPUT/motif/list_glam10 
	python py/len.py $OUT_URL/tmp-$OUTPUT/dataset/data-all-30 $OUT_URL/tmp-$OUTPUT/motif/list_glam10 > $OUT_URL/tmp-$OUTPUT/glam10-motif
	cp $GLAM_P20 $OUT_URL/tmp-$OUTPUT/motif/list_glam20
	python py/len.py $OUT_URL/tmp-$OUTPUT/dataset/data-all-30 $OUT_URL/tmp-$OUTPUT/motif/list_glam20 > $OUT_URL/tmp-$OUTPUT/glam20-motif
else
	cp $MEME_M $OUT_URL/tmp-$OUTPUT/motif/list_meme
	python py/len.py $OUT_URL/tmp-$OUTPUT/dataset/data-all-30 $OUT_URL/tmp-$OUTPUT/motif/list_meme > $OUT_URL/tmp-$OUTPUT/meme-motif
	cp $GLAM_M10 $OUT_URL/tmp-$OUTPUT/motif/list_glam10 
	python py/len.py $OUT_URL/tmp-$OUTPUT/dataset/data-all-30 $OUT_URL/tmp-$OUTPUT/motif/list_glam10 > $OUT_URL/tmp-$OUTPUT/glam10-motif
	cp $GLAM_M20 $OUT_URL/tmp-$OUTPUT/motif/list_glam20
	python py/len.py $OUT_URL/tmp-$OUTPUT/dataset/data-all-30 $OUT_URL/tmp-$OUTPUT/motif/list_glam20 > $OUT_URL/tmp-$OUTPUT/glam20-motif
fi

	# motif search - TEISER
	teiserfile=$OUT_URL/tmp-$OUTPUT/list-seq-30
	while read line
	do
		$TEISER/Programs/scan_sequences_for_motif_profile -seedfile $TEISER_BIN -fastafile $OUT_URL/tmp-$OUTPUT/seq-30/$line -dataoutfile $OUT_URL/tmp-$OUTPUT/motif_t/$line-dat -reportfile $OUT_URL/tmp-$OUTPUT/motif_t/$line-rpt
	t_line=$(wc -l < $OUT_URL/tmp-$OUTPUT/motif_t/$line-rpt)
	t_line_a=$(expr $t_line / 2)
	echo "$t_line_a" >> $OUT_URL/tmp-$OUTPUT/mid-result/$line
	done < "$teiserfile" 

	# distance search
	distfile=$S_LIST
	while read line
	do 
	for i in {1..8}	
	do
	echo $line > $OUT_URL/tmp-$OUTPUT/tmp-li 
	numC=$(cat $OUT_URL/tmp-$OUTPUT/tmp-li |awk '{print $1}')
	numB=$(cat $OUT_URL/tmp-$OUTPUT/tmp-li |awk '{print $2}')
	numD=$(( 30 * $i ))
	numA=$(expr $numC - 195 + $numD)
	nameL=$numC$numB
	if [ $STRAND == + ] 
	then 
		python $D_GENE_P $numA $numB | awk -F' ' '{print $7,$8,$9,$14,$15,$16}' >> $OUT_URL/tmp-$OUTPUT/mid-result/$nameL.fa$i.fa
	value=$(tail -n 1 $OUT_URL/tmp-$OUTPUT/seq-30/$nameL.fa$i.fa) 
	python $STACK $value >> $OUT_URL/tmp-$OUTPUT/mid-result/$nameL.fa$i.fa
	$KMER -R -d 4 $OUT_URL/tmp-$OUTPUT/seq-30/$nameL.fa$i.fa $KMER_FA_P $KMER_OUT_P $OUT_URL/tmp-$OUTPUT/tmp-kmer
	else
		python $D_GENE_M $numA $numB | awk -F' ' '{print $7,$8,$9,$14,$15,$16}' >> $OUT_URL/tmp-$OUTPUT/mid-result/$nameL.fa$i.fa
	value=$(tail -n 1 $OUT_URL/tmp-$OUTPUT/seq-30/$nameL.fa$i.fa) 
	python $STACK $value >> $OUT_URL/tmp-$OUTPUT/mid-result/$nameL.fa$i.fa
	$KMER -R -d 4 $OUT_URL/tmp-$OUTPUT/seq-30/$nameL.fa$i.fa $KMER_FA_M $KMER_OUT_M $OUT_URL/tmp-$OUTPUT/tmp-kmer	
	fi

	awk -F' ' '{print $2}' $OUT_URL/tmp-$OUTPUT/tmp-kmer >> $OUT_URL/tmp-$OUTPUT/mid-result/$nameL.fa$i.fa
#	printf 0 >> $OUT_URL/tmp-$OUTPUT/mid-result/$nameL.fa$i.fa
	rm $OUT_URL/tmp-$OUTPUT/tmp-kmer

	sed -i ':a;N;$!ba;s/\n/ /g' $OUT_URL/tmp-$OUTPUT/mid-result/$nameL.fa$i.fa
	rm $OUT_URL/tmp-$OUTPUT/tmp-li
	done
	done < "$distfile"

# make train set	

trainfile=$OUT_URL/tmp-$OUTPUT/list-seq-30
while read line
do		
printf "@#$line @"
for file in $OUT_URL/tmp-$OUTPUT/mid-result/$line 
	do
	cat $file 
	printf "\n"
	done
done < "$trainfile" > $OUT_URL/tmp-$OUTPUT/call-all

STR="$POSNEG"
sed -i ':a;N;$!ba;s/\n/ /g;s/@/\n/g;s/.fa \n/.fa \n%% /g' $OUT_URL/tmp-$OUTPUT/call-all
sed -i 's/%%/'$STR'1/g' $OUT_URL/tmp-$OUTPUT/call-all
sed '1d'  $OUT_URL/tmp-$OUTPUT/call-all > $OUT_URL/tmp-$OUTPUT/$OUTPUT-r.trn
sed -i 's/  / /g' $OUT_URL/tmp-$OUTPUT/$OUTPUT-r.trn

sed -i ':a;N;$!ba;s/\n/\n\n/g'  $OUT_URL/tmp-$OUTPUT/fire-motif
sed -i '1d'  $OUT_URL/tmp-$OUTPUT/fire-motif
sed -i 's/  / /g' $OUT_URL/tmp-$OUTPUT/fire-motif

sed -i ':a;N;$!ba;s/\n/\n\n/g'  $OUT_URL/tmp-$OUTPUT/meme-motif
sed -i '1d'  $OUT_URL/tmp-$OUTPUT/meme-motif
sed -i 's/  / /g' $OUT_URL/tmp-$OUTPUT/meme-motif

sed -i ':a;N;$!ba;s/\n/\n\n/g'  $OUT_URL/tmp-$OUTPUT/glam10-motif
sed -i '1d'  $OUT_URL/tmp-$OUTPUT/glam10-motif
sed -i 's/  / /g' $OUT_URL/tmp-$OUTPUT/glam10-motif

sed -i ':a;N;$!ba;s/\n/\n\n/g'  $OUT_URL/tmp-$OUTPUT/glam20-motif
sed -i '1d'  $OUT_URL/tmp-$OUTPUT/glam20-motif
sed -i 's/  / /g' $OUT_URL/tmp-$OUTPUT/glam20-motif

paste -d' ' $OUT_URL/tmp-$OUTPUT/$OUTPUT-r.trn $OUT_URL/tmp-$OUTPUT/fire-motif $OUT_URL/tmp-$OUTPUT/meme-motif $OUT_URL/tmp-$OUTPUT/glam10-motif $OUT_URL/tmp-$OUTPUT/glam20-motif > $OUT_URL/$OUTPUT.trn

grep ^[+-]1 $OUT_URL/$OUTPUT.trn |sed 's/[+-]1 //g' |awk 'NR%8{printf $0" ";next;}1' | sed 's/  / /g' |  sed 's/^/\n'$STR'1 /g'  > $OUT_URL/$OUTPUT.trn-b

sed  's/^/>/g'  $S_LIST |sed ':a;N;$!ba;s/\n/\n\n/g' > $OUT_URL/$OUTPUT.trn-a
paste -d' ' $OUT_URL/$OUTPUT.trn-a $OUT_URL/$OUTPUT.trn-b > $OUT_URL/$OUTPUT.trn 
sed -i ':a;N;$!ba;s/ \n [+-]1/\n'$STR'1/g' $OUT_URL/$OUTPUT.trn 
sed -i 's/>/#/g' $OUT_URL/$OUTPUT.trn

rm $OUT_URL/$OUTPUT.trn-a $OUT_URL/$OUTPUT.trn-b
rm -r $OUT_URL/tmp-$OUTPUT/
