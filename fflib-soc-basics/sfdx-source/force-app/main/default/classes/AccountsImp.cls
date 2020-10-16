/**
 * File Name: AccountsImp 
 * Description: 
 * Copyright (c) 2020 Johnson & Johnson
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wvelzebo@its.jnj.com 
 */
public class AccountsImp extends fflib_SObjectDomain implements Accounts
{
    public AccountsImp(List<Account> records)
    {
        super(records);
    }

    public Map<Id, String> getShippingCountryById()
    {
        Map<Id, String> result = new Map<Id, String>();
        for (Account record : (List<Account>) getRecords())
        {
            result.put(record.Id, record.ShippingCountry);
        }
        return result;
    }

    public Set<Id> getRecordIds()
    {
        Set<Id> result = new Set<Id>();
        for (Account record : (List<Account>) getRecords())
        {
            result.add(record.Id);
        }
        return result;
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable2
    {
        public fflib_SObjectDomain construct(List<SObject> sObjectList)
        {
            return new AccountsImp(sObjectList);
        }

        public fflib_SObjectDomain construct(List<SObject> sObjectList, SObjectType sObjectType)
        {
            return new AccountsImp(sObjectList);
        }
    }
}