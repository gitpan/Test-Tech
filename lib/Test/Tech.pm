#!perl
#
# Documentation, copyright and license is at the end of this file.
#
package  Test::Tech;

use 5.001;
use strict;
use warnings;
use warnings::register;

require Test;
use Data::Dumper;
use File::FileUtil;
use Config;


use vars qw($VERSION $DATE $FILE);
$VERSION = '1.07';
$DATE = '2003/06/19';
$FILE = __FILE__;

use vars qw(@ISA @EXPORT_OK);
require Exporter;
@ISA=('Exporter');
@EXPORT_OK = qw(&tech &plan &ok &skip &skip_tests &done &stringify &example);

use vars qw( $tech );
$tech = new Test::Tech;

######
#
#
sub tech
{
   if( @_ ) {
       $tech = new Test::Tech( @_ ) ;
   }
   else {
       $tech = new Test::Tech() unless $tech;
   }
   $tech  
}


######
#
#
sub plan
{
   $tech->work_breakdown( @_ );
   $Test::TestLevel = 2;
}


######
#
#
sub ok
{
   my ($result, $expected, $diagnostic, $name) = @_;
   $tech->test($result, $expected, $name, $diagnostic);
}


######
#
#
sub skip
{
   my ($mod, $result, $expected, $diagnostic, $name) = @_;
   $tech->verify($mod, $result, $expected, $name, $diagnostic );
}


######
#
#
sub skip_tests
{
   $tech->skip_rest( @_ );
}


######
#
#
sub done
{
   $tech->finish( @_ );

}


######
#
#
sub example
{
   $tech->demo( @_ );

}


#####
# Because Test::TestUtil uses SelfLoader, the @ISA
# method of inheriting Test::TestUtil has problems.
#
# Use AUTOLOAD inheritance technique below instead.
#
# use vars qw(@ISA);
# @ISA = qw(Test::TestUtil);


####
# Using an object to pass localized object data
# between functions. Makes the functions reentrant
# where out right globals can be clobbered when
# used with different threads (processes??)
#
sub new
{
    my ($class, $log) = @_;
    $class = ref($class) if ref($class);
    my $self = bless {}, $class;

    ########
    # Tend to Data::Dumper variables
    #
    $self->{Dumper}->{Terse} = \$Data::Dumper::Terse;
    $self->{Dumper}->{Indent} = \$Data::Indent;
    $self->{Dumper}->{Purity} = \$Data::Purity;
    $self->{Dumper}->{Pad} = \$Data::Pad;
    $self->{Dumper}->{Varname} = \$Data::Varname;
    $self->{Dumper}->{Useqq} = \$Data::Useqq;
    $self->{Dumper}->{Freezer} = \$Data::Freezer;
    $self->{Dumper}->{Toaster} = \$Data::Toaster;
    $self->{Dumper}->{Deepcopy} = \$Data::Deepcopy;
    $self->{Dumper}->{Quotekeys} = \$Data::Quotekeys;
    $self->{Dumper}->{Maxdepth} = \$Data::Maxdepth;


    ######
    # Tend to Test variables
    #  
    $self->{Test}->{ntest} = \$Test::ntest;
    $self->{Test}->{TESTOUT} = \$Test::TESTOUT;
    $self->{Test}->{TestLevel} = \$Test::TestLevel;
    $self->{Test}->{ONFAIL} = \$Test::ONFAIL;
    $self->{Test}->{todo} = \%Test::todo;
    $self->{Test}->{history} = \%Test::history;
    $self->{Test}->{planned} = \$Test::planned;
    $self->{Test}->{FAILDETAIL} = \@Test::FAILDETAIL;

    if( 1.24 <= $Test::VERSION ) {
        $self->{Test}->{Program_Lines} = \%Test::Program_Lines;
        $self->{Test}->{TESTERR} =   \$Test::TESTERR;
    }

    $self->{LOG} = $log if $log;
    if($self->{LOG}) {
        unless ( open($Test::TESTOUT, ">>$self->{LOG}") ) {
            warn( "Cannot open $self->{LOG}\n" );
            $Test::TESTOUT = ${$self->{TESTOUT}};
            $self->skip_rest();
            return $self;
        }
        binmode $Test::TESTOUT; # make the test friendly for more platforms
    }

    $self
}


#####
# Done with the test
#
sub finish # end a test
{
   my ($self)=@_;
   if( $self->{LOG} ) {
       $self->{LOG} = '';
       unless (close( $Test::TESTOUT )) {
           warn( "Cannot close $self->{LOG}\n" );
       }
       $Test::TESTOUT = ${$self->{TESTOUT}};
   }
   1
}


