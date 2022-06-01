#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stddef.h>

#include "table.h"

int yyerror(char* s); //Lo exige la versión de bison

struct reg* top = NULL;

struct reg* buscar(char *id){ //busca el más reciente (local oculta global) (!?)
	struct reg* p = top;
	while (p != NULL && strcmp(p->id, id) != 0) {
		p = p->sig;
	}
	return p;
}

struct reg* buscar_cat(char *id, enum category cat){
	struct reg* p = buscar(id);
	return (p != NULL && p->cat == cat) ? p : NULL;
}

void insertar(char *id, enum category cat, struct reg *tp){
	if (buscar(id) != NULL) yyerror("-1: nombre ya definido");
	struct reg *p = (struct reg *) malloc(sizeof(struct reg));
	p->id = id; p->cat = cat; p->tip = tp; p->sig = top;
	top = p;
}

void finbloq(){
	while (top != NULL && top->cat != rutina) {
		struct reg *p = top->sig;
		free(top->id); free(top); top=p;
	}
}

void dump(const char* s) {
	printf("	DUMP: %s\n", s);
	struct reg *p = top;
	while (p != NULL){
		printf("0x%x %c %s %s\n", (int)p, "TGLR"[p->cat], p->id, p->tip==NULL?".":p->tip->id);
		p=p->sig;
	}
}