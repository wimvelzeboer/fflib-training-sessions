#parse("Apex File Header.cls")

// Click on each word below, click CONTROL-COMMAND-G, change it into the desired name and remove this comment afterwards
// OBJECTNAME

public class ${NAME} implements Iterator<OBJECTNAME> {

  OBJECTNAME[] results { get;set; }
  Integer index { get;set; }
  String query;

  public ${NAME}()
  {
    index = 0;
    results = Database.query(query);   
  }

  public Boolean hasNext()
  {
    return results != null && !results.isEmpty() && index < results.size();
  }    

  public OBJECTNAME next()
  {
    return results[index++];
  }    

}