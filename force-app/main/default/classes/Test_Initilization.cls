/**
 * Created by DanielStange on 2019-08-07.
 */

@isTest
private class Test_Initilization {


    @isTest
    private static void testUserUpdate(){

        Test.startTest();
        Initialization.CacheUser();
        Test.stopTest();

        User u = [SELECT UserPreferencesCacheDiagnostics FROM User WHERE Id =: UserInfo.getUserId()];
        System.assertEquals(true, u.UserPreferencesCacheDiagnostics, 'Cache Diganostics is not set.');
    }

    @isTest
    private static void testSalesDistrictCreation(){

        Test.startTest();
        Initialization.SalesDistricts();
        Test.stopTest();

        System.assertEquals(90, [SELECT Count() FROM SalesDistrict__c ], 'Number of Sales Districts does not match the expected number');
    }

}