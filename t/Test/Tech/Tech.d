#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.07';   # automatically generated file
$DATE = '2004/05/11';


##### Demonstration Script ####
#
# Name: Tech.d
#
# UUT: Test::Tech
#
# The module Test::STDmaker generated this demo script from the contents of
#
# t::Test::Tech::Tech 
#
# Don't edit this test script file, edit instead
#
# t::Test::Tech::Tech
#
#	ANY CHANGES MADE HERE TO THIS SCRIPT FILE WILL BE LOST
#
#       the next time Test::STDmaker generates this script file.
#
#

######
#
# The working directory is the directory of the generated file
#
use vars qw($__restore_dir__ @__restore_inc__ );

BEGIN {
    use Cwd;
    use File::Spec;
    use FindBin;
    use Test::Tech qw(demo is_skip plan skip_tests tech_config );

    ########
    # The working directory for this script file is the directory where
    # the test script resides. Thus, any relative files written or read
    # by this test script are located relative to this test script.
    #
    use vars qw( $__restore_dir__ );
    $__restore_dir__ = cwd();
    my ($vol, $dirs) = File::Spec->splitpath($FindBin::Bin,'nofile');
    chdir $vol if $vol;
    chdir $dirs if $dirs;

    #######
    # Pick up any testing program modules off this test script.
    #
    # When testing on a target site before installation, place any test
    # program modules that should not be installed in the same directory
    # as this test script. Likewise, when testing on a host with a @INC
    # restricted to just raw Perl distribution, place any test program
    # modules in the same directory as this test script.
    #
    use lib $FindBin::Bin;

    unshift @INC, File::Spec->catdir( cwd(), 'lib' ); 

}

END {

    #########
    # Restore working directory and @INC back to when enter script
    #
    @INC = @lib::ORIG_INC;
    chdir $__restore_dir__;

}

print << 'MSG';

~~~~~~ Demonstration overview ~~~~~
 
The results from executing the Perl Code 
follow on the next lines as comments. For example,

 2 + 2
 # 4

~~~~~~ The demonstration follows ~~~~~

MSG

demo( "\ \ \ \ use\ File\:\:Spec\;\
\
\ \ \ \ use\ File\:\:Package\;\
\ \ \ \ my\ \$fp\ \=\ \'File\:\:Package\'\;\
\
\ \ \ \ use\ Text\:\:Scrub\;\
\ \ \ \ my\ \$s\ \=\ \'Text\:\:Scrub\'\;\
\
\ \ \ \ use\ File\:\:SmartNL\;\
\ \ \ \ my\ \$snl\ \=\ \'File\:\:SmartNL\'\;\
\
\ \ \ \ my\ \$uut\ \=\ \'Test\:\:Tech\'\;"); # typed in command           
          use File::Spec;

    use File::Package;
    my $fp = 'File::Package';

    use Text::Scrub;
    my $s = 'Text::Scrub';

    use File::SmartNL;
    my $snl = 'File::SmartNL';

    my $uut = 'Test::Tech';; # execution

demo( "\$snl\-\>fin\(\'techA0\.t\'\)", # typed in command           
      $snl->fin('techA0.t')); # execution


print << "EOF";

 ##################
 # Run test script techA0.t using Test 1.15
 # 
 
EOF

demo( "\ \ \ \ my\ \$actual_results\ \=\ \`perl\ techA0\.t\`\;\
\ \ \ \ \$snl\-\>fout\(\'tech1\.txt\'\,\ \$actual_results\)\;"); # typed in command           
          my $actual_results = `perl techA0.t`;
    $snl->fout('tech1.txt', $actual_results);; # execution

print << "EOF";

 ##################
 # Run test script techA0.t using Test 1.15
 # 
 
EOF

demo( "\$s\-\>scrub_probe\(\$s\-\>scrub_file_line\(\$actual_results\)\)", # typed in command           
      $s->scrub_probe($s->scrub_file_line($actual_results))); # execution


demo( "\$snl\-\>fin\(\'techC0\.t\'\)", # typed in command           
      $snl->fin('techC0.t')); # execution


print << "EOF";

 ##################
 # Run test script techC0.t using Test 1.24
 # 
 
EOF

