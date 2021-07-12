package features.unibank.api.vip.accounts;

import com.intuit.karate.junit5.Karate;

class VIPAccountsRunner {
    
    @Karate.Test
    Karate testGetAccountList() {
        return Karate.run("account-list").relativeTo(getClass());
    }

    @Karate.Test
    Karate testGetAccount() {
        return Karate.run("account").relativeTo(getClass());
    }

    @Karate.Test
    Karate testDeleteBeneficiaries() {
        return Karate.run("delete-beneficiary").relativeTo(getClass());
    }

    @Karate.Test
    Karate testAddBeneficiary() {
        return Karate.run("add-beneficiary").relativeTo(getClass());
    }

    @Karate.Test
    Karate testCreateTransfer() {
        return Karate.run("create-transfer").relativeTo(getClass());
    }

    @Karate.Test
    Karate testCheckTransfer() {
        return Karate.run("check-transfer").relativeTo(getClass());
    }

    @Karate.Test
    Karate testCheckBeneficiary() {
        return Karate.run("check-beneficiary").relativeTo(getClass());
    }

    @Karate.Test
    Karate testSetGauge() {
        return Karate.run("set-gauge").relativeTo(getClass());
    }

    @Karate.Test
    Karate testTransactions() {
        return Karate.run("transactions").relativeTo(getClass());
    }
    @Karate.Test
    Karate testBeneficiaries() {
        return Karate.run("beneficiaries").relativeTo(getClass());
    }
}