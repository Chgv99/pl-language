enum category { tipo, v_global, v_local, rutina };

enum type { nada, entero, flotante, booleano, caracter };

extern struct reg {
	char *id;
	enum category cat;
	enum type tipo;
	//struct reg *tip;
	struct reg *sig;
	int scope;
} *top;

struct reg* buscar(char *id);

struct reg* buscar_cat(char *id, enum category cat);

void insertar(char *id, enum category cat, enum type tipo);

void finbloq();

void dump(const char* s);