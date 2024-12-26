#include <string.h>

extern void console(const char *s, int l);

int load(void) {
  const char *s = "hi sir\n";
  console(s, strlen(s));
  return 0;
}
