public class SalesDistrict_Trg extends TriggerHandler {

	public override void afterInsert() {

		SampleCacheManager.populateSalesDistricts();
	}

	public override void afterUpdate() {

		SampleCacheManager.populateSalesDistricts();
	}

	public override void afterDelete() {

		SampleCacheManager.populateSalesDistricts();
	}

	public override void afterUndelete() {

		SampleCacheManager.populateSalesDistricts();
	}
	

}