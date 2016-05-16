#! /usr/bin/env perl


use Getopt::Std;

my %opts;
getopts('r', \%opts);

my $reverse = $opts{r};

my @things = <>;

# get rid of line ends
for (@things) {
    $_ =~ s/[\r\n]*$//;
}


print join ("\n", sort byParts @things);


sub byParts {
    my $left = $reverse ? $b : $a;
    my $right = $reverse ? $a : $b;
    my @Aparts = split(/[-.]+/, $left);
    my @Bparts = split(/[-.]+/, $right);
    my $Aparts = $#Aparts;
    my $Bparts = $#Bparts;
    my $maxparts = $Bparts > $Aparts ? $Bparts : $Aparts;
    my $cmp = 0;
    for (0..$maxparts) {
	my ($A,$B) = ($Aparts[$_],$Bparts[$_]);
	defined $A || return -1;
	defined $B || return 1;
	if ("$A$B" =~ m/^\d+$/) {  # both are numbers
	    $cmp = ($A <=> $B);
	    next if $cmp == 0;
	}
	else {
	    $cmp = ($A cmp $B);
	    next if $cmp == 0;
	}
	return $cmp;
    }
    return $cmp;
}

