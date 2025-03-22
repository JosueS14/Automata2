%option noyywrap

%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_PALABRAS 1000

int contador_Amor = 0;
int contador_Alegria = 0;
int contador_Esperanza = 0;
int contador_Exito = 0;
int contador_Tristeza = 0;
int contador_Miedo = 0;
int contador_Enojo = 0;
int contador_Derrota = 0;
int contador_Neutral = 0;

const char* palabras_irrelevantes[] = {
    "el", "la", "los", "las", "un", "una", "y", "o", "pero", "como", "en", "a", "de", "que", "por", "con", "para", "aqui", "ahora"
};

typedef struct {
    char palabra[100];
    int contador;
} PalabraFrecuente;

PalabraFrecuente lista_palabras[MAX_PALABRAS]; // Lista de palabras y sus contadores
int total_palabras_count = 0; // Variable para contar las palabras

void contar_emocion(const char* palabra);
void encontrar_mas_repetido();
int es_irrelevante(const char* palabra);
void agregar_palabra_frecuente(const char* palabra);
void ordenar_palabras();
%}

%%

amor|querer|amar|carino|ternura|admiracion|afecto { contador_Amor++; agregar_palabra_frecuente(yytext); }
feliz|contento|entusiasmo|risa|euforia|placer { contador_Alegria++; agregar_palabra_frecuente(yytext); }
optimismo|confianza|ilusion|motivacion|inspiracion { contador_Esperanza++; agregar_palabra_frecuente(yytext); }
logro|triunfo|superacion|avance|orgullo { contador_Exito++; agregar_palabra_frecuente(yytext); }
llanto|soledad|vacio|desesperanza|perdida|dolor { contador_Tristeza++; agregar_palabra_frecuente(yytext); }
temor|angustia|inseguridad|panico|horror|amenaza { contador_Miedo++; agregar_palabra_frecuente(yytext); }
ira|odio|rabia|resentimiento|frustracion|venganza { contador_Enojo++; agregar_palabra_frecuente(yytext); }
fracaso|decepcion|perdida|humillacion|rendirse { contador_Derrota++; agregar_palabra_frecuente(yytext); }
cambio|duda|destino|misterio|sorpresa { contador_Neutral++; agregar_palabra_frecuente(yytext); }
.|\n { /* Ignorar otros caracteres */ }
<<EOF>> { return 0; } /* Detiene yylex al final del archivo */

%%

int es_irrelevante(const char* palabra) {
    int i;
    for (i = 0; i < sizeof(palabras_irrelevantes) / sizeof(palabras_irrelevantes[0]); i++) {
        if (strcmp(palabra, palabras_irrelevantes[i]) == 0) {
            return 1; 
        }
    }
    return 0;
}

void agregar_palabra_frecuente(const char* palabra) {
    int i;
    if (es_irrelevante(palabra)) {
        return; 
    }

    for (i = 0; i < total_palabras_count; i++) {
        if (strcmp(lista_palabras[i].palabra, palabra) == 0) {
            lista_palabras[i].contador++; // Incrementar el contador
            return;
        }
    }

    strcpy(lista_palabras[total_palabras_count].palabra, palabra);
    lista_palabras[total_palabras_count].contador = 1;
    total_palabras_count++;
}

void ordenar_palabras() {
    int i, j;
    for (i = 0; i < total_palabras_count - 1; i++) {
        for (j = i + 1; j < total_palabras_count; j++) {
            if (lista_palabras[i].contador < lista_palabras[j].contador) {
                PalabraFrecuente temp = lista_palabras[i];
                lista_palabras[i] = lista_palabras[j];
                lista_palabras[j] = temp;
            }
        }
    }
}

void encontrar_mas_repetido() {
    int i;
    ordenar_palabras();

    printf("\nLas 10 palabras más frecuentes son:\n");
    for (i = 0; i < 10 && i < total_palabras_count; i++) {
        printf("%d. %s: %d veces\n", i + 1, lista_palabras[i].palabra, lista_palabras[i].contador);
    }
}

int main() {
    extern FILE *yyin;
    yyin = fopen("El_Prisionero_de_Azkaban.txt", "r");
    if (!yyin) {
        perror("Error al abrir el archivo");
        return 1;
    }

    yylex();

    printf("\nLa emoción 'Amor' aparece %d veces.\n", contador_Amor);
    printf("La emoción 'Alegria' aparece %d veces.\n", contador_Alegria);
    printf("La emoción 'Esperanza' aparece %d veces.\n", contador_Esperanza);
    printf("La emoción 'Exito' aparece %d veces.\n", contador_Exito);
    printf("La emoción 'Tristeza' aparece %d veces.\n", contador_Tristeza);
    printf("La emoción 'Miedo' aparece %d veces.\n", contador_Miedo);
    printf("La emoción 'Enojo' aparece %d veces.\n", contador_Enojo);
    printf("La emoción 'Derrota' aparece %d veces.\n", contador_Derrota);
    printf("La emoción 'Neutral' aparece %d veces.\n", contador_Neutral);

    encontrar_mas_repetido();

    fclose(yyin);

    return 0; }

#define YY_SKIP_YYWRAP