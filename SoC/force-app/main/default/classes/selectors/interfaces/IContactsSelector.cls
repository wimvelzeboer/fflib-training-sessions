/**
 * File Name: IContactsSelector 
 * Description: Method signature definitions for Contact selector classes
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
public interface IContactsSelector
{
	List<Contact> selectByAccountId(Set<Id> accountIds);
	List<Contact> selectByLeadSource(Set<String> leadSources);
	List<Contact> selectByIdWithCases(Set<Id> raceIds);
	List<Contact> selectByIdWithAccount(Set<Id> raceIds);
	List<PartnerContact> selectPartnersById(Set<Id> idSet);
}