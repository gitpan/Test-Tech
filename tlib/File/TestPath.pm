#!perl
#
# Documentation, copyright and license is at the end of this file.
#
package  File::TestPath;

use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '1.11';
$DATE = '2004/04/07';

use vars qw(@ISA @EXPORT_OK);
use Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw(test_lib2inc find_t_paths find_t_roots);

use SelfLoader;
use File::Spec;

1

__DATA__

#####
#
#
sub test_lib2inc
{
   #######
   # Add the library of the unit under test (UUT) to @INC
   #
   use Cwd;
   my @inc = @INC;
   my $work_dir = cwd();

   ######
   # Determine the operating system
   #
   my $OS; 
   unless ($OS = $^O) {   # on some perls $^O is not defined
       require Config;
       $OS = $Config::Config{'osname'};
   }

   ######
   # Find root path of the t directory
   #
   my ($vol,$dirs) = File::Spec->splitpath( $work_dir, 'nofile');
   my @dirs = File::Spec->splitdir( $dirs );
   while( @dirs && $dirs[-1] ne 't' ) { 
       chdir File::Spec->updir();
       pop @dirs;
   };
   chdir File::Spec->updir();
   my $lib_dir = cwd();

   #####
   # Add the root path of the t directory to @INC. Thus, all
   # modules in the t subtree may be loaded
   #
   $lib_dir =~ s|/|\\|g if $OS eq 'MSWin32';  # microsoft abberation
   unshift @INC, $lib_dir;  # include the current test directory

   #####
   # Add the root path of the tlib directory at the same level as t
   # @INC. Thus, this modules may be loaded. This is usually special
   # test software that may or may not be appropriate for the library
   #
   $lib_dir = File::Spec->catdir( cwd(), 'tlib' );
   $lib_dir =~ s|/|\\|g if $OS eq 'MSWin32';  # microsoft abberation
   unshift @INC, $lib_dir;

   #####
   # Add the root path of the lib directory at the same level as t
   # @INC. Thus, modules in this lib subtree will be loaded before
   # any other lib directories
   #
   $lib_dir = File::Spec->catdir( cwd(), 'lib' );
   $lib_dir =~ s|/|\\|g if $OS eq 'MSWin32';  # microsoft abberation
   unshift @INC, $lib_dir;

   #####
   # Restore the directory
   #
   chdir $work_dir if $work_dir;
   @inc;
 
}


####
# Find test roots
#
sub find_t_roots
{
   #######
   # Add t directories to the search path
   #
   my ($t_dir,@dirs,$vol);
   my %t_root=();
   my @t_root = ();
   foreach my $dir (@INC) {
       ($vol,$t_dir) = File::Spec->splitpath( $dir, 'nofile' );
       @dirs = File::Spec->splitdir($t_dir);
       pop @dirs;
       $t_dir = File::Spec->catdir( @dirs);
       $t_dir = File::Spec->catpath( $vol, $t_dir, '');
       next unless $t_dir;
       next if $t_root{$t_dir}; # eliminate dups
       $t_root{$t_dir} = 1;
       push @t_root, $t_dir;
   }
   @t_root
}


####
# Find test paths
#
sub find_t_paths
{
   #######
   # Add t directories to the search path
   #
   my ($t_dir,@dirs,$vol);
   my @t_path=();
   foreach my $dir (@INC) {
       ($vol,$t_dir) = File::Spec->splitpath( $dir, 'nofile' );
       @dirs = File::Spec->splitdir($t_dir);
       $dirs[-1] = 't';
       $t_dir = File::Spec->catdir( @dirs);
       $t_dir = File::Spec->catpath( $vol, $t_dir, '');
       push @t_path,$t_dir;
   }
   @t_path;
}





1


__END__

=head1 NAME

File::TestPath - Determines include directories for the test software

=head1 SYNOPSIS

  #######
  # Procedural (subroutine) interface
  # 
  use File::TestPath qw(test_lib2inc find_t_paths find_t_roots);

  @INC           = test_lib2inc()
  @t_path        = find_t_paths()
  @t_path        = find_t_roots()

  #######
  # Class interface
  # 
  use File::TestPath

  @INC           = File::TestPath->test_lib2inc()
  @t_path        = File::TestPath->find_t_paths()
  @t_path        = File::TestPath->find_t_roots()


=head1 DESCRIPTION

The test software is traditionally not part of the Perl lib subtree
since it is usually of little concern to the end-user. 
The normal run environment does not support loading test program
modules outside the lib subtrees. 

This module provides methods to access program modules and other files
in the test subtree.

=head2 find_t_paths method

This method operates on the assumption that the test files are a subtree to
a directory named I<t> and the I<t> directories are on the same level as
the last directory of each directory tree specified in I<@INC>.
If this assumption is not true, this method most likely will not behave
very well.

The I<find_t_paths> method returns the directory trees in I<@INC> with
the last directory changed to I<t>.

