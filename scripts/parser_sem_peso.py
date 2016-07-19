import csv  

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

count = 0
for e in correlacoes:
	if count == 0:
		count+=1
	else:
		f.write('%s; %s\n' % (e[0], e[1]))


