#include <string.h>
#include <stdlib.h>
#include <stdio.h>

void myprint()
{
  printf("Hello World!");
}

//--------------------------------------------------------------------------
// Main

int main( int argc, char* argv[] )
{
  setStats(1);
  myprint();
  setStats(0);

  return 0;
}
