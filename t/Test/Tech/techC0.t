#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.06';
$DATE = '2003/07/05';

use Cwd;
use File::Spec;
use File::TestPath;

######
#
# T:
#
# use a BEGIN block so we print our plan before Module Under Test is loaded
#
######
#
# T:
#
# use a BEGIN block so we print our plan before Module Under Test is loaded
#
BEGIN { 
   use vars qw($t $__restore_dir__ @__restore_inc__);

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
   @__restore_inc__ = File::TestPath->test_lib2inc;

   #######
   # Add the directory with "Test.pm" version 1.24 to @INC
   #
   # Thus, when load Test::Tech, it will find Test.pm 1.24
   #
   unshift @INC, File::Spec->catdir ( cwd(), 'V001024'); 

   ########
   # Create the test plan by supplying the number of tests
   # and the todo tests
   #
   require Test::Tech;
   Test::Tech->import( qw(plan ok skip skip_tests tech_config) );
   plan(tests => 2, todo => [1]);

}


END {

   #########
   # Restore working directory and @INC back to when enter script
   #
   @INC = @__restore_inc__;
   chdir $__restore_dir__;
}



######
# This is perl, v5.6.1 built for MSWin32-x86-multi-thread
# (with 1 registered patch, see perl -V for more detail)
#
# Copyright 1987-2001, Larry Wall
#
# Binary build 631 provided by ActiveState Tool Corp. http://www.ActiveState.com
# Built 17:16:22 Jan  2 2002
#
#
# Perl may be copied only under the terms of either the Artistic License or the
# GNU General Public License, which may be found in the Perl 5 source kit.
#
# Complete documentation for Perl, including FAQ lists, should be found on
# this system using `man perl' or `perldoc perl'.  If you have access to the
# Internet, point your browser at http://www.perl.com/, the Perl Home Page.
#
# ~~~~~~~
#
# Wall, Christiansen and Orwant on Perl internal storage
#
# Page 351 of Programming Perl, Third Addition, Overloadable Operators
# quote:
# 
# Conversion operators: "", 0+, bool
#   These three keys let you provide behaviors for Perl's automatic conversions
#   to strings, numbers, and Boolean values, respectively.
# 
# ~~~~~~~
#
# Internal Storage of Perls that are in the wild
#
#   string - Perl v5.6.1 MSWin32-x86-multi-thread, ActiveState build 631, binary
#   number - Perl version 5.008 for solaris  
#
#   Perls in the wild with internal storage of string may be mutants that need to 
#   be hunted down killed.
#

######
#
# 1.24 error goes to the STDERR
# while 1.15 goes to STDOUT
#
# redirect STDERR to the STDOUT
# 
tech_config('Test.TESTERR', \*STDOUT);

my $internal_number = tech_config('Internal_Number');

my $x = 2;
my $y = 3;

########
#  xy feature
#  Under development, i.e todo
#
#  ok:  1
#
if( $internal_number eq 'string') {
    ok( [$x+$y,$y-$x], # actual results
              ['5','1'], # expected results
             '', 'Todo test that passes');
}
else {
    ok( [$x+$y,$y-$x], # actual results
              [5,1], # expected results
             '', 'Todo test that passes');
}


########
#
#  ok:  2
#
if( $internal_number eq 'string') {
    ok( [$x+$y,$x*$y], # actual results
          ['6','5'], # expected results
          '', 'Test that fails');
}
else{
    ok( [$x+$y,$x*$y], # actual results
          [6,5], # expected results
          '', 'Test that fails');
}


__END__

=head1 NAME

tgC0.t - test script for Test::Tech

=head1 SYNOPSIS

 tgC0.t 

=head1 COPYRIGHT

This test script is public domain.

=cut

## end of test script file ##

