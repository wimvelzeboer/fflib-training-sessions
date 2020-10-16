/**
 * File Name: Accounts 
 * Description: 
 * Copyright (c)  Johnson & Johnson
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wvelzebo@its.jnj.com 
 */
public interface Accounts
{
	Map<Id, String> getShippingCountryById();
	Set<Id> getRecordIds();
}