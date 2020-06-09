// Missionaries and cannibals implementation using a tree and the breadth first search algorithm.

#include<iostream>
using std::cout;

int iMis = 3, // missionary initial state (on Side1)
iCan = 3, // cannibal initial state (on Side1)
fMis = 0, // missionary final state (on Side2)
fCan = 0, // cannibal final state (on Side2)
flag = 0; // flag = 0 when boat is on Side1. flag = 1 when boat is on Side2.

// Displays the output as: 
//                                 SIDE1               RIVER              SIDE2
//                          Initial Group  <BOAT( , )> RIVER              Final Group
//                          Initial Group              RIVER <BOAT( , )>  Final Group
// Boat can hold one or two riders
void output(char rider1, char rider2)
{
    cout << "\n\n";
    for (int i = 0; i < iMis; i++)
        cout << " M ";
    for (int i = 0; i < iCan; i++)
        cout << " C ";
    if (flag == 0) // boat is on Side1
        cout << " <BOAT(" << rider1 << "," << rider2 << ")> RIVER               ";
    else // boat is on Side2
        cout << "               RIVER <BOAT(" << rider1 << "," << rider2 << ")> ";
    for (int i = 0; i < fMis; i++)
        cout << " M ";
    for (int i = 0; i < fCan; i++)
        cout << " C ";
}

// Returns 0 if the goal state has been reached, otherwise returns 1.
int final()
{
    if (fCan == 3 && fMis == 3) // goal state
        return 0;
    else
        return 1;
}

// Solution function solves the missionaries and cannibals problem
void solution()
{
    int option = 0;
    while (final())
    {
        if (!flag) // the boat is on Side1
        {
            switch (option)
            {
            case 1: output('C', ' ');
                iCan = iCan + 1; // move 1 cannibal from boat to Side1
                break;
            case 2: output('M', 'C');
                iCan = iCan + 1; // move 1 cannibal from boat to Side1
                iMis = iMis + 1; // move 1 missionary from boat to Side1
                break;
            }
            if (((iMis - 2) >= iCan && (fMis + 2) >= fCan) || (iMis - 2) == 0)
            {
                iMis = iMis - 2; // move 2 missionaries from Side1 to boat
                option = 1;
                output('M', 'M');
                flag = 1;
            }
            else if ((iCan - 2) < iMis && (fMis == 0 || (fCan + 2) <= fMis) || iMis == 0)
            {
                iCan = iCan - 2; // move two cannibals from Side1 to boat
                option = 2;
                output('C', 'C');
                flag = 1;
            }
            else if ((iCan--) <= (iMis--) && (fMis++) >= (fCan++))
            {
                iCan = iCan - 1; // move 1 cannibal from Side1 to boat
                iMis = iMis - 1; // move 1 missionary from Side1 to boat
                option = 3;
                output('M', 'C');
                flag = 1;
            }
        }
        else // the boat is on side2
        {
            switch (option)
            {
            case 1: output('M', 'M');
                fMis = fMis + 2; // move 2 missionaries from boat to Side2
                break;

            case 2: output('C', 'C');
                fCan = fCan + 2; // move 2 cannibals from boat to Side2
                break;

            case 3: output('M', 'C');
                fCan = fCan + 1; // move 1 cannibal from boat to Side2
                fMis = fMis + 1; // move 1 missionary from boat to Side2
                break;
            }
            if (final())
            {
                if (((fCan > 1 && fMis == 0) || iMis == 0))
                {
                    fCan = fCan - 1; // move 1 cannibal from Side2 to boat
                    option = 1;
                    output('C', ' ');
                    flag = 0;
                }
                else if ((iCan + 2) > iMis)
                {
                    fCan = fCan - 1; // move 1 cannibal from Side2 to boat
                    fMis = fMis - 1; // move 1 missionary from Side2 to boat
                    option = 2;
                    output('M', 'C');
                    flag = 0;
                }
            }
        }
    }
}

// Main function for running program. Displays steps for solving the problem.
int main()
{
    cout << "   Missionaries and Cannibals Problem\n";
    cout << " SIDE1               RIVER               SIDE2";
    output(' ', ' ');
    solution();
    output(' ', ' ');
    return 0;
}
