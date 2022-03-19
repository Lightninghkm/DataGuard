#include <stdio.h>

typedef struct clothes {
    char color[10];
    int length;
} Clothes;

typedef struct person_t {
    int age;
    char name[10];
    Clothes s;
} Person;

void f1(int* a) {
    *a = 5;
}

void f(Person *p1) {
    f1(&p1->age);
    printf("clothes color %c.", p1->name[9]);
}

int main() {
    Clothes c = {"red", 5};
    Person p = {10, "Jack", c};
    Person *pt = &p;
    f(pt);
    return 0;
}
