/**
 * File Name: AccountsTriggerHandlerTest 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
@IsTest
private class AccountsTriggerHandlerTest
{
	@IsTest
	static void testRecordCreation()
	{
        // GIVEN
        List<Account> testData = new List<Account>();
        testData.addAll(generateRecalculateRatingTestData());
        final Integer amount = testData.size();

        // WHEN the test data is created
        System.Test.startTest();
        insert testData;
        System.Test.stopTest();

        // THEN it should be created as expected
        Set<Id> recordIds = new Map<Id, SObject>(testData).keySet();
        List<Account> result = AccountsSelector.newInstance().selectById(recordIds);
        System.assertEquals(amount, result.size());
        verifyRecalculateRatingData(result);
	}

    private static void verifyRecalculateRatingData(List<Account> accounts)
    {
        for (Account record : accounts)
        {
            if (record.NumberOfEmployees > 99 && record.Rating != 'Hot')
                throw new RecalculateRatingException('Expected Hot rating for accounts with more than 99 employees');

            else if (record.NumberOfEmployees < 100 && record.Rating != 'Warm')
                throw new RecalculateRatingException('Expected Warm rating for accounts with less than 100 employees');
        }
    }

    private static List<Account> generateRecalculateRatingTestData()
    {
        return new List<Account>
        {
                new Account(Name = 'TestRating', Rating = 'Cold', NumberOfEmployees = 50),
                new Account(Name = 'TestRating', Rating = 'Cold', NumberOfEmployees = 500)
        };
    }

    public class RecalculateRatingException extends Exception {}
}