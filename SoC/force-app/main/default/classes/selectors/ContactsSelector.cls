/**
 * File Name: ContactsSelector
 * Description: Selector implementation for Contact records
 *
 * @author : architect ir. Wilhelmus G.J. Velzeboer | wim@velzeboer.nl
 */
public virtual inherited sharing class ContactsSelector
		extends fflib_SObjectSelector
		implements IContactsSelector
{
	public static IContactsSelector newInstance()
	{
		return (IContactsSelector) Application.Selector.newInstance(Schema.Contact.SObjectType);
	}

	public static IContactsSelector newWithoutSharingInstance()
	{
		return (IContactsSelector) Application.WithoutSharingSelector.newInstance(Schema.Contact.SObjectType);
	}

	public static IContactsSelector newWithSharingInstance()
	{
		return (IContactsSelector) Application.WithSharingSelector.newInstance(Schema.Contact.SObjectType);
	}

	public ContactsSelector()
	{
		super();
	}

	public ContactsSelector(Boolean includeFieldSetFields, Boolean enforceCRUD, Boolean enforceFLS)
	{
		super(includeFieldSetFields, enforceCRUD, enforceFLS);
	}

	/**
	 * Holds a list of fields to be returned by all selector methods
	 *
	 * @return Returns list of default Contact fields
	 */
	public List<Schema.SObjectField> getSObjectFieldList()
	{
		return new List<Schema.SObjectField>
		{
				Contact.Id,
				Contact.AccountId,
				Contact.BirthDate,
				Contact.DoNotCall,
				Contact.Email,
				Contact.HasOptedOutOfEmail,
				Contact.FirstName,
				Contact.LastName
		};
	}

	public List<Schema.SObjectField> getSObjectPartnerFieldList()
	{
		return new List<Schema.SObjectField>
		{
				Contact.Id,
				Contact.AccountId,
				Contact.AssistantName,
				Contact.AssistantPhone,
				Contact.Email,
				Contact.FirstName,
				Contact.LastName,
				Contact.ReportsToId,
				Contact.Title
		};
	}

	public Schema.SObjectType getSObjectType()
	{
		return Contact.SObjectType;
	}

	public virtual List<Contact> selectById(Set<Id> idSet)
	{
		return (List<Contact>) selectSObjectsById(idSet);
	}


	/**
	 * Query Contact records with the given Account Ids
	 *
	 * @param accountIds The Account Ids to query
	 *
	 * @return Returns the records containing the given Account Id values
	 *
	 * @example
	 *     List<Contact> records = ContactsSelector().newInstance()
     *                                .selectByAccountId( accountIds );
	 *
	 * Generated the following query:
	 * ------------------------------
	 * SELECT AccountId, Birthdate, DoNotCall, Email, FirstName,
	 *        HasOptedOutOfEmail, Id, LastName
	 * FROM Contact
	 * WHERE AccountId IN :accountIds
	 * ORDER BY Name ASC NULLS FIRST
	 */
	public virtual List<Contact> selectByAccountId(Set<Id> accountIds)
	{
		return (List<Contact>)
				Database.query(
						newQueryFactory()
								.setCondition('AccountId IN :accountIds')
								.toSOQL()
				);
	}

	/**
	 * Query Contact records with the given LeadSource values
	 * and includes the Account.Name field
	 *
	 * @param leadSources The LeadSource values to query
	 *
	 * @return Returns the records containing the given LeadSource values including the Account Name field
	 *
	 * @example
	 *
	 * Set<String> leadSources = new Set<String>{ 'Email' }
	 * List<Contact> records = ContactsSelector().newInstance()
     *                                .selectByLeadSource( leadSources );
	 *
	 * Generated the following query:
	 * ------------------------------
	 * SELECT Account.Name,
	 *        AccountId, Birthdate, DoNotCall, Email, FirstName,
	 *        HasOptedOutOfEmail, Id, LastName
	 * FROM Contact
	 * WHERE LeadSource IN :leadSources
	 * ORDER BY Name ASC NULLS FIRST
	 */
	public virtual List<Contact> selectByLeadSource(Set<String> leadSources)
	{
		return (List<Contact>)
				Database.query(
						newQueryFactory()
								.selectField('Account.Name')
								.setCondition('LeadSource IN :leadSources')
								.toSOQL()
				);
	}

	/**
	 * Query Contact records with the given Ids
	 * and includes all the default Account fields
	 *
	 * @param idSet Record ids to query
	 *
	 * @return Returns the records containing the Id which include all the default Account fields
	 *
	 * @example
	 *     ContactsSelector.newInstance()
	 *             .selectByIdWithAccount( contactIds );
	 *
	 * Generated the following query:
	 * ------------------------------
	 * SELECT Account.AccountNumber, Account.Id, Account.Name, Account.Rating, Account.ShippingCountry,
	 *        AccountId, Birthdate, DoNotCall, Email, FirstName,
	 *        HasOptedOutOfEmail, Id, LastName
	 * FROM Contact
	 * WHERE Id in :idSet
	 * ORDER BY Name ASC NULLS FIRST
	 */
	public virtual List<Contact> selectByIdWithAccount(Set<Id> idSet)
	{
		fflib_QueryFactory queryFactory = newQueryFactory();

		((fflib_SObjectSelector) AccountsSelector.newInstance())
				.configureQueryFactoryFields(
				queryFactory,
				Contact.AccountId.getDescribe().getRelationshipName());

		return Database.query(queryFactory.setCondition('Id in :idSet').toSOQL());
	}

	/**
	 * Query Contact records with the given Ids
	 * and includes all the related Case records
	 *
	 * @param idSet Record ids to query
	 *
	 * @return Returns the records containing the Id with related Case records
	 *
	 * @example
	 *  ContactsSelector.newInstance()
	 *             .selectByIdWithCases( contactIds );
	 *
	 * Generated the following query:
	 * ------------------------------
	 * SELECT AccountId, Birthdate, DoNotCall, Email, FirstName, HasOptedOutOfEmail, Id, LastName,
	 *       (SELECT CaseNumber, Id, Priority, Status, Subject FROM Cases ORDER BY CaseNumber ASC NULLS FIRST )
	 * FROM Contact
	 * WHERE Id in :idSet
	 * ORDER BY Name ASC NULLS FIRST
	 */
	public virtual List<Contact> selectByIdWithCases(Set<Id> idSet)
	{
		fflib_QueryFactory queryFactory = newQueryFactory();

		((fflib_SObjectSelector) CasesSelector.newInstance())
				.addQueryFactorySubselect(
						queryFactory,
						'Case'

		);

		return (List<Contact>) Database.query(
				queryFactory.setCondition('Id in :idSet').toSOQL()
		);
	}

	/**
	 * Query Contact records with the given Ids
	 * and includes not the standard fields but the partner fields
	 *
	 * @param idSet Record ids to query
	 *
	 * @return Returns the records containing the Id which contain the partner fields.
	 *
	 * @example
	 *  ContactsSelector.newInstance()
	 *             .selectPartnersById( contactIds );
	 *
	 * Generated the following query:
	 * ------------------------------
	 * SELECT AccountId, AssistantName, AssistantPhone, Email, FirstName, Id, LastName, ReportsToId, Title
	 * FROM Contact
	 * WHERE Id in :idSet AND RecordType.Name='Partner'
	 * ORDER BY Name ASC NULLS FIRST
	 */
	public virtual List<PartnerContact> selectPartnersById(Set<Id> idSet)
	{
		List<Contact> result = (List<Contact>) Database.query(
				newQueryFactory(false)
						.selectFields(getSObjectPartnerFieldList())
				        .setCondition('Id in :idSet AND RecordType.Name=\'Partner\'')
						.toSOQL()
		);

		return ContactsFactory.generatePartnerContacts(result);
	}

	/**
	 * Sub class construct to instantiate a selector with CRUD and FLS sharing enforced
	 *
	 * The methods in this class only override all the selector methods and invoke its super,
	 * so that the logic is execute in the "with sharing" context.
	 */
	public with sharing class WithSharing extends ContactsSelector
	{
		// Constructor that will enforce CRUD and FLS
		public WithSharing()
		{
			super(
					true, // Include field set felds
					true, // enforce CRUD
					true // enforce FLS
			);
		}

		public override List<Contact> selectById(Set<Id> idSet)
		{
			return super.selectById(idSet);
		}

		public override List<Contact> selectByAccountId(Set<Id> accountIds)
		{
			return super.selectByAccountId(accountIds);
		}

		public override List<Contact> selectByLeadSource(Set<String> leadSources)
		{
			return super.selectByLeadSource(leadSources);
		}

		public override List<Contact> selectByIdWithAccount(Set<Id> idSet)
		{
			return super.selectByIdWithAccount(idSet);
		}

		public override List<Contact> selectByIdWithCases(Set<Id> idSet)
		{
			return super.selectByIdWithCases(idSet);
		}

		public override List<PartnerContact> selectPartnersById(Set<Id> idSet)
		{
			return super.selectPartnersById(idSet);
		}
	}

	/**
	 * Sub class construct to instantiate a selector that is run without any sharing rules
	 *
	 * The methods in this class only override all the selector methods and invoke its super,
	 * so that the logic is execute in the "without sharing" context.
	 */
	public without sharing class WithoutSharing extends ContactsSelector
	{
		public WithoutSharing()
		{
			super(
					true, // Include field set felds
					false, // enforce CRUD
					false // enforce FLS
			);
		}

		public override List<Contact> selectById(Set<Id> idSet)
		{
			return super.selectById(idSet);
		}

		public override List<Contact> selectByLeadSource(Set<String> leadSources)
		{
			return super.selectByLeadSource(leadSources);
		}

		public override List<Contact> selectByIdWithAccount(Set<Id> idSet)
		{
			return super.selectByIdWithAccount(idSet);
		}

		public override List<Contact> selectByIdWithCases(Set<Id> idSet)
		{
			return super.selectByIdWithCases(idSet);
		}

		public override List<PartnerContact> selectPartnersById(Set<Id> idSet)
		{
			return super.selectPartnersById(idSet);
		}

		public override List<Contact> selectByAccountId(Set<Id> accountIds)
		{
			return super.selectByAccountId(accountIds);
		}
	}
}