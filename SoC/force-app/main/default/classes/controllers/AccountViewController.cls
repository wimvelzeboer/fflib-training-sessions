/**
 * File Name: AccountViewController 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
public with sharing class AccountViewController
{
	private Account accountRecord;

	// The extension constructor initializes the private member
	// variable mysObject by using the getRecord method from the standard
	// controller.
	public AccountViewController(ApexPages.StandardController stdController)
	{
		this.accountRecord = (Account) stdController.getRecord();
	}

    /**
     * awardPoints
     *
     * @description Award Championship points to the record
     * @return PageReference Returns a null PageReference
     */
    public PageReference onRecalculateButtonClick()
    {
        System.Savepoint savePoint = Database.setSavepoint();
        try
        {
            AccountsService.recalculateRating(new List<Account> { this.accountRecord });
        }
        catch (Exception e)
        {
            Database.rollback(savePoint);
            ApexPages.addMessages(e);
        }
        return null;
    }
}