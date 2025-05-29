public class AccountTriggerHandler {
    public static void handleAfterInsert(List<Account> newAccounts) {
        List<Contact> contactsToInsert = new List<Contact>();
        
        for (Account acc : newAccounts) {
            if (String.isNotBlank(acc.Name)) {
                Contact con = new Contact();
                con.FirstName ='CFRO';
                con.LastName = acc.Name;
                con.AccountId = acc.Id;
                con.Phone=acc.phone;
                contactsToInsert.add(con);
            }
        }
        
        if (!contactsToInsert.isEmpty()) {
            insert contactsToInsert;
        }
    }
    public static void updateConDescription(List<Account> accList, Map<Id, Account> accOldMap) {
        
        Set<Id> accIds = new Set<Id>();
        
        // Identify Accounts whose Industry has changed
        for (Account acc : accList) {
            if (acc.Industry != null && accOldMap.get(acc.Id) != null && accOldMap.get(acc.Id).Industry != null &&
                acc.Industry != accOldMap.get(acc.Id).Industry) {
                    accIds.add(acc.Id);
                }
        }
        
        if (!accIds.isEmpty()) {
            List<Contact> conUpdateList = new List<Contact>();
            
            // Query Accounts and related Contacts
            List<Account> accountList = [
                SELECT Id, Industry, 
                (SELECT Id, Description FROM Contacts) 
                FROM Account 
                WHERE Id IN :accIds
            ];
            
            for (Account acc : accountList) {
                Account oldValues = accOldMap.get(acc.Id);
                
                for (Contact con : acc.Contacts) {
                    con.Description = 'Parent Account Industry field value changed from ' + oldValues.Industry + ' to ' + acc.Industry;
                    conUpdateList.add(con);
                }
            }
            
            if (!conUpdateList.isEmpty()) {
                update conUpdateList;
            }
        }
    }
    
    
}