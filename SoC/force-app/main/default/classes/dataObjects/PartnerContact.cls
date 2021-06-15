public with sharing class PartnerContact
{
	private Contact record;

	public Id recordId
	{
		get	{ return this.record.Id; }
		set { this.record.Id = value; }
	}

	public Id accountId
	{
		get { return this.record.AccountId; }
		set { this.record.Id = value; }
	}

	public String assistantName
	{
		get { return this.record.AssistantName; }
		set { this.record.AssistantName = value; }
	}

	public String assistantPhone
	{
		get { return this.record.AssistantPhone; }
		set { this.record.AssistantPhone = value; }
	}

	public String email
	{
		get { return this.record.Email; }
		set { this.record.Email = value; }
	}

	public String firstName
	{
		get { return this.record.FirstName; }
		set { this.record.FirstName = value; }
	}

	public String lastName
	{
		get { return this.record.LastName; }
		set { this.record.LastName = value; }
	}

	public Id reportsToId
	{
		get { return this.record.ReportsToId; }
		set { this.record.ReportsToId = value; }
	}

	public String title
	{
		get { return this.record.Title; }
		set { this.record.Title = value; }
	}

	public PartnerContact(Contact record)
	{
		this.record = record;
	}
}