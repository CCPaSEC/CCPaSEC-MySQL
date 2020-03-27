#!/usr/bin/perl -w
#
use DBI;
use strict;

my $stream_data_file='/home/wx2dxnet/stream_data/Import1024.csv';

my $DB_database='wx2dxnet_CCPaSEC';
my $DB_username='wx2dxnet_WES';
my $DB_password='ccpasec42';

open( FILE, "<$stream_data_file")
    or
        die(Failed to open file $stream_data_file);

my $dbh=DBI->connect(
    "DBI:mysql:database=$DB_database",
    "$DB_username","$DB_password")
or
    die("Failed to connect to the database ".
        "(error number $DBI::err): $DBI::errstr\n");

while(<FILE>) {
    chomp($_);
    my @stream_data=split(",",$_);
    my $id = $stream_data[0];
    my $date = $stream_data[1];
    my $pH = $stream_data[2];
    my $cond = $stream_data[3];
    my $do = $stream_data[4];
    my $alk = $stream_data[5];
    my $nit = $stream_data[6];
    my $sul = $stream_data[7];
    my $pho = $stream_data[8];

    my $Query = "INSERT INTO chemical_data
       (site_id, Date, pH, Conductivity, DO, Alkalinity, Nitrates, Sulphates, Phosphates) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    my $sth = $dbh->prepare($Query);
    $sth->execute($id,$date,$pH,$cond,$do,$alk,$nit,$sul,$pho);
}

$dbh->disconnect();

close FILE;
