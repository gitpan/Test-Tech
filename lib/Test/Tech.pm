#!perl
#
# Documentation, copyright and license is at the end of this file.
#
package  Test::Tech;

use 5.001;
use strict;
use warnings;
use warnings::register;

use Test ();   # do not import the "Test" subroutines
use Data::Secs2 qw(stringify);

use vars qw($VERSION $DATE $FILE);
$VERSION = '1.15';
$DATE = '2003/09/20';
$FILE = __FILE__;

use vars qw(@ISA @EXPORT_OK);
require Exporter;
@ISA=('Exporter');
@EXPORT_OK = qw(&tech_config &plan &ok &skip &skip_tests &stringify &demo);

#######
#
# Keep all data hidden in a local hash
# 
my $tech_p = new Test::Tech;  # quasi objectify by using new Test::Tech instead of %tech

sub new
{

   ####################
   # $class is either a package name (scalar) or
   # an object with a data pointer and a reference
   # to a package name. A package name is also the
   # name of a class
   #
   my ($class, @args) = @_;
   $class = ref($class) if( ref($class) );
   my $self = bless {}, $class;

   ######
   # Make Test variables visible to tech_config
   #  
   $self->{Test}->{ntest} = \$Test::ntest;
   $self->{Test}->{TESTOUT} = \$Test::TESTOUT;
   $self->{Test}->{TestLevel} = \$Test::TestLevel;
   $self->{Test}->{ONFAIL} = \$Test::ONFAIL;
   $self->{Test}->{planned} = \$Test::planned;
   $self->{Test}->{TESTERR} = \$Test::TESTERR if defined $Test::TESTERR; 

   $self->{TestDefault}->{TESTOUT} = $Test::TESTOUT;
   $self->{TestDefault}->{TestLevel} = $Test::TestLevel;
   $self->{TestDefault}->{ONFAIL} = $Test::ONFAIL;
   $self->{TestDefault}->{TESTERR} = $Test::TESTERR if defined $Test::TESTERR; 

   ######
   # Test::Tech object data
   #
   $self->{Skip_Tests} = 0;

   $self;
}
 

#####
# Restore the Test:: moduel variable back to where they were when found
#
sub DESTROY
{
   my $self = UNIVERSAL::isa($_[0],__PACKAGE__) ? shift @_ : $tech_p;

   return unless defined $self;

   $Test::TESTOUT = $self->{TestDefault}->{TESTOUT};
   $Test::TestLevel = $self->{TestDefault}->{TestLevel};
   $Test::ONFAIL = $self->{TestDefault}->{ONFAIL};
   $Test::TESTERR = $self->{TestDefault}->{TESTERR} if defined $Test::TESTERR;

}

sub finish 
{
    Test::Tech::DESTROY( @_ );

}

# *finish = &*Test::Tech::DESTORY; # finish is alias for DESTORY


######
# Cover function for &Test::plan that sets the proper 'Test::TestLevel'
# and outputs some info on the current site
#
sub plan
{
   ######
   # This subroutine uses no object data; therefore,
   # drop any class or object.
   #
   shift @_ if UNIVERSAL::isa($_[0],__PACKAGE__);

   &Test::plan( @_ );

   ###############
   #  
   # Establish default for Test
   #
   # Test 1.24 resets global variables in plan which
   # never happens in 1.15
   #
   $Test::TestLevel = 1;

   my $loctime = localtime();
   my $gmtime = gmtime();

   my $perl = "$]";
   if(defined(&Win32::BuildNumber) and defined &Win32::BuildNumber()) {
       $perl .= " Win32 Build " . &Win32::BuildNumber();
   }
   elsif(defined $MacPerl::Version) {
       $perl .= " MacPerl version " . $MacPerl::Version;
   }

   print $Test::TESTOUT <<"EOF" unless 1.20 < $Test::VERSION ;
# OS            : $^O
# Perl          : $perl
# Local Time    : $loctime
# GMT Time      : $gmtime
# Test          : $Test::VERSION
EOF

   print $Test::TESTOUT <<"EOF";
# Test::Tech    : $VERSION
# Data::Secs2   : $Data::Secs2::VERSION
# =cut 
EOF

   1
}


