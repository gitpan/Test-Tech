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
$VERSION = '0.03';
$DATE = '2003/06/16';
$FILE = __FILE__;

use vars qw(%INVENTORY);
%INVENTORY = (
    'lib/Docs/Site_SVD/Test_Tech.pm' => [qw(0.03 2003/06/16), 'revised 0.02'],
    'MANIFEST' => [qw(0.03 2003/06/16), 'generated, replaces 0.02'],
    'Makefile.PL' => [qw(0.03 2003/06/16), 'generated, replaces 0.02'],
    'README' => [qw(0.03 2003/06/16), 'generated, replaces 0.02'],
    'lib/Test/Tech.pm' => [qw(1.05 2003/06/16), 'revised 1.04'],
    't/Test/Tech/tech.t' => [qw(0.04 2003/06/16), 'revised 0.03'],
    't/Test/Tech/tech0.d' => [qw(0.02 2003/06/13), 'unchanged'],
    't/Test/Tech/tech0.t' => [qw(0.03 2003/06/16), 'revised 0.02'],
    't/Test/Tech/tech2.txt' => [qw(0.01 2003/06/12), 'unchanged'],
    't/Test/Tech/tech3.txt' => [qw(0.02 2003/06/16), 'revised 0.01'],
    't/Test/Tech/tech4.txt' => [qw(0.03 2003/06/16), 'new'],
    't/Test/Tech/tech5.txt' => [qw(0.03 2003/06/16), 'new'],

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

 Revision: C

 Version: 0.03

 Date: 2003/06/16

 Prepared for: General Public 

 Prepared by:  SoftwareDiamonds.com E<lt>support@SoftwareDiamonds.comE<gt>

 Copyright: copyright � 2003 Software Diamonds

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

Correctly compares almost any data structure by passing the variables
through I<Data::Dumper> before making the comparision

=item *

Adds a method to skip the rest of the tests upon a critical failure

=item *

Adds a method to generate demos that appear as an interactive
session using the methods under test

=item *

Inherits the methods from the L<Test::Util|Test::Util> module

=back

The L<Test::Tech|Test::Tech> module is an integral part of the US DOD SDT2167A bundle
of modules.
The dependency of the program modules in the US DOD STD2167A bundle is as follows:

 Test::TestUtil
     Test::Tech
        DataPort::FileType::FormDB DataPort::DataFile
            Test::STDmaker ExtUtils::SVDmaker

=head2 1.3 Document overview.

This document releases Test::Tech version 0.03
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

   http://www.softwarediamonds/packages/Test-Tech-0.03
   http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/Test-Tech-0.03


=head2 3.1.2 Copyright.

copyright � 2003 Software Diamonds

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
 lib/Docs/Site_SVD/Test_Tech.pm                               0.03    2003/06/16 revised 0.02
 MANIFEST                                                     0.03    2003/06/16 generated, replaces 0.02
 Makefile.PL                                                  0.03    2003/06/16 generated, replaces 0.02
 README                                                       0.03    2003/06/16 generated, replaces 0.02
 lib/Test/Tech.pm                                             1.05    2003/06/16 revised 1.04
 t/Test/Tech/tech.t                                           0.04    2003/06/16 revised 0.03
 t/Test/Tech/tech0.d                                          0.02    2003/06/13 unchanged
 t/Test/Tech/tech0.t                                          0.03    2003/06/16 revised 0.02
 t/Test/Tech/tech2.txt                                        0.01    2003/06/12 unchanged
 t/Test/Tech/tech3.txt                                        0.02    2003/06/16 revised 0.01
 t/Test/Tech/tech4.txt                                        0.03    2003/06/16 new
 t/Test/Tech/tech5.txt                                        0.03    2003/06/16 new


=head2 3.3 Changes

The &Data::Dumper::Dumper subroutine stringifies the iternal Perl
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

   http://www.softwarediamonds/packages/Test-Tech-0.03
   http://www.perl.com/CPAN-local/authors/id/S/SO/SOFTDIA/Test-Tech-0.03


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

=over 4

=item L<Test::TestUtil|Test::TestUtil>

=item L<Test::Tech|Test::Tech>

=item L<DataPort::FileType::FormDB|DataPort::FileType::FormDB>

=item L<DataPort::DataFile|DataPort::DataFile>

=item L<Test::STDmaker|Test::STDmaker>

=item L<ExtUtils::SVDmake|ExtUtils::SVDmake>

=item L<US DOD Software Version Description (SVD) DID|Docs::US_DOD::SVD>

=item L<US DOD Software Test Description (STD) DID|Docs::US_DOD::STD>

=item L<US DOD Software Development Standard|Docs::US_DOD::STD2167A>

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
VERSION : 0.03^
REPOSITORY_DIR: packages^
FREEZE: 1^

PREVIOUS_DISTNAME:  ^
PREVIOUS_RELEASE: 0.02^
REVISION: C^
AUTHOR  : SoftwareDiamonds.com E<lt>support@SoftwareDiamonds.comE<gt>^

ABSTRACT: 
Objectify the Test module,
adds the skip_test method to the Test module, and 
adds the ability to compare complex data structures to the Test module.
^

TITLE   : Test::Tech - Extends the Test program module^
END_USER: General Public^
COPYRIGHT: copyright � 2003 Software Diamonds^
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
^

PREREQ_PM: 'Test::TestUtil' => 0^

TESTS: t/Test/Tech/tech.t^
EXE_FILES:  ^

CHANGES:
The &Data::Dumper::Dumper subroutine stringifies the iternal Perl
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
^

CAPABILITIES:
The L<Test::Tech|Test::Tech> module extends the capabilities of
the L<Test|Test> module as follows:

\=over

\=item *

Correctly compares almost any data structure by passing the variables
through I<Data::Dumper> before making the comparision

\=item *

Adds a method to skip the rest of the tests upon a critical failure

\=item *

Adds a method to generate demos that appear as an interactive
session using the methods under test

\=item *

Inherits the methods from the L<Test::Util|Test::Util> module

\=back

The L<Test::Tech|Test::Tech> module is an integral part of the US DOD SDT2167A bundle
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

\=over 4

\=item L<Test::TestUtil|Test::TestUtil>

\=item L<Test::Tech|Test::Tech>

\=item L<DataPort::FileType::FormDB|DataPort::FileType::FormDB>

\=item L<DataPort::DataFile|DataPort::DataFile>

\=item L<Test::STDmaker|Test::STDmaker>

\=item L<ExtUtils::SVDmake|ExtUtils::SVDmake>

\=item L<US DOD Software Version Description (SVD) DID|Docs::US_DOD::SVD>

\=item L<US DOD Software Test Description (STD) DID|Docs::US_DOD::STD>

\=item L<US DOD Software Development Standard|Docs::US_DOD::STD2167A>

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


