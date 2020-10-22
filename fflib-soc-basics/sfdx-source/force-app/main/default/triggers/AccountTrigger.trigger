/**
 * File Name: AccountTrigger 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wvelzebo@its.jnj.com 
 */
trigger AccountTrigger on Account
		(before insert, before update, before delete, after insert, after update, after delete, after undelete)
{
	fflib_SObjectDomain.triggerHandler(AccountsImp.class);
}