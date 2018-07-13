@isTest
public class SOA_RecentAccountsTest {
	@isTest
    private static void checkContactCount(){
        SOA_TestDataFactory.createAccounts(20);
        List<Account> accounts = SOA_RecentAccountsCtlr.getRecentAccounts();
        System.assertEquals(10, accounts.size());
    } 
}