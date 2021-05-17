public with sharing class PartnerContact
{
	public Id recordId { get; set; }
	public Id accountId { get; set; }
	public String assistantName { get; set; }
	public String assistantPhone { get; set; }
	public String email { get; set; }
	public String firstName { get; set; }
	public String lastName { get; set; }
	public Id reportsToId { get; set; }
	public String title { get; set; }

	public PartnerContact(Contact record)
	{
		this.recordId = record.Id;
		this.accountId = record.AccountId;
		this.assistantName = record.AssistantName;
		this.assistantPhone = record.AssistantPhone;
		this.email = record.Email;
		this.firstName = record.FirstName;
		this.lastName = record.LastName;
		this.reportsToId = record.ReportsToId;
		this.title = record.Title;
	}
}