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
        print "<th>Date</th>";
        print "<th>Location</th>";
        print "<th>Stream</th>";
        print "<th>Team</th>";
        print "<th>pH</th>";
        print "<th>Conductivity</th>";
        print "<th>DO</th>";
        print "<th>Alkalinity</th>";
        print "<th>Nitrates</th>";
        print "<th>Sulphates</th>";
        print "<th>Phosphates</th>";
    print "</tr>";

$q = $db->query("SELECT Date,Location,Stream,Team,pH,Conductivity,DO as Oxy,Alkalinity,Nitrates,Sulphates,Phosphates FROM sites,chemical_data where site_id=ID and Date>='$dt' and Date<DATE_ADD('$dt',INTERVAL 1 MONTH) order by Date,Team");
while ($row = $q->fetch()) {
    print "<tr>";
        print "<td>$row[Date]</td>";
        print "<td>$row[Location]</td>";
        print "<td>$row[Stream]</td>";
        print "<td>$row[Team]</td>";
        if ($row[pH] < 6 or $row[pH] > 9) {print "<td style='background-color: orange'>$row[pH]</td>";} else {print "<td style='background-color: lightgreen'>$row[pH]</td>";} 
        if ($row[Conductivity] < 150 or $row[Conductivity] > 500 ) {print "<td style='background-color: orange'>$row[Conductivity]</td>";} else {print "<td style='background-color: lightgreen'>$row[Conductivity]</td>";} 
        if ($row[Oxy] < 5 and $row[Oxy] > 0 ) {print "<td style='background-color: orange'>$row[Oxy]</td>";} else if($row[Oxy] >=5){print "<td style='background-color: lightgreen'>$row[Oxy]</td>";} else {print "<td>$row[Oxy]</td>";}
        if ($row[Alkalinity] > 400 ) {print "<td style='background-color: orange'>$row[Alkalinity]</td>";} else {print "<td style='background-color: lightgreen'>$row[Alkalinity]</td>";} 
        if ($row[Nitrates] > 4.4 ) {print "<td style='background-color: orange'>$row[Nitrates]</td>";} else if($row[Nitrates] <= 4.4 and $row[Nitrates] > 0){print "<td style='background-color: lightgreen'>$row[Nitrates]</td>";} else {print "<td>$row[Nitrates]</td>";} 
        if ($row[Sulphates] > 250 ) {print "<td style='background-color: orange'>$row[Sulphates]</td>";} else if($row[Sulphates] <=250 and $row[Sulphates] > 0){print "<td style='background-color: lightgreen'>$row[Sulphates]</td>";} else {print "<td>$row[Sulphates]</td>";} 
        if ($row[Phosphates] > 0.03 and $row[Phosphates] <= 0.3 ) {print "<td style='background-color: yellow'>$row[Phosphates]</td>";
        } else if ($row[Phosphates] > 0.3){
           print "<td style='background-color: orange'>$row[Phosphates]</td>";
        } else if ($row[Phosphates] > 0 and $row[Phosphates] <= 0.03){
           print "<td style='background-color: lightgreen'>$row[Phosphates]</td>";
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
