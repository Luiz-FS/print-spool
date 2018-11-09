#include <sys/types.h>
#include <bits/stdc++.h>
#include <unistd.h> 

using namespace std; 
int setuid(uid_t uid);

int main(int argc, char* argv[]) {
    setuid(0);
    string c = "./lp.sh ";

    for (int i = 1; i < argc; i++) {
      c += argv[i];
      c += " ";
    }

    char ol[c.size() + 1];
    strcpy(ol, c.c_str());
    system(ol);

    return 0;
}
