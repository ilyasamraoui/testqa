package features.unibank.api.auth;

import com.intuit.karate.junit5.Karate;

class AuthRunner {
    @Karate.Test
    Karate testGetAccountActivity() {
        return Karate.run("get-token").relativeTo(getClass());
    }
}