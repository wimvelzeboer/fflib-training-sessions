/**
 * File Name: OpportunitiesService 
 * Description: 
 *
 * @author: architect ir. Wilhelmus G.J. Velzeboer
 */
public interface OpportunitiesService
{
	void logLastActivityDateOnParentAccount(Set<Id> opportunityIds);
	void logLastActivityDateOnParentAccount(List<Opportunity> opportunityRecords);
	void logLastActivityDateOnParentAccount(Opportunities opportunities);
	void logLastActivityDateOnParentAccount(Opportunities opportunities, Accounts accounts);

	void logLastActivityDateOnParentAccount(
			fflib_ISObjectUnitOfWork unitOfWork,
			Opportunities opportunities,
			Accounts accounts
	);
}