#!perl
#
# The copyright notice and plain old documentation (POD)
# are at the end of this file.
#
package  Docs::Site_SVD::Test_Tech;

use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE $FILE );
$VERSION = '0.08';
$DATE = '2003/06/24';
$FILE = __FILE__;

use vars qw(%INVENTORY);
%INVENTORY = (
    'lib/Docs/Site_SVD/Test_Tech.pm' => [qw(0.08 2003/06/24), 'revised 0.07'],
    'MANIFEST' => [qw(0.08 2003/06/24), 'generated, replaces 0.07'],
    'Makefile.PL' => [qw(0.08 2003/06/24), 'generated, replaces 0.07'],
    'README' => [qw(0.08 2003/06/24), 'generated, replaces 0.07'],
    'lib/Test/Tech.pm' => [qw(1.09 2003/06/24), 'unchanged'],
    't/Test/Tech/Tech.t' => [qw(0.09 2003/06/24), 'revised 0.08'],
    't/Test/Tech/techA0.t' => [qw(0.05 2003/06/21), 'unchanged'],
    't/Test/Tech/techA2.txt' => [qw(0.05 2003/06/19), 'unchanged'],
    't/Test/Tech/techB0.t' => [qw(0.02 2003/06/21), 'unchanged'],
    't/Test/Tech/techC0.t' => [qw(0.05 2003/06/24), 'unchanged'],
    't/Test/Tech/techC2.txt' => [qw(0.06 2003/06/21), 'unchanged'],
    't/Test/Tech/techC3.txt' => [qw(0.06 2003/06/21), 'unchanged'],
    't/Test/Tech/techD0.d' => [qw(0.02 2003/06/21), 'unchanged'],
    't/Test/Tech/techD2.txt' => [qw(0.06 2003/06/21), 'unchanged'],
    't/Test/Tech/techD3.txt' => [qw(0.06 2003/06/21), 'unchanged'],
    't/Test/Tech/V001024/Test.pm' => [qw(1.24 2003/06/19), 'unchanged'],
    't/Test/Tech/V001015/Test.pm' => [qw(1.15 2003/06/19), 'unchanged'],

);

########
# The ExtUtils::SVDmaker module uses the data after the __DATA__ 
# token to automatically generate this file.
#
# Don't edit anything before __DATA_. Edit instead
# the data after the __DATA__ token.
#
# ANY CHANGES MADE BEFORE the  __DATA__ token WILL BE LOST
#
# the next time ExtUtils::SVDmaker generates this file.
#
#



=head1 Title Page

 Software Version Description

 for

 Test::Tech - Extends the Test program module

 Revision: G

 Version: 0.08

 Date: 2003/06/24

 Prepared for: General Public 

 Prepared by:  SoftwareDiamonds.com E<lt>support@SoftwareDiamonds.comE<gt>

 Copyright: copyright © 2003 Software Diamonds

 Classification: NONE

=head1 1.0 SCOPE

This paragraph identifies and provides an overview
of the released files.

=head2 1.1 Identification

This release,
identified in L<3.2|/3.2 Inventory of software contents>,
is a collection of Perl modules that
extend the capabilities of the Perl language.

=head2 1.2 System overview

The system is the Perl programming language software.
As established by the Perl referenced documents,
program modules, such the 
"L<Test::Tech|Test::Tech>" module, extend the Perl language.

The "Test::Tech" module extends the capabilities of the "Test" module.
       
The design is simple. 
The "Test::Tech" module loads the "Test" module without exporting
any "Test" subroutines into the "Test::Tech" namespace.
There is a "Test::Tech" cover subroutine with the same name
for each "Test" module subroutine.
Each "Test::Tech" cover subroutine will call the &Test::$subroutine
before or after it adds any additional capabilities.
The "Test::Tech" module is a drop-in for the "Test" module.
Who said you cannot reuse code that is not object oriented?
This design proves if the driving reason to use object oriented
code is reusability, it is a very poor reason.

