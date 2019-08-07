/**
 * @author	Daniel Stange
 * @date    2019-06-17
 * @description Trigger handler for TrgHandler_Account trigger
 * 	- fills SalesDistruct__c lookup field and assigns record to the Sales Manager
 */
public class TrgHandler_Account extends TriggerHandler {
    
    private String cacheHandler;
    
    public TrgHandler_Account() {
    
        CacheSetting__mdt cacheSetting = [SELECT Handler__c FROM CacheSetting__mdt WHERE DeveloperName = 'CacheDemo'];
        this.cacheHandler = (cacheSetting != null) ? cacheSetting.Handler__c : 'CacheBuilder';
    }
        
	
	public override void beforeInsert() {
		this.fillSalesDistrict();
	}

	public override void beforeUpdate() {
		this.fillSalesDistrict();
	}


	/**
	 * @description Retrieve a matching sales district from the cache to fill SalesDistrict__C relation
	 * or use the default
	 */
	private void fillSalesDistrict() {

		for (Account a : (List<Account>) Trigger.new) {

			String salesDistrictKey = a.BillingCountryCode + a.BillingPostalCode.left(2);
			SalesDistrict__c sd;
            
            if (this.cacheHandler == 'CustomApex') {
            	sd = Cache_SalesDistrictCustom.getDistrict(salesDistrictKey);
            }
            else {
                sd = (SalesDistrict__c) Cache.Org.get(Cache_SalesDistrict.class, salesDistrictKey);
            }
            
			if (sd != null) {

				a.OwnerId = sd.SalesManager__c;
				a.SalesDistrict__c = sd.Id;	
			}
		}
	}
}