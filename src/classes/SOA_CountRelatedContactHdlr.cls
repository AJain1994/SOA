public class SOA_CountRelatedContactHdlr {
	static Set<Id> accountIds; 
    static List<Account> accounts;
    static Map<Id, List<Contact>> contactsMap;
    static Map<Id, List<Contact>> deletedContactsMap;
    
    public static void handleTrigger(List<Contact> currentRecords, List<Contact> oldRecords,Map<Id, Contact> oldRecordsMap, System.TriggerOperation triggerEvent ) {
        accountIds = new Set<Id>();    
        accounts = new List<Account>();
		contactsMap = new Map<Id, List<Contact>>();
        deletedContactsMap = new Map<Id, List<Contact>>();

        switch on triggerEvent {
            when AFTER_INSERT,AFTER_UNDELETE {
                updateContactCount(currentRecords,contactsMap);
            }
            when AFTER_DELETE {
                updateContactCount(oldRecords,deletedContactsMap);
            }
            when AFTER_UPDATE {
                Boolean removeReference;
                for(Contact con : currentRecords) {
                    removeReference = false;
                    if(String.isNotBlank(con.AccountId) && con.AccountId != oldRecordsMap.get(con.Id).AccountId) {
                        if(!contactsMap.containsKey(con.AccountId)){
                            contactsMap.put(con.AccountId, new List<Contact>());
                        }
                        contactsMap.get(con.AccountId).add(con);
                        accountIds.add(con.AccountId);
                        if(String.isNotBlank(oldRecordsMap.get(con.Id).AccountId)){
                            removeReference = true;
                        }
                    } else if(String.isBlank(con.AccountId) && String.isNotBlank(oldRecordsMap.get(con.Id).AccountId)) {
                        removeReference = true;
                    }
                    
                    if(removeReference) {
                        if(!deletedContactsMap.containsKey(oldRecordsMap.get(con.Id).AccountId)){
                            deletedContactsMap.put(oldRecordsMap.get(con.Id).AccountId, new List<Contact>());
                        }
                        deletedContactsMap.get(oldRecordsMap.get(con.Id).AccountId).add(con); 
                        accountIds.add(oldRecordsMap.get(con.Id).AccountId);   
                    }
                    
                } 
            }
            
        }
        
        if(accountIds.size() > 0) {
            accounts = [SELECT Id, Number_of_Contacts__c FROM Account WHERE Id IN : accountIds];
            for(Account acct : accounts) {
                Integer noOfConts = 0;
                if(contactsMap.containsKey(acct.Id)) {
                    noOfConts += contactsMap.get(acct.Id).size();
                    
                }
                if(deletedContactsMap.containsKey(acct.Id)) {
                    noOfConts -= deletedContactsMap.get(acct.Id).size();
                }
                acct.Number_of_Contacts__c = acct.Number_of_Contacts__c == 0 ? noOfConts : (acct.Number_of_Contacts__c + noOfConts);
                    }
            
            update accounts;    
        }
    }
    
    private static void updateContactCount(List<Contact> records, Map<Id, List<Contact>> accountContactsMap){
        for(Contact con : records) {
            if(String.isNotBlank(con.AccountId)) {
                if(!accountContactsMap.containsKey(Con.AccountId)) {
                    accountContactsMap.put(con.AccountId, new List<Contact>());
                }
                accountContactsMap.get(con.AccountId).add(con); 
                accountIds.add(con.AccountId);
                
            }   
        }
    }
    
}