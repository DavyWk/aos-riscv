#include <stdio.h>
#include <stdlib.h>

int main() {

    int size = 10;
    size = size + 1;
    size = size -1;
    printf("size: %d\n", size);
    /*char* myptr = malloc(size);
    printf("original pointer: %p\r\n", myptr);
    //__asm__("pacma %1, %1;" : "=r" (myptr) : "r" (myptr));
    printf("new pointer: %p\r\n", myptr);
    //__asm__("xpacm %1, %1;" : "=r" (myptr) : "r" (myptr));
    free(myptr);
    printf("cleaned pointer: %p\r\n", myptr);*/

    return 0;
}
