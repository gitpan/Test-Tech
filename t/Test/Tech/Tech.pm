#!perl
#
# The copyright notice and plain old documentation (POD)
# are at the end of this file.
#
package  t::Test::Tech::Tech;

use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE $FILE );
$VERSION = '0.01';
$DATE = '2003/09/20';
$FILE = __FILE__;

########
# The Test::STDmaker module uses the data after the __DATA__ 
# token to automatically generate the this file.
#
# Don't edit anything before __DATA_. Edit instead
# the data after the __DATA__ token.
#
# ANY CHANGES MADE BEFORE the  __DATA__ token WILL BE LOST
#
# the next time Test::STDmaker generates this file.
#
#


=head1 TITLE PAGE

 Detailed Software Test Description (STD)

 for

 Perl Test::Tech Program Module

 Revision: -

 Version: 

 Date: 2003/09/19

 Prepared for: General Public 

 Prepared by:  http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com

 Classification: None

=head1 SCOPE

This detail STD and the 
L<General Perl Program Module (PM) STD|Test::STD::PerlSTD>
establishes the tests to verify the
requirements of Perl Program Module (PM) L<Test::Tech|Test::Tech>

The format of this STD is a tailored L<2167A STD DID|Docs::US_DOD::STD>.
in accordance with 
L<Detail STD Format|Test::STDmaker/Detail STD Format>.

#######
#  
#  4. TEST DESCRIPTIONS
#
#  4.1 Test 001
#
#  ..
#
#  4.x Test x
#
#

=head1 TEST DESCRIPTIONS

The test descriptions uses a legend to
identify different aspects of a test description
in accordance with
L<STD FormDB Test Description Fields|Test::STDmaker/STD FormDB Test Description Fields>.

=head2 Test Plan

 T: 10^

=head2 ok: 1


  C:
     use File::Spec;
     use File::Package;
     my $fp = 'File::Package';
     use Text::Scrub;
     my $s = 'Text::Scrub';
     use File::SmartNL;
     my $snl = 'File::SmartNL';
     my $uut = 'Test::Tech';
 ^
 VO: ^
  N: UUT loaded^
  A: $fp->is_package_loaded($uut)^
 SE: '1'^
 ok: 1^

=head2 ok: 2

 DO: ^
  A: $snl->fin('techA0.t')^
  N:  Run test script techA0.t using Test 1.15^

  C:
     my $actual_results = `perl techA0.t`;
     $snl->fout('tech1.txt', $actual_results);
 ^
  A: $s->scrub_probe($s->scrub_file_line($actual_results))^
  E: $s->scrub_probe($s->scrub_file_line($snl->fin('techA2.txt')))^
 ok: 2^

=head2 ok: 3

 VO: ^
  N:  Run test script techB0.t using Test 1.24^

  C:
     $actual_results = `perl techB0.t`;
     $snl->fout('tech1.txt', $actual_results);
 ^
  A: $s->scrub_probe($s->scrub_file_line($actual_results))^
  E: $s->scrub_probe($s->scrub_file_line($snl->fin('techA2.txt')))^
 ok: 3^

=head2 ok: 4

 DO: ^
  A: $snl->fin('techC0.t')^
  N:  Run test script techC0.t using Test 1.24^

  C:
     $actual_results = `perl techC0.t`;
     $snl->fout('tech1.txt', $actual_results);
 ^
  A: $s->scrub_probe($s->scrub_file_line($actual_results))^
  E: $s->scrub_probe($s->scrub_file_line($snl->fin('techC2.txt')))^
 ok: 4^

=head2 ok: 5

 VO: ^
  N:  Run demo script techD0.d^

  C:
     use Data::Dumper;
     my $probe = 3;
     $actual_results = Dumper([0+$probe]);
     my $internal_storage = 'undetermine';
     if( $actual_results eq Dumper([3]) ) {
         $internal_storage = 'number';
     }
     elsif ( $actual_results eq Dumper(['3']) ) {
         $internal_storage = 'string';
     }
     $actual_results = `perl techD0.d`;
     $snl->fout('tech1.txt', $actual_results);
     #######
     # expected results depend upon the internal storage from numbers 
     #
     my $expected_results;
     if( $internal_storage eq 'string') {
         $expected_results = $snl->fin('techD2.txt');
     }
     else {
         $expected_results = $snl->fin('techD3.txt');
     }
 ^
  A: $s->scrub_probe($s->scrub_file_line($actual_results))^
  E: $s->scrub_probe($s->scrub_file_line($expected_results))^
 ok: 5^

=head2 ok: 6

  N: config Test.TestLevel, read 1^
  C: my $tech = new Test::Tech^
  A: $tech->tech_config('Test.TestLevel')^
  E: 1^
 ok: 6^

=head2 ok: 7

  N: config Test.TestLevel, read 1, write 2^
  A: $tech->tech_config('Test.TestLevel', 2)^
  E: 1^
 ok: 7^

