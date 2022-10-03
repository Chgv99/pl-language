#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stddef.h>

#include <stdint.h>

#include "table.h"

extern int _scope;   /* lexico */

char* typeStrings[] = { "nada", "entero", "flotante", "booleano", "caracter" };

int yyerror(char* s); //Lo exige la versión de bison

struct node* top = NULL;

struct node* buscar(char *id){ //busca el más reciente (local oculta global) (!?)
	struct node* p = top;
	while (p != NULL && strcmp(p->id, id) != 0) {
		p = p->sig;
	}
	return p;
}

void eliminar_scope(int scope){
	struct node* p = top;
	dump("eliminando scope");
	while (p->sig != NULL) {
		if (p->scope < scope){
			top = p;
			dump("scope eliminado");
			break;
		}
		p = p->sig;
	}
}

struct node* buscar_cat(char *id, enum category cat){
	struct node* p = buscar(id);
	return (p != NULL && p->cat == cat) ? p : NULL;
}

struct node* buscar_scope(char *id, int scope){
	struct node* p = buscar(id);
	return (p != NULL && p->scope == scope) ? p : NULL;
}

void insertar(char *id, enum category cat, enum type tipo){
	if (buscar(id) != NULL) {
		yyerror("-1: nombre ya definido");
		return; // return evitaría variables repetidas en la TS
	}
	struct node *p = (struct node *) malloc(sizeof(struct node));
	//printf("\ninserta %s _scope = %d\n", id, _scope);
	p->id = id; p->cat = cat; p->tipo = tipo/*p->tip = tp*/; p->sig = top; p->scope = _scope;
	top = p;
}

void finbloq(){
	while (top != NULL && top->cat != rutina) {
		struct node *p = top->sig;
		free(top->id); free(top); top=p;
	}
}

void dump(const char* s) {
	printf("\tDUMP: %s\n", s);
	struct node *p = top;
	printf("DIR\t\tCATEGORY\t\tID\t\tTIPO\t\tSCOPE\n");
	while (p != NULL){
		//printf("0x%x\t\t%c\t\t%s\t\t%s\t\t%d\n", (int)p, "TGLR"[p->cat], p->id, p->tipo==0?".":typeStrings[p->tipo], p->scope);
		printf("%p\t\t%c\t\t%s\t\t%s\t\t%d\n", p, "TGLR"[p->cat], p->id, p->tipo==0?".":typeStrings[p->tipo], p->scope);
		p=p->sig;
	}
}