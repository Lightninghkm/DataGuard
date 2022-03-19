#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct clothes {
     char color[10];
     int length;
 } Clothes;

 typedef struct person_t {
     int age;
     char name[10];
     Clothes *s;
 } Person;

Person p = {10, "jack"};


// kernel function
Person* ReturnNewObj() {
    Person* p = (Person*)malloc(sizeof(Person));
    return p;
}

// kernel function
void PrintClothesColor(Person *pp) {
    /* pp->s = c; */
    printf("%s\n", pp->s->color);
}

// driver function
void AllocNewObj() {
    Person* pp = (Person*)malloc(sizeof(Person));
    Clothes *c = (Clothes*)malloc(sizeof(Clothes));
    strcpy(c->color, "green");
    c->length = 4;
    pp->s = c;
    /* p->age = 10; */
    /* strncpy(p->name, "foobar", 6); */
    PrintClothesColor(pp);
}

// Driver Function
void InvokeKernelPrint(Person* p) {
    PrintClothesColor(p);
}
