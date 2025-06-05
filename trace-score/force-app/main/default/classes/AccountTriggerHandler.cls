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
                con.email='coudfulcrum@gmail.com';
                contactsToInsert.add(con);
            }
        }
        for (Account acc : newAccounts) {
            if (String.isNotBlank(acc.Name)) {
                Contact con = new Contact();
                con.FirstName ='CFRO';
                con.LastName = acc.Name;
                con.AccountId = acc.Id;
                con.Phone=acc.phone;
                con.email='coudfulcrum@gmail.com';
                contactsToInsert.add(con);
            }
        }

        if (!contactsToInsert.isEmpty()) {
            insert contactsToInsert;
        }
    }   
    
}

