package blog;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class Subscription {
	@Id String e;
	String email;
	
	private Subscription(){
    }
    
    public Subscription(String em){
    	e = em;
    	this.email = em;
    }
    
    public String getEmail(){
    	return email;
    }

}
