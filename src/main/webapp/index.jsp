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
<%

    UserService userService = UserServiceFactory.getUserService();

    User user = userService.getCurrentUser();

    if (user != null) {

      pageContext.setAttribute("user", user);

%>

<p>Hello, ${fn:escapeXml(user.nickname)}! (You can

<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>

<%

    } else {

%>

<p>Hello!

<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>

to create your blog post.</p>

<%

    }

%>

 

<%


ObjectifyService.register(Posting.class);

List<Posting> postings = ObjectifyService.ofy().load().type(Posting.class).list();   

Collections.sort(postings); 

if (postings.isEmpty()) {

    %>

    <p>This blog has no posts.</p>

    <%

} else {

    %>

    <p>Available blog posts.</p>

    <%

    for (Posting posting : postings) {

    	pageContext.setAttribute("greeting_title", posting.getTitle());
    	
    	
        pageContext.setAttribute("greeting_content", posting.getContent());

        if (posting.getUser() == null) {

            %>

            <p>An anonymous person wrote:</p>

            <%

        } else {

            pageContext.setAttribute("greeting_user", posting.getUser());

            %>

            <p><b>${fn:escapeXml(greeting_user.nickname)}</b> wrote:</p>

            <%

        }

        %>

		<blockquote>${fn:escapeXml(greeting_title)}</blockquote>
        <blockquote>${fn:escapeXml(greeting_content)}</blockquote>

        <%

    }

}

%>

<%
 if (user != null) {
 
 	%>
 	<form action="/sign" method="post">

	  <div><textarea name="title" rows="1" cols="60"></textarea></div>
      <div><textarea name="content" rows="3" cols="60"></textarea></div>

      <div><input type="submit" value="Post it!" /></div>

    </form>
    <%
}
%>
    

 

  </body>

</html>

 