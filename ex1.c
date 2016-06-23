#include <stdio.h>

void hanoi(int, int, int, int);

int main(){
    int num;
    scanf("%d", &num);
    hanoi(num, 1, 3, 2);
    return 0;
}

void hanoi(int num, int sPeg, int dPeg, int ePeg){
    if (num == 1){
        printf("Move disk %d from Peg %d to Peg %d\n", num, sPeg, dPeg);
        return;
    }
    hanoi(num - 1, sPeg, ePeg, dPeg);
    printf("Move disk %d from Peg %d to Peg %d\n", num, sPeg, dPeg);
    hanoi(num - 1, ePeg, dPeg, sPeg);
}