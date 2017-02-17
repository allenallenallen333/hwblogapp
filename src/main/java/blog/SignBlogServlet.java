package blog;


import com.googlecode.objectify.Key;
import com.googlecode.objectify.ObjectifyService;

import blog.Posting;

import static com.googlecode.objectify.ObjectifyService.ofy;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SignBlogServlet extends HttpServlet{
	static {
        ObjectifyService.register(Posting.class);
    }
	
    public void doPost(HttpServletRequest req, HttpServletResponse resp)

        throws IOException {
    	
    	if (req.getParameter("del") != null){
			List<Key<Posting>> keys = ofy().load().type(Posting.class).keys().list();
			ofy().delete().keys(keys).now();
			resp.sendRedirect("/allposts.jsp");
		}
    	else{
    		UserService userService = UserServiceFactory.getUserService();

            User user = userService.getCurrentUser();

            String title = req.getParameter("title");
            
            String content = req.getParameter("content");

            Posting pst = new Posting(user, title, content);
            
            
            ofy().save().entity(pst);
            
            // Problem - redirect to permalink page of this new post
            resp.sendRedirect("/index.jsp");
    	}
    	

    }
}
