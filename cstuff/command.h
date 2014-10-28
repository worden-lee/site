int Name (char *name, char *val[]);
void LeadArg (char **str, int count, char *val[], FILE *outf);
int StrArg (char **str, char *name, char *def, int count, char *val[],
	FILE *outf);
int FlagArg (int *num, char *name, int count, char *val[], FILE *outf);
int IntArg (int *num, char *name, int n, int count, char *val[], FILE *outf);
int LongArg (long *num, char *name, long n, int count, char *val[], FILE *outf);
int RealArg (double *num, char *name, double n, 
	int count, char *val[], FILE *outf);
int FileArg (int count, char *val[], FILE **outfp);
int IFileArg (int count, char *val[], FILE **infp);
void ArgCount (int r, int count);
void utilerror(char error_text[]);
