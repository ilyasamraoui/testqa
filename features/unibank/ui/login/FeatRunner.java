package features.unibank.ui.login;

import com.intuit.karate.junit5.Karate;

class FeatRunner {
    
    @Karate.Test
    Karate testLogin() {
        return Karate.run("login").relativeTo(getClass());
    }

}