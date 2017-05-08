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

if len(sys.argv) != 4:
   sys.stderr.write('Usage: sys.argv[0] fasta start_no strand(+ or -) ' )
   print "\n"
   sys.exit(1)

for seq in SeqIO.parse(sys.argv[1],"fasta"):
	pass
seq_rgd = seq.seq

s = int(sys.argv[2])
dir = str(sys.argv[3])

if __name__ == '__main__':

	if dir=='+':
		print seq_rgd[s-195:s+45],
	elif dir=='-':
		seq=seq_rgd[s-44:s+196]
		seqr = seq.reverse_complement()
#		def rev(s): return s[::-1]
#		seqr = rev(seq)
		print seqr
#		print seq
	else:
		print "Error: correct strand direction needed"