######
# Cover function for &Test::ok that adds capability to test 
# complex data structures.
#
sub ok
{

   ######
   # If no object, use the default $tech_p object.
   #
   my $self = (UNIVERSAL::isa($_[0],__PACKAGE__) && ref($_[0])) ? shift @_ : $tech_p;

   my ($actual_result, $expected_result, $diagnostic, $name) = @_;

   ######### 
   # Fill in undefined inputs
   #
   $name = '' unless defined $name; 
   $diagnostic = $name unless $diagnostic;

   print $Test::TESTOUT "# $name\n" if $name;
   if($self->{Skip_Tests}) { # skip rest of tests switch
       print $Test::TESTOUT "# Test invalid because of previous failure.\n";
       &Test::skip( 1, 0, '');
       return 1; 
   }

   &Test::ok(stringify($actual_result), stringify($expected_result), $diagnostic);

}


######
#
#
sub skip
{

   ######
   # If no object, use the default $tech_p object.
   #
   my $self = (UNIVERSAL::isa($_[0],__PACKAGE__) && ref($_[0])) ? shift @_ : $tech_p;

   my ($mod, $actual_result, $expected_result, $diagnostic, $name) = @_;

   print $Test::TESTOUT "# $name\n" if $name;

   if($self->{Skip_Tests}) {  # skip rest of tests switch
       print $Test::TESTOUT "# Test invalid because of previous failure.\n";
       &Test::skip( 1, 0, '');
       return 1; 
   }
  
   &Test::skip($mod, stringify($actual_result), stringify($expected_result), $diagnostic);

}


######
#
#
sub skip_tests
{

   ######
   # If no object, use the default $tech_p object.
   #
   my $self = (UNIVERSAL::isa($_[0],__PACKAGE__) && ref($_[0])) ? shift @_ : $tech_p;

   my ($value) =  @_;
   my $result = $self->{Skip_Tests};
   if (defined $value) {
       $self->{Skip_Tests} = $value;
   }
   else {
       $self->{Skip_Tests} = 1;
   }
   $result;   
}


#######
# This accesses the values in the %tech hash
#
# Use a dot notation for following down layers
# of hashes of hashes
#
sub tech_config
{

   ######
   # If no object, use the default $tech_p object.
   #
   my $self = (UNIVERSAL::isa($_[0],__PACKAGE__) && ref($_[0])) ? shift @_ : $tech_p;

   my ($key, $value) = @_;
   my @keys = split /\./, $key;

   #########
   # Follow the hash with the current
   # dot index until there are no more
   # hashes. For success, the dot hash 
   # notation must match the structure.
   #
   my $key_p = $self;
   while (@keys) {

       $key = shift @keys;

       ######
       # Do not allow creation of new configs
       #
       if( defined( $key_p->{$key}) ) {

           ########
           # Follow the hash
           # 
           if( ref($key_p->{$key}) eq 'HASH' ) { 
               $key_p  = $key_p->{$key};
           }
           else {
              if(@keys) {
                   warn( "More key levels than hashes.\n");
                   return undef; 
              } 
              last;
           }
       }
   }


   #########
   # References to arrays and scalars in the config may
   # be transparent.
   #
   my $current_value = $key_p->{$key};
   if( ref($current_value) eq 'SCALAR') {
       $current_value = $$current_value;
   }
   if (defined $value && $key ne 'ntest' && $key ne 'planned') {
       if( ref($value) eq 'SCALAR' ) {
           ${$key_p->{$key}} = $$value;
       }
       else {
           ${$key_p->{$key}} = $value;
       }
   }

   $current_value;

}



######
# Demo
#
sub demo
{
   use Data::Dumper;

   ######
   # This subroutine uses no object data; therefore,
   # drop any class or object.
   #
   shift @_ if UNIVERSAL::isa($_[0],__PACKAGE__);

   my ($quoted_expression, @expression) = @_;

   #######
   # A demo trys to simulate someone typing expresssions
   # at a console.
   #

   #########
   # Print quoted expression so that see the non-executed
   # expression. The extra space is so when pasted into
   # a POD, the POD will process the line as code.
   #
   $quoted_expression =~ s/(\n+)/$1 => /g;
   print $Test::TESTOUT ' => ' . $quoted_expression . "\n";   

   ########
   # @data is the result of the script executing the 
   # quoted expression.
   #
   # The demo output most likely will end up in a pod. 
   # The the process of running the generated script
   # will execute the setup. Thus the input is the
   # actual results. Putting a space in front of it
   # tells the POD that it is code.
   #
   return unless @expression;
  
   $Data::Dumper::Terse = 1;
   my $data = Dumper(@expression);
   $data =~ s/(\n+)/$1 /g;
   $data =~ s/\\\\/\\/g;
   $data =~ s/\\'/'/g;

   print $Test::TESTOUT ' ' . $data . "\n" ;

}

