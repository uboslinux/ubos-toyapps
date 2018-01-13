<?php
#
# Main program code for gladiwashere-php-mysql.
#
# Copyright (C) 2014 and later, Indie Computing Corp. All rights reserved. License: see package.
#

    $db = mysqli_connect( $dbServer, $dbUser, $dbPass, $dbName );
    if( !$db ) {
        die( 'ERROR: Cannot connect: ' . mysqli_error() );
    }
    if( $_SERVER['REQUEST_METHOD'] == 'POST' ) {
        mysqli_query(
                $db,
                sprintf(
                        "INSERT INTO Comment( name, created, email, comment ) VALUES ( '%s', NOW(), '%s', '%s' );",
                        mysqli_real_escape_string( $db, $_POST['name'] ),
                        mysqli_real_escape_string( $db, $_POST['email'] ),
                        mysqli_real_escape_string( $db, $_POST['comment'] )));
    }
    $query = mysqli_query( $db, "SELECT * FROM Comment ORDER BY id DESC LIMIT 10" );

?>
<html>
 <head>
  <title>Glad-I-Was-Here Guestbook</title>
 </head>
 <body>
  <h1>Glad-I-Was-Here Guestbook</h1>
  <p>Example PHP/MySQL app for <a href="http://ubos.net/">UBOS</a>.</p>
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
<?php
if( file_exists( 'footer.php' )) {
    require_once( 'footer.php' );
}
?>
</html>
