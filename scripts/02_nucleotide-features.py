#!/usr/bin/python

####################################################
#
# Freddolino Lab
# Author : Taeho Jo
#
####################################################

import sys
from Bio import SeqIO
from Bio.Seq import Seq

if len(sys.argv) != 2:
   sys.stderr.write('Usage: sys.argv[0] fasta')
   print "\n"
   sys.exit(1)

for seq in SeqIO.parse(sys.argv[1],"fasta"):
	pass
seq_rgd = seq.seq

def make_nuc(seqn, s):
	s = seqn.count(s)/float(len(seqn))
	return s

if __name__ == '__main__':
	seqlist = ['A', 'C', 'G', 'T', 'AA', 'AC', 'AG', 'AT', 'CA', 'CC', 'CG', 'CT', 'GA', 'GC', 'GG', 'GT', 'TA', 'TC', 'TG', 'TT', 'AAA', 'AAC', 'AAG', 'AAT', 'ACA', 'ACC', 'ACG', 'ACT', 'AGA', 'AGC', 'AGG', 'AGT', 'ATA', 'ATC', 'ATG', 'ATT','CAA', 'CAC', 'CAG', 'CAT', 'CCA', 'CCC', 'CCG', 'CCT', 'CGA', 'CGC', 'CGG', 'CGT', 'CTA', 'CTC', 'CTG', 'CTT','GAA', 'GAC', 'GAG', 'GAT', 'GCA', 'GCC', 'GCG', 'GCT', 'GGA', 'GGC', 'GGG', 'GGT', 'GTA', 'GTC', 'GTG', 'GTT','TAA', 'TAC', 'TAG', 'TAT', 'TCA', 'TCC', 'TCG', 'TCT', 'TGA', 'TGC', 'TGG', 'TGT', 'TTA', 'TTC', 'TTG', 'TTT']
	for res in seqlist:
		freq = make_nuc(seq_rgd, res)
		print round(freq, 4),

