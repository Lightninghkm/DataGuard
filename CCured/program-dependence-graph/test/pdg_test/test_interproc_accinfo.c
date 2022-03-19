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

void f2(int* age) {
    printf("%d\n", *age);
}

void f1(Person *p) {
    printf("%s\n", p->name);
    f2(&p->age);
}

int main() {
    Clothes c = {"red", 5};
    Person p = {10, "Jack", c};
    Person *pt = &p;
    f1(pt); 
    return 0;
}
