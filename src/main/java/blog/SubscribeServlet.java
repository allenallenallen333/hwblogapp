package blog;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
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
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
	try {
	_logger.info("Cron Job has been executed");
	//Put your logic here
	//BEGIN
	//END
	}
	catch (Exception ex) {
	//Log any exceptions in your Cron Job
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