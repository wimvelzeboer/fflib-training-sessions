/**
 * File Name: Contacts 
 * Description: 
 * Copyright (c)  Johnson & Johnson
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wvelzebo@its.jnj.com 
 */
public interface Contacts extends fflib_ISObjectDomain
{
	void setMailingCountryByAccountId(Map<Id, String> shippingCountryById);
}