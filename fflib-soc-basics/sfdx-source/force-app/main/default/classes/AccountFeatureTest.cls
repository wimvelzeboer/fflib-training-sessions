/**
 * File Name: AccountFeatureTest 
 * Description: 
 * Copyright (c) 2020 Johnson & Johnson
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wvelzebo@its.jnj.com 
 */
@IsTest
private class AccountFeatureTest
{
    private static final String HOLLAND = 'Holland';

    @IsTest
    static void testBehavior()
    {
//        GIVEN an account with contact records
        Account account = new Account(Name = 'Test');
        insert account;

        List<Contact> contacts = new List<Contact>
        {
                new Contact(LastName = 'John', AccountId = account.Id),
                new Contact(LastName = 'Jack', AccountId = account.Id),
                new Contact(LastName = 'Jill', AccountId = account.Id)
        };
        insert contacts;

//        WHEN the ShippingCountry is changing on the account record
        System.Test.startTest();
        account.ShippingCountry = HOLLAND;
        update account;
        System.Test.stopTest();

//        THEN the country should be copied to all the MailingCountry field on all the child contacts of that account
        List<Contact> results = [SELECT MailingCountry FROM Contact WHERE AccountId=:account.Id];
        System.assert(results.size() == 3);
        for (Contact result : results)
        {
            System.assertEquals(HOLLAND, result.MailingCountry, 'Whoops country not updated');
        }
    }
}