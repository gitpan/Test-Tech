#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.04';
$DATE = '2003/06/17';

use Getopt::Long;
use Cwd;
use File::Spec;
use Data::Dumper;
use Config;

######
#
# T:
#
# use a BEGIN block so we print our plan before Module Under Test is loaded
#
BEGIN { 
   use vars qw( $T $__restore_dir__ @__restore_inc__);

   ########
   # Working directory is that of the script file
   #
   $__restore_dir__ = cwd();
   my ($vol, $dirs, undef) = File::Spec->splitpath( $0 );
   chdir $vol if $vol;
   chdir $dirs if $dirs;

   #######
   # Add the library of the unit under test (UUT) to E:\User\SoftwareDiamonds\installation\lib E:\User\SoftwareDiamonds\installation\libSD E:\User\SoftwareDiamonds\installation\lib E:\User\SoftwareDiamonds\installation\libperl D:/Perl/lib D:/Perl/site/lib .
   #
   my $work_dir = cwd();
   ($vol,$dirs) = File::Spec->splitpath( $work_dir, 'nofile');
   my @dirs = File::Spec->splitdir( $dirs );
   while( $dirs[-1] ne 't' ) { 
       chdir File::Spec->updir();
       pop @dirs;
   };
   chdir File::Spec->updir();
   my $lib_dir = File::Spec->catdir( cwd(), 'lib' );
   @__restore_inc__ = @INC;
   unshift @INC, $lib_dir;
   chdir $work_dir;

   unshift @INC, cwd(); 


   ##########
   # Pick up a output redirection file and tests to skip
   # from the command line.
   #
   my $test_log = '';
   GetOptions('log=s' => \$test_log);

   ########
   # Start a test with a new Tech
   #
   require Test::Tech;
   $T = new Test::Tech( $test_log );

   ########
   # Create the test plan by supplying the number of tests
   # and the todo tests
   #
   $T->work_breakdown(tests => 8, todo => [2,5]);


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

my $internal_storage = $T->{Number_Internal_Storage};

my $x = 2;
my $y = 3;

#########
#  ok:  1 - Do not skip rest
#
$T->skip_rest() unless $T->test(
    $x + $y, # actual results
    5, # expected results
    'Pass test'); 

########
#  xy feature
#  Under development, i.e todo
#
#  ok:  2
#
if( $internal_storage eq 'string') {
    $T->test( [$x+$y,$y-$x], # actual results
              ['5','1'], # expected results
             'Todo test that passes');
}
else {
    $T->test( [$x+$y,$y-$x], # actual results
              [5,1], # expected results
             'Todo test that passes');
}


########
#
#  ok:  3
#
if( $internal_storage eq 'string') {
    $T->test( [$x+$y,$x*$y], # actual results
          ['6','5'], # expected results
          'Test that fails');
}
else{
    $T->test( [$x+$y,$x*$y], # actual results
          [6,5], # expected results
          'Test that fails');
}

#########
#
#  ok:  4
#
$T->verify( 1, # condition to skip test   
            ($x*$y*2), # actual results
            6, # expected results
            'Skipped tests');

#######
#  zyw feature
#  Under development, i.e todo
#
#  ok:  5
#
$T->test( $x*$y*2, # actual results
          6, # expected results
          'Todo Test that Fails');


####
# 
#  ok:  6
#
$T->skip_rest() unless $T->test(
    $x + $y, # actual results
    6, # expected results
    'Failed test that skips the rest'); 

####
#
#  ok:  7
#
$T->test( $x + $y + $x, # actual results
          9, # expected results
          'A test to skip');

####
# 
#  ok:  8
# 
$T->test( $x + $y + $x + $y, # actual results
          10, # expected results
          'A not skip to skip');

$T->finish();

__END__

=head1 NAME

tgA1.t - test script for Test::Tech

=head1 SYNOPSIS

 tgA1.t 

=head1 COPYRIGHT

This test script is public domain.

=cut

## end of test script file ##

