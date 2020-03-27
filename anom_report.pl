#!/usr/bin/perl -w
#
use DBI;
use strict;

my $report_file='/home/wx2dxnet/stream_data/anomaly.txt';

my @report_data;
my $sth;

my $DB_database='wx2dxnet_CCPaSEC';
my $DB_username='wx2dxnet_WES';
my $DB_password='ccpasec42';

open( FILE, ">$report_file")
    or
        die(Failed to open file $report_file);

printf FILE "\n2019-2020 Stream Data Anomaly Report\n\n";

my $dbh=DBI->connect(
    "DBI:mysql:database=$DB_database",
    "$DB_username","$DB_password")
or
    die("Failed to connect to the database ".
        "(error number $DBI::err): $DBI::errstr\n");

my $Query = "select sites.Location,sites.team,Date,pH,sites.Stream from sites,chemical_data where
    sites.ID = chemical_data.site_id and Date > '2019-12-31' and (pH < 6 or pH > 9 )";
$sth = $dbh->prepare($Query)
    or
        die "Could not prepare pH query: " . $sth->errstr;

$sth->execute()
    or
        die "Could not execute pH query: " . $sth->errstr;

printf FILE "\n\npH values less than 6 or greater than 9\n\n";

if( $sth->rows != 0) {
    printf FILE "\tpH        Date    Team      Location                  Stream\n\n"; }

while( @report_data = $sth->fetchrow_array() ){

    my $Loc=$report_data[0];
    my $Team=$report_data[1];
    my $Date=$report_data[2];
    my $param=$report_data[3];
    my $stream=$report_data[4];

    printf FILE "\t%5.2f  %8s  %2d  %20s %20s\n",$param,$Date,$Team,$Loc,$stream;

}

if( $sth->rows == 0) {
    printf FILE "No pH anomalies were found.\n"; }

$sth->finish;

$Query = "select sites.Location,sites.team,Date,DO,sites.Stream from sites,chemical_data where
    sites.ID = chemical_data.site_id and Date>'2019-12-31' and DO<5";
$sth = $dbh->prepare($Query)
    or
        die "Could not prepare DO query: " . $sth->errstr;

$sth->execute()
    or
        die "Could not execute DO query: " . $sth->errstr;

printf FILE "\n\nDissolved oxygen values less than 5\n\n";

if( $sth->rows != 0) {
    printf FILE "\tDO        Date    Team      Location                  Stream\n\n"; }

while( @report_data = $sth->fetchrow_array() ){

    my $Loc=$report_data[0];
    my $Team=$report_data[1];
    my $Date=$report_data[2];
    my $param=$report_data[3];
    my $stream=$report_data[4];

    printf FILE "\t%5.2f  %8s  %2d  %20s %20s\n",$param,$Date,$Team,$Loc,$stream;

}

if( $sth->rows == 0) {
    printf FILE "No dissolved oxygen anomalies were found.\n"; }

$sth->finish;

$Query = "select sites.Location,sites.team,Date,Conductivity,sites.Stream from sites,chemical_data where
    sites.ID = chemical_data.site_id and Date>'2019-12-31' and (Conductivity<150 or Conductivity>500)";
$sth = $dbh->prepare($Query)
    or
        die "Could not prepare Conductivity query: " . $sth->errstr;

$sth->execute()
    or
        die "Could not execute Conductivity query: " . $sth->errstr;

printf FILE "\n\nConductivity values less than 150 or greater than 500\n\n";

if( $sth->rows != 0) {  
    printf FILE "\tCond      Date    Team      Location                  Stream\n\n"; }

while( @report_data = $sth->fetchrow_array() ){

    my $Loc=$report_data[0];
    my $Team=$report_data[1];
    my $Date=$report_data[2];
    my $param=$report_data[3];
    my $stream=$report_data[4];

    printf FILE "\t%5d  %8s  %2d  %20s %20s\n",$param,$Date,$Team,$Loc,$stream;

}

if( $sth->rows == 0) {
    printf FILE "No conductivity anomalies were found.\n"; }

$sth->finish;

$Query = "select sites.Location,sites.team,Date,Alkalinity,sites.Stream from sites,chemical_data where
    sites.ID = chemical_data.site_id and Date>'2019-12-31' and Alkalinity > 400";
$sth = $dbh->prepare($Query)
    or
        die "Could not prepare Alkalinity query: " . $sth->errstr;

