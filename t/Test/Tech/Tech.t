#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.06';
$DATE = '2003/06/19';

use Cwd;
use File::Spec;
use File::FileUtil;
use Test;

######
#
# T:
#
# use a BEGIN block so we print our plan before Module Under Test is loaded
#
BEGIN { 
   use vars qw( $T $__restore_dir__ @__restore_inc__ $__tests__);
   ########
   # Working directory is that of the script file
   #
   $__restore_dir__ = cwd();
   my ($vol, $dirs, undef) = File::Spec->splitpath( $0 );
   chdir $vol if $vol;
   chdir $dirs if $dirs;

   #######
   # Add the library of the unit under test (UUT) to @INC
   #
   @__restore_inc__ = File::FileUtil->test_lib2inc;
   unshift @INC, cwd();

   ########
   # Create the test plan by supplying the number of tests
   # and the todo tests
   #
   require Test;
   $__tests__ = 8;
   &Test::plan(tests => $__tests__);

}

END {

    #########
    # Restore working directory and @INC back to when enter script
    #
    @INC = @__restore_inc__;
    chdir $__restore_dir__;
}

    #### 
    # File Legend
    # 
    #  0 - series is used to generate an test case test script
    #
    #  1 - this is the actual value test case
    #      thus, TestGen1 is used to produce actual test results
    #
    #  2 and above - these series are the expected test results
    # 
    #

#####
# Clean up directory
#
unlink 'tech1.txt';

########
# Probe Perl for internal storage method
#
use Data::Dumper;
my $probe = 3;
my $actual = Dumper([0+$probe]);
my $internal_storage = 'undetermine';
if( $actual eq Dumper([3]) ) {
    $internal_storage = 'number';
}
elsif ( $actual eq Dumper(['3']) ) {
    $internal_storage = 'string';
}

#####
# New $fu object
#
my $fu = 'File::FileUtil';

#######
#
# ok: 1 
#
# R:
#
my $loaded;
print "# is_package_loaded\n";
ok ($loaded = $fu->is_package_loaded('Test::Tech'), ''); 

#######
# 
# ok:  2
#
# R:
# 
print "# load_package\n";
my $errors = $fu->load_package( 'Test::Tech' );
skip($loaded, $errors, '');
skip_rest( $errors, 2 );

#######
#
# ok:  3
#
# R:
#
print "# Pod_pod_errors\n";
ok( $fu->pod_errors( 'Test::Tech'), 0 );

#####
# New $scrub object
#
use Test::STD::Scrub;
my $s = 'Test::STD::Scrub';

#####
#  ok:  4
# 
# R:
#
# Run test script test techA0.t
#
print "# Run test script techA0.t\n";

my $actual_results = `perl techA0.t`;
$fu->fout('tech1.txt', $actual_results);
$actual_results = $s->scrub_probe($s->scrub_file_line($actual_results));

my $expected_results = $fu->fin('techA2.txt');
$expected_results = $s->scrub_probe($s->scrub_file_line($expected_results));

ok( $actual_results . "\n\n" . $fu->hex_dump($actual_results), 
    $expected_results . "\n\n" . $fu->hex_dump($expected_results) ); 

#####
#  ok:  5
# 
# R:
#
# Run test script test techB0.t
#
print "# Run test script techB0.t\n";

$actual_results = `perl techB0.t`;
$fu->fout('tech1.txt', $actual_results);
$actual_results = $s->scrub_probe($s->scrub_file_line($actual_results));

$expected_results = $fu->fin('techA2.txt');
$expected_results = $s->scrub_probe($s->scrub_file_line($expected_results));

ok( $actual_results . "\n\n" . $fu->hex_dump($actual_results), 
    $expected_results . "\n\n" . $fu->hex_dump($expected_results) ); 


#####
#  ok:  6
# 
# Run test script test techC0.t
#
# R:
#
print "# Run test script techC0.t\n";

$actual_results = `perl techC0.t`;
$fu->fout('tech1.txt', $actual_results);
$actual_results = $s->scrub_probe($s->scrub_file_line($actual_results));

$expected_results = $fu->fin('techA2.txt');
$expected_results = $s->scrub_probe($s->scrub_file_line($expected_results));

ok( $actual_results . "\n\n" . $fu->hex_dump($actual_results), 
    $expected_results . "\n\n" . $fu->hex_dump($expected_results) ); 


#####
#  ok:  7
# 
# Run test script test techD0.t
#
# R:
#
print "# Run test script techD0.t\n";

$actual_results = `perl techD0.t`;
$fu->fout('tech1.txt', $actual_results);
$actual_results = $s->scrub_probe($s->scrub_file_line($actual_results));

#######
# expected results depend upon the internal storage from numbers 
#
if( $internal_storage eq 'string') {
    $expected_results = $fu->fin('techD2.txt');
}
else {
    $expected_results = $fu->fin('techD3.txt');
}

$expected_results = $s->scrub_probe($s->scrub_file_line($expected_results));
ok( $actual_results . "\n\n" . $fu->hex_dump($actual_results), 
    $expected_results . "\n\n" . $fu->hex_dump($expected_results) ); 

#####
#  ok:  8
# 
# Run demo script techE0.d
#
# R:
#
print "# Run demo script techE0.d\n";

$actual_results = `perl techE0.d`;
$fu->fout('tech1.txt', $actual_results);
$actual_results = $s->scrub_probe($s->scrub_file_line($actual_results));

#######
# expected results depend upon the internal storage from numbers 
#
if( $internal_storage eq 'string') {
    $expected_results = $fu->fin('techE2.txt');
}
else {
    $expected_results = $fu->fin('techE3.txt');
}

$expected_results = $s->scrub_probe($s->scrub_file_line($expected_results));
ok( $actual_results . "\n\n" . $fu->hex_dump($actual_results), 
    $expected_results . "\n\n" . $fu->hex_dump($expected_results) ); 


#####
# Clean up directory
#
unlink 'tech1.txt';



####
# 
# Support:
#
#

sub skip_rest
{
    my ($results, $test_num) = @_;
    if( $results ) {
        for (my $i=$test_num; $i < $__tests__; $i++) { skip(1,0,0) };
        exit 1;
    }
}


__END__


if( $internal_storage eq 'string' ) {

####
#  ok:  4
# 
# RUn demonstration script test case 

$test_results = `perl tech0.d`;
Test::TestUtil->fout('tech1.txt', $test_results);

$expected_results = Test::TestUtil->fin('tech2.txt');
print "# Demonstration script\n";
test( [$test_results, hex_dump($test_results)], 
      [$expected_results, hex_dump($expected_results)] ); # expected results

}
else {

    #####
    #  ok:  5
    # 
    # Run test script test case 
    #
    $test_results = `perl tech0.t`;
    Test::TestUtil->fout('tech1.txt', $test_results);
    $test_results = scrub_probe(Test::TestUtil->scrub_file_line($test_results));
    $test_results .= hex_dump($test_results);

    $expected_results = scrub_probe(Test::TestUtil->scrub_file_line(Test::TestUtil->fin('tech5.txt')));
    $expected_results .= hex_dump($expected_results);

    print "# Run test script\n";
    ok( $test_results, $expected_results); # expected results


}

=head1 NAME

tech.t - test script for Test::tech

=head1 SYNOPSIS

 tech.t 

=head1 NOTES

=head2 Copyright

copyright © 2003 Software Diamonds.

head2 License

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

