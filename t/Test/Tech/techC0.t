#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.01';
$DATE = '2003/06/19';

use Cwd;
use File::Spec;
use File::FileUtil;

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
   @__restore_inc__ = File::FileUtil->test_lib2inc;

   #######
   # Add the directory with "Test.pm" version 1.15 to @INC
   #
   # Thus, when load Test::Tech, it will find Test.pm 1.15
   #
   unshift @INC, File::Spec->catdir ( cwd(), 'V001024'); 

   ########
   # Create the test plan by supplying the number of tests
   # and the todo tests
   #
   use Test::Tech qw(plan ok skip skip_tests done tech);
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

######
#
# 1.24 error goes to the STDERR
# while 1.15 goes to STDOUT
#
# redirect STDERR to the STDOUT
# 
$t = tech();
${$t->{Test}->{TESTERR}} = *STDOUT; 

#########
#  ok:  1 - Using Test 1.24
#
ok( $Test::VERSION, '1.24', '', 'Test version');


#########
#  ok:  2 - Do not skip rest
#
skip_tests() unless ok(
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

done();

__END__

=head1 NAME

tgA1.t - test script for Test::Tech

=head1 SYNOPSIS

 tgA1.t 

=head1 COPYRIGHT

This test script is public domain.

=cut

## end of test script file ##

