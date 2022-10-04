#include "Q.h"
BEGIN
L 0:						# Inicio del programa
	# Memoria estática
CODE(0)
	R7 = 0x08000
	R6 = R7
	R7 = R7 - 4	# Reserva de memoria para c
	R7 = R7 - 4	# Reserva de memoria para b
	R7 = R7 - 4	# Reserva de memoria para a
END
