@IsTest
private class Test_CacheBenchmark {

    @TestSetup
    private static void setup() {

        populateWithObjects();
        populateFromInnerClass();
    }
    
    
    /**
     * Create 9000 Product2 records that go into the database.
     * 9000 is roughly the number that will still fit into a 100kB Cache items
     */
    private static void populateWithObjects() {

        List<Product2> products = new List<Product2>();
        
        for (Integer i = 0 ; i < 9000 ; i++) {
          
            products.add(new Product2(
                Name = 'Product ' + i,
                IsActive = true,
                ProductCode = 'P' + i));
        }

        insert products;
        Cache.Org.put('local.Products.productsTest', new Map<Id, Product2>(products));

    }

    private static void populateFromInnerClass() {

        Map<String, SlimProduct> slimprods = new Map<String, SlimProduct>();

        for (Integer i = 0 ; i < 12500 ; i++) {
          
            SlimProduct sp = new SlimProduct();
            sp.name = 'Product ' + i;
            sp.isActive = true;
            sp.productCode = 'P' + i;

            slimprods.put(sp.productCode, sp);
        }

        Cache.Org.put('local.Products.slimProductsTest', slimprods);
    }
    

    @IsTest
    static void retrieveTenKCacheSObjects() {

        Long startTime = System.currentTimeMillis();

        Map<Id, Product2> products = (Map<Id, Product2>) Cache.Org.get('local.Products.productsTest');

        Long endTime = System.currentTimeMillis();

        System.debug('Fetching ' + products.values().size() + ' products from Cache took ' + (endTime - startTime));

    }

    @IsTest
    static void retrieveTenKCacheApexObjects() {

        Long startTime = System.currentTimeMillis();

        Map<Id, Product2> products = (Map<Id, Product2>) Cache.Org.get('local.Products.productsTest');

        Long endTime = System.currentTimeMillis();

        System.debug('Fetching ' + products.values().size() + ' products from Cache took ' + (endTime - startTime));

    }

    @IsTest
    static void retrieveTenKDBValues() {
        
        Long startTime = System.currentTimeMillis();

        Map<Id, Product2> products = new Map<Id, Product2>([SELECT Id, Name, IsActive, ProductCode FROM Product2]);

        Long endTime = System.currentTimeMillis();

        System.debug('Fetching ' + products.values().size() + ' products from Database took ' + (endTime - startTime));

    }

    /**
     * @description Inner class for product handling
     */
    public class SlimProduct {

        public String name;
        public Boolean isActive;
        public String productCode;
    }
}