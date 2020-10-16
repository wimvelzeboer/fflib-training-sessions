/**
 * File Name: ContactsSelector 
 * Description: 
 * Copyright (c)  Johnson & Johnson
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wvelzebo@its.jnj.com 
 */
public interface ContactsSelector
{
	List<Contact> selectByAccountId(Set<Id> accountsIds);
}