The "L<Test::Tech|Test::Tech>" module extends the capabilities of
the "L<Test|Test>" module as follows:

=over

=item *

If the compared variables are references, 
stingifies the referenced variable by passing the reference
through I<Data::Dumper> before making the comparison.
Thus, L<Test::Tech|Test::Tech> can test almost any data structure. 
If the compare variables are not refernces, use the &Test::ok
and &Test::skip directly.

=item *

Adds a method to skip the rest of the tests upon a critical failure

=item *

Adds a method to generate demos that appear as an interactive
session using the methods under test

=back

The "L<Test::Tech|Test::Tech>" module was originally developed for
the US DOD STD2167A bundle and is an integral part of the US DOD STD2167A bundle
of modules. 
The "L<Test::Tech|Test::Tech>" module was broken out from the design modules
because it may have uses outside the US DOD STD2167A bundle.

Two STD2167A bundle end user (functional interface) modules are as follows:

=over 4

=item L<Test::STDmaker|Test::STDmaker>

generates Test script, demo script and STD document POD from
a text database in the Data::Port::FileTYpe::FormDB format.

=item L<Test::SVDmaker|Test::SVDmaker>

generates SVD document POD and distribution *.tar.gz file including
a generated Makefile.PL README and MANIFEST file from 
a text database in the Data::Port::FileTYpe::FormDB format.

=back

The dependency of the program modules in the US DOD STD2167A bundle is as follows:
 
 File::FileUtil 
   Test::STD::Scrub
     Test::Tech
        DataPort::FileType::FormDB DataPort::DataFile DataPort::Maker Test::STD::Template
            Test::STDmaker ExtUtils::SVDmaker

Note the 
L<File::FileUtil|File::FileUtil>, 
L<Test::STD::STDutil|Test::STD::STDutil> 
L<Test::STD::Scrub|Test::STD::Scrub> 
program modules breaks up 
the Test::TestUtil program module
and Test::TestUtil has disappeared.

=head2 1.3 Document overview.

This document releases Test::Tech version 0.08
providing description of the inventory, installation
instructions and other information necessary to
utilize and track this release.

=head1 3.0 VERSION DESCRIPTION

All file specifications in this SVD
use the Unix operating
system file specification.

=head2 3.1 Inventory of materials released.

This document releases the file found
at the following repository(s):

   http://www.softwarediamonds/packages/Test-Tech-0.08
   http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/Test-Tech-0.08


Restrictions regarding duplication and license provisions
are as follows:

=over 4

=item Copyright.

copyright © 2003 Software Diamonds

=item Copyright holder contact.

 603 882-0846 E<lt>support@SoftwareDiamonds.comE<gt>

=item License.

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

=back

=head2 3.2 Inventory of software contents

The content of the released, compressed, archieve file,
consists of the following files:

 file                                                         version date       comment
 ------------------------------------------------------------ ------- ---------- ------------------------
 lib/Docs/Site_SVD/Test_Tech.pm                               0.08    2003/06/24 revised 0.07
 MANIFEST                                                     0.08    2003/06/24 generated, replaces 0.07
 Makefile.PL                                                  0.08    2003/06/24 generated, replaces 0.07
 README                                                       0.08    2003/06/24 generated, replaces 0.07
 lib/Test/Tech.pm                                             1.09    2003/06/24 unchanged
 t/Test/Tech/Tech.t                                           0.09    2003/06/24 revised 0.08
 t/Test/Tech/techA0.t                                         0.05    2003/06/21 unchanged
 t/Test/Tech/techA2.txt                                       0.05    2003/06/19 unchanged
 t/Test/Tech/techB0.t                                         0.02    2003/06/21 unchanged
 t/Test/Tech/techC0.t                                         0.05    2003/06/24 unchanged
 t/Test/Tech/techC2.txt                                       0.06    2003/06/21 unchanged
 t/Test/Tech/techC3.txt                                       0.06    2003/06/21 unchanged
 t/Test/Tech/techD0.d                                         0.02    2003/06/21 unchanged
 t/Test/Tech/techD2.txt                                       0.06    2003/06/21 unchanged
 t/Test/Tech/techD3.txt                                       0.06    2003/06/21 unchanged
 t/Test/Tech/V001024/Test.pm                                  1.24    2003/06/19 unchanged
 t/Test/Tech/V001015/Test.pm                                  1.15    2003/06/19 unchanged


