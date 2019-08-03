/**
 * @description Sample handler logic for doing measurements in the Demo scenarios
 * @author  Daniel Stange
 * @date    2019-08-02
 */
public without sharing class Demo_Cache {

    private static Map<String, Id> cachedProductKeys;
    private static Boolean wasInitialized;

    static {
        cachedProductKeys = (Map<String, Id>) Cache.Org.get('local.Products.productMap');
        wasInitialized = false;
    }

    /**
     * @description Retrieves a product ID from a bulkified cache instance.
     *
     * @param byKey - a product key
     *
     * @return - the Id of a matching product (or null)
     */
    public static Id getProductId(String byKey) {

        if (cachedProductKeys == null) {
            initCache(null);
            cachedProductKeys = (Map<String, Id>) Cache.Org.get('local.Products.productMap');
        }

        if (cachedProductKeys.containsKey(byKey)) {
            return cachedProductKeys.get(byKey);
        } else {
            return null;
        }
    }

    /**
     * @description Retrieves cached products from a 'per-item' cache instance.
     *
     * @param byKey
     *
     * @return
     */
    public static Id getProductIdPerItem(String byKey) {

        if (!wasInitialized) {
            initCache('Item');
            wasInitialized = true;
        }

        try {
            return (Id) Cache.Org.get('local.Products.' + byKey);
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * @description Retrieves a single record from a bulkified record map
     *              loaded from the Database.
     *              DEMO/PROFILING PURPOSE ONLY!
     *
     * @param byKey
     *
     * @return a Product2 record Id
     */
    public static Id getProductFromDB(String byKey) {

        if (!wasInitialized) {
            initCache('DB');
            wasInitialized = true;
        }
        if (cachedProductKeys.containsKey(byKey)) {
            return cachedProductKeys.get(byKey);
        } else {
            return null;
        }
    }

    /**
     * @description Retrieves a single record from the Database.
     *              DEMO PURPOSE ONLY - as this is not bulkified,
     *              DO NOT USE except for profiling!
     *
     * @param byKey
     *
     * @return a Product2 record Id
     */
    public static Id getSingleProductFromDB(String byKey) {

        try {
            return [SELECT Id FROM Product2 WHERE ExtId__c = :byKey LIMIT 1].Id;
        } catch (Exception e) {
            return null;
        }

    }

    /**
     * @description Rebuilds cache items and populates static variables
     *              DEMO & PROFILING USE ONLY!
     *              (Unselective and error prone queries)
     *
     * @param cacheType (Item = itemized cache, Map = bulkified cache)
     */
    private static void initCache(String cacheType) {

        List<Product2> p = [SELECT Id, ExtId__c FROM Product2];

        Map<String, Id> productKeyToId = new Map<String, Id>();

        for (Product2 pr : p) {

            if (cacheType == 'Item') {
                Cache.Org.put('local.Products.' + pr.ExtId__c, pr.Id);
            } else {
                productKeyToId.put(pr.ExtId__c, pr.Id);
            }

        }

        if (cacheType == 'Map') {
            Cache.Org.put('local.Products.productMap', productKeyToId);
        } else if (cacheType == 'DB') {
            cachedProductKeys = productKeyToId;
        }

    }

}