=head2 find_t_roots method

This method operates on the assumption that the test files are a subtree to
a directory named I<t> and the I<t> directories are on the same level as
the last directory of each directory tree specified in I<@INC>.
If this assumption is not true, this method most likely will not behave
very well.

The I<find_t_roots> method returns the directory trees in I<@INC> with
last directory drooped.

=head2 test_lib2inc method

 @INC           = File::TestPath->test_lib2inc()

The I<test_lib2inc> method walks up the directory tree from the current
directory until it finds a directory named "t".
It then pushs the parent to that directory, and a directory with "t" 
replaced by "lib" onto @INC.
The I<test_lib2inc> method returns the @INC before it is altered so
that the using method may return @INC to before calling I<test_lib2inc>.

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
 =>  
 =>     use File::Package;
 =>     my $fp = 'File::Package';

 =>     use File::TestPath;
 =>     my $uut = 'File::TestPath';
 =>     use File::TestPath;
 =>    unshift @INC,File::Spec->catdir(cwd(),'lib');
 =>    my @t_path = $uut->find_t_paths( );
 => $t_path[0]
 'E:\User\SoftwareDiamonds\installation\t\File\t'

 => shift @INC;
 =>    my @restore_inc = $uut->test_lib2inc( );

 =>    my ($vol,$dirs) = File::Spec->splitpath( cwd(), 'nofile');
 =>    my @dirs = File::Spec->splitdir( $dirs );
 =>    pop @dirs;
 =>    shift @dirs unless $dirs[0];
 =>    my @expected_lib = ();
 =>    my @t_root = @dirs;
 =>    pop @t_root;
 =>    unshift @expected_lib, File::Spec->catdir($vol, @t_root);
 =>    $dirs[-1] = 'lib';
 =>    unshift @expected_lib, File::Spec->catdir($vol, @dirs);
 =>    $dirs[-1] = 'tlib';
 =>    unshift @expected_lib, File::Spec->catdir($vol, @dirs);
 => join('; ', ($INC[0],$INC[1],$INC[2]))
 'E:\User\SoftwareDiamonds\installation\tlib; E:\User\SoftwareDiamonds\installation\lib; E:\User\SoftwareDiamonds\installation'

 => @INC = @restore_inc;
 =>    my $dir = File::Spec->catdir(cwd(),'lib');
 =>    $dir =~ s=/=\\=g if $^O eq 'MSWin32';
 =>    unshift @INC,$dir;
 =>    @t_path = $uut->find_t_roots( );
 =>    $dir = cwd();
 =>    $dir =~ s=/=\\=g if $^O eq 'MSWin32';
 => $t_path[0]
 'E:\User\SoftwareDiamonds\installation\t\File'

 => shift @INC

=head1 QUALITY ASSURANCE

Running the test script 'TestPath.t' found in
the "File-TestPath-$VERSION.tar.gz" distribution file verifies
the requirements for this module.

All testing software and documentation
stems from the 
Software Test Description (L<STD|Docs::US_DOD::STD>)
program module 't::File::TestPath',
found in the distribution file 
"File-TestPath-$VERSION.tar.gz". 

The 't::File::TestPath' L<STD|Docs::US_DOD::STD> POD contains
a tracebility matix between the
requirements established above for this module, and
the test steps identified by a
'ok' number from running the 'TestPath.t'
test script.

The t::File::TestPath' L<STD|Docs::US_DOD::STD>
program module '__DATA__' section contains the data 
to perform the following:

=over 4

=item *

to generate the test script 'TestPath.t'

=item *

generate the tailored 
L<STD|Docs::US_DOD::STD> POD in
the 't::File::TestPath' module, 

=item *

generate the 'TestPath.d' demo script, 

=item *

replace the POD demonstration section
herein with the demo script
'TestPath.d' output, and

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

place the 't::File::TestPath' at the same
level in the directory struture as the
directory holding the 'File::TestPath'
module

=item *

execute the following in any directory:

 tmake -test_verbose -replace -run -pm=t::File::TestPath

=back

=head1 NOTES

=head2 FILES

The installation of the
"File-TestPath-$VERSION.tar.gz" distribution file
installs the 'Docs::Site_SVD::File_TestPath'
L<SVD|Docs::US_DOD::SVD> program module.

The __DATA__ data section of the 
'Docs::Site_SVD::File_TestPath' contains all
the necessary data to generate the POD
section of 'Docs::Site_SVD::File_TestPath' and
the "File-TestPath-$VERSION.tar.gz" distribution file.

To make use of the 
'Docs::Site_SVD::File_TestPath'
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
__DATA__ section of the 'Docs::Site_SVD::File_TestPath'
module.
For example, any changes to
'File::TestPath' will impact the
at least 'Changes' field.

=item *

Execute the following:

 vmake readme_html all -pm=Docs::Site_SVD::File_TestPath

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

=back
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