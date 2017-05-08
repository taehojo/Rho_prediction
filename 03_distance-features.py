#!/usr/bin/python

####################################################
#
# Freddolino Lab
# Author : Taeho Jo
#
####################################################

import sys
import csv as csv
import numpy as np

if len(sys.argv) != 3:
   sys.stderr.write('Usage: sys.argv[0] start_no strand(+ or -) ' )
   print "\n"
   sys.exit(1)

s = int(sys.argv[1])
s_plus = s
s_minus = s
dir = str(sys.argv[2])

csv_plus = csv.reader(open('../data/cds_only_plus_strand.csv','rb'))
data=[]
csv_minus = csv.reader(open('../data/cds_only_minus_strand.csv','rb'))
data2=[]

for row in csv_plus:
	data.append(row[0:])

data = np.array(data)

for row in csv_minus:
	data2.append(row[0:])

data2 = np.array(data2)

def find_nearest(array1,array2,value):
	idx1 = (np.abs(array1-value)).argmin()
	search_result = array1[idx1]

	if search_result >= value:  	
		s1 = array1[idx1 - 1]  		
		s2 = array1[idx1]			
		e1 = array2[idx1 - 1]		
		print s1, e1, s2,   			
		if value >= e1:   		
			sp1 = value - e1		
			sp2 = s2 - value		
			print ("0 %d %d" %(sp1, sp2)),  

		else: 				
			sp1 = value - s1		
			sp2 = e1 - value		
			print ("1 0 0"),

	else: 					
		s1 = array1[idx1]			
		s2 = array1[idx1+1]		
		e1 = array2[idx1]			
		print s1, e1, s2,
		if value >= e1:		
			sp1 = value - e1		
			sp2 = s2 - value		
			print ("0 %d %d" %(sp1, sp2)),

		else:				
			sp1 = value - s1		
			sp2 = e1 - value		
			print ("1 0 0"),

if __name__ == '__main__':

	if dir=='+':
		array1 = np.array(data[0::,0].astype(np.int)) 
		array2 = np.array(data[0::,1].astype(np.int)) 
		array3 = np.array(data2[0::,0].astype(np.int)) 
		array4 = np.array(data2[0::,1].astype(np.int)) 
		print ("%d %s same" % (s, dir)),
		find_nearest(array1, array2, s_plus)
		print ("reverse"),
		find_nearest(array3, array4, s_plus)

	elif dir=='-':
		array1 = np.array(data2[0::,0].astype(np.int)) 
		array2 = np.array(data2[0::,1].astype(np.int)) 
		array3 = np.array(data[0::,0].astype(np.int)) 
		array4 = np.array(data[0::,1].astype(np.int)) 
		print ("%d %s same" % (s, dir)),
		find_nearest(array1, array2, s_minus)
		print ("reverse"),
		find_nearest(array3, array4, s_minus)

	else:
		print "Error: correct strand direction needed"