1

__END__

=head1 NAME
  
Test::Tech - adds skip_tests and test data structures capabilities to the "Test" module

=head1 SYNOPSIS

 #######
 # Procedural (subroutine) Interface
 #
 # (use for &Test::plan, &Test::ok, &Test::skip drop in)
 #  
 use Test::Tech qw(plan ok skip skip_tests tech_config stringify demo);

 $new_value  = tech_config( $key, $old_value);

 $success = plan(@args);

 $test_ok = ok($actual_results, $expected_results, $diagnostic, $test_name);
 $test_ok = skip($skip_test, $actual_results,  $expected_results, $diagnostic, $test_name);

 $state = skip_tests( $on_off );
 $state = skip_tests( );

 $string = stringify( $var ); # imported from Data::Secs2

 finish( );

 demo($quoted_expression, @expression)

 ###### 
 # Test::Tech methods inherited by another Class
 #
 use Test::Tech;
 use vars qw(@ISA);
 @ISA = qw(Test::Tech);
 
 $new_value    = __PACKAGE__->tech_config( $key, $old_value);

 $success = __PACKAGE__->plan(@args);

 $test_ok = __PACKAGE__->ok($actual_results, $expected_results, $diagnostic, $test_name);
 $test_ok = __PACKAGE__->skip($skip_test, $actual_results,  $expected_results, $diagnostic, $test_name);

 $state = __PACKAGE__->skip_tests( $on_off );
 $state = __PACKAGE__->skip_tests( );

 $string = __PACKAGE__->stringify( $var ); 

 __PACKAGE__->finish( );

 __PACKAGE__->demo($quoted_expression, @expression)

 ###### 
 # Class Interface
 #
 use Test::Tech;
 
 $new_value    = Test::Tech->tech_config( $key, $old_value);

 $success = Test::Tech->plan(@args);

 $test_ok = Test::Tech->ok($actual_results, $expected_results, $diagnostic, $test_name);
 $test_ok = Test::Tech->skip($skip_test, $actual_results,  $expected_results, $diagnostic, $test_name);

 $state = Test::Tech->skip_tests( $on_off );
 $state = Test::Tech->skip_tests( );

 Test::Tech->finish( );

 Test::Tech->demo($quoted_expression, @expression)

 #####
 # Object Interface
 # 
 $tech = new Test::Tech;

 $test_ok = $tech->ok($actual_results, $expected_results, $diagnostic, $test_name);
 $test_ok = $tech->skip($skip_test, $actual_results,  $expected_results, $diagnostic, $test_name);

 $state  = $tech->skip_tests( $on_off );
 $state  = $tech->skip_tests( );

 $new_value = $tech->tech_config( $key, $old_value);

 $tech->finish();
 
=head1 DESCRIPTION

The "Test::Tech" module extends the capabilities of the "Test" module.

The design is simple. 
The "Test::Tech" module loads the "Test" module without exporting
any "Test" subroutines into the "Test::Tech" namespace.
There is a "Test::Tech" cover subroutine with the same name
for each "Test" module subroutine.
Each "Test::Tech" cover subroutine will call the &Test::$subroutine
before or after it adds any additional capabilities.
The "Test::Tech" module procedural (subroutine) interface 
is a drop-in for the "Test" module.

The "Test::Tech" has a hybrid interface. The subroutine/methods that use
object data are the 'new', 'ok', 'skip', 'skip_tests', 'tech_config' and 'finish'
subroutines/methods.

When the module is loaded it creates a default object. If any of the
above subroutines/methods are used procedurally, without a class or
object, the subroutine/method will use the default method. 

The "Test::Tech" module extends the capabilities of
the "Test" module as follows:

=over 4

=item *

Compare almost any data structure by passing variables
through I<Data::Dumper> before making the comparision

=item *

Method to skip the rest of the tests upon a critical failure

=item *

Method to generate demos that appear as an interactive
session using the methods under test

=back

=head2 plan subroutine

 $success = plan(@args);

The I<plan> subroutine is a cover method for &Test::plan.
The I<@args> are passed unchanged to &Test::plan.
All arguments are options. Valid options are as follows:

