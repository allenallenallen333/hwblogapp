package blog;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
// [END simple_includes]


import java.util.Collections;
import java.util.List;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.googlecode.objectify.ObjectifyService;
@SuppressWarnings("serial")

public class SubscribeServlet extends HttpServlet {
	
	static {
        ObjectifyService.register(Subscription.class);
    }
	
	private static final Logger _logger = Logger.getLogger(SubscribeServlet.class.getName());
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		_logger.info("SubscribeServlet Cron Job has been executed");
		
		// makes the emails
				final long DAY = 24 * 60 * 60 * 1000;
				
				Properties props = new Properties();
			    Session session = Session.getDefaultInstance(props, null);
			    
				ObjectifyService.register(Posting.class);
				List<Posting> postings = ObjectifyService.ofy().load().type(Posting.class).list();   
				Collections.sort(postings); 
				Collections.reverse(postings);

			    String msgBody = "Hello! You are subscribed to hwblog's daily digest to receive news of blog posts within the last 24 hours. \n ";

				int i = 0;
				long now = System.currentTimeMillis();
				while(i < postings.size() && postings.get(i).getDate().getTime() > now - DAY){
					
					msgBody += " \n ------ \n \n Posted by " + postings.get(i).getUser() + " at " + postings.get(i).getDate().toString() + ": \n";
					msgBody += "Title: " + postings.get(i).getTitle() + "\n";
					msgBody += postings.get(i).getContent() + "\n";
					
					i++;
				}
			    
				if (i >= 1){
					try {
					      Message msg = new MimeMessage(session);
					      msg.setFrom(new InternetAddress("allenallenallen333@gmail.com"));
					      
							ObjectifyService.register(Subscription.class);
							List<Subscription> emails = ObjectifyService.ofy().load().type(Subscription.class).list();   
							
					      for(Subscription email : emails){
						     msg.addRecipient(Message.RecipientType.TO, new InternetAddress(email.getEmail(), "Subscriber"));	    	  
					      }
					      
					      msg.setText(msgBody);

					      msg.setSubject("Blog: Daily Digest");
					      Transport.send(msg);
					    } catch (Exception e) {}
				}
			    	     
			    
	}

	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException {
		
		String email = req.getParameter("email");

		Subscription sub = new Subscription(email);
		
		if (req.getParameter("button1") != null){
			ofy().save().entity(sub);
		}
		else if (req.getParameter("button2") != null){
			ofy().delete().entity(sub);
		}
		else{
			// Error
		}
		
		
		
		
		resp.sendRedirect("/subscription.jsp");
		
	// doGet(req, resp);
	}
}