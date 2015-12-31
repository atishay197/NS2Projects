#include <bits/stdc++.h>
using namespace std;

int main()
{
	int count = 0,lcount=0;
	FILE *fp;
    int c,prev,pprev;
    fp = fopen("out.tr", "r");
    fstream myfile;
    myfile.open ("final1.tr");
    while((c = fgetc(fp)) != EOF) 
    {
    	if(c == '\n')
    		lcount++;
    	if(lcount<7)
    		continue;
    	if(lcount==7)
    	{
    		lcount++;
    		continue;
    	}
    	if (c == '-')
    		count++;
    	if(count > 9)
    	{
    		while((c = fgetc(fp)) != '\n') 
    		count = 0;
    	}
    	if (c == '\n')
    		count = 0;
        if (c != '-' && c != '[' && c != ']' && c != '_' && !(c == ' ' && pprev == ' ' && prev == ' '))
        	myfile<<(char)c;
        prev = c;
        pprev = prev;
    }
    fclose(fp);
    myfile.close();
}