=over 4

=item tests

The number of tests. For example

 tests => 14,

=item todo

An array of test that will fail. For example

 todo => [3,4]

=item onfail

A subroutine that the I<Test> module will
execute on a failure. For example,

 onfail => sub { warn "CALL 911!" } 

=back

=head2 ok subroutine

 $test_ok = ok(\@actual_results, \@expected_results, $test_name);
 $test_ok = ok($actual_results, $expected_results, $test_name);

The I<test> method is a cover function for the &Test::ok subroutine
that extends the &Test::ok routine as follows:

=over 4

=item *

Prints out the I<$test_name> to provide an English identification
of the test.

=item *

The I<ok> subroutine passes the arrays from an array reference
I<@actual_results> and I<@expectet_results> through &Data::Dumper::Dumper.
The I<test> method then uses &Test::ok to compare the text results
from &Data::Dumper::Dumper.

=item *

The I<ok> subroutine method passes variables that are not a reference
directly to &Test::ok unchanged.

=item *

Responses to a flag set by the L<skip_tests subroutine|Test::Tech/skip_tests> subroutine
and skips the test completely.

=back

=head2 skip subroutine

 $test_ok = skip(\@actual_results, \@expected_results, $test_name);
 $test_ok = skip($actual_results, $expected_results, $test_name);

The I<skip> subroutine is a cover function for the &Test::skip subroutine
that extends the &Test::skip the same as the 
L<ok subroutine|Test::Tech/ok> subroutine extends
the I<&Test::ok> subroutine.

=head2 skip_tests method

 $state = skip_tests( $on_off );
 $state = skip_tests( );

The I<skip_tests> subroutine sets a flag that causes the
I<ok> and the I<skip> methods to skip testing.

=head2 stringify subroutine

 $string = stringify( $var );

The I<stringify> subroutine will stringify I<$var> using
the "L<Data::Dumper|Data::Dumper>" module only if I<$var> is a reference;
otherwise, it leaves it unchanged.

For numeric arrays, "L<Data::Dumper|Data::Dumper>" module will not
stringify them the same for all Perls. The below Perl code will
produce different results for different Perls

 $probe = 3;
 $actual = Dumper([0+$probe]);

For Perl v5.6.1 MSWin32-x86-multi-thread, ActiveState build 631, binary,
the results will be '[\'3\']'  
while for Perl version 5.008 for solaris the results will be '[3]'. 

This module will automatically, when loaded, probe the site Perl
and will this statement and enter the results as 'string' or
'number' in the I<Internal_Number> configuration variable.

=head2 tech_config subroutine

 $old_value = tech_config( $dot_index, $new_value );

The I<tech_config> subroutine reads and writes the
below configuration variables

 dot index              contents           mode
 --------------------   --------------     --------
 Test.ntest             $Test::ntest       read only 
 Test.TESTOUT           $Test::TESTOUT     read write
 Test.TestLevel         $Test::TestLevel   read write
 Test.ONFAIL            $Test::ONFAIL      read write
 Test.planned           $Test::planned     read only
 Test.TESTERR           $Test::TESTERR     read write
 Skip_Tests             # boolean          read write
 
The I<tech_config> subroutine always returns the
I<$old_value> of I<$dot_index> and only writes
the contents if I<$new_value> is defined.

The 'SCALAR' and 'ARRAY' references are transparent.
The I<tech_config> subroutine, when it senses that
the I<$dot_index> is for a 'SCALAR' and 'ARRAY' reference,
will read or write the contents instead of the reference.

The The I<tech_config> subroutine will read 'HASH" references
but will never change them. 

The variables for the top level 'Dumper' I<$dot_index> are
established by "L<Data::Dumper|Data::Dumper>" module;
for the top level 'Test', the "L<Test|Test>" module.

=head2 finish subroutine/method

 finish();

The 'finish' subroutine/method restores changes made
to the 'Test' module module made by the 
'tech_config' subroutine/method or directly.

When the 'new' subroutine/method creates a 'Test::Tech'
object, the Perl will automatically run the
'finish' method when that object is destoried.

Running the 'finish' method without a class or object,
restores the 'Test' module to the values when
the 'Test::Tech' module was loaded.

=head2 demo subroutine/method

 demo($quoted_expression, @expression)

The demo subroutine/method provides a session like out.
The '$quoted_express' is printed out as typed in from
the keyboard.
The '@expression' is executed and printed out as the
results of '$quoted_expression'.

