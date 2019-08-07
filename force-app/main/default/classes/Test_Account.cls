/**
 * Created by DanielStange on 2019-08-03.
 */

@IsTest
private class Test_Account {

    @testSetup
    private static void setup(){

        List<SalesDistrict__c> lSalesDistricts = new List<SalesDistrict__c>();

        lSalesDistricts.add(
                (SalesDistrict__c) DataFactory.createObject(false, 'SalesDistrict__c', new Map<String, Object>{
                'Name' => 'SD Default',
                'SalesManager__c' => UserInfo.getUserId(),
                'SalesDistrictKey__c' => 'DEXX',
                'Country__c' => 'Germany',
                'CountryIsoCode__c' => 'DE',
                'isDefault__c' => true
                })
        );

        for (Integer i = 2; i<20; i++) {
            lSalesDistricts.add(
                    (SalesDistrict__c) DataFactory.createObject(false, 'SalesDistrict__c', new Map<String, Object>{
                            'Name' => 'SD ' + (i*5),
                            'SalesDistrictKey__c' => 'DE'+ (i*5),
                            'SalesManager__c' => UserInfo.getUserId(),
                            'Country__c' => 'Germany',
                            'CountryIsoCode__c' => 'DE'
                    })
            );
        }
        insert lSalesDistricts;
    }

    @isTest
    private static void testSalesDistrictInsert() {

        Test.startTest();
        SalesDistrict__c sd = (SalesDistrict__c) DataFactory.createObject(true, 'SalesDistrict__c', new Map<String, Object>{
                'Name' => 'SD 99 ',
                'SalesDistrictKey__c' => 'DE99',
                'SalesManager__c' => UserInfo.getUserId(),
                'Country__c' => 'Germany',
                'CountryIsoCode__c' => 'DE'
        });
        Test.stopTest();

    }

    @IsTest
    private static void testSalesDistrictUpdate() {

        SalesDistrict__c sd = [SELECT ID FROM SalesDistrict__c WHERE SalesDistrictKey__c = 'DEXX' LIMIT 1];

        Test.startTest();
        sd.Name = 'Updated DE Default';
        update sd;
        Test.stopTest();

    }

    @IsTest
    private static void testSalesDistrictUnDelete() {

        SalesDistrict__c sd = [SELECT ID FROM SalesDistrict__c WHERE SalesDistrictKey__c = 'DEXX' LIMIT 1];
        delete sd;

        Test.startTest();
        undelete [SELECT ID FROM SalesDistrict__c WHERE Id =: sd.Id LIMIT 1 ALL ROWS];
        Test.stopTest();

    }

    @IsTest
    private static void testSalesDistrictDelete() {

        SalesDistrict__c sd = [SELECT ID FROM SalesDistrict__c WHERE SalesDistrictKey__c = 'DEXX' LIMIT 1];

        Test.startTest();
        delete sd;
        Test.stopTest();

    }

    @IsTest
    private static void testAccountInsert(){

        Test.startTest();
        Account acc = DataFactory.createAccount(true);
        Test.stopTest();

    }

    @IsTest
    private static void testAccountUpdate(){

        Account acc = DataFactory.createAccount(true);

        Test.startTest();
        acc.Name = 'Test updated name';
        update acc;
        Test.stopTest();

    }





}