$sth->execute()
    or
        die "Could not execute Alkalinity query: " . $sth->errstr;

printf FILE "\n\nAlkalinity values greater than 400\n\n";

if( $sth->rows != 0) {  
    printf FILE "\tAlk       Date    Team      Location                  Stream\n\n"; }

while( @report_data = $sth->fetchrow_array() ){

    my $Loc=$report_data[0];
    my $Team=$report_data[1];
    my $Date=$report_data[2];
    my $param=$report_data[3];
    my $stream=$report_data[4];

    printf FILE "\t%5d  %8s  %2d  %20s %20s\n",$param,$Date,$Team,$Loc,$stream;

}

if( $sth->rows == 0) {
    printf FILE "No alkalinity anomalies were found.\n"; }

$sth->finish;

$Query = "select sites.Location,sites.team,Date,Nitrates,sites.Stream from sites,chemical_data where
    sites.ID = chemical_data.site_id and Date>'2019-12-31' and Nitrates > 4.4";
$sth = $dbh->prepare($Query)
    or
        die "Could not prepare Nitrate query: " . $sth->errstr;

$sth->execute()
    or
        die "Could not execute Nitrate query: " . $sth->errstr;

printf FILE "\n\nNitrate values greater than 4.4\n\n";

if( $sth->rows != 0) {  
    printf FILE "\tNitr      Date    Team      Location                  Stream\n\n"; }

while( @report_data = $sth->fetchrow_array() ){

    my $Loc=$report_data[0];
    my $Team=$report_data[1];
    my $Date=$report_data[2];
    my $param=$report_data[3];
    my $stream=$report_data[4];

    printf FILE "\t%5.2f  %8s  %2d  %20s %20s\n",$param,$Date,$Team,$Loc,$stream;

}

if( $sth->rows == 0) {
    printf FILE "No nitrate anomalies were found.\n"; }

$sth->finish;

$Query = "select sites.Location,sites.team,Date,Sulphates,sites.Stream from sites,chemical_data where
    sites.ID = chemical_data.site_id and Date>'2019-12-31' and Sulphates > 250";
$sth = $dbh->prepare($Query)
    or
        die "Could not prepare Sulphate query: " . $sth->errstr;

$sth->execute()
    or
        die "Could not execute Sulphate query: " . $sth->errstr;

printf FILE "\n\nSulphate values greater than 250\n\n";

if( $sth->rows != 0) {  
    printf FILE "\tSulph     Date    Team      Location                  Stream\n\n"; }

while( @report_data = $sth->fetchrow_array() ){

    my $Loc=$report_data[0];
    my $Team=$report_data[1];
    my $Date=$report_data[2];
    my $param=$report_data[3];
    my $stream=$report_data[4];

    printf FILE "\t%5.2f  %8s  %2d  %20s %20s\n",$param,$Date,$Team,$Loc,$stream;

}

if( $sth->rows == 0) {
    printf FILE "No sulphate anomalies were found.\n"; }

$sth->finish;

$Query = "select sites.Location,sites.team,Date,Phosphates,sites.stream from sites,chemical_data where
    sites.ID = chemical_data.site_id and Date>'2019-12-31' and Phosphates > 0.30";
#   sites.ID = chemical_data.site_id and Date>'2019-12-31' and Phosphates > 0.03";
$sth = $dbh->prepare($Query)
    or
        die "Could not prepare Phosphate query: " . $sth->errstr;

$sth->execute()
    or
        die "Could not execute Phosphate query: " . $sth->errstr;

#printf FILE "\n\nPhosphate values greater than 0.03\n\n";
printf FILE "\n\nPhosphate values greater than 0.30\n\n";

if( $sth->rows != 0) {  
    printf FILE "\tPhos      Date    Team      Location                  Stream\n\n"; }

while( @report_data = $sth->fetchrow_array() ){

    my $Loc=$report_data[0];
    my $Team=$report_data[1];
    my $Date=$report_data[2];
    my $param=$report_data[3];
    my $stream=$report_data[4];

    printf FILE "\t%5.2f  %8s  %2d  %20s %20s\n",$param,$Date,$Team,$Loc,$stream;

}

if( $sth->rows == 0) {
    printf FILE "No phosphate anomalies were found.\n"; }

$sth->finish;

$dbh->disconnect;

close FILE;
