sed -i '/^#include <time.h>/ s@$@\n#include <sys/time.h>@' headers.c

