
####
# 
# The module Build::SVDgen generated this file from the contents of
#
# E:\User\SoftwareDiamonds\installation\lib/Docs/Site_SVD/Test_Tech.pm 
#
# Don't edit this file, edit instead
#
# E:\User\SoftwareDiamonds\installation\lib/Docs/Site_SVD/Test_Tech.pm
#
#	ANY CHANGES MADE HERE WILL BE LOST
#
#       the next time Build::SVDgen generates it.
#
#

use ExtUtils::MakeMaker;

my $tests = join ' ',unix2os('t/Test/Tech/tech.t');
my $exe;
if( $exe ) {
  $exe = [join ' ',unix2os($exe)];
}
else {
   $exe = [];
}

WriteMakefile(
    NAME => 'Test::Tech',
    DISTNAME => 'Test-Tech',
    VERSION  => '0.02',
    dist     => {COMPRESS => 'gzip',
                'gz' => 'gz'},
    test     => {TESTS => $tests},
    PREREQ_PM => {'Test::TestUtil' => 0},
    EXE_FILES => $exe,

    ($] >= 5.005 ?     
        (AUTHOR    => 'SoftwareDiamonds.com E<lt>support@SoftwareDiamonds.comE<gt>',
        ABSTRACT  => 'Objectify the Test module,
adds the skip_test method to the Test module, and 
adds the ability to compare complex data structures to the Test module.', ) : ()),
);



use File::Spec;
use File::Spec::Unix;
sub unix2os
{
   my @file = ();
   foreach my $file (@_) {
       my (undef, $dir, $file_unix) = File::Spec::Unix->splitpath( $file );
       my @dir = File::Spec::Unix->splitdir( $dir );
       push @file, File::Spec->catfile( @dir, $file_unix);
   }
   @file;
}

