#!/usr/bin/python

####################################################
#
# Freddolino Lab
# Author : Taeho Jo
#
####################################################

import sys
import get_stacking_dG
from Bio import SeqIO
from Bio.Seq import Seq

if len(sys.argv) != 2:
   sys.stderr.write('Usage: sys.argv[0] fasta')
   print "\n"
   sys.exit(1)

stack = get_stacking_dG.calc_ener_for_seq(sys.argv[1])
print stack