=head2 ok: 8

  N: config Test.TestLevel, read 2^
  A: $tech->tech_config('Test.TestLevel')^
  E: 2^
 ok: 8^

=head2 ok: 9

  N: Test::TestLevel read 2^
  A: $Test::TestLevel^
  E: 2^
 ok: 9^

=head2 ok: 10

  N: retore Test::TestLevel on finish^
  C: $tech->finish( )^
  A: $Test::TestLevel^
  E: 1^
 ok: 10^



#######
#  
#  5. REQUIREMENTS TRACEABILITY
#
#

=head1 REQUIREMENTS TRACEABILITY

  Requirement                                                      Test
 ---------------------------------------------------------------- ----------------------------------------------------------------


  Test                                                             Requirement
 ---------------------------------------------------------------- ----------------------------------------------------------------


=cut

#######
#  
#  6. NOTES
#
#

=head1 NOTES

copyright � 2003 Software Diamonds.

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

#######
#
#  2. REFERENCED DOCUMENTS
#
#
#

=head1 SEE ALSO

L<Test::Tech>

=back

=for html
<hr>
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
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>

=cut

__DATA__

File_Spec: Unix^
UUT: Test::Tech^
Revision: -^
End_User: General Public^
Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
Detail_Template: ^
STD2167_Template: ^
Version: ^
Classification: None^
Temp: temp.pl^
Demo: Tech.d^
Verify: Tech.t^


 T: 10^


 C:
    use File::Spec;

    use File::Package;
    my $fp = 'File::Package';

    use Text::Scrub;
    my $s = 'Text::Scrub';

    use File::SmartNL;
    my $snl = 'File::SmartNL';

    my $uut = 'Test::Tech';
^

VO: ^
 N: UUT loaded^
 A: $fp->is_package_loaded($uut)^
SE: '1'^
ok: 1^

DO: ^
 A: $snl->fin('techA0.t')^
 N:  Run test script techA0.t using Test 1.15^

 C:
    my $actual_results = `perl techA0.t`;
    $snl->fout('tech1.txt', $actual_results);
^

 A: $s->scrub_probe($s->scrub_file_line($actual_results))^
 E: $s->scrub_probe($s->scrub_file_line($snl->fin('techA2.txt')))^
ok: 2^

VO: ^
 N:  Run test script techB0.t using Test 1.24^

 C:
    $actual_results = `perl techB0.t`;
    $snl->fout('tech1.txt', $actual_results);
^

 A: $s->scrub_probe($s->scrub_file_line($actual_results))^
 E: $s->scrub_probe($s->scrub_file_line($snl->fin('techA2.txt')))^
ok: 3^

DO: ^
 A: $snl->fin('techC0.t')^
 N:  Run test script techC0.t using Test 1.24^

 C:
    $actual_results = `perl techC0.t`;
    $snl->fout('tech1.txt', $actual_results);
^

 A: $s->scrub_probe($s->scrub_file_line($actual_results))^
 E: $s->scrub_probe($s->scrub_file_line($snl->fin('techC2.txt')))^
ok: 4^

VO: ^
 N:  Run demo script techD0.d^

 C:
    use Data::Dumper;
    my $probe = 3;
    $actual_results = Dumper([0+$probe]);
    my $internal_storage = 'undetermine';
    if( $actual_results eq Dumper([3]) ) {
        $internal_storage = 'number';
    }
    elsif ( $actual_results eq Dumper(['3']) ) {
        $internal_storage = 'string';
    }

    $actual_results = `perl techD0.d`;
    $snl->fout('tech1.txt', $actual_results);

    #######
    # expected results depend upon the internal storage from numbers 
    #
    my $expected_results;
    if( $internal_storage eq 'string') {
        $expected_results = $snl->fin('techD2.txt');
    }
    else {
        $expected_results = $snl->fin('techD3.txt');
    }
^

 A: $s->scrub_probe($s->scrub_file_line($actual_results))^
 E: $s->scrub_probe($s->scrub_file_line($expected_results))^
ok: 5^

 N: config Test.TestLevel, read 1^
 C: my $tech = new Test::Tech^
 A: $tech->tech_config('Test.TestLevel')^
 E: 1^
ok: 6^

 N: config Test.TestLevel, read 1, write 2^
 A: $tech->tech_config('Test.TestLevel', 2)^
 E: 1^
ok: 7^

 N: config Test.TestLevel, read 2^
 A: $tech->tech_config('Test.TestLevel')^
 E: 2^
ok: 8^

 N: Test::TestLevel read 2^
 A: $Test::TestLevel^
 E: 2^
ok: 9^

 N: retore Test::TestLevel on finish^
 C: $tech->finish( )^
 A: $Test::TestLevel^
 E: 1^
ok: 10^


See_Also: L<Test::Tech>^

Copyright:
copyright � 2003 Software Diamonds.

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
^


HTML:
<hr>
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
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>
^



~-~
