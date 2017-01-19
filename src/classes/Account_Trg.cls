/**
 * Trigger handler for Account_Trg trigger
 * - fills SalesDistruct__c lookup field and assigns record to the Sales Manager
 */
public class Account_Trg extends TriggerHandler {
	

	public override void beforeInsert() {

		this.fillSalesDistrict();
	}

	public override void beforeUpdate() {

		this.fillSalesDistrict();
	}

	public override void afterUndelete() {

		this.fillSalesDistrict();
	}

	/**
	 * Retrieve a matching sales district from the cache to fill SalesDistrict__C relation 
	 * or use the default
	 */
	private void fillSalesDistrict() {

		for (Account a : (List<Account>) Trigger.new) {

			String salesDistrictKey = a.BillingCountryCode + a.BillingPostalCode.left(2);

			SalesDistrict__c sd = SampleCacheManager.getDistrict(salesDistrictKey);

			if (sd != NULL) {

				a.OwnerId = sd.SalesManager__c;
				a.SalesDistrict__c = sd.Id;	
			}
		}
	}
}