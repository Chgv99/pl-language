enum category { tipo, v_global, v_local, rutina };

enum type { nada, entero, flotante, booleano, caracter, ristra/*, array*/ };

extern struct node {
	unsigned int dir;
	char *id;
	int reg;
	enum category cat;
	enum type tipo;
	//struct node *tip;

	struct node *sig;
	int scope;
	char* function;
} *top;

struct node* buscar(char *id);

unsigned int ultima();

int eliminar_scope(int scope);

struct node* buscar_cat(char *id, enum category cat);

struct node* buscar_scope(char *id, int scope);

void insertar(char *id, enum category cat, enum type tipo, unsigned int address);

void finbloq();

void dump(const char* s);