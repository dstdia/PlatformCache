/**
 * @author Daniel Stange <daniel.stange@die-interaktiven.de>
 * @date	2019-06-17
 * @description Service Class to maintain the Platform Cache
 *
 */
public with sharing class Cache_SalesDistrictCustom implements Schedulable {
	
	private static Map<String, SalesDistrict__c> salesDistricts;
	private static SalesDistrict__c defaultDistrict;

	/**
	 * @description  build a map of SalesDistrict__c by SalesDistrictKey__c and puts it into the cache
	 */
	public static void populateSalesDistricts() {

		salesDistricts = new Map<String, SalesDistrict__c>();
        
        // query a complete list from the database
        List<SalesDistrict__c>  lSalesDistricts = [
        	SELECT	Id, 
        			Name, 
        			Country__c,
        			CountryIsoCode__c,
        			SalesDistrictKey__c,
        			SalesManager__c,
        			ServiceManager__c,
        			isDefault__c
        	FROM 	SalesDistrict__c
        ];
        
        for (SalesDistrict__c sd : lSalesDistricts) {

        	salesDistricts.put(sd.SalesDistrictKey__c, sd);

        	if (sd.isDefault__c == true) {

        		defaultDistrict = sd;
        		Cache.Org.put('local.SalesDistricts.DefaultSalesDistrict', sd);
        	}
        }
        Cache.Org.put('local.SalesDistricts.SalesDistricts', salesDistricts);
    }

    /**
     * @description  Wrapper for the get-Method of the platform cache
     *
     * @param  salesDistrictKey A Sales District Key (Country ISO Code + two digit PostalCode key)
     * @return The matching Sales District record
     *
     */
    public static SalesDistrict__c getDistrict(String salesDistrictKey) {
        
    	// first, try to retrieve the cached values and cast it into the expected type.
    	// call will fail if nothing's there or can't be casted into the desired type
    	try {
    		salesDistricts = (Map<String, SalesDistrict__c>) Cache.Org.get('local.SalesDistricts.SalesDistricts');
    		defaultDistrict = (SalesDistrict__c) Cache.Org.get('local.SalesDistricts.DefaultSalesDistrict');
    	}
    	
    	catch (Exception e) {
			System.debug('Cache is not available. Falling back to database');
    	}
        
		// if the above failed or nothing is there, try to rebuild the map
        
        if(salesDistricts == null) {            
            populateSalesDistricts();
        }

        // try to resolve the sales district. 
        // If any miss happens, still, try to get the default, and 
        // if that fails, return NULL
        
        if (salesDistricts.containsKey(salesDistrictKey)) {
        	return salesDistricts.get(salesDistrictKey);
        }
        
        else if (defaultDistrict != null) {
        	return defaultDistrict;
        }
        
        else {
        	return null;
        }
    }

    /**
     * @description  Schedule a refresh of your cache for any period shorter than the standard time to live of 24 hrs
     * @param sc The context from System.Schedulable Context
     */
    public void execute(SchedulableContext sc) {

    	populateSalesDistricts();
    }
}