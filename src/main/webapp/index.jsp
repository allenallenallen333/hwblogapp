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

	<div id="container">

		<div class="header">

		<%
   			UserService userService = UserServiceFactory.getUserService();
   		 	User user = userService.getCurrentUser();

   		 	if (user != null) {
		%>
			<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">{ sign out }</a>
			<a href="/newpost" class="postbtn">+Post</a>
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
	          
	          	<a href="/"><h1 class="cufon">Blog Title</h1></a>

	          </td>
	          <td width="250" class="description">

	         	 <p>A description of the blog</p>

	          </td>
	        </tr>
     	 </table>    
      
      		<div style="margin-top: 20px">
          
          		<a href="/subscribe">Subscribe</a>&nbsp;&nbsp;
          
      		</div>
		</div>

		<div class="separate"></div>

		<ul class="posts">

	<%
		ObjectifyService.register(Posting.class);
		List<Posting> postings = ObjectifyService.ofy().load().type(Posting.class).list();   
		Collections.sort(postings); 

		if (postings.isEmpty()) {
	%>
	
    	<p align="center">This blog has no posts.</p>
    	
	<%
		} else {
		    for (Posting posting : postings) {
		        pageContext.setAttribute("greeting_content", posting.getContent());
				pageContext.setAttribute("greeting_user", posting.getUser());	
	%>

			<li class="post" style="min-height: 104px">
				<a href="#" class="title"><span>${fn:escapeXml(greeting_title)}</span></a>

		        <div class="caption">
		          	<p>
		          	${fn:escapeXml(greeting_content)}
					</p>
				</div>

				<div class="postinfo">
					Posted by <b>${fn:escapeXml(greeting_user.nickname)}</b> at <___timestamp___>
				</div>

			</li>

	<%
    			}
    	}
	%>

		</ul>

		<div class="separate"></div>

    	<div class="footer">
     		<div class="pagination">

     	<%
     	 // some code to determine next/previous buttons
     	%>	

     		</div>

     		<div class="credit">
     			Blog by: <br>
     			Katya Malyavina <br>
     			Allen Yang
     		</div>

	</div>

  </body>
 </html>
