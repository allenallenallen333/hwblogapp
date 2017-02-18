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
    <title>all the posts!! ⚞^✧ᆺ✧^⚟</title>
   <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
 </head>
  <body>
  
	<div id="container">

		<div class="header">

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
          
          		<%
   			UserService userService = UserServiceFactory.getUserService();
   		 	User user = userService.getCurrentUser();

   		 	if (user != null) {
		%>
			<a href="/subscription.jsp">Subscribe </a> ▬ <a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">{ sign out }</a>
			<!--<a href="/newpost" class="postbtn">+Post</a> -->	
		<%
    		} else {
		%>
			<a href="/subscription.jsp">Subscribe </a> ▬ <a href="<%= userService.createLoginURL(request.getRequestURI()) %>"> { sign in to post }</a>
		<%
		    }
		%>
		          
      		</div>
		</div>
		<div class="separate"></div>

<% 
if (user != null) {
%>
<ul  class="posts">
<li class="post" style="min-height: 104px">
		<form action="/sign" method="post">

	  <div>
	  
	  <textarea name="title" placeholder="Post Title" rows="1" cols="50"></textarea> 
	  <br> <br>
      <textarea name="content" placeholder="Share your thoughts..." rows="10" cols="50"></textarea>

      <input type="submit" value="Submit" />
      
      </div>

    </form>
    </li>
</ul>

		<div class="separate"></div>
		
		<%
		
		if (user.getEmail().equals("allenallenallen333@gmail.com")){
			
			%>
			<form action="/sign" method="post">
			<div><input type="submit" action="/sign" name="del" value="Delete All Posts" /></div>
			</form>
			<div class="separate"></div>
			<% 
			
		}
		
		%>	
<%
} 
%>
		
		<ul class="posts">

	<%
		ObjectifyService.register(Posting.class);
		List<Posting> postings = ObjectifyService.ofy().load().type(Posting.class).list();   
		Collections.sort(postings); 
		Collections.reverse(postings);

		if (postings.isEmpty()) {
	%>
	
    	<p align="center">This blog has no posts.</p>
    	
	<%
		} else {

		    for (Posting posting : postings) {
		    	pageContext.setAttribute("greeting_title", posting.getTitle());
		        pageContext.setAttribute("greeting_content", posting.getContent());
				pageContext.setAttribute("greeting_user", posting.getUser());	
				pageContext.setAttribute("greeting_date", posting.getDate().toString());

				
	%>

			<li class="post" style="min-height: 104px">
				<a href="#" class="title"><span> ${fn:escapeXml(greeting_title)} </span></a>

		        <div class="caption">
		          	<p>
		          	${fn:escapeXml(greeting_content)}
					</p>
				</div>

				<div class="postinfo">
					Posted by <b>${fn:escapeXml(greeting_user.nickname)} </b> at ${fn:escapeXml(greeting_date)}
				</div>

			</li>

	<%
    			}
    	}
	%>

		</ul>

		<div class="separate"></div>

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