=head2 3.3 Changes

Changes to the previous version are as follows:

Replace code in the 't/Tech/Tech.t' with
the test_lib2inc method in the "File::TestPath" module.

Previous changes are as follows:

=over 4

=item Test::Tester 0.01

Originated.

=item Test::Tester 0.02

Minor changes to this SVD.

=item Test::Tech 0.01

Due to a non-registered namespace conflict with CPAN,
changed the namespace from Test::Tester to Test::Tech

=item Test::Tech 0.02

Fixed prototype for &Test::Tech::skip_rest Test::Tech line 84

=item Test::Tech 0.03

The &Data::Dumper::Dumper subroutine stringifies the internal Perl
variable. Different Perls keep the have different internal formats
for numbers. Some keep them as binary numbers, while others as
strings. The ones that keep them as strings may be well spec.
In any case they have been let loose in the wild so the test 
scripts that use Data::Dumper must deal with them.

Added a probe to determine how a Perl stores its internal
numbers and added code to the test script to adjust for 
the difference in Perl

~~~~~

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

 ########
 # Probe Perl for internal storage method
 #
 my $probe = 3;
 my $actual = Dumper([0+$probe]);
 my $internal_storage = 'undetermine';
 if( $actual eq Dumper([5]) ) {
     $internal_storage = 'number';
 }
 elsif ( $actual eq Dumper(['3']) ) {
     $internal_storage = 'string';
 }

=item Test::Tech 0.04

=over 4

=item *

Added functions with the same name as the "Test" functions.
This make it easier to upgrade from "Test" to "Test::Tech"

=item * 

Added tests not only for Test 1.15 but also Test 1.24

=item *

Added tests for the new "Test" functions.

=back

=item Test::Tech 0.05

Replaced using Test::Util that has disappeared with its
replacements: File::FileUtil, Test::STD::Scrub, Test::STD::STDutil

=item Test::Tech 0.06

This version changes the previous version but eliminating
all object methods. 
Since this module is built on the L<Test|Test> and the
L<Data::Dumper|Data::Dumper> modules, neither which
are objectified, 
there is little advantage in providing methods
where a large number of data is static for all objects.
In other words, all new objects are mostly same.

=item Test::Tech 0.07



=back

=head2 3.4 Adaptation data.

This installation requires that the installation site
has the Perl programming language installed.
Installation sites running Microsoft Operating systems require
the installation of Unix utilities. 
An excellent, highly recommended Unix utilities for Microsoft
operating systems is unxutils by Karl M. Syring.
A copy is available at the following web sites:

 http://unxutils.sourceforge.net
 http://packages.SoftwareDiamnds.com

There are no other additional requirements or tailoring needed of 
configurations files, adaptation data or other software needed for this
installation particular to any installation site.

=head2 3.5 Related documents.

There are no related documents needed for the installation and
test of this release.

=head2 3.6 Installation instructions.

Instructions for installation, installation tests
and installation support are as follows:

=over 4

=item Installation Instructions.

To installed the release file, use the CPAN module in the Perl release
or the INSTALL.PL script at the following web site:

 http://packages.SoftwareDiamonds.com

Follow the instructions for the the chosen installation software.

The distribution file is at the following respositories:

   http://www.softwarediamonds/packages/Test-Tech-0.08
   http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/Test-Tech-0.08


=item Prerequistes.

'File::SmartNL' => 0,
'File::Package' => 0,
'File::TestPath' => 0,
'Test::STD::Scrub' => 0,

=item Security, privacy, or safety precautions.

None.

=item Installation Tests.

Most Perl installation software will run the following test script(s)
as part of the installation:

 t/Test/Tech/Tech.t

