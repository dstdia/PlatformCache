@isTest
private class CacheBenchmark_Test {

    @testSetup 
    private static void setup() {

        populateWithObjects();
        populateFromInnerClass();
    }
    
    
    private static void populateWithObjects() {

        List<Product2> products = new List<Product2>();
        
        for (Integer i = 0 ; i < 9000 ; i++) {
          
            products.add(new Product2(
                Name = 'Product ' + i,
                isActive = true,
                Productcode = 'P' + i));
        }

        insert products;
        Cache.Org.put('products', new Map<Id, Product2>(products));

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
        
        Cache.Org.put('slimproducts', slimprods);
    }
    

    @istest
    static void retrieveTenKCacheValues() {
        
        long startTime = System.currentTimeMillis();

        Map<Id, Product2> products = (Map<Id, Product2>) Cache.org.get('products');	

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

    @isTest
    static void useImmutableAnnotation() {

        Cache.org.put('Products', new List<String>{'Banana','Apple','Orange'});
        Cache.org.put('Products', 'Shoe');

        Cache.org.put('ProductsImmutable', new List<String>{'Banana','Apple','Orange'}, 3600, Cache.Visibility.ALL, true);
        Cache.org.put('ProductsImmutable', 'Shoe');
        SYstem.debug(Cache.org.get('ProductsImmutable'));
        
    }

    public class SlimProduct {

        public String Name;
        public Boolean isActive;
        public String ProductCode;
    }
}