/**
 * @see TrgHandler_SalesDistrict.cls
 */
trigger Trg_SalesDistrict on SalesDistrict__c (after insert, after update, after delete, after undelete) {

	new TrgHandler_SalesDistrict().run();
}