=item Installation support.

If there are installation problems or questions with the installation
contact

 603 882-0846 E<lt>support@SoftwareDiamonds.comE<gt>

=back

=head2 3.7 Possible problems and known errors

Known issues are as follows:

=over 4

=item Merge with the "Test" module

The "Test::Tech" capabilites could be incorporated into the
"Test" program module and "Test::Tech" eliminated.

=item TestLevel and Program_Lines

The "Test" module does not take the I<$TestLevel> value
into account where it chooses the module to load the
I<%Program_Line> hash. 
Since the L<Test::Tech> module adds a module layer in between
the L<Test> module that the test script, the I<$TestLevel>
must be set to 1. 
Thus, the L<Test> module loads the L<Test::Tech> module into
I<%Program_Line> hash instead of the Module Under Test.

=item "Data::Dumper" stringification not portable

For numeric arrays, "L<Data::Dumper|Data::Dumper>" module will not
stringify them the same for all Perls. The below Perl code will
produce different results for different Perls

 $probe = 3;
 $actual = Dumper([0+$probe]);

For Perl v5.6.1 MSWin32-x86-multi-thread, ActiveState build 631, binary,
the results will be '[\'3\']'  
while for Perl version 5.008 for solaris the results will be '[3]'. 

The '[\'3\']' results is probable wrong, and the Perls that produce
them are mutants that should be hunted down and killed.

=back

=head1 4.0 NOTES

The following are useful acronyms:

=over 4

=item .d

extension for a Perl demo script file

=item .pm

extension for a Perl Library Module

=item .t

extension for a Perl test script file

=item DID

Data Item Description

=item DOD

Department of Defense

=item POD

Plain Old Documentation

=item STD

Software Test Description

=item SVD

Software Version Description

=item US

United States

=back

=head1 2.0 SEE ALSO

Modules with end-user functional interfaces 
relating to US DOD 2167A automation are
as follows:

=over 4

=item L<Test::STDmaker|Test::STDmaker>

=item L<ExtUtils::SVDmaker|ExtUtils::SVDmaker>

=item L<DataPort::FileType::FormDB|DataPort::FileType::FormDB>

=item L<DataPort::DataFile|DataPort::DataFile>

=item L<Test::Tech|Test::Tech>

=item L<Test|Test>

=item L<Data::Dumper|Data::Dumper>

=item L<Test::STD::Scrub|Test::STD::Scrub>

=item L<Test::STD::STDutil|Test::STD::STDutil>

=item L<File::FileUtil|File::FileUtil>

=back

The design modules for L<Test::STDmaker|Test::STDmaker>
have no other conceivable use then to support the
L<Test::STDmaker|Test::STDmaker> functional interface. 
The  L<Test::STDmaker|Test::STDmaker>
design modules are as follows:

=over 4

=item L<Test::STD::Check|Test::STD::Check>

=item L<Test::STD::FileGen|Test::STD::FileGen>

=item L<Test::STD::STD2167|Test::STD::STD2167>

=item L<Test::STD::STDgen|Test::STD::STDgen>

=item L<Test::STDtype::Demo|Test::STDtype::Demo>

=item L<Test::STDtype::STD|Test::STDtype::STD>

=item L<Test::STDtype::Verify|Test::STDtype::Verify>

=back


Some US DOD 2167A Software Development Standard, DIDs and
other related documents that complement the 
US DOD 2167A automation are as follows:

=over 4

=item L<US DOD Software Development Standard|Docs::US_DOD::STD2167A>

=item L<US DOD Specification Practices|Docs::US_DOD::STD490A>

=item L<Computer Operation Manual (COM) DID|Docs::US_DOD::COM>

=item L<Computer Programming Manual (CPM) DID)|Docs::US_DOD::CPM>

=item L<Computer Resources Integrated Support Document (CRISD) DID|Docs::US_DOD::CRISD>

=item L<Computer System Operator's Manual (CSOM) DID|Docs::US_DOD::CSOM>

