/**
 * @author	Daniel Stange <daniel.stange@die-interaktiven.de>
 * @date 	2019-06-17
 * @description Trigger handler for Sales District logic
 *  - Maintains the Sales District Cache
 */
public class SalesDistrict_Trg extends TriggerHandler {


	/**
	 * @description Trigger handler method for After Insert Triggers
	 */
	public override void afterInsert() {
		SampleCacheManager.populateSalesDistricts();
	}

	/**
	 * @description Trigger handler method for After Update Triggers
	 */
	public override void afterUpdate() {
		SampleCacheManager.populateSalesDistricts();
	}

	/**
	 * @description Trigger handler method for After Delete Triggers
	 */
	public override void afterDelete() {
		SampleCacheManager.populateSalesDistricts();
	}

	/**
	 * @description Trigger handler method for After Undelete Triggers
	 */
	public override void afterUndelete() {
		SampleCacheManager.populateSalesDistricts();
	}
	

}