/**
 * Created by DanielStange on 2019-08-03.
 */

@isTest
private class Test_SalesDistrict {

    @testSetup
    private static void setup(){
        Initialization.SalesDistricts();
    }

    @isTest
    private static void populateCache() {

        Test.startTest();
        Cache_SalesDistrictCustom.populateSalesDistricts();
        Test.stopTest();

    }

    @isTest
    private static void scheduleCacheRebuild() {

        Test.startTest();
        System.schedule('TestCacheRebuild', '0 0 0 3 9 ? 2022', new Cache_SalesDistrictCustom());
        Test.stopTest();

    }
}