=item L<Database Design Description (DBDD) DID|Docs::US_DOD::DBDD>

=item L<Engineering Change Proposal (ECP) DID|Docs::US_DOD::ECP>

=item L<Firmware support Manual (FSM) DID|Docs::US_DOD::FSM>

=item L<Interface Design Document (IDD) DID|Docs::US_DOD::IDD>

=item L<Interface Requirements Specification (IRS) DID|Docs::US_DOD::IRS>

=item L<Operation Concept Description (OCD) DID|Docs::US_DOD::OCD>

=item L<Specification Change Notice (SCN) DID|Docs::US_DOD::SCN>

=item L<Software Design Specification (SDD) DID|Docs::US_DOD::SDD>

=item L<Software Development Plan (SDP) DID|Docs::US_DOD::SDP> 

=item L<Software Input and Output Manual (SIOM) DID|Docs::US_DOD::SIOM>

=item L<Software Installation Plan (SIP) DID|Docs::US_DOD::SIP>

=item L<Software Programmer's Manual (SPM) DID|Docs::US_DOD::SPM>

=item L<Software Product Specification (SPS) DID|Docs::US_DOD::SPS>

=item L<Software Requirements Specification (SRS) DID|Docs::US_DOD::SRS>

=item L<System or Segment Design Document (SSDD) DID|Docs::US_DOD::SSDD>

=item L<System or Subsystem Specification (SSS) DID|Docs::US_DOD::SSS>

=item L<Software Test Description (STD) DID|Docs::US_DOD::STD>

=item L<Software Test Plan (STP) DID|Docs::US_DOD::STP>

=item L<Software Test Report (STR) DID|Docs::US_DOD::STR>

=item L<Software Transition Plan (STrP) DID|Docs::US_DOD::STrP>

=item L<Software User Manual (SUM) DID|Docs::US_DOD::SUM>

=item L<Software Version Description (SVD) DID|Docs::US_DOD::SVD>

=item L<Version Description Document (VDD) DID|Docs::US_DOD::VDD>

=back

=for html
<hr>
<p><br>
<!-- BLK ID="PROJECT_MANAGEMENT" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="NOTICE" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="OPT-IN" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>

=cut

1;

__DATA__

DISTNAME: Test-Tech^
REPOSITORY_DIR: packages^

VERSION : 0.08^
FREEZE: 1^
PREVIOUS_DISTNAME:  ^
PREVIOUS_RELEASE: 0.07^
REVISION: G^

AUTHOR  : SoftwareDiamonds.com E<lt>support@SoftwareDiamonds.comE<gt>^
ABSTRACT: 
The "Test::Tech" module extends the capabilities of the "Test" module.
It adds the skip_test method to the Test module, and 
adds the ability to compare complex data structures to the Test module.
^

TITLE   : Test::Tech - Extends the Test program module^
END_USER: General Public^
COPYRIGHT: copyright © 2003 Software Diamonds^
CLASSIFICATION: NONE^
TEMPLATE:  ^
CSS: help.css^
SVD_FSPEC: Unix^

REPOSITORY: 
  http://www.softwarediamonds/packages/
  http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/
^

COMPRESS: gzip^
COMPRESS_SUFFIX: gz^

CHANGE2CURRENT:  ^

RESTRUCTURE:  ^

