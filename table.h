enum category { tipo, v_global, v_local, rutina };

extern struct reg {
	char *id;
	enum category cat;
	struct reg *tip;
	struct reg *sig;
} *top;

struct reg* buscar(char *id);

struct reg* buscar_cat(char *id, enum category cat);

void insertar(char *id, enum category cat, struct reg *tp);

void finbloq();

void dump(const char* s);