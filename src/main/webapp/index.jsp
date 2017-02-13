<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="blog.Posting" %>
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
  
  <div class="header">
  
  <a href="">Subscribe</a>
  
  
<%

    UserService userService = UserServiceFactory.getUserService();

    User user = userService.getCurrentUser();

    if (user != null) {
%>

		<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Sign Out</a> 
		<a href="">+ Post</a>

<%
    } else {
%>

<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>

<%
    }
%>

 </div>

<%

ObjectifyService.register(Posting.class);

List<Posting> postings = ObjectifyService.ofy().load().type(Posting.class).list();   

Collections.sort(postings); 

if (postings.isEmpty()) {

%>

    <p>This blog has no posts.</p>

<%
} else {
    for (Posting posting : postings) {
        pageContext.setAttribute("greeting_content", posting.getContent());
		pageContext.setAttribute("greeting_user", posting.getUser());
		
%>
		<div class="post">
		
		<h1>${fn:escapeXml(greeting_title)}</h1>
		<p>${fn:escapeXml(greeting_content)}</p>
		<hr>
		<p align="right">Posted by <b>${fn:escapeXml(greeting_user.nickname)}</b> at </p>
		
		</div>
        
<%
    	}
    }
%>

<%
 if (user != null) {
 
 	%>
 	<form action="/sign" method="post">

	  <div>
	  
	  <textarea name="title" placeholder="Post Title" rows="1" cols="60"></textarea> 
	  <br> <br>
      <textarea name="content" placeholder="Share your thoughts..." rows="10" cols="60"></textarea>

      <input type="submit" value="Submit" />
      
      </div>

    </form>
    <%
}
%>
    

 

  </body>

</html>

 