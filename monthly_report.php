<html>
<head>
     <Title> Monthly Stream Report </Title>
</head>
<body>

<?php

try {
 $db=new PDO('mysql:host=localhost;dbname=wx2dxnet_CCPaSEC','wx2dxnet_WES','ccpasec42');
} catch (PDOException $e) {
   print "Could not connect to the database: " . $e->getMessage();
}
 print "Report for 2020 <br><br>";
 print "Site ID  Date  pH   Conductivity  DO  Alkalinity  Nitrates  Sulphates  Phosphates <br><br>";

$q = $db->query("SELECT site_id,Date,pH,Conductivity,DO,Alkalinity,Nitrates,Sulphates,Phosphates FROM chemical_data where Date>='2020-01-01'");

while ($row = $q->fetch()) {
    print "$row[site_id] $row[Date] $row[pH] $row[Conductivity] $row[DO], $row[Alkalinity] $row[Nittrates] $row[Sulphates] $row[Phosphates]<br>";
}

?>

</body>
</html>
