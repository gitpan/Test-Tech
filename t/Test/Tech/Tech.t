#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.12';
$DATE = '2003/09/15';

use Cwd;
use File::Spec;
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
   # Create the test plan by supplying the number of tests
   # and the todo tests
   #
   $__tests__ = 6;
   &Test::plan(tests => $__tests__);

   ########
   # Working directory is that of the script file
   #
   $__restore_dir__ = cwd();
   my ($vol, $dirs, undef) = File::Spec->splitpath( __FILE__ );
   chdir $vol if $vol;
   chdir $dirs if $dirs;
   ($vol, $dirs) = File::Spec->splitpath(cwd(), 'nofile'); # absolutify

   #######
   # Add the library of the unit under test (UUT) to @INC
   # It will be found first because it is first in the include path
   #
   use Cwd;
   @__restore_inc__ = @INC;

   ######
   # Find root path of the t directory
   #
   my @updirs = File::Spec->splitdir( $dirs );
   while(@updirs && $updirs[-1] ne 't' ) { 
       chdir File::Spec->updir();
       pop @updirs;
   };
   chdir File::Spec->updir();
   my $lib_dir = cwd();

   #####
   # Add lib to the include path so that modules under lib at the
   # same level as t, will be found
   #
   my $inc_dir = File::Spec->catdir( $lib_dir, 'lib' );
   $inc_dir =~ s|/|\\|g if $^O eq 'MSWin32';  # microsoft abberation
   unshift @INC, $inc_dir;

   #####
   # Add tlib to the include path so that modules under tlib at the
   # same level as t, will be found
   #
   $inc_dir = File::Spec->catdir( $lib_dir, 'tlib' );
   $inc_dir =~ s|/|\\|g if $^O eq 'MSWin32';  # microsoft abberation
   unshift @INC, $inc_dir;
   chdir $dirs if $dirs;
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
use File::Package;
use File::SmartNL;
my $fp  = 'File::Package';
my $snl = 'File::SmartNL';

#######
#
# ok: 1 
#
# R:
#
my $loaded;
print "# is_package_loaded\n";
ok ($loaded = $fp->is_package_loaded('Test::Tech'), ''); 

#######
# 
# ok:  2
#
# R:
# 
print "# load_package\n";
my $errors = $fp->load_package( 'Test::Tech' );
skip($loaded, $errors, '');
skip_rest( $errors, 2 );

#####
# New $scrub object
#
use Text::Scrub;
my $s = 'Text::Scrub';


#####
#  ok:  3
# 
# R:
#
# Run test script test techA0.t
#
print "# Run test script techA0.t - Uses Test 1.15\n";

my $actual_results = `perl techA0.t`;
$snl->fout('tech1.txt', $actual_results);
$actual_results = $s->scrub_probe($s->scrub_file_line($actual_results));

my $expected_results = $snl->fin('techA2.txt');
$expected_results = $s->scrub_probe($s->scrub_file_line($expected_results));

ok($actual_results, $expected_results); 

#####
#  ok:  4
# 
# R:
#
# Run test script test techB0.t
#
print "# Run test script techB0.t - Uses Test 1.24\n";

$actual_results = `perl techB0.t`;
$snl->fout('tech1.txt', $actual_results);
$actual_results = $s->scrub_probe($s->scrub_file_line($actual_results));

$expected_results = $snl->fin('techA2.txt');
$expected_results = $s->scrub_probe($s->scrub_file_line($expected_results));

ok( $actual_results, $expected_results); 



#####
#  ok:  5
# 
# Run test script test techD0.t
#
# R:
#
print "# Run test script techC0.t - Uses Test 1.24 - (0+\$number) test\n";

$actual_results = `perl techC0.t`;
$snl->fout('tech1.txt', $actual_results);
$actual_results = $s->scrub_probe($s->scrub_file_line($actual_results));

#######
# expected results depend upon the internal storage from numbers 
#
if( $internal_storage eq 'string') {
    $expected_results = $snl->fin('techC2.txt');
}
else {
    $expected_results = $snl->fin('techC3.txt');
}

$expected_results = $s->scrub_probe($s->scrub_file_line($expected_results));
ok( $actual_results, $expected_results); 

#####
#  ok:  6
# 
# Run demo script techD0.d
#
# R:
#
print "# Run demo script techD0.d\n";

$actual_results = `perl techD0.d`;
$snl->fout('tech1.txt', $actual_results);
$actual_results = $s->scrub_probe($s->scrub_file_line($actual_results));

#######
# expected results depend upon the internal storage from numbers 
#
if( $internal_storage eq 'string') {
    $expected_results = $snl->fin('techD2.txt');
}
else {
    $expected_results = $snl->fin('techD3.txt');
}

$expected_results = $s->scrub_probe($s->scrub_file_line($expected_results));
ok( $actual_results, $expected_results); 


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

