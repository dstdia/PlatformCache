public class SampleCacheManager implements Schedulable {
	
	private static Map<String, SalesDistrict__c> salesDistricts;
	private static SalesDistrict__c defaultDistrict;

	/**
	 * build a map of Salesdistrict__c by SalesDistrictKey__c and puts it into the cache
	 */
	public static void populateSalesDistricts() {

		salesDistricts = new Map<String, Salesdistrict__c>();
        
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

        	if (sd.isDefault__c == TRUE) {

        		defaultDistrict = sd;
        		Cache.Org.put('local.SalesDistricts.DefaultSalesDistrict', sd);
        	}
        }
        Cache.Org.put('local.SalesDistricts.SalesDistricts', salesDistricts);
    }

    /**
     * Wrapper for the get-Method of the platform cache
     */
    public static SalesDistrict__c getDistrict(String salesDistrictKey) {
        
    	// first, try to retrieve the cached values and cast it into the expected type.
    	// call will fail if nothing's there or can't be casted into the desired type
    	try {
    		salesDistricts = (Map<String, SalesDistrict__c>) Cache.Org.get('local.SalesDistricts.SalesDistricts');
    		defaultDistrict = (SalesDistrict__c) Cache.Org.get('local.SalesDistricts.DefaultSalesDistrict');
    	}
    	
    	catch (Exception e) {
    		System.debug('Cache is not availbale. Falling back to database');
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
        
        else if (defaultDistrict != NULL) {
        	return defaultDistrict;
        }
        
        else {
        	return NULL;	
        }
    }

    /**
     * Schedule a refresh of your cache for any period shorter than the standard time to live of 24 hrs
     *
     */
    public void execute(SchedulableContext sc) {

    	populateSalesDistricts();
    }
}