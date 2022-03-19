#include <stdio.h>
struct S {
    int a;
    int b;
};

void f(struct S *s) {
    s->a |= 10;
    printf("%d\n", s->a);
}

int main() {
    return 0;
}
