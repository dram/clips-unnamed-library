//META/	AddUDF(env,
//META/	       "UNNAMED-open-piped-command",
//META/	       "v", 3, 3, "sys",
//META/	       UNNAMED_open_piped_command, "UNNAMED_open_piped_command",
//META/	       NULL);
static void UNNAMED_open_piped_command(
	Environment *env, UDFContext *udfc, UDFValue *out)
{
	UDFValue command, name, mode;

	UDFNthArgument(udfc, 1, STRING_BIT, &command);
	UDFNthArgument(udfc, 2, SYMBOL_BIT, &name);
	UDFNthArgument(udfc, 3, STRING_BIT, &mode);

	struct fileRouter *router = get_struct(env, fileRouter);
	router->logicalName = gm2(env, strlen(name.lexemeValue->contents) + 1);
	strcpy((char *)router->logicalName, name.lexemeValue->contents);
	router->stream = popen(command.lexemeValue->contents,
			       mode.lexemeValue->contents);
	router->next = FileRouterData(env)->ListOfFileRouters;
	FileRouterData(env)->ListOfFileRouters = router;
}
