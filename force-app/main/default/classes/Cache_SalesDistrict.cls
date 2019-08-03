/**
 * @description Sample implementation of the CacheBuilder interface for a SalesDistrict__c by District Key cache.
 * @author  Daniel Stange
 * @date 2019-08-02
 *
 */

public without sharing class Cache_SalesDistrict implements Cache.CacheBuilder {

    /**
     * @description mandatory internal method to gracefully retrieve data and handle potential cache misses
     * @param districtKey
     * @return cached items as an Object
     */
    public Object doLoad(String districtKey) {
        SalesDistrict__c oSalesDistrict = (SalesDistrict__c) [
                SELECT Id,
                        Name,
                        Country__c,
                        CountryIsoCode__c,
                        SalesDistrictKey__c,
                        SalesManager__c,
                        ServiceManager__c,
                        isDefault__c
                FROM SalesDistrict__c
                WHERE SalesDistrictKey__c = :districtKey
        ];
        return oSalesDistrict;
    }
}