<%@   page contentType="text/html" pageEncoding="UTF-8"
%><%--
  This file is part of gladiwashere-java-mysql.
  (C) 2012-2017 Indie Computing Corp.
  
  gladiwashere-java-mysql is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
 
  gladiwashere-java-mysql is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
 
  You should have received a copy of the GNU General Public License
  along with gladiwashere-java-mysql.  If not, see <http://www.gnu.org/licenses/>.

--%><%@ page import="javax.naming.InitialContext"
%><%@ page import="java.sql.Connection"
%><%@ page import="java.sql.PreparedStatement"
%><%@ page import="java.sql.ResultSet"
%><%@ page import="javax.sql.DataSource"
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
    InitialContext ctx  = new InitialContext();
    DataSource     ds   = (DataSource) ctx.lookup( "java:comp/env/jdbc/maindb" );
    Connection     conn = ds.getConnection();

    if( "POST".equals( request.getMethod())) {

        PreparedStatement stm = conn.prepareStatement( "INSERT INTO Comment( name, created, email, comment ) VALUES ( ?, NOW(), ?, ? )" );
        stm.setString( 1, request.getParameter( "name" ));
        stm.setString( 2, request.getParameter( "email" ));
        stm.setString( 3, request.getParameter( "comment" ));
        stm.execute();
        stm.close();
    }
    ResultSet results = conn.prepareCall( "SELECT * FROM Comment ORDER BY id DESC LIMIT 10" ).executeQuery();
%>
<html>
 <head>
  <title>Glad-I-Was-Here Guestbook</title>
 </head>
 <body>
  <h1>Glad-I-Was-Here Guestbook</h1>
  <p>Example Java/MySQL app for <a href="http://ubos.net/">UBOS</a>.</p>
<%
boolean first = true;
while( results.next() ) {
    if( first ) {
        out.print( "<h2>Comments:</h2>\n" );
        out.print( "<dl>\n" );
    }
    out.print( " <dt>" + results.getString( "name" ) + " (on " + results.getString( "created" ) + ")</dt>\n" );
    out.print( " <dd>" + results.getString( "comment" ) + "</dd>\n" );
    first = true;
}
if( !first ) {
    out.print( "</dl>\n" );
}
conn.close();
%>
  <p>Please leave your comments here:</p>
  <form method="POST" action="<%= request.getRequestURI() %>">
   <table>
    <tr>
     <th>Name:</th>
     <td>
      <input type="text" name="name" size="40" maxlength="80" />
     </td>
    </tr>
    <tr>
     <th>E-mail:</th>
     <td>
      <input type="text" name="email" size="40" maxlength="80" />
     </td>
    </tr>
    <tr>
     <th>Comment:</th>
     <td>
      <textarea name="comment" maxlength="1024" cols="40" rows="8" ></textarea>
     </td>
    </tr>
    <tr>
     <td colspan="2" class="submit">
      <input type="submit" name="submit" value="Leave Comment" />
     </td>
   </table>
  </form>
 </body>
</html>
