public with sharing class ContactsFactory
{
	public static List<PartnerContact> generatePartnerContacts(List<Contact> contacts)
	{
		List<PartnerContact> result = new List<PartnerContact>();
		for (Contact record : contacts)
		{
			result.add(
					new PartnerContact(record)
			);
		}
		return result;
	}
}