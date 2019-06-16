@isTest
private class CacheBenchmark_Test {

    @testSetup 
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
                isActive = true,
                Productcode = 'P' + i));
        }

        insert products;
        Cache.Org.put('local.def.products', new Map<Id, Product2>(products));

    }

    private static void populateFromInnerClass() {

        Map<String, SlimProduct> slimprods = new Map<String, SlimProduct>();

        for (Integer i = 0 ; i < 12500 ; i++) {
          
            SlimProduct sp = new SlimProduct();
            sp.Name = 'Product ' + i;
            sp.isActive = true;
            sp.ProductCode = 'P' + i;

            slimprods.put(sp.ProductCode, sp);
        }
        
        Cache.Org.put('local.def.slimproducts', slimprods);
    }
    

    @istest
    static void retrieveTenKCacheValues() {
        
        long startTime = System.currentTimeMillis();

        Map<Id, Product2> products = (Map<Id, Product2>) Cache.org.get('local.def.products');	

        long endTime = System.currentTimeMillis();

        System.debug('Fetching products from Cache took ' + (endtime - starttime));

    }

    @istest
    static void retrieveTenKDBValues() {
        
        long startTime = System.currentTimeMillis();

        Map<Id, Product2> products = new Map<Id, Product2>([SELECT id, Name, isActive, ProductCode FROM Product2]);

        long endTime = System.currentTimeMillis();

        System.debug('Fetching products from Database took ' + (endtime - starttime));

    }

    public class SlimProduct {

        public String Name;
        public Boolean isActive;
        public String ProductCode;
    }
}