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
   <title>subscribe! meow!! ⚞^✧ᆺ✧^⚟</title>
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
	          
	          	<a href="/"><h1 class="cufon">meow</h1></a>

	          </td>
	          <td width="250" class="description">

	         	 <p><img src="https://s-media-cache-ak0.pinimg.com/originals/31/f1/7d/31f17d37aad1b028590bb5ea0ba6df20.jpg"></p>

	          </td>
	        </tr>
     	 </table>    
      
      		<div style="margin-top: 20px">
          
          		<a href="/subscription.jsp">Subscribe ♡</a>&nbsp;&nbsp;
          
      		</div>
		</div>
		<div class="separate"></div>
      		<div align="center">		
		<div> If you would like to receive a daily email containing the latest blog posts, enter your email to subscribe! <br><br>
		
		  	⚞^✧ᆺ✧^⚟ <br><br>
		</div>

		<form action="/subs" method="post">


      
      		<input type="text" name="email"  placeholder="Email" rows="1" cols="25"></input> <br> <br>

      		<input type="submit" class="button button1" value="Subscribe" /> <br>
      
      		<input type="submit" class="button button2" value="Unsubscribe" />
      		
      		</div>

    	</form>
		
		<div class="separate"></div>
		
		<%
		
		if (user != null && user.getEmail().equals("allenallenallen333@gmail.com") || user.getEmail().equals("kmalyavina@gmail.com")) {
		
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
			<p><b>All subscribed users:</b> </p>
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
