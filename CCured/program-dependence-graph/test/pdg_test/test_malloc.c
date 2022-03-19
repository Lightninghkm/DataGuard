#include <stdio.h>
#include <stdlib.h>
// imported functions: test 1
struct bar {
    int b1;
    float b2;
};

struct foo {
    int f1;
    struct bar* b;
};

void test1(struct foo* f) {
    f = (struct foo*)malloc(sizeof(struct foo));
}
