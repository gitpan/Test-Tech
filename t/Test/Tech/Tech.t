#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE $FILE);
$VERSION = '0.15';   # automatically generated file
$DATE = '2004/04/07';
$FILE = __FILE__;

use Getopt::Long;
use Cwd;
use File::Spec;

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
   use vars qw( $__restore_dir__ @__restore_inc__);

   ########
   # Working directory is that of the script file
   #
   $__restore_dir__ = cwd();
   my ($vol, $dirs) = File::Spec->splitpath(__FILE__);
   chdir $vol if $vol;
   chdir $dirs if $dirs;
   ($vol, $dirs) = File::Spec->splitpath(cwd(), 'nofile'); # absolutify

   #######
   # Add the library of the unit under test (UUT) to @INC
   # It will be found first because it is first in the include path
   #
   require File::TestPath;
   @__restore_inc__ = File::TestPath->test_lib2inc();

   ##########
   # Pick up a output redirection file and tests to skip
   # from the command line.
   #
   my $test_log = '';
   GetOptions('log=s' => \$test_log);

   ########
   # Using Test::Tech, a very light layer over the module "Test" to
   # conduct the tests.  The big feature of the "Test::Tech: module
   # is that it takes a expected and actual reference and stringify
   # them by using "Data::Dumper" before passing them to the "ok"
   # in test.
   #
   # Create the test plan by supplying the number of tests
   # and the todo tests
   #
   require Test::Tech;
   Test::Tech->import( qw(plan ok skip skip_tests tech_config finish) );
   plan(tests => 11);

}



END {

   #########
   # Restore working directory and @INC back to when enter script
   #
   @INC = @__restore_inc__;
   chdir $__restore_dir__;
}

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
     " Run test script techA0.t using Test 1.15");

#  ok:  2

   # Perl code from C:
    $actual_results = `perl techB0.t`;
    $snl->fout('tech1.txt', $actual_results);

ok(  $s->scrub_probe($s->scrub_file_line($actual_results)), # actual results
     $s->scrub_probe($s->scrub_file_line($snl->fin('techA2.txt'))), # expected results
     "",
     " Run test script techB0.t using Test 1.24");

#  ok:  3

   # Perl code from C:
    $actual_results = `perl techC0.t`;
    $snl->fout('tech1.txt', $actual_results);

ok(  $s->scrub_probe($s->scrub_file_line($actual_results)), # actual results
     $s->scrub_probe($s->scrub_file_line($snl->fin('techC2.txt'))), # expected results
     "",
     " Run test script techC0.t using Test 1.24");

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

ok(  $s->scrub_probe($s->scrub_file_line($actual_results)), # actual results
     $s->scrub_probe($s->scrub_file_line($expected_results)), # expected results
     "",
     " Run demo script techD0.d");

#  ok:  5

   # Perl code from C:
    $actual_results = `perl techE0.t`;
    $snl->fout('tech1.txt', $actual_results);

ok(  $s->scrub_probe($s->scrub_file_line($actual_results)), # actual results
     $s->scrub_probe($s->scrub_file_line($snl->fin('techE2.txt'))), # expected results
     "",
     " Run test script techE0.t using Test 1.24");

#  ok:  6

   # Perl code from C:
my $tech = new Test::Tech;

ok(  $tech->tech_config('Test.TestLevel'), # actual results
     1, # expected results
     "",
     "config Test.TestLevel, read 1");

#  ok:  7

ok(  $tech->tech_config('Test.TestLevel', 2), # actual results
     1, # expected results
     "",
     "config Test.TestLevel, read 1, write 2");

#  ok:  8

ok(  $tech->tech_config('Test.TestLevel'), # actual results
     2, # expected results
     "",
     "config Test.TestLevel, read 2");

#  ok:  9

ok(  $Test::TestLevel, # actual results
     2, # expected results
     "",
     "Test::TestLevel read 2");

#  ok:  10

   # Perl code from C:
$tech->finish( );

ok(  $Test::TestLevel, # actual results
     1, # expected results
     "",
     "retore Test::TestLevel on finish");

#  ok:  11


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