demo( "\ \ \ \ \$actual_results\ \=\ \`perl\ techC0\.t\`\;\
\ \ \ \ \$snl\-\>fout\(\'tech1\.txt\'\,\ \$actual_results\)\;"); # typed in command           
          $actual_results = `perl techC0.t`;
    $snl->fout('tech1.txt', $actual_results);; # execution

demo( "\$s\-\>scrub_probe\(\$s\-\>scrub_file_line\(\$actual_results\)\)", # typed in command           
      $s->scrub_probe($s->scrub_file_line($actual_results))); # execution


demo( "\$snl\-\>fin\(\'techE0\.t\'\)", # typed in command           
      $snl->fin('techE0.t')); # execution


print << "EOF";

 ##################
 # Run test script techE0.t using Test 1.24
 # 
 
EOF

demo( "\ \ \ \ \$actual_results\ \=\ \`perl\ techE0\.t\`\;\
\ \ \ \ \$snl\-\>fout\(\'tech1\.txt\'\,\ \$actual_results\)\;"); # typed in command           
          $actual_results = `perl techE0.t`;
    $snl->fout('tech1.txt', $actual_results);; # execution

demo( "\$s\-\>scrub_probe\(\$s\-\>scrub_file_line\(\$actual_results\)\)", # typed in command           
      $s->scrub_probe($s->scrub_file_line($actual_results))); # execution


demo( "\$snl\-\>fin\(\'techF0\.t\'\)", # typed in command           
      $snl->fin('techF0.t')); # execution


print << "EOF";

 ##################
 # Run test script techF0.t using Test 1.24
 # 
 
EOF

demo( "\ \ \ \ \$actual_results\ \=\ \`perl\ techF0\.t\`\;\
\ \ \ \ \$snl\-\>fout\(\'tech1\.txt\'\,\ \$actual_results\)\;"); # typed in command           
          $actual_results = `perl techF0.t`;
    $snl->fout('tech1.txt', $actual_results);; # execution

demo( "\$s\-\>scrub_probe\(\$s\-\>scrub_file_line\(\$actual_results\)\)", # typed in command           
      $s->scrub_probe($s->scrub_file_line($actual_results))); # execution


print << "EOF";

 ##################
 # config Test.ONFAIL, read undef
 # 
 
EOF

demo( "my\ \$tech\ \=\ new\ Test\:\:Tech"); # typed in command           
      my $tech = new Test::Tech; # execution

demo( "\$tech\-\>tech_config\(\'Test\.ONFAIL\'\)", # typed in command           
      $tech->tech_config('Test.ONFAIL')); # execution


print << "EOF";

 ##################
 # config Test.ONFAIL, read undef, write 0
 # 
 
EOF

demo( "\$tech\-\>tech_config\(\'Test\.ONFAIL\'\,0\)", # typed in command           
      $tech->tech_config('Test.ONFAIL',0)); # execution


print << "EOF";

 ##################
 # config Test.ONFAIL, read 0
 # 
 
EOF

demo( "\$tech\-\>tech_config\(\'Test\.ONFAIL\'\)", # typed in command           
      $tech->tech_config('Test.ONFAIL')); # execution


print << "EOF";

 ##################
 # $Test::ONFAIL, read 0
 # 
 
EOF

demo( "\$Test\:\:ONFAIL", # typed in command           
      $Test::ONFAIL); # execution


print << "EOF";

 ##################
 # restore Test.ONFAIL on finish
 # 
 
EOF

demo( "\ \ \ \ \ \$tech\-\>finish\(\ \)\;\
\ \ \ \ \ \$Test\:\:planned\ \=\ 1\;\ \ \#\ keep\ going"); # typed in command           
           $tech->finish( );
     $Test::planned = 1;  # keep going; # execution

print << "EOF";

 ##################
 # Test.ONFAIL restored by finish()
 # 
 
EOF

demo( "\$tech\-\>tech_config\(\'Test\.ONFAIL\'\)", # typed in command           
      $tech->tech_config('Test.ONFAIL')); # execution


demo( "unlink\ \'tech1\.txt\'"); # typed in command           
      unlink 'tech1.txt'; # execution

demo( "unlink\ \'tech1\.txt\'"); # typed in command           
      unlink 'tech1.txt'; # execution


=head1 NAME

Tech.d - demostration script for Test::Tech

=head1 SYNOPSIS

 Tech.d

=head1 OPTIONS

None.

=head1 COPYRIGHT

copyright © 2003 Software Diamonds.

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

## end of test script file ##

=cut

