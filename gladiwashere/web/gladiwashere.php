<?php
#
# Program code for gladiwashere.
#
# This file is part of gladiwashere.
# (C) 2012-2016 Indie Computing Corp.
#
# gladiwashere is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# gladiwashere is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with gladiwashere.  If not, see <http://www.gnu.org/licenses/>.
#

    $db = mysqli_connect( $dbServer, $dbUser, $dbPass, $dbName );
    if( !$db ) {
        die( 'ERROR: Cannot connect: ' . mysqli_error() );
    }
    if( $_SERVER['REQUEST_METHOD'] == 'POST' ) {
        mysqli_query(
                sprintf(
                        "INSERT INTO Comment( name, created, email, comment ) VALUES ( '%s', NOW(), '%s', '%s' );",
                        mysqli_real_escape_string( $_POST['name'] ),
                        mysqli_real_escape_string( $_POST['email'] ),
                        mysqli_real_escape_string( $_POST['comment'] )),
                $db );
    }
    $query = mysqli_query( "SELECT * FROM Comment ORDER BY id DESC LIMIT 10", $db );

?>
<html>
 <head>
  <title>Glad-I-Was-Here Guestbook</title>
 </head>
 <body>
  <h1>Glad-I-Was-Here Guestbook</h1>
  <p>Example MySQL/PHP app for <a href="http://ubos.net/">UBOS</a>.</p>
<?php
$first = TRUE;
while( $row = mysqli_fetch_assoc( $query )) {
    if( $first ) {
        echo "<h2>Comments:</h2>\n";
        echo "<dl>\n";
    }
    echo " <dt>" . $row['name'] . " (on " . $row['created'] . ")</dt>\n";
    echo " <dd>" . $row['comment'] . "</dd>\n";
    $first = FALSE;
}
if( !$first ) {
    echo "</dl>\n";
}
mysqli_close( $db );
?>
  <p>Please leave your comments here:</p>
  <form method="POST" action="<?php $_SERVER['PHP_SELF'] ?>">
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
