#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.03';   # automatically generated file
$DATE = '2003/07/27';

use Cwd;
use File::Spec;

BEGIN {

   use vars qw($t $T $__restore_dir__ @__restore_inc__);

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
   # Add the directory with "Test.pm" version 1.15 to @INC
   #
   # Thus, when load Test::Tech, it will find Test.pm 1.15
   #
   unshift @INC, File::Spec->catdir ( cwd(), 'V001024'); 

   ########
   # Create the test plan by supplying the number of tests
   # and the todo tests
   #
   require Test::Tech;
   Test::Tech->import( qw(demo) );
}

END {

   #########
   # Restore working directory and @INC back to when enter script
   #
   @INC = @__restore_inc__;
   chdir $__restore_dir__;
}


print << 'MSG';

 ~~~~~~ Demonstration overview ~~~~~
 
Perl code begins with the prompt

 =>

The selected results from executing the Perl Code 
follow on the next lines. For example,

 => 2 + 2
 4

 ~~~~~~ The demonstration follows ~~~~~

MSG

demo(   
"my\ \$x\ \=\ 2"); # typed in command           
my $x = 2; # execution

demo(   
"my\ \$y\ \=\ 3"); # typed in command           
my $y = 3; # execution

demo(   
"\$x\ \+\ \$y", # typed in command           
$x + $y); # execution


demo(   
"\(\$x\+\$y\,\$y\-\$x\)", # typed in command           
($x+$y,$y-$x)); # execution


demo(   
"\(\$x\+4\,\$x\*\$y\)", # typed in command           
($x+4,$x*$y)); # execution


demo(   
"\$x\*\$y\*2", # typed in command           
$x*$y*2 # execution
) unless     1; # condition for execution                            

demo(   
"\$x\*\$y\*2", # typed in command           
$x*$y*2 # execution
) unless     0; # condition for execution                            

demo(   
"\$x", # typed in command           
$x); # execution


demo(   
"\ \ \ \ my\ \@expected\ \=\ \(\'200\'\,\'201\'\,\'202\'\)\;\
\ \ \ \ my\ \$i\;\
\ \ \ \ for\(\ \$i\=0\;\ \$i\ \<\ 3\;\ \$i\+\+\)\ \{"); # typed in command           
    my @expected = ('200','201','202');
    my $i;
    for( $i=0; $i < 3; $i++) {; # execution

demo(   
"\$i\+200", # typed in command           
$i+200); # execution


demo(   
"\$i\ \+\ \(\$x\ \*\ 100\)", # typed in command           
$i + ($x * 100)); # execution


demo(   
"\ \ \ \ \}\;"); # typed in command           
    };; # execution

demo(   
"\$x\ \+\ \$y", # typed in command           
$x + $y); # execution


demo(   
"\$x\ \+\ \$y\ \+\ \$x", # typed in command           
$x + $y + $x); # execution


demo(   
"\$x\ \+\ \$y\ \+\ \$x\ \+\ \$y", # typed in command           
$x + $y + $x + $y # execution
) unless     0; # condition for execution                            

demo(   
"\$x\ \+\ \$y\ \+\ \$x\ \+\ \$y\ \+\ \$x", # typed in command           
$x + $y + $x + $y + $x # execution
) unless     1; # condition for execution                            



=head1 NAME

tgA1.d - demostration script for Test::STDmaker::tg1

=head1 SYNOPSIS

 tgA1.d

=head1 OPTIONS

None.

=head1 COPYRIGHT

This STD is public domain.

## end of test script file ##

=cut

