#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE $FILE);
$VERSION = '0.2';   # automatically generated file
$DATE = '2004/05/11';
$FILE = __FILE__;


##### Test Script ####
#
# Name: Tech.t
#
# UUT: Test::Tech
#
# The module Test::STDmaker generated this test script from the contents of
#
# t::Test::Tech::Tech;
#
# Don't edit this test script file, edit instead
#
# t::Test::Tech::Tech;
#
#	ANY CHANGES MADE HERE TO THIS SCRIPT FILE WILL BE LOST
#
#       the next time Test::STDmaker generates this script file.
#
#

######
#
# T:
#
# use a BEGIN block so we print our plan before Module Under Test is loaded
#
BEGIN { 

   use FindBin;
   use File::Spec;
   use Cwd;

   ########
   # The working directory for this script file is the directory where
   # the test script resides. Thus, any relative files written or read
   # by this test script are located relative to this test script.
   #
   use vars qw( $__restore_dir__ );
   $__restore_dir__ = cwd();
   my ($vol, $dirs) = File::Spec->splitpath($FindBin::Bin,'nofile');
   chdir $vol if $vol;
   chdir $dirs if $dirs;

   #######
   # Pick up any testing program modules off this test script.
   #
   # When testing on a target site before installation, place any test
   # program modules that should not be installed in the same directory
   # as this test script. Likewise, when testing on a host with a @INC
   # restricted to just raw Perl distribution, place any test program
   # modules in the same directory as this test script.
   #
   use lib $FindBin::Bin;

   ########
   # Using Test::Tech, a very light layer over the module "Test" to
   # conduct the tests.  The big feature of the "Test::Tech: module
   # is that it takes expected and actual references and stringify
   # them by using "Data::Secs2" before passing them to the "&Test::ok"
   # Thus, almost any time of Perl data structures may be
   # compared by passing a reference to them to Test::Tech::ok
   #
   # Create the test plan by supplying the number of tests
   # and the todo tests
   #
   require Test::Tech;
   Test::Tech->import( qw(finish is_skip ok plan skip skip_tests tech_config) );
   plan(tests => 11);

}


END {
 
   #########
   # Restore working directory and @INC back to when enter script
   #
   @INC = @lib::ORIG_INC;
   chdir $__restore_dir__;
}


=head1 comment_out

###
# Have been problems with debugger with trapping CARP
#

####
# Poor man's eval where the test script traps off the Carp::croak 
# Carp::confess functions.
#
# The Perl authorities have Core::die locked down tight so
# it is next to impossible to trap off of Core::die. Lucky 
# must everyone uses Carp to die instead of just dieing.
#
use Carp;
use vars qw($restore_croak $croak_die_error $restore_confess $confess_die_error);
$restore_croak = \&Carp::croak;
$croak_die_error = '';
$restore_confess = \&Carp::confess;
$confess_die_error = '';
no warnings;
*Carp::croak = sub {
   $croak_die_error = '# Test Script Croak. ' . (join '', @_);
   $croak_die_error .= Carp::longmess (join '', @_);
   $croak_die_error =~ s/\n/\n#/g;
       goto CARP_DIE; # once croak can not continue
};
*Carp::confess = sub {
   $confess_die_error = '# Test Script Confess. ' . (join '', @_);
   $confess_die_error .= Carp::longmess (join '', @_);
   $confess_die_error =~ s/\n/\n#/g;
       goto CARP_DIE; # once confess can not continue

};
use warnings;
=cut


   # Perl code from C:
    use File::Spec;

    use File::Package;
    my $fp = 'File::Package';

    use Text::Scrub;
    my $s = 'Text::Scrub';

    use File::SmartNL;
    my $snl = 'File::SmartNL';

    my $uut = 'Test::Tech';

skip_tests( 1 ) unless ok(
      $fp->is_package_loaded($uut), # actual results
      '1', # expected results
      "",
      "UUT loaded"); 

#  ok:  1

   # Perl code from C:
    my $actual_results = `perl techA0.t`;
    $snl->fout('tech1.txt', $actual_results);

ok(  $s->scrub_probe($s->scrub_file_line($actual_results)), # actual results
     $s->scrub_probe($s->scrub_file_line($snl->fin('techA2.txt'))), # expected results
     "",
     "Run test script techA0.t using Test 1.15");

#  ok:  2

   # Perl code from C:
    $actual_results = `perl techB0.t`;
    $snl->fout('tech1.txt', $actual_results);

ok(  $s->scrub_probe($s->scrub_file_line($actual_results)), # actual results
     $s->scrub_probe($s->scrub_file_line($snl->fin('techA2.txt'))), # expected results
     "",
     "Run test script techB0.t using Test 1.24");

#  ok:  3

   # Perl code from C:
    $actual_results = `perl techC0.t`;
    $snl->fout('tech1.txt', $actual_results);

