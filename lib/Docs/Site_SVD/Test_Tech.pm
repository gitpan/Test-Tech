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
$VERSION = '0.05';
$DATE = '2003/06/19';
$FILE = __FILE__;

use vars qw(%INVENTORY);
%INVENTORY = (
    'lib/Docs/Site_SVD/Test_Tech.pm' => [qw(0.05 2003/06/19), 'revised 0.04'],
    'MANIFEST' => [qw(0.05 2003/06/19), 'generated, replaces 0.04'],
    'Makefile.PL' => [qw(0.05 2003/06/19), 'generated, replaces 0.04'],
    'README' => [qw(0.05 2003/06/19), 'generated, replaces 0.04'],
    'lib/Test/Tech.pm' => [qw(1.07 2003/06/19), 'revised 1.06'],
    't/Test/Tech/Tech.t' => [qw(0.06 2003/06/19), 'revised 0.05'],
    't/Test/Tech/techA0.t' => [qw(0.04 2003/06/19), 'new'],
    't/Test/Tech/techA2.txt' => [qw(0.05 2003/06/19), 'new'],
    't/Test/Tech/techB0.t' => [qw(0.01 2003/06/19), 'new'],
    't/Test/Tech/techC0.t' => [qw(0.01 2003/06/19), 'new'],
    't/Test/Tech/techD0.t' => [qw(0.04 2003/06/19), 'new'],
    't/Test/Tech/techD2.txt' => [qw(0.05 2003/06/19), 'new'],
    't/Test/Tech/techD3.txt' => [qw(0.05 2003/06/19), 'new'],
    't/Test/Tech/techE0.d' => [qw(0.02 2003/06/19), 'new'],
    't/Test/Tech/techE2.txt' => [qw(0.05 2003/06/19), 'new'],
    't/Test/Tech/techE3.txt' => [qw(0.05 2003/06/19), 'new'],
    't/Test/Tech/V001024/Test.pm' => [qw(1.24 2003/06/19), 'new'],
    't/Test/Tech/V001015/Test.pm' => [qw(1.15 2003/06/19), 'new'],

);

########
# The SVD::SVDmaker module uses the data after the __DATA__ 
# token to automatically generate the this file.
#
# Don't edit anything before __DATA_. Edit instead
# the data after the __DATA__ token.
#
# ANY CHANGES MADE BEFORE the  __DATA__ token WILL BE LOST
#
# the next time SVD::SVDmaker generates this file.
#
#



=head1 Title Page

 Software Version Description

 for

 Test::Tech - Extends the Test program module

 Revision: D

 Version: 0.05

 Date: 2003/06/19

 Prepared for: General Public 

 Prepared by:  SoftwareDiamonds.com E<lt>support@SoftwareDiamonds.comE<gt>

 Copyright: copyright © 2003 Software Diamonds

 Classification: NONE

=head1 1.0 SCOPE

This paragraph identifies and provides an overview
of the released files.

=head2 1.1 Indentification

This release is a collection of Perl modules that
extend the capabilities of the Perl language.

=head2 1.2 System overview

The system is the Perl programming language software.
The system does not have any hardware.
The Perl programming language contains two features that
are utilized by this release:

=over 4

=item 1

Program Modules to extend the languages

=item 2

Plain Old Documentation (POD) that may be embedded in the language

=back

These features are established by the referenced documents.

The L<Test::Tech|Test::Tech> module extends the capabilities of
the L<Test|Test> module as follows:

=over

=item *

If the compared variables are references, 
stingifies the refenced variable by passing the referenced
through I<Data::Dumper> before making the comparison.
Thus, Test::Tech can test almost any data structure. 
If the compare variables are not refernces, uses the &Test::ok
and &Test::skip directly.


=item *

Adds a method to skip the rest of the tests upon a critical failure

=item *

Adds a method to generate demos that appear as an interactive
session using the methods under test

=back

The L<Test::Tech|Test::Tech> module was originally developed for
the US DOD STD2167A bundle and is an integral part of the US DOD STD2167A bundle
of modules. 
The L<Test::Tech|Test::Tech> module was broken out from the design modules
because it may have uses outside the US DOD STD2167A bundle.

Two STD2167A bundle end user modules are as follows:

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
        DataPort::FileType::FormDB DataPort::DataFile Test::STD::STDutil
            Test::STDmaker ExtUtils::SVDmaker

Note the 
L<File::FileUtil|File::FileUtil>, 
L<Test::STD::STDutil|Test::STD::STDutil> 
L<Test::STD::Scrub|Test::STD::Scrub> 
program modules breaks up 
the Test::TestUtil program module
and Test::TestUtil has disappeared.

=head2 1.3 Document overview.

This document releases Test::Tech version 0.05
providing description of the inventory, installation
instructions and other information necessary to
utilize and track this release.

=head1 3.0 VERSION DESCRIPTION

All file specifications in this SVD
use the Unix operating
system file specification.

=head2 3.1 Inventory of materials released.

=head2 3.1.1 Files.

This document releases the file found
at the following repository:

   http://www.softwarediamonds/packages/Test-Tech-0.05
   http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/Test-Tech-0.05


