#!/usr/bin/python

####################################################
#
# Freddolino Lab
# Author : Taeho Jo
#
####################################################

import sys
import regex
import numpy as  np

if len(sys.argv) != 3:
   sys.stderr.write('Usage: sys.argv[0] fasta motif ' )
   print "\n"
   sys.exit(1)

f = sys.argv[1]
m = sys.argv[2]

def fire_cal(motif_seq, target_seq):
	# this is what this does
	# this is what the arguments are
        myre0 = regex.compile("(%s){e<=0}" % (str(motif_seq),))
        myre1 = regex.compile("(%s){e<=1}" % (str(motif_seq),))
        myre2 = regex.compile("(%s){e<=2}" % (str(motif_seq),))
        myre3 = regex.compile("(%s){e<=3}" % (str(motif_seq),))
        myre4 = regex.compile("(%s){e<=4}" % (str(motif_seq),))
        cal0 = len(myre0.findall(target_seq))
        cal1 = len(myre1.findall(target_seq))*0.8
        cal2 = len(myre2.findall(target_seq))*0.6
        cal3 = len(myre3.findall(target_seq))*0.4
        cal4 = len(myre4.findall(target_seq))*0.2
	cal1_all=myre1.findall(target_seq)
#	print 'cal1: %s' % cal1, 
#	print 'cat1_all: %s' % cal1_all,
	sum_cal = np.sum([cal0, cal1, cal2, cal3, cal4])
	div_cal = np.divide(sum_cal,5.)
#	print ""
	return div_cal

if __name__ == '__main__':
	with open(f, "r") as ins:
    		array = []
    		for line1 in ins:
			print ""
#			print 'seq: %s' % line1,
			with open(m, "r") as ins2:
				array = []
    				for line2 in ins2:
#					print 'motif: %s' % line2,
					fm = fire_cal(line2.rstrip(), line1.rstrip())
					print(fm),
#					print ""
