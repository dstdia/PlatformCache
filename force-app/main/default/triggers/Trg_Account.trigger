/**
 * @see TrgHandler_Account.cls
 */
trigger Trg_Account on Account (before insert, before update, after undelete) {

	new TrgHandler_Account().run();

}