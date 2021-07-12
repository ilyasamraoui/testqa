package features.unibank.api.smg.deposit;

import com.intuit.karate.junit5.Karate;

class DepositRunner {
    
    @Karate.Test
    Karate testGetCodDetail() {
        return Karate.run("get-cod-detail").relativeTo(getClass());
    }

    @Karate.Test
    Karate testGetCodList() {
        return Karate.run("get-cod-list").relativeTo(getClass());
    }

    @Karate.Test
    Karate testGetTdDetail() {
        return Karate.run("get-td-detail").relativeTo(getClass());
    }

    @Karate.Test
    Karate testGetTdList() {
        return Karate.run("get-td-list").relativeTo(getClass());
    }
}