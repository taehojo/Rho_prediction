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
   sys.stderr.write('Usage: sys.argv[0] fasta ' )
   print "\n"
   sys.exit(1)

for seq in SeqIO.parse(sys.argv[1],"fasta"):
	pass
seq_rgd = seq.seq

print  seq_rgd[0:50]
print seq_rgd[30:80]
print  seq_rgd[60:110]
print seq_rgd[90:140]
print  seq_rgd[120:170]
print  seq_rgd[150:200]
print seq_rgd[180:230]
print  seq_rgd[210:260]


