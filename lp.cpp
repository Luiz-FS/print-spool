#include <sys/types.h>
#include <bits/stdc++.h>
#include <unistd.h> 

using namespace std; 
int setuid(uid_t uid);

int main(int argc, char* argv[]) {
    setuid(0);
    string command = "./lp.sh ";

    for (int i = 1; i < argc; i++) {
      command += argv[i];
      command += " ";
    }

    system(command.c_str());

    return 0;
}
