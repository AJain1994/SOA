@isTest
public class SOA_CountRelatedContactTest {
    @isTest
    private static void checkContactCount(){
        List<Account> accounts = SOA_TestDataFactory.createAccounts(1);
        List<Contact> contacts = SOA_TestDataFactory.createContacts(1);
        //No Contact test
        Account tempAccount1 = [SELECT Number_of_Contacts__c FROM Account WHERE Id = :accounts[0].Id];
        System.assertEquals(0, tempAccount1.Number_of_Contacts__c);
        
        contacts[0].AccountId = accounts[0].Id;
        update contacts[0];
        
		//Single Contact Test
        Account tempAccount2 = [SELECT Number_of_Contacts__c FROM Account WHERE Id = :accounts[0].Id];
        System.assertEquals(1, tempAccount2.Number_of_Contacts__c);
        
		Contact newContact = new Contact(FirstName='SOA_Test', LastName='SOA_LName', AccountId=accounts[0].Id);
        Insert newContact;
        
		//Multiple contact test
        Account tempAccount = [SELECT Number_of_Contacts__c FROM Account WHERE Id = :accounts[0].Id];
        System.assertEquals(2, tempAccount.Number_of_Contacts__c);
        
		//On Contact delete test
        Delete newContact;
        Account acc3 = [Select Number_of_Contacts__c FROM Account WHERE Id = :accounts[0].Id];
        System.assertEquals(1, acc3.Number_of_Contacts__c);

        //Mass records test
        List<Account> massAccounts = SOA_TestDataFactory.createAccountsWithRelatedConacts(1,10);
        Account tempAccount3 = [SELECT Number_of_Contacts__c FROM Account WHERE Id = :massAccounts[0].Id];
        System.assertEquals(10, tempAccount3.Number_of_Contacts__c);
        
    }
}