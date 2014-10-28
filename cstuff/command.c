#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "command.h"

int Name (char *name, char *val[])
{
	// printf ("Comp: %d %s %s", strcmp(name, val[0]), name, val[0]);
	if(strcmp(name, val[0])==0)
	{
		printf("# Program %s\n", name);
		return 1;
	}
	return 0;
}

void LeadArg (char **str, int count, char *val[], FILE *outf)
{
	if (count>1)
		*str = val[1];
	else 
		*str = "NULL";
}

int StrArg (char **str, char *name, char *def, int count, char *val[],
	FILE *outf)
{
	int i, r=0;

	*str=def;

	for (i=1;i<count;i++)
	{
		// printf ("%s -- %s\n", val[i], name);

		if (!strcmp(val[i], name))
		{
			*str = val[i+1];
			r = 2;
			break;
		}
	}
	fprintf (outf, "#%s\t%s", name, *str);
	
	if (r)
		fprintf (outf, " (command)");
	
	fprintf (outf, "\n");
	return(r);
}

int FlagArg (int *num, char *name, int count, char *val[], FILE *outf)
{
	int i;

	*num=0;

	for (i=1;i<count;i++)
	{
		if (!strcmp(val[i], name))
		{
			*num = i;
			fprintf (outf, "#Flag %s\n", name);
			return 1;
		}
	}
	return 0;
}

int IntArg (int *num, char *name, int n, int count, char *val[], FILE *outf)
{
	int i, r=0;

	*num=n;

	for (i=1;i<count;i++)
	{
		// printf ("%s -- %s\n", val[i], name);

		if (!strcmp(val[i], name))
		{
			*num = atoi(val[i+1]);
			r = 2;
			break;
		}
	}
	fprintf (outf, "#%s\t%d", name, *num);
	// if (!r)
		// fprintf (outf, " (default)");
	
	if (r)
		fprintf (outf, " (command)");
	
	fprintf (outf, "\n");
	return(r);
	
	fprintf (outf, "\n");
	return(r);
}

int LongArg (long *num, char *name, long n, int count, char *val[], FILE *outf)
{
	int i, r=0;

	*num=n;

	for (i=1;i<count;i++)
	{
		// printf ("%s -- %s\n", val[i], name);

		if (!strcmp(val[i], name))
		{
			*num = atol(val[i+1]);
			r = 2;
			break;
		}
	}
	fprintf (outf, "#%s\t%ld", name, *num);
	// if (!r)
		// fprintf (outf, " (default)");
	
	if (r)
		fprintf (outf, " (command)");
	
	fprintf (outf, "\n");
	return(r);
	
	fprintf (outf, "\n");
	return(r);
}

int RealArg (double *num, char *name, double n, 
	int count, char *val[], FILE *outf)
{
	int i, r=0;

	*num = n;

	for (i=1;i<count;i++)
	{
		// printf ("%s -- %s\n", val[i], name);

		if (!strcmp(val[i], name))
		{
			*num = atof(val[i+1]);
			r = 2;
			break;
		}
	}
	fprintf (outf, "#%s\t%f", name, *num);
	// if (!r)
		// fprintf (outf, " (default)");
	
	if (r)
		fprintf (outf, " (command)");
	
	fprintf (outf, "\n");
	return(r);

	return(r);
}

int FileArg (int count, char *val[], FILE **outfp)
{
	// printf ("%s -- %s\n", val[i], name);

	if (val[count-1][0] == '=')
	{
		*outfp = fopen (val[count-1]+1, "w");
		if (*outfp == NULL)
			utilerror("Could not open output file");
		fprintf (stderr, "%s opened for writing\n", val[count-1]+1);
		// fprintf (stdout, "%s opened for writing\n", val[count-1]+1);
		return (1);
	}

	if (val[count-1][0] == '+')
	{
		*outfp = fopen (val[count-1]+1, "a");
		if (*outfp == NULL)
			utilerror("Could not open output file");
		fprintf (stderr, "%s opened for writing\n", val[count-1]+1);
		// fprintf (stdout, "%s opened for writing\n", val[count-1]+1);
		return (1);
	}

	if (val[count-1][0] == '-')
	{
		*outfp = fopen (val[count-1]+1, "r");
		if (*outfp != NULL)
			utilerror("Output file exists, use + or =");

		*outfp = fopen (val[count-1]+1, "w");
		if (*outfp == NULL)
			utilerror("Could not open output file");
		fprintf (stderr, "%s opened for writing\n", val[count-1]+1);
		// fprintf (stdout, "%s opened for writing\n", val[count-1]+1);
		return (1);
	}

	*outfp = stdout;
	fprintf (stderr, "Using stdout\n");
	return(0);
}

int IFileArg (int count, char *val[], FILE **infp)
{
	int i;

	// printf ("%s -- %s\n", val[i], name);

	for (i=1;i<count;i++)
	{
		if (val[i][0] == '#')
		{
			*infp = fopen (val[i]+1, "r");
			if (*infp == NULL)
				utilerror("Could not open input file");
			fprintf (stderr, "%s opened for reading\n", val[i]+1);
			// fprintf (stdout, "%s opened for reading\n", val[i]+1);
			return (1);
		}
	}
	fprintf (stderr, "Using stdin\n");
	// fprintf (stdout, "Using stdin\n");
	return(0);
}

void ArgCount (int r, int count)
{
	if (r!=count)
	{
		fprintf (stderr, "Warning:  Argument Count %d\t%d\n", count, r);
		fprintf (stdout, "Warning:  Argument Count %d\t%d\n", count, r);
		utilerror ("Argument error");
	}
	fprintf(stdout, "\n");
}

void utilerror(char error_text[])
{
   fprintf(stderr,"%s\n",error_text);
   fprintf(stderr,"...now exiting to system...\n");
   exit(1);
}

