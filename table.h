enum category { tipo, v_global, v_local, rutina };

enum type { entero, flotante, booleano, caracter, nada };

extern struct reg {
	char *id;
	enum category cat;
	enum type tipo;
	struct reg *tip;
	struct reg *sig;
} *top;

struct reg* buscar(char *id);

struct reg* buscar_cat(char *id, enum category cat);

void insertar(char *id, enum category cat, enum type tipo);

void finbloq();

void dump(const char* s);