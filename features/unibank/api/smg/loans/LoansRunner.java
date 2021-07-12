package features.unibank.api.smg.loans;

import com.intuit.karate.junit5.Karate;

class LoansRunner {
    
    @Karate.Test
    Karate testGetAmortizableLoanDetail() {
        return Karate.run("get-amortizable-loan-detail").relativeTo(getClass());
    }

    @Karate.Test
    Karate testGetAmortizableLoanList() {
        return Karate.run("get-amortizable-loan-list").relativeTo(getClass());
    }
    
}