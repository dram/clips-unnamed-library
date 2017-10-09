//META/	AddUDF(env,
//META/	       "UNNAMED-close-piped-process",
//META/	       "v", 1, 1, "y",
//META/	       UNNAMED_close_piped_process, "UNNAMED_close_piped_process",
//META/	       NULL);
static void UNNAMED_close_piped_process(
	Environment *env, UDFContext *udfc, UDFValue *out)
{
	UDFValue name;

	UDFFirstArgument(udfc, SYMBOL_BIT, &name);

	struct fileRouter *p;
	struct fileRouter *prev = NULL;
	for (p = FileRouterData(env)->ListOfFileRouters;
	     p != NULL;
	     p = p->next, prev = p) {
		if (strcmp(p->logicalName, name.lexemeValue->contents) != 0)
			continue;

		pclose(p->stream);
		rm(env, (void *)p->logicalName, strlen(p->logicalName) + 1);
		if (prev == NULL)
			FileRouterData(env)->ListOfFileRouters = p->next;
		else
			prev->next = p->next;
		rm(env, p, sizeof(struct fileRouter));

		break;
	}
}
