/**
 * Created by DanielStange on 06.10.18.
 */
@isTest
private class Test_DataFactory {

    @isTest
    private static void testCreateContact() {

        System.assertEquals(0, [SELECT Count() FROM Contact]);

        Test.startTest();
        Contact cSaved = DataFactory.createContact(true);
        Contact cNotSaved = DataFactory.createContact(false);
        Test.stopTest();

        System.assertEquals(1, [SELECT Count() FROM Contact]);
        System.assertNotEquals(NULL, cSaved.Id);

    }

    @isTest
    private static void testCreateAccount() {

        System.assertEquals(0, [SELECT Count() FROM Account]);

        Test.startTest();
        Account aSaved = DataFactory.createAccount(true);
        Account aNotSaved = DataFactory.createAccount(false);
        Test.stopTest();

        System.assertEquals(1, [SELECT Count() FROM Account], 'Expected number of Accounts does not match');
        System.assertNotEquals(NULL, aSaved.Id, 'The account has not been correctly saved');
        System.assertEquals(NULL, aNotSaved.Id, 'An unsaved account has received an Id. Test state is not sane');
        System.assertNotEquals(NULL, aNotSaved, 'No unsaved account has been returned');

    }

    @isTest
    private static void testCreateUser() {

        User u = DataFactory.createUser(true);
        System.assertNotEquals(NULL, u, 'User was not created');
        Profile p = [SELECT Id FROM Profile WHERE Name IN ('Standard User','Standardbenutzer') LIMIT 1];
        Test.startTest();
        User anotherUser;
        System.runAs(u) {
            anotherUser = DataFactory.createUser(false, 'Standard User');
        }

        Test.stopTest();

        System.assertEquals(p.Id, anotherUser.profileId, 'User does not have the correct profile');
    }

    @isTest
    private static void testCreateLead() {

        System.assertEquals(0, [SELECT Count() FROM Lead], 'Unexpected number of leads in the Database');

        Test.startTest();
        Lead l = DataFactory.createLead(true);
        Test.stopTest();

        Lead[] leads = [SELECT ID FROM Lead];
        System.assertEquals(1, leads.size(), 'Unexpected number of leads in the Database');
        System.assertEquals(l.Id, leads[0].Id);
    }

    @isTest
    private static void testCreateProduct() {

        Test.startTest();
        Product2 p = DataFactory.createProductWithPricebookEntry(NULL);
        Test.stopTest();
        System.assertEquals(1, [SELECT Count() FROM Product2 LIMIT 2], 'Unexpected Number of Products');
        System.assertEquals(1, [SELECT Count() FROM PricebookEntry LIMIT 2], 'Unexpected Number of Pricebook Entries');
    }


}