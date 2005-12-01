#!/usr/bin/perl -w
#
#	$Id$
#	$Author$
#

# Auto-detect the path for libraries and the FreeMED install
use FindBin;
use lib "$FindBin::Bin/../lib/perl";
my $rootpath = "$FindBin::Bin/..";

use XML::RAX;

my $file = shift or die("$0 inputfile > outputfile");

my $h = new XML::RAX();
$h->openfile($file);

# Print header ... for now, we fake most of it
$h->setRecord('information');
my $headers = $h->readRecord();
print "# This file is automatically generated by GettextXML utilities\n";
print "#\n";
print "msgid \"\"\n";
print "msgstr \"\"\n";
print "\"MIME-Version: 1.0\\n\"\n";
print "\n";

# Translate records
my $r = new XML::RAX();
$r->openfile($file);
$r->setRecord('translation');
while (my $rec = $r->readRecord()) {
	if ($rec->getField('original') =~ /\n/) {
		my @lines = split(/\n/, $rec->getField('original'));
		print "msgid \"\"\n";
		foreach my $line (@lines) {
			print "\"".$line."\"\n";
		}
	} else {
		print "msgid \"".$rec->getField('original')."\"\n";
	}
	if ($rec->getField('translated') =~ /\n/) {
		my @lines = split(/\n/, $rec->getField('translated'));
		print "msgstr \"\"\n";
		foreach my $line (@lines) {
			print "\"".$line."\"\n";
		}
	} else {
		print "msgstr \"".$rec->getField('translated')."\"\n";
	}
	print "\n";
}

