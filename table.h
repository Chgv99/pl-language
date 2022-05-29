enum category { tipo, v_global, v_local, rutina }

extern struct reg {
	char *id;
	enum category cat;
	struct reg *tip;
	struct reg *sig;
} *top;