AUTO_REVISE: 
lib/Test/Tech.pm
t/Test/Tech/*
t/Test/Tech/V001024/*
t/Test/Tech/V001015/*
^

PREREQ_PM: 
'File::SmartNL' => 0,
'File::Package' => 0,
'File::TestPath' => 0,
'Test::STD::Scrub' => 0,
^

TESTS: t/Test/Tech/Tech.t^
EXE_FILES:  ^

CHANGES:

Changes to the previous version are as follows:

Replace code in the 't/Tech/Tech.t' with
the test_lib2inc method in the "File::TestPath" module.

Previous changes are as follows:

\=over 4

\=item Test::Tester 0.01

Originated.

\=item Test::Tester 0.02

Minor changes to this SVD.

\=item Test::Tech 0.01

Due to a non-registered namespace conflict with CPAN,
changed the namespace from Test::Tester to Test::Tech

\=item Test::Tech 0.02

Fixed prototype for &Test::Tech::skip_rest Test::Tech line 84

\=item Test::Tech 0.03

The &Data::Dumper::Dumper subroutine stringifies the internal Perl
variable. Different Perls keep the have different internal formats
for numbers. Some keep them as binary numbers, while others as
strings. The ones that keep them as strings may be well spec.
In any case they have been let loose in the wild so the test 
scripts that use Data::Dumper must deal with them.

Added a probe to determine how a Perl stores its internal
numbers and added code to the test script to adjust for 
the difference in Perl

~~~~~

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

 ########
 # Probe Perl for internal storage method
 #
 my $probe = 3;
 my $actual = Dumper([0+$probe]);
 my $internal_storage = 'undetermine';
 if( $actual eq Dumper([5]) ) {
     $internal_storage = 'number';
 }
 elsif ( $actual eq Dumper(['3']) ) {
     $internal_storage = 'string';
 }

\=item Test::Tech 0.04

\=over 4

\=item *

Added functions with the same name as the "Test" functions.
This make it easier to upgrade from "Test" to "Test::Tech"

\=item * 

Added tests not only for Test 1.15 but also Test 1.24

\=item *

Added tests for the new "Test" functions.

\=back

\=item Test::Tech 0.05

Replaced using Test::Util that has disappeared with its
replacements: File::FileUtil, Test::STD::Scrub, Test::STD::STDutil

\=item Test::Tech 0.06

This version changes the previous version but eliminating
all object methods. 
Since this module is built on the L<Test|Test> and the
L<Data::Dumper|Data::Dumper> modules, neither which
are objectified, 
there is little advantage in providing methods
where a large number of data is static for all objects.
In other words, all new objects are mostly same.

\=item Test::Tech 0.07



\=back

^

CAPABILITIES:
The system is the Perl programming language software.
As established by the Perl referenced documents,
program modules, such the 
"L<Test::Tech|Test::Tech>" module, extend the Perl language.

The "Test::Tech" module extends the capabilities of the "Test" module.
       
The design is simple. 
The "Test::Tech" module loads the "Test" module without exporting
any "Test" subroutines into the "Test::Tech" namespace.
There is a "Test::Tech" cover subroutine with the same name
for each "Test" module subroutine.
Each "Test::Tech" cover subroutine will call the &Test::$subroutine
before or after it adds any additional capabilities.
The "Test::Tech" module is a drop-in for the "Test" module.
Who said you cannot reuse code that is not object oriented?
This design proves if the driving reason to use object oriented
code is reusability, it is a very poor reason.

The "L<Test::Tech|Test::Tech>" module extends the capabilities of
the "L<Test|Test>" module as follows:

\=over

\=item *

If the compared variables are references, 
stingifies the referenced variable by passing the reference
through I<Data::Dumper> before making the comparison.
Thus, L<Test::Tech|Test::Tech> can test almost any data structure. 
If the compare variables are not refernces, use the &Test::ok
and &Test::skip directly.

\=item *

Adds a method to skip the rest of the tests upon a critical failure

\=item *

Adds a method to generate demos that appear as an interactive
session using the methods under test

\=back

The "L<Test::Tech|Test::Tech>" module was originally developed for
the US DOD STD2167A bundle and is an integral part of the US DOD STD2167A bundle
of modules. 
The "L<Test::Tech|Test::Tech>" module was broken out from the design modules
because it may have uses outside the US DOD STD2167A bundle.

Two STD2167A bundle end user (functional interface) modules are as follows:

\=over 4

\=item L<Test::STDmaker|Test::STDmaker>

generates Test script, demo script and STD document POD from
a text database in the Data::Port::FileTYpe::FormDB format.

\=item L<Test::SVDmaker|Test::SVDmaker>

generates SVD document POD and distribution *.tar.gz file including
a generated Makefile.PL README and MANIFEST file from 
a text database in the Data::Port::FileTYpe::FormDB format.

\=back

The dependency of the program modules in the US DOD STD2167A bundle is as follows:
 
 File::FileUtil 
   Test::STD::Scrub
     Test::Tech
        DataPort::FileType::FormDB DataPort::DataFile DataPort::Maker Test::STD::Template
            Test::STDmaker ExtUtils::SVDmaker

Note the 
L<File::FileUtil|File::FileUtil>, 
L<Test::STD::STDutil|Test::STD::STDutil> 
L<Test::STD::Scrub|Test::STD::Scrub> 
program modules breaks up 
the Test::TestUtil program module
and Test::TestUtil has disappeared.
^

PROBLEMS:
Known issues are as follows:

\=over 4

\=item Merge with the "Test" module

The "Test::Tech" capabilites could be incorporated into the
"Test" program module and "Test::Tech" eliminated.

\=item TestLevel and Program_Lines

The "Test" module does not take the I<$TestLevel> value
into account where it chooses the module to load the
I<%Program_Line> hash. 
Since the L<Test::Tech> module adds a module layer in between
the L<Test> module that the test script, the I<$TestLevel>
must be set to 1. 
Thus, the L<Test> module loads the L<Test::Tech> module into
I<%Program_Line> hash instead of the Module Under Test.

\=item "Data::Dumper" stringification not portable

For numeric arrays, "L<Data::Dumper|Data::Dumper>" module will not
stringify them the same for all Perls. The below Perl code will
produce different results for different Perls

 $probe = 3;
 $actual = Dumper([0+$probe]);

For Perl v5.6.1 MSWin32-x86-multi-thread, ActiveState build 631, binary,
the results will be '[\'3\']'  
while for Perl version 5.008 for solaris the results will be '[3]'. 

The '[\'3\']' results is probable wrong, and the Perls that produce
them are mutants that should be hunted down and killed.

\=back
^

DOCUMENT_OVERVIEW:
This document releases ${NAME} version ${VERSION}
providing description of the inventory, installation
instructions and other information necessary to
utilize and track this release.
^

LICENSE:
Software Diamonds permits the redistribution
and use in source and binary forms, with or
without modification, provided that the 
following conditions are met: 

\=over 4

\=item 1

Redistributions of source code, modified or unmodified
must retain the above copyright notice, this list of
conditions and the following disclaimer. 

\=item 2

Redistributions in binary form must 
reproduce the above copyright notice,
this list of conditions and the following 
disclaimer in the documentation and/or
other materials provided with the
distribution.

\=back

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

INSTALLATION:
To installed the release file, use the CPAN module in the Perl release
or the INSTALL.PL script at the following web site:

 http://packages.SoftwareDiamonds.com

Follow the instructions for the the chosen installation software.

The distribution file is at the following respositories:

${REPOSITORY}
^

SUPPORT: 603 882-0846 E<lt>support@SoftwareDiamonds.comE<gt>^

NOTES:
The following are useful acronyms:

\=over 4

\=item .d

extension for a Perl demo script file

\=item .pm

extension for a Perl Library Module

\=item .t

extension for a Perl test script file

\=item DID

Data Item Description

\=item DOD

Department of Defense

\=item POD

Plain Old Documentation

\=item STD

Software Test Description

\=item SVD

Software Version Description

\=item US

United States

\=back
^

SEE_ALSO:
Modules with end-user functional interfaces 
relating to US DOD 2167A automation are
as follows:

\=over 4

\=item L<Test::STDmaker|Test::STDmaker>

\=item L<ExtUtils::SVDmaker|ExtUtils::SVDmaker>

\=item L<DataPort::FileType::FormDB|DataPort::FileType::FormDB>

\=item L<DataPort::DataFile|DataPort::DataFile>

\=item L<Test::Tech|Test::Tech>

\=item L<Test|Test>

\=item L<Data::Dumper|Data::Dumper>

\=item L<Test::STD::Scrub|Test::STD::Scrub>

\=item L<Test::STD::STDutil|Test::STD::STDutil>

\=item L<File::FileUtil|File::FileUtil>

\=back

The design modules for L<Test::STDmaker|Test::STDmaker>
have no other conceivable use then to support the
L<Test::STDmaker|Test::STDmaker> functional interface. 
The  L<Test::STDmaker|Test::STDmaker>
design modules are as follows:

\=over 4

\=item L<Test::STD::Check|Test::STD::Check>

\=item L<Test::STD::FileGen|Test::STD::FileGen>

\=item L<Test::STD::STD2167|Test::STD::STD2167>

\=item L<Test::STD::STDgen|Test::STD::STDgen>

\=item L<Test::STDtype::Demo|Test::STDtype::Demo>

\=item L<Test::STDtype::STD|Test::STDtype::STD>

\=item L<Test::STDtype::Verify|Test::STDtype::Verify>

\=back


Some US DOD 2167A Software Development Standard, DIDs and
other related documents that complement the 
US DOD 2167A automation are as follows:

\=over 4

\=item L<US DOD Software Development Standard|Docs::US_DOD::STD2167A>

\=item L<US DOD Specification Practices|Docs::US_DOD::STD490A>

\=item L<Computer Operation Manual (COM) DID|Docs::US_DOD::COM>

\=item L<Computer Programming Manual (CPM) DID)|Docs::US_DOD::CPM>

\=item L<Computer Resources Integrated Support Document (CRISD) DID|Docs::US_DOD::CRISD>

\=item L<Computer System Operator's Manual (CSOM) DID|Docs::US_DOD::CSOM>

\=item L<Database Design Description (DBDD) DID|Docs::US_DOD::DBDD>

\=item L<Engineering Change Proposal (ECP) DID|Docs::US_DOD::ECP>

\=item L<Firmware support Manual (FSM) DID|Docs::US_DOD::FSM>

\=item L<Interface Design Document (IDD) DID|Docs::US_DOD::IDD>

\=item L<Interface Requirements Specification (IRS) DID|Docs::US_DOD::IRS>

\=item L<Operation Concept Description (OCD) DID|Docs::US_DOD::OCD>

\=item L<Specification Change Notice (SCN) DID|Docs::US_DOD::SCN>

\=item L<Software Design Specification (SDD) DID|Docs::US_DOD::SDD>

\=item L<Software Development Plan (SDP) DID|Docs::US_DOD::SDP> 

\=item L<Software Input and Output Manual (SIOM) DID|Docs::US_DOD::SIOM>

\=item L<Software Installation Plan (SIP) DID|Docs::US_DOD::SIP>

\=item L<Software Programmer's Manual (SPM) DID|Docs::US_DOD::SPM>

\=item L<Software Product Specification (SPS) DID|Docs::US_DOD::SPS>

\=item L<Software Requirements Specification (SRS) DID|Docs::US_DOD::SRS>

\=item L<System or Segment Design Document (SSDD) DID|Docs::US_DOD::SSDD>

\=item L<System or Subsystem Specification (SSS) DID|Docs::US_DOD::SSS>

\=item L<Software Test Description (STD) DID|Docs::US_DOD::STD>

\=item L<Software Test Plan (STP) DID|Docs::US_DOD::STP>

\=item L<Software Test Report (STR) DID|Docs::US_DOD::STR>

\=item L<Software Transition Plan (STrP) DID|Docs::US_DOD::STrP>

\=item L<Software User Manual (SUM) DID|Docs::US_DOD::SUM>

\=item L<Software Version Description (SVD) DID|Docs::US_DOD::SVD>

\=item L<Version Description Document (VDD) DID|Docs::US_DOD::VDD>

\=back

^

HTML:
<hr>
<p><br>
<!-- BLK ID="PROJECT_MANAGEMENT" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="NOTICE" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="OPT-IN" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>
^
~-~