#######
# Sets flag to skip rest of tests
#
sub skip_rest
{
   my ($self,$value) =  @_;
   my $result = $self->{SKIP_ALL};
   $self->{SKIP_ALL} = $value if defined $value;
   $result;   
}


######
# Cover function for &Test::plan
#
sub work_breakdown  # open a file
{
   my $self = shift @_;

   &Test::plan( @_ );

   ###############
   #  
   # Establish default for Test and Data::Dumper
   #
   # Test 1.24 resets global variables in plan which
   # never happens in 1.15
   #
   $Data::Dumper::Terse = 1; 
   $Test::TestLevel = 1;

   my $loctime = localtime();
   my $gmtime = gmtime();

   #######
   # Probe for internal storage
   #
   my $probe = 3;
   my $actual = Dumper([0+$probe]);
   my $internal_storage = 'undetermine';
   if( $actual eq Dumper([3]) ) {
       $internal_storage = 'number';
   }
   elsif ( $actual eq Dumper(['3']) ) {
      $internal_storage = 'string';
   }
   $self->{Number_Internal_Storage} = $internal_storage;
  
   my $perl = "$]";
   if(defined(&Win32::BuildNumber) and defined &Win32::BuildNumber()) {
       $perl .= " Win32 Build " . &Win32::BuildNumber();
   }
   elsif(defined $MacPerl::Version) {
       $perl .= " MacPerl version " . $MacPerl::Version;
   }

   print $Test::TESTOUT <<"EOF" unless 1.24 <= $Test::VERSION;
# OS            : $^O
# Perl          : $perl
# Local Time    : $loctime
# GMT Time      : $gmtime GMT
# Test          : $Test::VERSION
EOF

   print $Test::TESTOUT <<"EOF";
# Number Storage: $internal_storage
# Test::Tech    : $VERSION
# Data::Dumper  : $Data::Dumper::VERSION
# =cut 
EOF

   1

}


#####
# Stringify the variable and compare the string.
#
sub stringify
{
   my ($var_p) = @_;
   
   my ($result, $ref);
   if($ref = ref($var_p)) {
       if( $ref eq 'ARRAY' ) { 
           if( 1 < @$var_p ) {
               $result = Dumper(@$var_p);
           }
           else {
               $result = shift @$var_p;
           }
        }
        elsif( $ref eq 'HASH' ) {
           $result = Dumper(%$var_p);
        } 
        else {
           $result = Dumper($var_p);
        }
   }
   else {
       $result  = $var_p;
   }
   $result;
}


#######
#
# Cover function for &TEST::ok that uses Dumper 
# so can test arbitary inputs
#
sub test
{

   my ($self, $actual_p, $expected_p, $name, $diagnostic) = @_;
   print $Test::TESTOUT "# $name\n" if $name;
   if($self->{SKIP_ALL}) {  # skip rest of tests switch
       print $Test::TESTOUT "# Test invalid because of previous failure.\n";
       &Test::skip( 1, 0, '');
       return 1; 
   }

   my $expected = stringify($expected_p);
   my $actual = stringify($actual_p); 
   &Test::ok($actual, $expected, $diagnostic);

}


#######
#
# Cover function for &TEST::skip so that uses Dumper 
# so can test arbitary inputs
#
sub verify  # store expected array for later use
{
   my ($self, $mod, $actual_p, $expected_p, $name, $diagnostic) = @_;

   print $Test::TESTOUT "# $name\n" if $name;

   if($self->{SKIP_ALL}) {  # skip rest of tests switch
       print $Test::TESTOUT "# Test invalid because of previous failure.\n";
       &Test::skip( 1, 0, '');
       return 1; 
   }
  
   my $expected = stringify($expected_p);
   my $actual = stringify($actual_p); 
   my $test_ok = &Test::skip($mod, $actual, $expected, $diagnostic);
   $test_ok = 1 if $mod;  # make sure do not stop 
   $test_ok

}


######
# Demo
#
sub demo
{
   my ($self, $quoted_expression, @expression_results) = @_;

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
   return unless @expression_results;
  
   $Data::Dumper::Terse = 1;
   my $data = Dumper(@expression_results);
   $data =~ s/(\n+)/$1 /g;
   $data =~ s/\\\\/\\/g;
   $data =~ s/\\'/'/g;

   print $Test::TESTOUT ' ' . $data . "\n" ;

}


1

__END__

=head1 NAME
  
Test::Tech - extends the capabilites of the I<Test> module

