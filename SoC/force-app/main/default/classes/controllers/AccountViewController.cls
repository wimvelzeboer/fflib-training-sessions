/**
 * File Name: AccountViewController 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
public with sharing class AccountViewController
{
	private Account accountRecord;

	public AccountViewController(ApexPages.StandardController stdController)
	{
		this.accountRecord = (Account) stdController.getRecord();
	}

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