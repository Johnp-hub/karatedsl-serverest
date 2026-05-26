package users;

import com.intuit.karate.junit5.Karate;

class TestRunner {
    
    @Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
        //return Karate.run("post_user").relativeTo(getClass());
    }    

}