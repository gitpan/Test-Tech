#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.03';
$DATE = '2003/06/15';

use Test::TestUtil;
use Cwd;
use File::Spec;
use File::Glob ':glob';
use Test;
use Data::Dumper;

######
#
# T:
#
# use a BEGIN block so we print our plan before Module Under Test is loaded
#
BEGIN { 
   use vars qw( $T $__restore_dir__ @__restore_inc__ $__tests__);

   ########
   # Create the test plan by supplying the number of tests
   # and the todo tests
   #
   $__tests__ = 5;
   plan(tests => $__tests__);

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
   @__restore_inc__ = Test::TestUtil->test_lib2inc;

}

END {

    #########
    # Restore working directory and @INC back to when enter script
    #
    @INC = @__restore_inc__;
    chdir $__restore_dir__;
}

    #######
    # Delete actual results files
    #
    my @outputs = bsd_glob( 'tech1.*' );
    unlink @outputs;

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

#######
#
# ok: 1 
#
my $loaded;
print "# UUT not loaded\n";
test( [$loaded = Test::TestUtil->is_package_loaded('Test::Tech')], 
    ['']); #expected results

#######
# 
# ok:  2
# 
print "# Load UUT\n";
my $errors = Test::TestUtil->load_package( 'Test::Tech' );
skip_rest() unless verify(
    $loaded, # condition to skip test   
    [$errors], # actual results
    ['']);  # expected results


#######
#
#  ok:  3
#
#  Pod check 
# 

print  "No pod errors\n";
test( [Test::TestUtil->pod_errors( 'Test::Tech')], 
        [0]); # expected results);

#####
#  ok:  4
# 
# RUn demonstration script test case 
#
my $test_results = `perl tech0.d`;
Test::TestUtil->fout('tech1.txt', $test_results);
my $test_results_hex = unpack('H*',$test_results );

my $expected_results = Test::TestUtil->fin('tech2.txt');
my $expected_results_hex = unpack('H*', $expected_results );

print "# Demonstration script\n";
test( [$test_results, $test_results_hex], 
        [$expected_results, $expected_results_hex] ); # expected results


#####
#  ok:  5
# 
# Run test script test case 
#
$test_results = `perl tech0.t`;
Test::TestUtil->fout('tech1.txt', $test_results);
$test_results = Test::TestUtil->scrub_file_line($test_results);
$test_results_hex = unpack('H*',$test_results );

$expected_results = Test::TestUtil->scrub_file_line(Test::TestUtil->fin('tech3.txt'));
$expected_results_hex = unpack('H*', $expected_results );

print "# Run test script\n";
test( [$test_results, $test_results_hex], 
        [$expected_results, $expected_results_hex] ); # expected results


#######
# Delete actual results files
#
@outputs = bsd_glob( 'tech1.*' );
unlink @outputs;


####
# 
# Support:
#
# The ok user caller to look up the stack. If nothing there,
# ok produces a warining. Thus, burying it in a subroutine eliminates
# these warning.
#
sub test { 
   my ($actual_p, $expected_p, $name) = @_;
   print "# $name\n" if $name;
   
   my ($actual, $expected);
   if( ref($expected_p) eq 'ARRAY') {
       $expected = Dumper(@$expected_p);
   }
   else {
       $expected = Dumper($expected_p);
   }

   if( ref($actual_p) eq 'ARRAY') {
       $actual = Dumper(@$actual_p);
   }
   else {
       $actual = Dumper($actual_p);
   }

   ok($actual, $expected, '');
};

sub verify { 
   my ($mod, $actual_p, $expected_p, $name) = @_;

   my ($actual, $expected);
   if( ref($expected_p) eq 'ARRAY') {
       $expected = Dumper(@$expected_p);
   }
   else {
       $expected = Dumper($expected_p);
   }

   if( ref($actual_p) eq 'ARRAY') {
       $actual = Dumper(@$actual_p);
   }
   else {
       $actual = Dumper($actual_p);
   }

   my $test_ok = skip($mod, $actual, $expected, '');
   $test_ok = 1 if $mod;  # make sure do not stop 
   $test_ok

};


sub skip_rest
{
    my ($test_results) = @_;
    unless( $test_results ) {
        for (my $i=2; $i < $__tests__; $i++) { skip(1,0,0) };
        exit 1;
    }
}

__END__

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