=head1 REQUIREMENTS

Coming soon.

=head1 DEMONSTRATION

 ~~~~~~ Demonstration overview ~~~~~

Perl code begins with the prompt

 =>

The selected results from executing the Perl Code 
follow on the next lines. For example,

 => 2 + 2
 4

 ~~~~~~ The demonstration follows ~~~~~

 =>     use File::Spec;

 =>     use File::Package;
 =>     my $fp = 'File::Package';

 =>     use Text::Scrub;
 =>     my $s = 'Text::Scrub';

 =>     use File::SmartNL;
 =>     my $snl = 'File::SmartNL';

 =>     my $uut = 'Test::Tech';
 => $snl->fin('techA0.t')
 '#!perl
 #
 #
 use 5.001;
 use strict;
 use warnings;
 use warnings::register;

 use vars qw($VERSION $DATE);
 $VERSION = '0.08';
 $DATE = '2003/09/15';

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

 '

 =>     my $actual_results = `perl techA0.t`;
 =>     $snl->fout('tech1.txt', $actual_results);
 => $s->scrub_probe($s->scrub_file_line($actual_results))
 '1..8 todo 4 8;
 # Test version
 ok 1
 # Pass test
 ok 2
 # Skipped tests
 ok 3 # skip
 # Todo Test that Fails
 not ok 4
 # Test 4 got: '12' (xxxx.t at line 000 *TODO*)
 #   Expected: '6' (Todo Test that Fails)
 # Failed test that skips the rest
 not ok 5
 # Test 5 got: '5' (xxxx.t at line 000)
 #   Expected: '6' (Failed test that skips the rest)
 # A test to skip
 # Test invalid because of previous failure.
 ok 6 # skip
 # A not skip to skip
 # Test invalid because of previous failure.
 ok 7 # skip
 # Stop skipping tests. Todo Test that Passes
 ok 8 # (xxxx.t at line 000 TODO?!)
 '

 => $snl->fin('techC0.t')
 '#!perl
 #
 #
 use 5.001;
 use strict;
 use warnings;
 use warnings::register;

 use vars qw($VERSION $DATE);
 $VERSION = '0.09';
 $DATE = '2003/09/18';

 use Cwd;
 use File::Spec;

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
 #
 # Test 1.24 error goes to the STDERR
 # while 1.15 goes to STDOUT
 #
 # redirect STDERR to the STDOUT
 # 
 tech_config('Test.TESTERR', \*STDOUT);

 my $x = 2;
 my $y = 3;

 ########
 #  xy feature
 #  Under development, i.e todo
 #
 #  ok:  1
 #
 ok( [$x+$y,$y-$x], # actual results
     [5,1], # expected results
     '', 'Todo test that passes');

 ########
 #
 #  ok:  2
 #
 ok( [$x+$y,$x*$y], # actual results
     [6,5], # expected results
     '', 'Test that fails');

 __END__

 =head1 NAME

 techC0.t - test script for Test::Tech

 =head1 SYNOPSIS

  techC0.t 

 =head1 COPYRIGHT

 This test script is public domain.

 =cut

 ## end of test script file ##

 '

 =>     $actual_results = `perl techC0.t`;
 =>     $snl->fout('tech1.txt', $actual_results);
 => $s->scrub_probe($s->scrub_file_line($actual_results))
 '1..2 todo 1;
 # Todo test that passes
 ok 1 # (xxxx.t at line 000 TODO?!)
 # Test that fails
 not ok 2
 # Test 2 got: 'L[4]
   A[0] 
   A[5] ARRAY
   A[1] 5
   A[1] 6
 ' (xxxx.t at line 000)
 #   Expected: 'L[4]
   A[0] 
   A[5] ARRAY
   A[1] 6
   A[1] 5
 ' (Test that fails)
 '

 => my $tech = new Test::Tech
 => $tech->tech_config('Test.TestLevel')
 undef

 => $tech->tech_config('Test.TestLevel', 2)
 undef

 => $tech->tech_config('Test.TestLevel')
 2

 => $Test::TestLevel
 2

 => $tech->finish( )
 => $Test::TestLevel
 undef


=head1 QUALITY ASSURANCE

Running the test script 'Tech.t' found in
the "Test-Tech-$VERSION.tar.gz" distribution file verifies
the requirements for this module.

