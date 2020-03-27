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
 $yr = $_POST["year"];
 $mo = $_POST["month"];
 $dt = $yr."-".$mo."-01";

 if($mo == '01'){$mon = 'January';}
 if($mo == '02'){$mon = 'February';}
 if($mo == '03'){$mon = 'March';}
 if($mo == '04'){$mon = 'April';}
 if($mo == '05'){$mon = 'May';}
 if($mo == '06'){$mon = 'June';}
 if($mo == '07'){$mon = 'July';}
 if($mo == '08'){$mon = 'August';}
 if($mo == '09'){$mon = 'September';}
 if($mo == '10'){$mon = 'October';}
 if($mo == '11'){$mon = 'November';}
 if($mo == '12'){$mon = 'December';}
 print "<table border='1'>";
 print "<caption><b>Stream Report for $mon $yr</b></caption>";
 print "<caption>Values in yellow are marginally out of normal range</caption>";
 print "<caption>Values in orange are out of normal range</caption>";
    print "<tr>";
        print "<th>Site ID</th>";
        print "<th>Date</th>";
        print "<th>pH</th>";
        print "<th>Conductivity</th>";
        print "<th>DO</th>";
        print "<th>Alkalinity</th>";
        print "<th>Nitrates</th>";
        print "<th>Sulphates</th>";
        print "<th>Phosphates</th>";
    print "</tr>";

$q = $db->query("SELECT site_id,Date,pH,Conductivity,DO as Oxy,Alkalinity,Nitrates,Sulphates,Phosphates FROM chemical_data where Date>='$dt' and Date<DATE_ADD('$dt',INTERVAL 1 MONTH) order by Date");
while ($row = $q->fetch()) {
    print "<tr>";
        print "<td>$row[site_id]</td>";
        print "<td>$row[Date]</td>";
        if ($row[pH] < 6 or $row[pH] > 9) {print "<td style='background-color: orange'>$row[pH]</td>";} else {print "<td>$row[pH]</td>";} 
        if ($row[Conductivity] < 150 or $row[Conductivity] > 500 ) {print "<td style='background-color: orange'>$row[Conductivity]</td>";} else {print "<td>$row[Conductivity]</td>";} 
        if ($row[Oxy] < 5 ) {print "<td style='background-color: orange'>$row[Oxy]</td>";} else {print "<td>$row[Oxy]</td>";} 
        if ($row[Alkalinity] > 400 ) {print "<td style='background-color: orange'>$row[Alkalinity]</td>";} else {print "<td>$row[Alkalinity]</td>";} 
        if ($row[Nitrates] > 4.4 ) {print "<td style='background-color: orange'>$row[Nitrates]</td>";} else {print "<td>$row[Nitrates]</td>";} 
        if ($row[Sulphates] > 250 ) {print "<td style='background-color: orange'>$row[Sulphates]</td>";} else {print "<td>$row[Sulphates]</td>";} 
        if ($row[Phosphates] > 0.03 and $row[Phosphates] < 0.3 ) {print "<td style='background-color: yellow'>$row[Phosphates]</td>";
        } else if ($row[Phosphates] > 0.3){
           print "<td style='background-color: orange'>$row[Phosphates]</td>";
        } else {
           print "<td>$row[Phosphates]</td>"; 
        }
    print "</tr>";
}
 print "</table>";
?>

<br>
<a href="http://wx2dx.net/ccpasec/php/report_form.php">Return to Request Form</a>

</body>
</html>
