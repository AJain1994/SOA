public class SOA_RecentAccountsCtlr {
    //@return 10 recent accounts
	@AuraEnabled
    public static List <Account> getRecentAccounts() {
        return [SELECT Name, Phone, Rating, Industry FROM Account ORDER BY createdDate DESC LIMIT 10];
    }
}