%{
#include <stdio.h>
#include <string.h>

int contador_Amor = 0;
int contador_Alegria = 0;
int contador_Esperanza = 0;
int contador_Exito = 0;
int contador_Tristeza = 0;
int contador_Miedo = 0;
int contador_Enojo = 0;
int contador_Derrota = 0;
int contador_Neutral = 0;

void contar_emocion(const char* palabra);
void encontrar_mas_repetido(); // Declaración de la función
%}

%%

amor|querer|amar|carino|ternura|admiracion|afecto     { contador_Amor++; }
feliz|contento|entusiasmo|risa|euforia|placer           { contador_Alegria++; }
optimismo|confianza|ilusion|motivacion|inspiracion       { contador_Esperanza++; }
logro|triunfo|superacion|avance|orgullo                 { contador_Exito++; }
llanto|soledad|vacio|desesperanza|perdida|dolor          { contador_Tristeza++; }
temor|angustia|inseguridad|panico|horror|amenaza         { contador_Miedo++; }
ira|odio|rabia|resentimiento|frustracion|venganza        { contador_Enojo++; }
fracaso|decepcion|perdida|humillacion|rendirse           { contador_Derrota++; }
cambio|duda|destino|misterio|sorpresa                    { contador_Neutral++; }

.|\n    { /* Ignorar otros caracteres */ }

<<EOF>>  { return 0; } /* Detiene yylex al final del archivo */

%%

void encontrar_mas_repetido() {
    int max = contador_Amor;
    char nombre_max[20] = "Amor";

    if (contador_Alegria > max) {
        max = contador_Alegria;
        sprintf(nombre_max, "Alegria");
    }
    if (contador_Esperanza > max) {
        max = contador_Esperanza;
        sprintf(nombre_max, "Esperanza");
    }
    if (contador_Exito > max) {
        max = contador_Exito;
        sprintf(nombre_max, "Exito");
    }
    if (contador_Tristeza > max) {
        max = contador_Tristeza;
        sprintf(nombre_max, "Tristeza");
    }
    if (contador_Miedo > max) {
        max = contador_Miedo;
        sprintf(nombre_max, "Miedo");
    }
    if (contador_Enojo > max) {
        max = contador_Enojo;
        sprintf(nombre_max, "Enojo");
    }
    if (contador_Derrota > max) {
        max = contador_Derrota;
        sprintf(nombre_max, "Derrota");
    }
    if (contador_Neutral > max) {
        max = contador_Neutral;
        sprintf(nombre_max, "Neutral");
    }

    printf("\nLa emoción más mencionada es '%s' con %d apariciones.\n", nombre_max, max);
}

int main() {
    yyin = fopen("El_Prisionero_de_Azkaban.txt", "r");
    if (!yyin) {
        perror("Error al abrir el archivo");
        return 1;
    }

    yylex(); // Ejecuta el análisis léxico

    printf("\nLa emoción 'Amor' aparece %d veces.\n", contador_Amor);
    printf("La emoción 'Alegria' aparece %d veces.\n", contador_Alegria);
    printf("La emoción 'Esperanza' aparece %d veces.\n", contador_Esperanza);
    printf("La emoción 'Exito' aparece %d veces.\n", contador_Exito);
    printf("La emoción 'Tristeza' aparece %d veces.\n", contador_Tristeza);
    printf("La emoción 'Miedo' aparece %d veces.\n", contador_Miedo);
    printf("La emoción 'Enojo' aparece %d veces.\n", contador_Enojo);
    printf("La emoción 'Derrota' aparece %d veces.\n", contador_Derrota);
    printf("La emoción 'Neutral' aparece %d veces.\n", contador_Neutral);

    encontrar_mas_repetido(); // Llama a la función para encontrar la más repetida

    fclose(yyin); // Cierra el archivo

    return 0;
}

// Definición de yywrap
int yywrap() {
    return 1; // Indica que el análisis ha terminado
}
