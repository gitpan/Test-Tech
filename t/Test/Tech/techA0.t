#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.09';
$DATE = '2003/09/20';

use Cwd;
use File::Spec;

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
   my ($vol, $dirs) = File::Spec->splitpath(__FILE__);
   chdir $vol if $vol;
   chdir $dirs if $dirs;
   ($vol, $dirs) = File::Spec->splitpath(cwd(), 'nofile'); # absolutify

   #######
   # Add the library of the unit under test (UUT) to @INC
   # It will be found first because it is first in the include path
   #
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
   # Add this to the include path. Thus modules that start with t::
   # will be found.
   # 
   $lib_dir =~ s|/|\\|g if $^O eq 'MSWin32';  # microsoft abberation
   unshift @INC, $lib_dir;  # include the current test directory

   #####
   # Add lib to the include path so that modules under lib at the
   # same level as t, will be found
   #
   $lib_dir = File::Spec->catdir( cwd(), 'lib' );
   $lib_dir =~ s|/|\\|g if $^O eq 'MSWin32';  # microsoft abberation
   unshift @INC, $lib_dir;

   #####
   # Add tlib to the include path so that modules under tlib at the
   # same level as t, will be found
   #
   $lib_dir = File::Spec->catdir( cwd(), 'tlib' );
   $lib_dir =~ s|/|\\|g if $^O eq 'MSWin32';  # microsoft abberation
   unshift @INC, $lib_dir;
   chdir $dirs if $dirs;

   #######
   # Add the directory with "Test.pm" version 1.15 to the front of @INC
   #
   # Thus, load Test::Tech, will find Test.pm 1.15 first
   #
   unshift @INC, File::Spec->catdir ( cwd(), 'V001015'); 

   ########
   # Create the test plan by supplying the number of tests
   # and the todo tests
   #
   require Test::Tech;
   Test::Tech->import( qw(plan ok skip skip_tests tech_config) );
   plan(tests => 8, todo => [4, 8]);

}


END {

   #########
   # Restore working directory and @INC back to when enter script
   #
   @INC = @__restore_inc__;
   chdir $__restore_dir__;
}




########
# Start a test with a new File::FileUtil
#
my $fu = 'File::FileUtil';

my $x = 2;
my $y = 3;

#########
#  ok:  1 - Using Test 1.15
#
ok( $Test::VERSION, '1.15', '', 'Test version');


#########
#  ok:  2 - Do not skip rest
#
skip_tests( 1 ) unless ok(
    $x + $y, # actual results
    5, # expected results
    '', 'Pass test'); 

#########
#
#  ok:  3
#
# R:
#
skip( 1, # condition to skip test   
      ($x*$y*2), # actual results
      6, # expected results
      '','Skipped tests');

#######
#  zyw feature
#  Under development, i.e todo
#
#  ok:  4
#
# R:
#
ok( $x*$y*2, # actual results
          6, # expected results
          '','Todo Test that Fails');
####
# 
#  ok:  5
#
# R:
#
skip_tests(1) unless ok(
    $x + $y, # actual results
    6, # expected results
    '','Failed test that skips the rest'); 

####
#
#  ok:  6
#
# R:
#
ok( $x + $y + $x, # actual results
          9, # expected results
          '', 'A test to skip');

####
# 
#  ok:  7
# 
# R:
#
ok( $x + $y + $x + $y, # actual results
          10, # expected results
          '', 'A not skip to skip');

####
# 
#  ok:  8
# 
# R:
#
skip_tests(0);
ok( $x*$y*2, # actual results
          12, # expected results
          '', 'Stop skipping tests. Todo Test that Passes');

__END__

=head1 NAME

techA1.t - test script for Test::Tech

=head1 SYNOPSIS

 techA1.t 

=head1 COPYRIGHT

This test script is public domain.

=cut

## end of test script file ##

