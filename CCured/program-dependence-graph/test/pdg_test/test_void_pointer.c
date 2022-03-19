#include <stdio.h>
#include <stdlib.h>
struct bar {
    int a;
    int b;
};

void* bar() {
    struct bar* b = (struct bar*)(malloc(sizeof(struct bar)));
    return (void*)b;
}

void foo(void* data) {
    struct bar* bae = (struct bar*)data;
    printf("%d\n", bae->a);
}

int main() {
    struct bar bae = {1,2}; 
    foo(&bae);
    return 0;
}
