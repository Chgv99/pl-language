#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stddef.h>

#include "table.h"

struct reg* top = NULL;

struct reg* buscar(char *id){ //busca el más reciente (local oculta global) (!?)
	struct reg* pointer = top;
	while (pointer != NULL && strcmp(pointer->id, id) != 0) {
		pointer = pointer->sig;
	}
	return pointer;
}

struct reg* buscar_cat(char *id, enum category cat){
	struct reg* pointer = buscar(id);
	return (p != NULL && p->cat == cat) ? p : NULL;
}

void insertar(char *id, enum category cat, struct reg *tp){
	if (buscar(id) != NULL) yyerror("-1: nombre ya definido");
	struct reg *p = (struct reg *) malloc(sizeof(struct reg));
	p->id = id; p->cat = cat; p->tip = tp; p->sig = top;
	top = p;
}