trigger SalesDistrict_Trg on SalesDistrict__c (after insert, after update, after delete, after undelete) {

	new SalesDistrict_Trg().run();
}