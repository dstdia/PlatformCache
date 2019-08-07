/**
 * Created by DanielStange on 2019-08-03.
 */

/**
 * DIA Test Data Factory
 * @author Daniel Stange <daniel.stange@die-interaktiven.de>
 * @version 1.0
 *
 *
 */

global with sharing class DataFactory {

    /**
    * Create Test Users
    *
    * @param toInsert  determine whether to store and return (true) or just return the User object
    *
    * @return User
    * @throws TestDataFactoryException
    */
    public static User createUser(Boolean toInsert)
    {
        Profile p = [SELECT Name FROM Profile WHERE Name LIKE '%dministrator' LIMIT 1];
        return createUser(toInsert, p.Name);
    }
    /***
     * Create Test Users with a specific profile
     *
     * @param toInsert  determine whether to store and return (true) or just return the User object
     * @param profileName   a valid Prfile name
     *
     * @return User
     * @throws TestDataFactoryException
     */
    public static User createUser(Boolean toInsert, String profileName) {

        Map<String, Object> userFields = new Map<String, Object>{
                'UserName' =>  'SalesUser' + system.currentTimeMillis() + '@void.dia',
                'Alias' => 'standt',
                'Email' => 'test@factory.com',
                'EmailEncodingKey' => 'UTF-8',
                'LastName' => 'Testing',
                'LanguageLocaleKey' => 'en_US',
                'LocaleSidKey' => 'en_US',
                'TimeZoneSidKey' =>'Europe/Berlin'
        };

        return (User) createUser(
                toInsert,
                profileName,
                userFields
        );

    }

    public static User createUser(boolean toInsert, String profileName, Map <String, Object> userFields) {

        Profile p = [SELECT Id FROM Profile WHERE Name=: profileName];

        userFields.put('ProfileId', p.Id);

        return (User) createObject(
                toInsert,
                'User',
                userFields
        );
    }

    public static Contact createContact(boolean toInsert) {

        Account newAccount = createAccount(true);

        return createContact(toInsert, new Map<String, Object>{
                'FirstName' => 'Some Firstname',
                'LastName' =>'Some-LastName',
                'Email' =>'test@example.com',
                'AccountId' => newAccount.Id});

    }

    public static Contact createContact(boolean toInsert, Map<String, Object> contactFields) {

        return (Contact) createObject(
                toInsert,
                'Contact',
                contactFields
        );

    }

    public static Account createAccount(boolean toInsert) {

        Long millis = System.currentTimeMillis();
        String accountName = String.valueOf(millis * Math.random());
        return createAccount(toInsert, new Map<String, String>{
                'Name' => accountName,
                'BillingStreet' =>'Some Street ' + String.valueOf(millis),
                'BillingPostalCode' => String.valueOf(millis),
                'BillingCity' => 'Sample-' + String.valueOf(millis)
        });
    }

    public static Account createAccount(Boolean toInsert,Map<String,object> accountFields)
    {
        return (Account) createObject(
                toInsert,
                'Account',
                accountFields
        );
    }

    public static Lead createLead(boolean toInsert) {

        return createLead(toInsert, new Map<String, String>{
                'FirstName' => 'SampleFirstName',
                'LastName' => 'Some-LastName',
                'Company' => 'SampleAccount',
                'Email' =>'some@example.com'
        });
    }

    public static Lead createLead(Boolean toInsert,Map<String,object> leadFields)
    {
        return (lead) createObject(
                toInsert,
                'Lead',
                leadFields
        );
    }

    public static Product2 createProductWithPricebookEntry(Map<String, Object> productFields) {

        Map<String, Object> standardProduct = new Map<String, Object>{
                'Name' => 'Testproduct 1',
                'isActive' => true
        };

        if (NULL != productFields) {
            for (String s : productFields.keySet()) {
                standardProduct.put(s, productFields.get(s));
            }
        }

        Product2 p = (Product2) createObject(true, 'Product2', standardProduct);
        PricebookEntry pbe = (PricebookEntry) createObject(true, 'PricebookEntry', new Map<String, Object>{
                'Product2Id' => p.Id,
                'Pricebook2Id' => Test.getStandardPricebookId(),
                'isActive' => true,
                'UnitPrice' => 1.0
        });

        return p;
    }

    public static sObject createObject(Boolean toInsert, String objType, Map<String, Object> objFields) {

        Schema.DescribeSobjectResult[] res = Schema.describeSObjects(new List<String>{objType});
        sObject obj = res[0].getSObjectType().newSObject();

        for(String field: objFields.keySet()){
            obj.put(field,objFields.get(field));
        }

        if(toInsert){
            try {
                insert obj;
            }

            catch (Exception e) {
                System.debug('Factory Exception :: ' + e.getMessage());
                return NULL;
            }
        }

        return obj;
    }
}