All testing software and documentation
stems from the 
Software Test Description (L<STD|Docs::US_DOD::STD>)
program module 't::Test::Tech::Tech',
found in the distribution file 
"Test-Tech-$VERSION.tar.gz". 

The 't::Test::Tech::Tech' L<STD|Docs::US_DOD::STD> POD contains
a tracebility matix between the
requirements established above for this module, and
the test steps identified by a
'ok' number from running the 'Tech.t'
test script.

The t::Test::Tech::Tech' L<STD|Docs::US_DOD::STD>
program module '__DATA__' section contains the data 
to perform the following:

=over 4

=item *

to generate the test script 'Tech.t'

=item *

generate the tailored 
L<STD|Docs::US_DOD::STD> POD in
the 't::Test::Tech::Tech' module, 

=item *

generate the 'Tech.d' demo script, 

=item *

replace the POD demonstration section
herein with the demo script
'Tech.d' output, and

=item *

run the test script using Test::Harness
with or without the verbose option,

=back

To perform all the above, prepare
and run the automation software as 
follows:

=over 4

=item *

Install "Test_STDmaker-$VERSION.tar.gz"
from one of the respositories only
if it has not been installed:

=over 4

=item *

http://www.softwarediamonds/packages/

=item *

http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/

=back
  
=item *

manually place the script tmake.pl
in "Test_STDmaker-$VERSION.tar.gz' in
the site operating system executable 
path only if it is not in the 
executable path

=item *

place the 't::Test::Tech::Tech' at the same
level in the directory struture as the
directory holding the 'Test::Tech'
module

=item *

execute the following in any directory:

 tmake -test_verbose -replace -run -pm=t::Test::Tech::Tech

=back

=head1 NOTES

=head2 FILES

The installation of the
"Test-Tech-$VERSION.tar.gz" distribution file
installs the 'Docs::Site_SVD::Test_Tech'
L<SVD|Docs::US_DOD::SVD> program module.

The __DATA__ data section of the 
'Docs::Site_SVD::Test_Tech' contains all
the necessary data to generate the POD
section of 'Docs::Site_SVD::Test_Tech' and
the "Test-Tech-$VERSION.tar.gz" distribution file.

To make use of the 
'Docs::Site_SVD::Test_Tech'
L<SVD|Docs::US_DOD::SVD> program module,
perform the following:

=over 4

=item *

install "ExtUtils-SVDmaker-$VERSION.tar.gz"
from one of the respositories only
if it has not been installed:

=over 4

=item *

http://www.softwarediamonds/packages/

=item *

http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/

=back

=item *

manually place the script vmake.pl
in "ExtUtils-SVDmaker-$VERSION.tar.gz' in
the site operating system executable 
path only if it is not in the 
executable path

=item *

Make any appropriate changes to the
__DATA__ section of the 'Docs::Site_SVD::Test_Tech'
module.
For example, any changes to
'File::Package' will impact the
at least 'Changes' field.

=item *

Execute the following:

 vmake readme_html all -pm=Docs::Site_SVD::Test_Tech

=back

=head2 AUTHOR

The holder of the copyright and maintainer is

E<lt>support@SoftwareDiamonds.comE<gt>

=head2 COPYRIGHT NOTICE

Copyrighted (c) 2002 Software Diamonds

All Rights Reserved

=head2 BINDING REQUIREMENTS NOTICE

Binding requirements are indexed with the
pharse 'shall[dd]' where dd is an unique number
for each header section.
This conforms to standard federal
government practices, L<US DOD 490A 3.2.3.6|Docs::US_DOD::STD490A/3.2.3.6>.
In accordance with the License, Software Diamonds
is not liable for any requirement, binding or otherwise.

=head2 LICENSE

Software Diamonds permits the redistribution
and use in source and binary forms, with or
without modification, provided that the 
following conditions are met: 

=over 4

=item 1

Redistributions of source code must retain
the above copyright notice, this list of
conditions and the following disclaimer. 

=item 2

Redistributions in binary form must 
reproduce the above copyright notice,
this list of conditions and the following 
disclaimer in the documentation and/or
other materials provided with the
distribution.

=back

SOFTWARE DIAMONDS, http::www.softwarediamonds.com,
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

=for html
<p><br>
<!-- BLK ID="NOTICE" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="OPT-IN" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="EMAIL" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="COPYRIGHT" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>

=cut

### end of file ###