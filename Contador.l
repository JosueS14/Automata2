%option noyywrap
%{
    #include <stdio.h>

    int contador_Harry = 0;
    int contador_Hagrid = 0;
    int contador_Marge = 0;
    int contador_Vernon = 0;

    void encontrar_mas_repetido(); // Declaraci�n de la funci�n
%}

%%

Harry   { contador_Harry++; }
Hagrid  { contador_Hagrid++; }
Marge   { contador_Marge++; }
Vernon  { contador_Vernon++; }
.|\n    { /* Ignorar otros caracteres */ }
<<EOF>> { return 0; } /* Detiene yylex al final del archivo */

%%

void encontrar_mas_repetido() {
    int max = contador_Harry;
    char nombre_max[10] = "Harry";

    if (contador_Hagrid > max) {
        max = contador_Hagrid;
        sprintf(nombre_max, "Hagrid");
    }
    if (contador_Marge > max) {
        max = contador_Marge;
        sprintf(nombre_max, "Marge");
    }
    if (contador_Vernon > max) {
        max = contador_Vernon;
        sprintf(nombre_max, "Vernon");
    }

    printf("\nEl nombre m�s mencionado es '%s' con %d apariciones.\n", nombre_max, max);
}

int main() {
    yyin = fopen("El_Prisionero_de_Azkaban.txt", "r");
    if (!yyin) {
        perror("Error al abrir el archivo");
        return 1;
    }

    yylex(); // Ejecuta el an�lisis l�xico

    printf("\nEl nombre 'Harry' aparece %d veces.\n", contador_Harry);
    printf("El nombre 'Hagrid' aparece %d veces.\n", contador_Hagrid);
    printf("El nombre 'Marge' aparece %d veces.\n", contador_Marge);
    printf("El nombre 'Vernon' aparece %d veces.\n", contador_Vernon);

    encontrar_mas_repetido(); // Llama a la funci�n para encontrar el m�s repetido

    fclose(yyin); // Cierra el archivo

    return 0;
}