=head1 SYNOPSIS

  use Test::Tech

  $T = new Test::Tester(@args);

  $success = $T->work_breakdown(@args);

  $test_ok = $T->test(\@actual_results, \@expected_results, $test_name, $diagnostic);
  $test_ok = $T->verify($skip_test, \@actual_results,  \@expected_results, $test_name, $diagnostic);

  $test_ok = $T->test($actual_results, $expected_results, $test_name, $diagnostic);
  $test_ok = $T->verify($skip_test, $actual_results,  $expected_results, $test_name, $diagnostic);

  $state = $T->skip_rest(on_off);
  $state = $T->skip_rest();

  $success = $T->finish( );

  $success = $T->demo( $quoted_expression, @expression_results );


  $tech_hash = tech( @args );

  $success = plan(@args);

  $test_ok = ok(\@actual_results, \@expected_results, $diagnostic, $test_name);
  $test_ok = skip($skip_test, \@actual_results,  \@expected_results, $diagnostic, $test_name);

  $test_ok = ok($actual_results, $expected_results, $diagnostic, $test_name);
  $test_ok = skip($skip_test, $actual_results,  $expected_results, $diagnostic, $test_name);

  $state = skip_tests( $on_off );
  $state = skip_tests( );

  $success = done( );

  $success = example($quoted_expression, @expression_results );


=head1 DESCRIPTION

The Test::Tester module extends the capabilities of
the Test module as follows:

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

The Test::Tech module is an integral part of the US DOD SDT2167A bundle
of modules.
The dependency of the program modules in the US DOD STD2167A bundle is as follows:
 
 File::FileUtil 
   Test::STD::Scrub
     Test::Tech
        DataPort::FileType::FormDB DataPort::DataFile Test::STD::STDutil
            Test::STDmaker ExtUtils::SVDmaker



=head2 new method

 $T = new Test::Tech;

The I<new> method creates a new I<Test::Tech> object.

=head2 work_breakdown method

 $success = $T->work_breakdown(@args);

The I<work_breakdown> method is a cover method for &Test::plan.
The I<@args> are passed unchanged directory to &Test::plan.
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

=head2 test method

  $test_ok = $T->test(\@actual_results, \@expected_results, $test_name);
  $test_ok = $T->test($actual_results, $expected_results, $test_name);

The I<test> method is a cover function for the &Test::ok subroutine
that extends the &Test::ok routine as follows:

=over 4

=item *

Prints out the I<$test_name> to provide an English identification
of the test.

=item *

The I<test> method passes the arrays from an array reference
I<@actual_results> and I<@expectet_results> through &Data::Dumper::Dumper.
The I<test> method then uses &Test::ok to compare the text results
from &Data::Dumper::Dumper.

=item *

The I<test> method passes variables that are not a reference
directly to &Test::ok unchanged.

=item *

Responses to a flag set by the L<skip_rest method|Test::Tech/skip_rest method>
and skips the test completely.

=back

=head2 verify method

  $test_ok = $T->verify(test, \@actual_results,  \@expected_results, $test_name);

The I<test> method is a cover function for the &Test::skip subroutine
that extends the &Test::skip the same as the I<test> method extends
the I<&Test::ok> subroutine.
See L<test method|Test::Tech/test method>

=head2 skip_rest method

  $success = $T->skip_rest();

The I<skip_rest> method sets a flag that causes the
I<test> and the I<verify> methods to skip testing.

=head2 finish method

  $success = $T->finish( );

The I<finish> method shuts down the I<$T Test::Tech> object.

=head2 tech subroutine

  $tech_hash = tech( @args );

This module creates a "Test::Tech" object to
provide a bridge from the subroutines to the
methods.

The tech subroutine returns a reference to
this internal static object.
The object hash contains all the public
variables for the "Test" module and
the "Data::Dump" modules used by this module.

=head2 plan subroutine

  $success = plan(@args);

Calls the L<work_breakdown method|Test::Tech/work_breakdown method>

=head2 ok subroutine

  $test_ok = ok(\@actual_results, \@expected_results, $diagnostic, $test_name);
  $test_ok = ok($actual_results, $expected_results, $diagnostic, $test_name);

Calls the L<test method|Test::Tech/test method>

=head2 skip subroutine

  $test_ok = skip($skip_test, \@actual_results,  \@expected_results, $diagnostic, $test_name);
  $test_ok = skip($skip_test, $actual_results,  $expected_results, $diagnostic, $test_name);

Calls the L<verify method|Test::Tech/verify method>


=head2 skip_tests subroutine

  $state = skip_tests( $on_off );
  $state = skip_tests( );

Calls the L<skip_rest method|Test::Tech/skip_rest method>

=head2 done subroutine

  $success = done( );

Calls the L<finish method|Test::Tech/finish method>

=head2 example subroutine

  $success = example($quoted_expression, @expression_results );

Calls the L<demo method|Test::Tech/demo method>


=head1 NOTES

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
government practices, 490A (L<STD490A/3.2.3.6>).
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

=head1 SEE ALSO

L<Test> L<Test::TestUtil>

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