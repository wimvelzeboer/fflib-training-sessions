#parse("Apex File Header.cls")

global class ${NAME}
{

	webservice String parameter { get; set; }


	public ${NAME}()
	{
		this.parameter = 'value';
	}


	webservice static String serviceName()
	{
		return '';
	}
}