import csv  
import sys

f = open("correlacoes.csv", 'rb') 

try:
	correlacoes = []
	reader = csv.reader(f)
	for row in reader:   
		correlacoes.append(row)
finally:
	f.close()

for e in correlacoes:
	e.pop(0)


f = open("correlacoes_sem_peso.csv", "w")

for e in correlacoes:
	f.write('%s; %s; %s; %s\n' % (e[0], e[1], e[2], e[2]))

