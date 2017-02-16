package blog;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

public class Subscription {
	String email;
	
	private Subscription(){
    }
    
    public Subscription(String em){
    	this.email = em;
    }
}
