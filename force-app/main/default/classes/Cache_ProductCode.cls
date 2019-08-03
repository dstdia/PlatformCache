/**
 * @description Sample implementation of the CacheBuilder interface for a Product2 by External Id cache.
 * @author  Daniel Stange
 * @date 2019-08-02
 *
 */

public without sharing class Cache_ProductCode implements Cache.CacheBuilder {

    /**
     * @description mandatory internal method to gracefully retrieve data and handle potential cache misses
     * @param productCode
     * @return cached items as an Object
     */
    public Object doLoad(String productCode) {
        Product2 p = (Product2) [
                SELECT Id, Name, IsActive, ExtId__c
                FROM Product2
                WHERE ExtId__c = :productCode
        ];
        return p;
    }
}

