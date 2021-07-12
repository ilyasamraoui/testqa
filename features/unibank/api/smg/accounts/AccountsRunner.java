package features.unibank.api.smg.accounts;

import com.intuit.karate.junit5.Karate;

class AccountsRunner {
    
    @Karate.Test
    Karate testGetAccountActivity() {
        return Karate.run("get-account-activity").relativeTo(getClass());
    }

    @Karate.Test
    Karate testGetAccountBalance() {
        return Karate.run("get-account-balance").relativeTo(getClass());
    }

    @Karate.Test
    Karate testGetAccountDetail() {
        return Karate.run("get-account-detail").relativeTo(getClass());
    }

    @Karate.Test
    Karate testGetAccountList() {
        return Karate.run("get-account-list").relativeTo(getClass());
    }

    @Karate.Test
    Karate testCreateTransfer() {
        return Karate.run("create-transfer").relativeTo(getClass());
    }
}