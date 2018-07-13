@isTest
public class SOA_TestDataFactory {
    public static List<Account> createAccountsWithRelatedConacts(Integer numAccts, Integer numConAcct) {
        List<Account> accounts = new List<Account>();
        
        for(Integer i=0;i<numAccts;i++) {
            Account acc = new Account(Name='SOA_TestAccount' + i);
            accounts.add(acc);
        }
        insert accounts;
        //Create Related Contacts for each Account
        List<Contact> contacts = new List<Contact>();
        for (Integer j=0;j<numAccts;j++) {
            Account acct = accounts[j];
            for (Integer k=0;k<numConAcct;k++) {
                contacts.add(new Contact(FirstName='SOA_Fname',
                                      LastName='SOA_LName' + k,
                                      AccountId=acct.Id));
            }
        }
        
        insert contacts;
        return accounts;
    }
    
    public static List<Account> createAccounts(Integer numAccts) {
        List<Account> accounts = new List<Account>();
        
        for(Integer i=0;i<numAccts;i++) {
            Account acc = new Account(Name='SOA_TestAccount' + i);
            accounts.add(acc);
        }
        insert accounts;
        return accounts;
    }
    public static List<Contact> createContacts(Integer numCons) {
        List<Contact> contacts = new List<Contact>();
        for (Integer i=0;i<numCons;i++) {
            contacts.add(new Contact(FirstName='SOA_Fname',
                                  LastName='SOA_LName' + i
                                 ));
        }
        insert contacts;
        return contacts;
    }
}