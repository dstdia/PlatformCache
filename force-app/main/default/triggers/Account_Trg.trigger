trigger Account_Trg on Account (before insert, before update, after undelete) {

	new Account_Trg().run();

}