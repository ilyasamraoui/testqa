package features.unibank.api.vip.users;

import com.intuit.karate.junit5.Karate;

class VIPUsersRunner {
    
    @Karate.Test
    Karate testGetAccountList() {
        return Karate.run("get-user-consent").relativeTo(getClass());
    }
}