=head2 3.1.2 Copyright.

copyright © 2003 Software Diamonds

=head2 3.1.3 Copyright holder contact.

 603 882-0846 E<lt>support@SoftwareDiamonds.comE<gt>

=head2 3.1.4 License.

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

=head2 3.2 Inventory of software contents

The content of the released, compressed, archieve file,
consists of the following files:

 file                                                         version date       comment
 ------------------------------------------------------------ ------- ---------- ------------------------
 lib/Docs/Site_SVD/Test_Tech.pm                               0.05    2003/06/19 revised 0.04
 MANIFEST                                                     0.05    2003/06/19 generated, replaces 0.04
 Makefile.PL                                                  0.05    2003/06/19 generated, replaces 0.04
 README                                                       0.05    2003/06/19 generated, replaces 0.04
 lib/Test/Tech.pm                                             1.07    2003/06/19 revised 1.06
 t/Test/Tech/Tech.t                                           0.06    2003/06/19 revised 0.05
 t/Test/Tech/techA0.t                                         0.04    2003/06/19 new
 t/Test/Tech/techA2.txt                                       0.05    2003/06/19 new
 t/Test/Tech/techB0.t                                         0.01    2003/06/19 new
 t/Test/Tech/techC0.t                                         0.01    2003/06/19 new
 t/Test/Tech/techD0.t                                         0.04    2003/06/19 new
 t/Test/Tech/techD2.txt                                       0.05    2003/06/19 new
 t/Test/Tech/techD3.txt                                       0.05    2003/06/19 new
 t/Test/Tech/techE0.d                                         0.02    2003/06/19 new
 t/Test/Tech/techE2.txt                                       0.05    2003/06/19 new
 t/Test/Tech/techE3.txt                                       0.05    2003/06/19 new
 t/Test/Tech/V001024/Test.pm                                  1.24    2003/06/19 new
 t/Test/Tech/V001015/Test.pm                                  1.15    2003/06/19 new


=head2 3.3 Changes

The changes to the last version are as follows:

=over 4

=item *

Added functions with the same name as the "Test" functions.
This make it easier to upgrade from "Test" to "Test::Tech"

=item * 

Added tests not only for Test 1.15 but also Test 1.24

=item *

Added tests for the new "Test" functions.


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

To installed the release file, use the CPAN module in the Perl release
or the INSTALL.PL script at the following web site:

 http://packages.SoftwareDiamonds.com

Follow the instructions for the the chosen installation software.

The distribution file is at the following respositories:

   http://www.softwarediamonds/packages/Test-Tech-0.05
   http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/Test-Tech-0.05


=head2 3.6.1 Installation support.

If there are installation problems or questions with the installation
contact

 603 882-0846 E<lt>support@SoftwareDiamonds.comE<gt>

=head2 3.6.2 Installation Tests.

Most Perl installation software will run the following test script(s)
as part of the installation:

 t/Test/Tech/Tech.t

=head2 3.7 Possible problems and known errors

The Test::Tech capabilites could be incorporated into the
Test program module and Test::Tech eliminated.

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
VERSION : 0.05^
REPOSITORY_DIR: packages^
FREEZE: 1^

PREVIOUS_DISTNAME:  ^
PREVIOUS_RELEASE: 0.04^
REVISION: D^
AUTHOR  : SoftwareDiamonds.com E<lt>support@SoftwareDiamonds.comE<gt>^

ABSTRACT: 
Objectify the Test module,
adds the skip_test method to the Test module, and 
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
'File::FileUtil' => 0,
'Test::STD::Scrub' => 0,
^

TESTS: t/Test/Tech/Tech.t^
EXE_FILES:  ^

CHANGES:
The changes to the last version are as follows:

\=over 4

\=item *

Added functions with the same name as the "Test" functions.
This make it easier to upgrade from "Test" to "Test::Tech"

\=item * 

Added tests not only for Test 1.15 but also Test 1.24

\=item *

Added tests for the new "Test" functions.


\=back

^

CAPABILITIES:
The L<Test::Tech|Test::Tech> module extends the capabilities of
the L<Test|Test> module as follows:

\=over

\=item *

If the compared variables are references, 
stingifies the refenced variable by passing the referenced
through I<Data::Dumper> before making the comparison.
Thus, Test::Tech can test almost any data structure. 
If the compare variables are not refernces, uses the &Test::ok
and &Test::skip directly.


\=item *

Adds a method to skip the rest of the tests upon a critical failure

\=item *

Adds a method to generate demos that appear as an interactive
session using the methods under test

\=back

The L<Test::Tech|Test::Tech> module was originally developed for
the US DOD STD2167A bundle and is an integral part of the US DOD STD2167A bundle
of modules. 
The L<Test::Tech|Test::Tech> module was broken out from the design modules
because it may have uses outside the US DOD STD2167A bundle.

Two STD2167A bundle end user modules are as follows:

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
        DataPort::FileType::FormDB DataPort::DataFile Test::STD::STDutil
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
The Test::Tech capabilites could be incorporated into the
Test program module and Test::Tech eliminated.
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


