/**
 * File Name: Accounts 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
trigger Accounts on Account
		(before insert, before update, before delete, after insert, after update, after delete, after undelete)
{
	fflib_SObjectDomain.triggerHandler(AccountsTriggerHandler.class);
}