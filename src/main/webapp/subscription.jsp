<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="blog.Subscription" %>
<%@ page import="java.util.Collections" %>
<%@ page import="com.googlecode.objectify.*" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
  <head>
   <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
 </head>
  <body>

	<div id="container">

		<div class="header">

		<%
   			UserService userService = UserServiceFactory.getUserService();
   		 	User user = userService.getCurrentUser();

   		 	if (user != null) {
		%>
			<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">{ sign out }</a>
			<!--<a href="/newpost" class="postbtn">+Post</a> -->	
		<%
    		} else {
		%>
			<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">{ sign in to post }</a>
		<%
		    }
		%>

	      <table width="500">
	        <tr valign="baseline">	          
	          <td width="250">
	          
	          	<a href="/"><h1 class="cufon">title</h1></a>

	          </td>
	          <td width="250" class="description">

	         	 <p>A description of the blog</p>

	          </td>
	        </tr>
     	 </table>    
      
      		<div style="margin-top: 20px">
          
          		<a href="/subscription.jsp">Subscribe</a>&nbsp;&nbsp;
          
      		</div>
		</div>
		<div class="separate"></div>

		<form action="/cron/subscribe" method="post">

      <div><textarea name="email" rows="1" cols="60"></textarea></div>

      <div><input type="submit" name="button1" value="Subscribe" /></div>
      
      <div><input type="submit" name="button2" value="Unsubscribe" /></div>

    </form>
		
		<div class="separate"></div>
		
		<%
		
		if (user != null && user.getEmail().equals("allenallenallen333@gmail.com")) {
		
		ObjectifyService.register(Subscription.class);
		List<Subscription> subs = ObjectifyService.ofy().load().type(Subscription.class).list();   
		

		if (subs.isEmpty()) {
	%>
	
    	<p align="center">This subscription has no emails.</p>
    	
	<%
		} else {

		    for (Subscription sub : subs) {
		    	pageContext.setAttribute("greeting_email", sub.getEmail());
	
	%>

			<li class="post" style="max-height: 12px">
				<a href="#" class="email"><span> ${fn:escapeXml(greeting_email)} </span></a>
			</li>

	<%
    			}
		    
		    
    	}
		%>
	    <div class="separate"></div>
	    <%
		}
	%>
		
		

    	<div class="footer">
     	     		<div class="credit">
     			Blog by: <br>
     			Katya Malyavina <br>
     			Allen Yang
     		</div>
		</div>
		</div>
  </body>
 </html>
