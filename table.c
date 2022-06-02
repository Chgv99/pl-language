#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stddef.h>

#include "table.h"

extern int _scope;   /* lexico */

char* typeStrings[] = { "nada", "entero", "flotante", "booleano", "caracter" };

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

void insertar(char *id, enum category cat, enum type tipo){
	if (buscar(id) != NULL) {
		yyerror("-1: nombre ya definido");
		return; // return evitaría variables repetidas en la TS
	}
	struct reg *p = (struct reg *) malloc(sizeof(struct reg));
	printf("\ninserta %s _scope = %d\n", id, _scope);
	p->id = id; p->cat = cat; p->tipo = tipo/*p->tip = tp*/; p->sig = top; p->scope = _scope;
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
		printf("0x%x\t\t%c\t\t%s\t\t%s\t\t%d\n", (int)p, "TGLR"[p->cat], p->id, p->tipo==0?".":typeStrings[p->tipo], p->scope);
		p=p->sig;
	}
}