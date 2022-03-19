#include <stdio.h>
#include <stdlib.h>
struct st {
 int a;
 int b;
};

int main() {
  struct st *s = (struct st*)malloc(sizeof(struct st));
  int c = sizeof(int);
  s->a = 5;
  s->b = 10;
  s += c;
  printf("%d\n", *s);
  return 0;
}
