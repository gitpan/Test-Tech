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
$VERSION = '0.01';
$DATE = '2003/06/13';
$FILE = __FILE__;

use vars qw(%INVENTORY);
%INVENTORY = (
    'lib/Docs/Site_SVD/Test_Tech.pm' => [qw(0.01 2003/06/13), 'revised 0.01'],
    'MANIFEST' => [qw(0.01 2003/06/13), 'generated, replaces 0.01'],
    'Makefile.PL' => [qw(0.01 2003/06/13), 'generated, replaces 0.01'],
    'README' => [qw(0.01 2003/06/13), 'generated, replaces 0.01'],
    'lib/Test/Tech.pm' => [qw(1.03 2003/06/13), 'revised 1.02'],
    't/Test/Tech/tech.t' => [qw(0.02 2003/06/13), 'revised 0.01'],
    't/Test/Tech/tech0.d' => [qw(0.02 2003/06/13), 'revised 0.01'],
    't/Test/Tech/tech0.t' => [qw(0.02 2003/06/13), 'revised 0.01'],
    't/Test/Tech/tech2.txt' => [qw(0.01 2003/06/12), 'unchanged'],
    't/Test/Tech/tech3.txt' => [qw(0.01 2003/06/12), 'unchanged'],

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

 Test::Tech - Extends the Test:: program module

 Revision: -

 Version: 0.01

 Date: 2003/06/13

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

The Test::Tech module extends the capabilities of
the Test module as follows:

=over

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

 Test::TestUtil
     Test::Tech
        DataPort::FileType::FormDB DataPort::DataFile
            Test::STDmaker ExtUtils::SVDmaker

=head2 1.3 Document overview.

This document releases Test::Tech version 0.01
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

   http://www.softwarediamonds/packages/Test-Tech-0.01
   http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/Test-Tech-0.01


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
 lib/Docs/Site_SVD/Test_Tech.pm                               0.01    2003/06/13 revised 0.01
 MANIFEST                                                     0.01    2003/06/13 generated, replaces 0.01
 Makefile.PL                                                  0.01    2003/06/13 generated, replaces 0.01
 README                                                       0.01    2003/06/13 generated, replaces 0.01
 lib/Test/Tech.pm                                             1.03    2003/06/13 revised 1.02
 t/Test/Tech/tech.t                                           0.02    2003/06/13 revised 0.01
 t/Test/Tech/tech0.d                                          0.02    2003/06/13 revised 0.01
 t/Test/Tech/tech0.t                                          0.02    2003/06/13 revised 0.01
 t/Test/Tech/tech2.txt                                        0.01    2003/06/12 unchanged
 t/Test/Tech/tech3.txt                                        0.01    2003/06/12 unchanged


=head2 3.3 Changes

Due to a non-registered namespace conflict with CPAN,
changed the namespace from Test::Tester to Test::Tech

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

   http://www.softwarediamonds/packages/Test-Tech-0.01
   http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/Test-Tech-0.01


=head2 3.6.1 Installation support.

If there are installation problems or questions with the installation
contact

 603 882-0846 E<lt>support@SoftwareDiamonds.comE<gt>

=head2 3.6.2 Installation Tests.

Most Perl installation software will run the following test script(s)
as part of the installation:

 t/Test/Tech/tech.t

=head2 3.7 Possible problems and known errors

There are no open issures.

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

=item POD

Plain Old Documentation

=item STD

Software Test Description

=item SVD

Software Version Description

=back

=head1 2.0 SEE ALSO

 L<US DOD SVD|Docs::US_DOD::SVD>
 L<Test::TestUtil|Test::TestUtil>
 L<Test::Tech|Test::Tech>

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
VERSION : 0.01^
REPOSITORY_DIR: packages^
FREEZE: 1^

PREVIOUS_DISTNAME: Test-Tester^
PREVIOUS_RELEASE: 0.01^
AUTHOR  : SoftwareDiamonds.com E<lt>support@SoftwareDiamonds.comE<gt>^
ABSTRACT: Low level utilities originally developed to support Test::STDmaker^
REVISION: -^
TITLE   : Test::Tech - Extends the Test:: program module^
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

CHANGE2CURRENT:
return if $file =~ s|lib/Test/Tester.pm|lib/Test/Tech.pm|;
return if $file =~ s|Test/Tester/tester|Test/Tech/tech|;
^

RESTRUCTURE:  ^

AUTO_REVISE: 
lib/Test/Tech.pm
t/Test/Tech/*
^

PREREQ_PM: 'Test::TestUtil' => 0^

TESTS: t/Test/Tech/tech.t^
EXE_FILES:  ^

CHANGES: 
Due to a non-registered namespace conflict with CPAN,
changed the namespace from Test::Tester to Test::Tech
^

CAPABILITIES:
The Test::Tech module extends the capabilities of
the Test module as follows:

\=over

\=item *

Compare almost any data structure by passing variables
through I<Data::Dumper> before making the comparision

\=item *

Method to skip the rest of the tests upon a critical failure

\=item *

Method to generate demos that appear as an interactive
session using the methods under test

\=back

The Test::Tech module is an integral part of the US DOD SDT2167A bundle
of modules.
The dependency of the program modules in the US DOD STD2167A bundle is as follows:

 Test::TestUtil
     Test::Tech
        DataPort::FileType::FormDB DataPort::DataFile
            Test::STDmaker ExtUtils::SVDmaker

^

PROBLEMS: There are no open issures.^

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

\=item POD

Plain Old Documentation

\=item STD

Software Test Description

\=item SVD

Software Version Description

\=back
^

SEE_ALSO:
 L<US DOD SVD|Docs::US_DOD::SVD>
 L<Test::TestUtil|Test::TestUtil>
 L<Test::Tech|Test::Tech>
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


