boolcalc: boolcalc.y boolcalc.l
	flex boolcalc.l
	bison -d boolcalc.y
	gcc -o boolcalc lex.yy.c boolcalc.tab.c -lm

clean: 
	rm -f boolcalc boolcalc.exe boolcalc.tab.* lex.yy.*
