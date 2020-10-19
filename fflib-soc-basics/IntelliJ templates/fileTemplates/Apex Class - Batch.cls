#parse("Apex File Header.cls")

public class ${NAME} implements Database.Batchable<sObject> {

	
	public ${NAME}() {
		
	}
	
	public Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator( INSERT_SELECTOR_METHOD_HERE );
	}


   	public void execute(Database.BatchableContext BC, List<sObject> scope) {
	
	}


	public void finish(Database.BatchableContext BC) {
		
	}
	
}