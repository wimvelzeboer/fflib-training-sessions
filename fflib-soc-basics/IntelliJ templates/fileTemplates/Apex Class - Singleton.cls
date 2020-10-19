#parse("Apex File Header.cls")

public with sharing class ${NAME}
{
    private static ${NAME} classInstance;


    static {
        classInstance = new ${NAME}();
    }


    private ${NAME}()
    {
        
    }


    public static ${NAME} getInstance()
    {
        return classInstance;
    }
}