ok(  $s->scrub_probe($s->scrub_file_line($actual_results)), # actual results
     $s->scrub_probe($s->scrub_file_line($snl->fin('techC2.txt'))), # expected results
     "",
     "Run test script techC0.t using Test 1.24");

#  ok:  4

   # Perl code from C:
    use Data::Dumper;
    my $probe = 3;
    $actual_results = Dumper([0+$probe]);
    my $internal_storage = 'undetermine';
    if( $actual_results eq Dumper([3]) ) {
        $internal_storage = 'number';
    }
    elsif ( $actual_results eq Dumper(['3']) ) {
        $internal_storage = 'string';
    }

    $actual_results = `perl techD0.d`;
    $snl->fout('tech1.txt', $actual_results);

    #######
    # expected results depend upon the internal storage from numbers 
    #
    my $expected_results;
    if( $internal_storage eq 'string') {
        $expected_results = $snl->fin('techD2.txt');
    }
    else {
        $expected_results = $snl->fin('techD3.txt');
    };

   # Perl code from C:
    $actual_results = `perl techE0.t`;
    $snl->fout('tech1.txt', $actual_results);

ok(  $s->scrub_probe($s->scrub_file_line($actual_results)), # actual results
     $s->scrub_probe($s->scrub_file_line($snl->fin('techE2.txt'))), # expected results
     "",
     "Run test script techE0.t using Test 1.24");

#  ok:  5

   # Perl code from C:
    $actual_results = `perl techF0.t`;
    $snl->fout('tech1.txt', $actual_results);

ok(  $s->scrub_probe($s->scrub_file_line($actual_results)), # actual results
     $s->scrub_probe($s->scrub_file_line($snl->fin('techF2.txt'))), # expected results
     "",
     "Run test script techF0.t using Test 1.24");

#  ok:  6

   # Perl code from C:
my $tech = new Test::Tech;

ok(  $tech->tech_config('Test.ONFAIL'), # actual results
     undef, # expected results
     "",
     "config Test.ONFAIL, read undef");

#  ok:  7

ok(  $tech->tech_config('Test.ONFAIL',0), # actual results
     undef, # expected results
     "",
     "config Test.ONFAIL, read undef, write 0");

#  ok:  8

ok(  $tech->tech_config('Test.ONFAIL'), # actual results
     0, # expected results
     "",
     "config Test.ONFAIL, read 0");

#  ok:  9

ok(  $Test::ONFAIL, # actual results
     0, # expected results
     "",
     "$Test::ONFAIL, read 0");

#  ok:  10

   # Perl code from C:
     $tech->finish( );
     $Test::planned = 1;  # keep going;

ok(  $tech->tech_config('Test.ONFAIL'), # actual results
     undef, # expected results
     "",
     "Test.ONFAIL restored by finish()");

#  ok:  11

   # Perl code from C:
unlink 'tech1.txt';

   # Perl code from C:
unlink 'tech1.txt';


=head1 comment out

# does not work with debugger
CARP_DIE:
    if ($croak_die_error || $confess_die_error) {
        print $Test::TESTOUT = "not ok $Test::ntest\n";
        $Test::ntest++;
        print $Test::TESTERR $croak_die_error . $confess_die_error;
        $croak_die_error = '';
        $confess_die_error = '';
        skip_tests(1, 'Test invalid because of Carp die.');
    }
    no warnings;
    *Carp::croak = $restore_croak;    
    *Carp::confess = $restore_confess;
    use warnings;
=cut

    finish();

__END__

=head1 NAME

Tech.t - test script for Test::Tech

=head1 SYNOPSIS

 Tech.t -log=I<string>

=head1 OPTIONS

All options may be abbreviated with enough leading characters
to distinguish it from the other options.

=over 4

=item C<-log>

Tech.t uses this option to redirect the test results 
from the standard output to a log file.

=back

=head1 COPYRIGHT

copyright © 2003 Software Diamonds.

Software Diamonds permits the redistribution
and use in source and binary forms, with or
without modification, provided that the 
following conditions are met: 

=over 4

=item 1

Redistributions of source code, modified or unmodified
must retain the above copyright notice, this list of
conditions and the following disclaimer. 

=item 2

Redistributions in binary form must 
reproduce the above copyright notice,
this list of conditions and the following 
disclaimer in the documentation and/or
other materials provided with the
distribution.

=back

SOFTWARE DIAMONDS, http://www.SoftwareDiamonds.com,
PROVIDES THIS SOFTWARE 
'AS IS' AND ANY EXPRESS OR IMPLIED WARRANTIES,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
SHALL SOFTWARE DIAMONDS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL,EXEMPLARY, OR 
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE,DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING USE OF THIS SOFTWARE, EVEN IF
ADVISED OF NEGLIGENCE OR OTHERWISE) ARISING IN
ANY WAY OUT OF THE POSSIBILITY OF SUCH DAMAGE.

=cut

## end of test script file ##

