#!perl
#
# Documentation, copyright and license is at the end of this file.
#
package  Data::Secs2;

use 5.001;
use strict;
use warnings;
use warnings::register;
use attributes;

use vars qw($VERSION $DATE $FILE);
$VERSION = '1.16';
$DATE = '2004/04/13';
$FILE = __FILE__;

use vars qw(@ISA @EXPORT_OK);
require Exporter;
@ISA=('Exporter');
@EXPORT_OK = qw(arrayify itemify listify neuterify scalarize 
    secsify stringify transify vectorize);

use Data::SecsPack;

###########
# The keys for hashes are not sorted. In order to
# establish a canonical form for the  hash, sort
# the hash and convert it to an array with a two
# leading control elements in the array. 
#
# The elements determine if the data is an array
# or a hash and its reference.
#
sub arrayify
{
     ######
     # This subroutine uses no object data; therefore,
     # drop any class or object.
     #
     shift @_ if UNIVERSAL::isa($_[0],__PACKAGE__);
     my ($var) = shift @_;

     my $class = ref($var);
     return $var unless $class;

     my $reftype = attributes::reftype($var);
     $class = $class ne $reftype ? $class : '';
     my @array = ($class,$reftype);

     #####
     # Add rest of the members to the canoncial array
     # based on underlying data type
     # 
     if ( $reftype eq 'HASH') {
         foreach (sort keys %$var ) {
             push @array, ($_, $var->{$_});
         }
     }
     elsif($reftype eq 'ARRAY') {
         push @array, @$var;
     }
     elsif($reftype eq 'SCALAR') {
         push @array, $$var;
     }
     elsif($reftype eq 'REF') {
         push @array, $$var;
     }
     elsif($reftype eq 'GLOB') {
         push @array,(*$var{SCALAR},*$var{ARRAY},*$var{HASH},*$var{CODE},
                          *$var{IO},*$var{NAME},*$var{PACKAGE},"*$var"),
     }
     else {
         warn "Unknown underlying data type\n";
         @array = '';
     }
     \@array;
}

#######
# 
#
my %format = (
  L  =>  0x00, #  List (length in elements)
  B  =>  0x20, #  Binary
  T  =>  0x24, #  Boolean
  A  =>  0x40, #  ASCII
  J  =>  0x44, #  JIS-8
 I8  =>  0x60, #  8-byte integer (signed)
 I1  =>  0x62, #  1-byte integer (unsigned)
 I2  =>  0x64, #  2-byte integer (unsigned)
 I4  =>  0x70, #  4-byte integer (unsigned)
 S8  =>  0x60, #  8-byte integer (unsigned)
 S1  =>  0x62, #  1-byte integer (unsigned)
 S2  =>  0x64, #  2-byte integer (unsigned)
 S4  =>  0x70, #  4-byte integer (unsigned)
 F4  =>  0x80, #  8-byte floating
 F8  =>  0x90, #  4-byte floating
 U8  =>  0xA0, #  8-byte integer (unsigned)
 U1  =>  0xA4, #  1-byte integer (unsigned)
 U2  =>  0xA8, #  2-byte integer (unsigned)
 U4  =>  0xB0, #  4-byte integer (unsigned)
);

sub itemify
{
     my ($format, @elements) = @_;

     my $error;
     my $options = {};
     if(ref($elements[-1]) eq 'ARRAY') {
         my %options = @{pop @elements};
         $options = \%options;
     }
     elsif( ref($elements[-1]) eq 'HASH' ) {
         $options = pop @elements;
     }

     my $elements = $elements[0];
     
     my $length;
     if(defined($options->{length}) && $options->{length}) {
         $length =  $options->{length};
     }
     else {
        my $bytes_per_element = 1;
        if( $format =~ /(\d+)/ ) {
            $bytes_per_element = $1;
        }       
        unless( $bytes_per_element ) {
             $error = "No bytes per element\n";
             return \$error;
        }
        $length = length($elements) / $bytes_per_element; 
     }

     my $string;
     if($options->{type} eq 'ascii') {
         $string = $options->{indent} . $format . '[' . $length . ']' ;
         return $string unless $length; # do not get space after A[0]
         if ($format =~ /[SUF]\d/ || $format eq 'T') {
             if(ref($elements) eq 'ARRAY') {
                 $string .= ' ' . (join ' ' , @$elements);
             }
             else {
                 my $numbers = Data::SecsPack->unpack_num($format, $elements);
                 return $numbers unless ref($numbers) eq 'ARRAY';
                 $string .= ' ' . (join ' ' , @$numbers);
             }
         }
         elsif ($format =~ /[AJB]/) {
             $string .= ($elements =~ /\n/) ? "\n" : ' ';
             $string .= $elements[0];
         } 
         elsif( $format !~ /[L]/ ) {
             $error =  "Unknown format $format\n";
             return \$error;
         }
     }
     else {
         my ($len_format,$len_num) = Data::SecsPack->pack_num('I', $length);
         unless(defined($len_format) && $len_format =~ /^U/ ) {
             $error =  "Element length number is not unsigned integer\n";
             return \$error;
         }
         my $len_size = length($len_num);
         unless($len_size < 4) {
             $error = "Number of elements in item too big\n";
             return \$error;
         }
         $string = pack ("C1",($format{$format}+$len_size)) . $len_num;
         return $string if $format eq 'L' || $length == 0;
         if ($format =~ /[SUF]\d/ || $format eq 'T') {
             if(ref($elements) eq 'ARRAY') {
                 ($format, my $number) = Data::SecsPack->pack_num($format, @$elements);
                 if(defined($format)) {
                     return $string . $elements;
                 }
                 else {
                     $error = 'Could not pack number\n';
                     return \$error;
                 }
             }
         }        
         $string .= $elements;
     }
     $string;
}



################
# This subroutine walks a nested data structure, and listify each level
# into a perlified SECII message. The assumption is that the nested 
# data structure consists of only references to Perl arrays, 
# Perl arrays are not arrays in the traditional sense where arrays
# are multi-dimensional. Perl arrays are always one dimemsion. The
# Perl language gives the appearance of mulit-dimension by its
# syntax which it converts to indexing into physical nested 
# single dimensional arrays (all elements are not layed out
# linear for a Perl multi-dimensional array syntax)
#
sub listify
{

     ######
     # This subroutine uses no object data; therefore,
     # drop any class or object.
     #
     shift @_ if UNIVERSAL::isa($_[0],__PACKAGE__);

     #########
     # Return an array, so going to walk the array, looking
     # for hash and array references to arrayify
     #
     # Use a stack for the walk instead of recusing. Easier
     # to maintain when the data is on a separate stack instead
     # of the call (return) stack and only the pertient data
     # is stored on the separate stack. The return stack does
     # not grow. Instead the separate recure stack grows.
     #
     my %dups = ();
     my @stack = ();
     my @index = ();

     #####
     # Perl format code
     my @list = ('U1','P');  
     my $i = 0;
     my @var = @_; # do not clobber @_ so make a copy
     my $var = \@var;
     my ($is_numeric,$format,$num,$ref,$ref_dup,@dup_index,$str);

     for(;;) {

        while($i < @$var) {

             ######
             # Index to the same reference structure in the nested data.
             # First number is the number of indices. The indices are
             # within each level of the nested listes.
             #
             $ref_dup = (ref($var->[$i])) ? "$var->[$i]"  : '';
             if( $dups{$ref_dup} ) {
                 @dup_index = @{$dups{$ref_dup}};
                 ($format,$num) = Data::SecsPack->pack_num('I',scalar @dup_index, @dup_index);
                 ($format,$num) = ('U1','0') unless defined($format); # what else can we do
                 push @list, ('L', '2', 'A', 'Index', $format, $num);
                 $i++;
                 next;
             }

             #####
             # Try to convert to a pack numeric array.
             if (ref($var->[$i]) eq 'ARRAY') {
                  
                 $is_numeric = 1;
                 foreach (@{$var->[$i]}) {
                    if ($_ !~ /\s*\S*\s*/ ) {
                        $is_numeric = 0;
                        last;
                    }
                 }
                 if($is_numeric) {
                     ($format,$num,$str) = Data::SecsPack->pack_num('I',@{$var->[$i]});
                     if(defined($format) && $str eq '') {
                         push @list, $format, $num;
                         $i++;
                         next;
                     }
                 }
             }

             $var->[$i] = arrayify( $var->[$i] );
             $ref = ref($var->[$i]);

             ####
             # If $var->[$i] is a reference it is a reference to an array of
             # an underlying data type or object that is arrayified.
             #
             if ($ref) {

                 my @ref_index = (@index, $i);
                 $dups{$ref_dup} = \@ref_index;

                 ########
                 # Nest for 'ARRAY' reference to the arrayified underlying data data
                 #
                 if($ref eq 'ARRAY' ) {
                     push @stack, $var;
                     push @index, $i;
                     $var = $var->[$i];
                     $i = 0;
                     push @list, ('L', scalar @$var);
                     next;
                 }
             }

             ########
             # Otherwise, a pure simple scalar
             # 
             else {

                 ######
                 # Try for a single packed number type
                 #
                 ($format,$num) = Data::SecsPack->pack_num('I',$var->[$i]);
                 if(defined($format)) {
                     push @list, $format, $num;
                 }

                 #####
                 # Else ascii  
                 else {
                     push @list, 'A', $var->[$i];
                 }

             }
             $i++;
         }

         #####
         # At the end of the current array, so go back
         # working on any array whose work was interupted
         # to work on the current array.
         #
         last unless @stack;   
         $i = pop @index;
         $i++;  
         $var = pop @stack;

    }

    ########
    # Listified unpacked SECSII message
    # 
    \@list;

}


#######
# 
#
my @bin_format = (
  'L',   #  0 List (length in elements)
   '',   #  1
   '',   #  2
   '',   #  3
   '',   #  4
   '',   #  5
   '',   #  6
   '',   #  7
  'B',   #  8 Binary
  'T',   #  9 Boolean
   '',   # 10
   '',   # 11
   '',   # 12
   '',   # 13
   '',   # 14
   '',   # 15
  'A',   # 16 ASCII
  'J',   # 17 JIS-8
   '',   # 18
   '',   # 19
   '',   # 20
   '',   # 21
   '',   # 22
   '',   # 23
 'S8',   # 24 8-byte integer (unsigned)
 'S1',   # 25 1-byte integer (unsigned)
 'S2',   # 26 2-byte integer (unsigned)
   '',   # 27
 'S4',   # 28 4-byte integer (unsigned)
   '',   # 29
   '',   # 30
   '',   # 31
 'F4',   # 32 8-byte floating
   '',   # 33
   '',   # 34
   '',   # 35
 'F8',   # 36 4-byte floating
   '',   # 37
   '',   # 38
   '',   # 39
 'U8',   # 40 8-byte integer (unsigned)
 'U1',   # 41 1-byte integer (unsigned)
 'U2',   # 42 2-byte integer (unsigned)
   '',   # 43
 'U4',   # 44 4-byte integer (unsigned)
);

sub neuterify
{

     ######
     # This subroutine uses no object data; therefore,
     # drop any class or object.
     #
     shift @_ if UNIVERSAL::isa($_[0],__PACKAGE__);
     my $binary_secs = shift;
     my $options = {};
     if( ref($_[0]) eq 'ARRAY' ) {
         my %options = @{$_[0]};
         $options = \%options;
     }
     elsif( ref($_[0]) eq 'HASH' ) {
         $options = $_[0];
     }
     else {
         my %options = @_;
         $options = \%options;
     }

     #####
     # Data format code S - Secsii  P - Perl
     my $format_code = 'S';
     $format_code = $options->{format_code} if $options->{format_code};

     my @format_item = unpack('C3',$binary_secs);
     my @list;
     if( $format_item[0] == 165 && $format_item[1] == 1 &&
        ($format_item[2] == 80 || $format_item[2] == 83) ) {
        @list = ();
        if($options->{format_code}) {
            substr($binary_secs,2,1) = $format_code;
        }
     }
     else {
        @list = ('U1',$format_code);
     }

     use integer;     
     my ($format, $bytes_per_element, $length_size, $length, $length_num);
     while($binary_secs) {

          #####
          # Decode format byte
          $format = unpack('C1',$binary_secs);
          $binary_secs = substr($binary_secs,1);
          $length_size = $format & 0x03;
          $format = $bin_format[($format & 0xFC) >> 2];
          unless($format) {
             return("Unknown SECSII format\n");
          }
          push @list,$format;

          #####
          # decode number of elements
          $bytes_per_element = $format =~ /(\d)$/ ? $1 : 1;
          $length = substr($binary_secs,0,$length_size);
          $binary_secs = substr($binary_secs,$length_size);
          $length_num = Data::SecsPack->unpack_num('U1', $length);
          unless(ref($length_num) eq 'ARRAY') {
             return("Bad length.");
          }
          $length_num = ${$length_num}[0];

          ######
          # Grab the elements
          if($format eq 'L') {
              push @list,$length_num;
          }
          elsif($length_num) {
              push @list,substr($binary_secs,0,$length_num);
              $binary_secs = substr($binary_secs,$length_num);  
          }
          else {
              push @list,'';
          }        
     }
     no integer;
     \@list;
}


#####
#
#
sub scalarize
{
     shift if UNIVERSAL::isa($_[0],__PACKAGE__);
     my ($i,$number,$format);
     for ($i=0; $i < @{$_[0]}; $i = $i +2) {
         if( $_[0]->[$i] =~  /[SUF]\d/ || $_[0]->[$i] eq 'T') {
             if( ref($_[0]->[$i+1]) eq 'ARRAY' ) {
                 ($format, $number) = Data::SecsPack->pack_num( $_[0]->[$i], @{$_[0]->[$i+1]} );
                 return $number unless defined $format;
                 $_[0]->[$i+1] = $number;
             }
         }
     }
     return '';
}


####
# Take the listify Perl structure and convert it to
# a readable ASCII format.
#
sub secsify
{
     shift @_ if UNIVERSAL::isa($_[0],__PACKAGE__);

     my @list = @{shift @_};  # separate copy so do not clobber @_;
     my $options = {};
     if( ref($_[0]) eq 'ARRAY' ) {
         my %options = @{$_[0]};
         $options = \%options;
     }
     elsif( ref($_[0]) eq 'HASH' ) {
         $options = $_[0];
     }
     else {
         my %options = @_;
         $options = \%options;
     }

     my $spaces = $options->{spaces};
     $spaces = '  ' unless $spaces;
     $options->{type} = 'ascii' unless $options->{type};   
     $options->{indent} = '' unless $options->{indent};
     $options->{length}=undef;

     my @level = ();

     my ($format, $length, $element);
     my $string = '';
     my $item;

     while (@list) {

         my $format = shift @list;
         if(@level && $level[-1] <= 0) {
             while (@level && $level[-1] <= 0) {pop @level};
             $options->{indent} = $spaces x scalar @level;
         }
         if ($format eq 'L') {
             $options->{length} = shift @list;
             unless($options->{length}) {
                 warn( "Unkown L length\n");
                 last;
             }
             $string .= itemify( $format, $options );
             $level[-1] -= 1 if @level;
             push @level, $options->{length};
             $options->{indent} = $spaces x scalar(@level);
             $options->{length}=undef;
         }
         elsif ($format =~ /[IUF]\d+/) {
             $item = itemify($format,shift @list, $options);
             return $item if ref($item);
             $string .= $item;
             $level[-1] -= 1 if @level;
         }
         elsif ($format =~ /[AJBT]/) {
             $item = itemify( $format, shift @list, $options);
             return $item if ref($item);
             $string .= $item;
             $level[-1] -= 1 if @level;
         }
         else {
             $item = "Unkown SECSII format $format\n";
             return \$item;
         }
         $string .= "\n" if substr($string, -1, 1) ne "\n" && $options->{type} =~ /asc/i;

     };

     ########
     # Stingified SECSII message of a Perl Nested Data
     # 
     $string;

}


sub transify
{

     ######
     # This subroutine uses no object data; therefore,
     # drop any class or object.
     #
     shift @_ if UNIVERSAL::isa($_[0],__PACKAGE__);
     my $ascii_secs = shift;
     my $options = {};
     if( ref($_[0]) eq 'ARRAY' ) {
         my %options = @{$_[0]};
         $options = \%options;
     }
     elsif( ref($_[0]) eq 'HASH' ) {
         $options = $_[0];
     }
     else {
         my %options = @_;
         $options = \%options;
     }

     my $format_code = 'S';
     $format_code = $options->{format_code} if $options->{format_code};

     #####
     # Data format code S - Secsii  P - Perl
     my @list = ('U1',$format_code);

     use integer;     
     my ($format, $byte_code, $bytes_per_element, $length);
     my (@open_list, $list_location, $list_close_char, $item_count, $counted_list);
     my ($open_char, $close_char, $esc_esc, $str);
     $list_close_char = '';
     $list_location = 0;
     $item_count = 0;
     $counted_list = 0;
     my (@integers,$integer);
     $ascii_secs =~ s/^\s*//s;
     while($ascii_secs) {

          ######
          # Try closing any open list 
          if(($list_close_char && $ascii_secs =~ s/^\s*\Q$list_close_char\E//s) || 
              ($counted_list && $counted_list <= $item_count) ) {
              
              if($list_close_char && $counted_list ==0) {
                  $list[$list_location] = $item_count;
              }
              if(@open_list) {
                  ($list_location,$list_close_char,$item_count,$counted_list) = @{$open_list[-1]};
                  pop @open_list;
              }
              else {
                  $list_close_char = '';
                  $list_location = 0;
                  $item_count = 0;
                  $counted_list = 0;
                  $close_char = '';
              }
              $ascii_secs =~ s/^\s*//s;
              next;

          }

          #####
          # Parse format code
          ($format,$byte_code) = ($1,$2) if $ascii_secs =~ s/^\s*(\S)(\d)?//;
          return "No format code\n\t$ascii_secs" unless($format);
          $bytes_per_element = $byte_code;
          $bytes_per_element = '' unless $bytes_per_element;
          $item_count++;
          $bytes_per_element = 1 unless $bytes_per_element;

          ######
          # Look for number of elements in brackets jammed tight
          # against the format code. If not there then going to be
          # doing some parentheses type work.
          #
          $length = undef;          
          $length = $1 if $ascii_secs =~ s/^s*\[\s*(\d+)\s*\]//s;
          unless (defined $length) {
              $length = $1 if $ascii_secs =~ s/^\s*\,\s*(\d+)//s;
          }
          my $skip = 1;
          if(substr($ascii_secs,0,2) eq '\r\n' || substr($ascii_secs,0,2) eq '\n\r') {
              $skip = 2;    
          }
          $ascii_secs = substr($ascii_secs,$skip);

          ######
          # If length is specified, go with it.  
          # 
          if(defined $length) {
              if($format eq 'L') {
                  push @open_list,[$list_location,$list_close_char,$item_count,$counted_list] if $list_location;
                  $list_location = scalar @list + 1;
                  $item_count = 0;
                  $counted_list = $length;
                  $list_close_char = '';
                  $close_char = '';
                  push @list,$format,$length;
              }

              ####
              # Grab the length number of characters from input stream
              elsif($format =~ /^[JAB]$/) {
                  if(0 < $length) {
                      push @list,$format,substr($ascii_secs,0,$length);
                      $ascii_secs = substr($ascii_secs,$length);
                  }
                  else {
                      push @list,$format,'';  # length 0 
                  }
              }

              #####
              # Count the numbers, should agree with length 
              elsif ($format =~ /^[IUSFT]$/)  {
                  if(0 < $length) {
                       ($ascii_secs, @integers) = Data::SecsPack->str2int($ascii_secs);
                       return "Wrong number of integers\n\t$ascii_secs" if($length != @integers);
                       push @list, Data::SecsPack->pack_int("$format$byte_code",@integers);
                  }
                  else {
                      push @list,$format,'';  # length 0 
                  }
                 
              }
              else {
                  return "Unkown format $format\n";
              }
              $ascii_secs =~ s/^\s*//s;
              next;
          }

          ######
          # Count the numbers
          if( $format =~ /^[UTISF]$/ ) {
              ($format,$integer,$ascii_secs) = Data::SecsPack->pack_num("$format$byte_code",$ascii_secs);
              if(defined $format) {
                  push @list,$format,$integer;
              }
              else {
                  return "Integer could not be packed.";
              }
          }

          elsif( $format =~ /^[LAJB]$/ ) {

              ######
              # Otherwise, look for parentheses type enclosing.  
              # 
              $open_char = $1 if $ascii_secs =~ s/^\s*(\S)//;
              if($open_char eq '(') {
                  $close_char = ')';
              }
              elsif($open_char eq '[') {
                  $close_char = ']';
              }
              elsif($open_char eq '{') {
                  $close_char = '}';
              }
              elsif($open_char eq '<') {
                  $close_char = '>';
              }
              else {
                  $close_char = $open_char;
              }

              ####
              # Need to save old list item count, list location, and start a new open list 
              if($format eq 'L') {

                  ####
                  # Note: For open list, there must be L at the even location. Does $list_location
                  # for an open list must always be odd and never can be zero.
                  push @open_list,[$list_location,$list_close_char,$item_count,$counted_list] if $list_location; 
                  $list_location = scalar @list + 1;
                  $item_count = 0;
                  $counted_list = 0;
                  $list_close_char = $close_char;
                  $close_char = '';
                  push @list,$format,0;
              }

              ####
              # Close a text string 
              else {

                  $str = '';
                  use integer;
                  for(;;) { 
                      unless($ascii_secs =~ s/(.*?)\Q$close_char\E//s) {
                          return "No matching $close_char for $open_char\n\t$ascii_secs";
                      }
                      $str .= $1;
                      ($esc_esc) = $str =~ /(\\+)$/;

                      #####
                      # close_char escaped 
                      if($esc_esc && length($esc_esc) % 2) {
                          $str .= $close_char;
                      }

                      else {
                          last;
                      }
                  }                   
                  no integer;
                  $close_char = '';
                  push @list,$format,$str;
              }
          }
          else  {
              return "Unkown format $format\n";
          }

          $ascii_secs =~ s/^\s*//s;
     }
     no integer;
     my $open_lists = scalar @open_list;
     $open_lists++ if $counted_list || $list_close_char;
     return "There are $open_lists open lists.\n" if $open_lists;
     \@list ;
}

#####
# If the variable is not a scalar,
# stringify it.
#
sub stringify
{
     shift if UNIVERSAL::isa($_[0],__PACKAGE__);
     return $_[0] unless ref($_[0]) ||  1 < @_;
     secsify( listify(@_) );

}

#####
#
#
sub vectorize
{
     shift if UNIVERSAL::isa($_[0],__PACKAGE__);
     my ($i,$number);
     for ($i=0; $i < @{$_[0]}; $i = $i +2) {
         if( $_[0]->[$i] =~  /[SUF]\d/ || $_[0]->[$i] eq 'T') {
             unless( ref($_[0]->[$i+1]) eq 'ARRAY' ) {
                 $number = Data::SecsPack->unpack_num( $_[0]->[$i], $_[0]->[$i+1] );
                 return $number unless ref($number) eq 'ARRAY';
                 $_[0]->[$i+1] = $number;
             }
         }
     }
     return '';
}


1

__END__

=head1 NAME
  
Data::Secs2 - pack, unpack, format, transform from Perl data SEMI E5-94 nested data.

=head1 SYNOPSIS

 #####
 # Subroutine interface
 #  
 use Data::Secs2 qw();

 @array  = arrayify( @var );

 $string = itemify($format, @elements);
 $string = itemify($format, @elements, [@options]);
 $string = itemify($format, @elements, {optioins});

 \@sec_list  = listify(@vars);

 \@sec_list  = neuterify($binary_secs);
 \@sec_list  = neuterify($binary_secs, @options);
 \@sec_list  = neuterify($binary_secs, [@options]);
 \@sec_list  = neuterify($binary_secs, {@options});

 $error = scalarize( \@sec_list );

 $ascii_secs = secsify( \@sec_list);
 $ascii_secs = secsify( \@sec_list, @options);
 $ascii_secs = secsify( \@sec_list, [@options]);
 $ascii_secs = secsify( \@sec_list, {@options});

 $binary_secs = secsify( \@sec_list, type => 'binary');
 $binary_secs = secsify( \@sec_list, type => 'binary', @options);
 $binary_secs = secsify( \@sec_list, [type => 'binary',@options]);
 $binary_secs = secsify( \@sec_list, {type => 'binary',@options});

 $string = stringify( @arg );

 \@sec_list  = transify($acsii_secs);
 \@sec_list  = transify($acsii_secs, @options);
 \@sec_list  = transify($acsii_secs, [@options]);
 \@sec_list  = transify($acsii_secs, {@options});

 $error  = vectorize( \@sec_list );

 #####
 # Class interface
 #
 use Data::Secs2;

 @array  = Data::Secs2->arrayify( @var );

 $string = Data::Secs2->itemify($format, @elements);
 $string = Data::Secs2->itemify($format, @elements, [@options]);
 $string = Data::Secs2->itemify($format, @elements, {optioins});

 \@sec_list  = Data::Secs2->listify(@vars);

 \@sec_list  = Data::Secs2->neuterify($binary_secs);
 \@sec_list  = Data::Secs2->neuterify($binary_secs, @options);
 \@sec_list  = Data::Secs2->neuterify($binary_secs, [@options]);
 \@sec_list  = Data::Secs2->neuterify($binary_secs, {@options});

 $error = Data::Secs2->scalarize( \@sec_list );

 $ascii_secs = Data::Secs2->secsify( \@sec_list);
 $ascii_secs = Data::Secs2->secsify( \@sec_list, @options);
 $ascii_secs = Data::Secs2->secsify( \@sec_list, [@options]);
 $ascii_secs = Data::Secs2->secsify( \@sec_list, {@options});

 $binary_secs = Data::Secs2->secsify( \@sec_list, type => 'binary');
 $binary_secs = Data::Secs2->secsify( \@sec_list, type => 'binary', @options);
 $binary_secs = Data::Secs2->secsify( \@sec_list, [type => 'binary',@options]);
 $binary_secs = Data::Secs2->secsify( \@sec_list, {type => 'binary',@options});

 $string = Data::Secs2->stringify( @arg );

 \@sec_list  = Data::Secs2->transify($acsii_secs);
 \@sec_list  = Data::Secs2->transify($acsii_secs, @options);
 \@sec_list  = Data::Secs2->transify($acsii_secs, [@options]);
 \@sec_list  = Data::Secs2->transify($acsii_secs, {@options});

 $error = Data::Secs2->vectorize( \@sec_list );

 
=head1 DESCRIPTION

The 'Data::SECS2' module provides a widely accepted
method of packing nested lists into a linear string
and unpacked nested lists. 
In the hardware world, data and data passed between
hardware is not stored in SQL style tables but
nested lists. 
Nested data has a long history in mathematics.

The L<Data::Secs2|Data::Secs2> program module
facilitates the secsification of the nested data is in accordance with 
L<SEMI|http://www.semiconductor-intl.org> E5-94,
Semiconductor Equipment Communications Standard 2 (SECS-II),
pronounced 'sex two' with gussto and a perverted smile. 
The SEMI E4 SECS-I standard addresses transmitting SECSII messages from one machine to
another machine (all most always host to equipment) serially via RS-232. And, there is
another SECS standard for TCP/IP, the SEMI E37 standard,
High-Speed SECS Message Services (HSMS) Generic Services.

In order not to plagarize college students,
credit must be given where credit is due.
Tony Blair, when he was a college intern at Intel Fab 4, in London
invented the SEMI SECS standards.
When the Intel Fab 4 management discovered Tony's secsification of
their host and equipment, 
they called a board of directors meeting, voted,
and elected to have security to escort Tony out the door.
This was Mr. Blair's introduction to voting and elections which he
leverage into being elected prime minister of all of England. 
In this new position he used the skills he learned
at the Intel fab to secsify intelligence reports on Iraq's
weopons of mass distruction.
 
By using a well-known, widely-used standard 
invented and publicized by the prime mister of England for
packing and unpacking Perl nested data, 
not only is this useful in a open nested operations
such as comparing nested data, storing the packed
data in a file, but also for transmitting data
from one Perl site to another or between Perl
and other programming languages.

And do not forget the added benefit of SEMI secs humor
and that the real originators of the SECS-II yielded
and allowed Tony Blair to take illegal credit for SECS-II.

=head2 SECSII Format

The nested data linear format used by the
L<Data::Secs2|Data::Secs2> suroutines is in accordance with 
L<SEMI|http://http://www.semiconductor-intl.org> E5-94,
Semiconductor Equipment Communications Standard 2 (SECS-II),
pronounced 'sex two' with gussto and a perverted smile. 
This industry standard is copyrighted and cannot be
reproduced without violating the copyright.
However for those who have brought the original hard media
copy, there are robot help and Perl POD open source
copyrighted versions of the SECII hard copy copyright version available.
The base copyright is hard copy paper and PDF files available
from
 
 Semiconductor Equipment and Materials International
 805 East Middlefield Road,
 Mountain View, CA 94043-4080 USA
 (415) 964-5111
 Easylink: 62819945
 http://www.semiconductor-intl.org
 http://www.reed-electronics.com/semiconductor/

The SEMI E4 SECS-I standard addresses transmitting SECSII messages from one machine to
another machine (all most always host to equipment) serially via RS-232. And, there is
another SECS standard for TCP/IP, the SEMI E37 standard,
High-Speed SECS Message Services (HSMS) Generic Services.

In order not to plagarize college students,
credit must be given where credit is due.
Tony Blair, when he was a college intern at Intel Fab 4, in London
invented the SEMI SECS standards.
When the Intel Fab 4 management discovered Tony's secsification of
their host and equipment, 
they elected to have security to escort Tony out the door.
This was Mr. Blair's introduction to elections which he
leverage into being elected prime minister. 
In this new position he used the skills he learned
at the Intel fab to secsify intelligence reports on Iraq's
weopons of mass distruction.
 
The SEMI E5 SECS-II standard is a method of forming listified packed
messages from nested list data. 
It consists of elements where each element is a format code, 
number of elements followed by the elements. 

               Table 1 Item Format Codes

 unpacked   binary  octal  hex   description
 ----------------------------------------
 L          000000   00    0x00  List (length in elements)
 B          001000   10    0x20  Binary
 T          001001   11    0x24  Boolean
 A          010000   20    0x40  ASCII
 J          010001   21    0x44  JIS-8
 S8         011000   30    0x60  8-byte integer (signed)
 S1         011001   31    0x62  1-byte integer (signed)
 S2         011010   32    0x64  2-byte integer (signed)
 S4         011100   34    0x70  4-byte integer (signed)
 F4         100000   40    0x80  8-byte floating
 F8         100100   44    0x90  4-byte floating
 U8         101000   50    0xA0  8-byte integer (unsigned)
 U1         101001   51    0xA4  1-byte integer (unsigned)
 U2         101010   52    0xA8  2-byte integer (unsigned)
 U4         101100   54    0xB0  4-byte integer (unsigned)

Notes:

=over 4

=item 1
 
ASCII  format - Non-printing characters are equipment specific

=item 2 

Integer formats - most significant byte sent first

=item 3

floating formats - IEEE 753 with the byte containing the sign sent first.

=back

Nested lists are packed is a linear number of items where each
item consists of a header followed by the elements in the item.
The header is of the following format where the MS byte is always
first when transmitting  the bytes linearally:


          bits                                     MSB      LSB
   
    7        6       5       4       3       2      1       0
 +-------+-------+-------+-------+-------+-------+-------+-------+
 | Format code                                   |# length bytes | 
 +---------------------------------------------------------------+
 |MSB                MS length byte                         LSB  |
 +---------------------------------------------------------------+
 |                    length byte                                |
 +---------------------------------------------------------------+
 |                   LS length byte                              |
 +---------------------------------------------------------------+

=head2 SECS List

A SECS list is a Perl list (array) based upon the
SEMI E5-94 SECSII format.
The list consists consecutive items where each item takes two positions
in the list: the item header (IH) and  the item body (IB). 
The item headers are always even number indices where the item bodies
are odd number indices. 
The IH is a format code as specified in the
Table 1 Item Format Codes unpack column.
The IB for each format code is as follows:

=over 4

=item L
 
unpacked number

=item S U F T

either scalarized array of numbers packed in accordance with SEMI E5-97
or a vectorized reference to an array of numbers

=item B A J

unpacked string

=back

The first item of a SECS list 
is always a SECS list Format Code 
wit a IH of U1 and a packed IB of either 'P' or 'S' depending
upon whether the SECS list has information necessary to convert
to Perl data structure, 'P', or not, 'S'.

=head2 arrayify subroutine

 @array  = arrayify( @var );

The purpose of the C<arrayify> subroutine is
to provide a canoncial array representation of 
Perl reference types. When C<$var> is
not a reference C<arrayify> subroutine passes
C<$var> through unchanged;
otherewise the ref($var) is changed to
a reference to a canoncial array where the
first member is the the C<$var> class,
the second member the underlying
data type. If ref($var) and the underlying 
type type are the same, 
then C<$var> is classless and 
the first member is the empty string ''.
The rest of the members of the canonical array,
based on the underlying data type, are as follows:

=over

=item 'HASH'

hash key, value pairs, sorted by the key

=item 'ARRAY'

members of the array

=item 'SCALAR'

the scalar

=item 'REF'

the reference

=item 'GLOB'

values of the C<GLOB> in the
following order:

 *$var{SCALAR},
 *$var{ARRAY},
 *$var{HASH},
 *$var{CODE},
 *$var{IO},
 *$var{NAME},
 *$var{PACKAGE},
 "*$var"

=back

=head2 itemify subroutine

 $string = itemify($format, @elements);
 $string = itemify($format, @elements, [@options]);
 $string = itemify($format, @elements, {options});

The C<itemify> subroutine is the low-level work horse
for the C<secsify> subroutine that
produces a SEMI SECSII item C<$string> from a Perl
L<SECS list|Data::Secs2/SECS List>  item header C<$format> and item body C<@elements>.

For {type => 'binary'}, $string is a complete packed
SEMI E5-94 SECII item.
For {type => 'ascii'} or no type option, the C<$string> 
is the ascii unpacked SECSII item.

An unpacked SECSII item consists of the unpacked format
code from the Table 1 Item Format Codes, the number of
elements in the item body enclosed in brackets, followed
by the elements in the item body. 
In accordance with SEMI E5-94, section 6, there will
be no elements for format code 'L' or an element length
of 0.

In case of an error, the return is an reference 
a error message.

=head2 listify subroutine

 \@sec_list  = listify(@vars);

The listify subroutine takes a list of Perl variables, C<@arg>
that may contain references to nested data and 
converts it to a <L<SECS list|Data::Secs2/SECS List>  
that mimics a SECSII data structure of a linearized
list of items.

Information is included to recontruct Perl hashes, arrays
and objects by provided two item header for each Perl
data type. The first item is the object class which is
empty for Perl hashes and arrays and the second item
is the Perl underlying data type.
Valid Perl underlying data types are: HASH ARRAY
SCALAR REF GLOB.

The return is either a reference to a  
L<SECS list|Data::Secs2/L<SECS list|Data::Secs2/SECS List> > 
or case of an error an error message.
To determine an error from a L<SECS list|Data::Secs2/SECS List> ,
check if the return is a reference or
a reference to an ARRAY.

=head2 neuterify subroutine

 \@sec_list  = neuterify($binary_secs);
 \@sec_list  = neuterify($binary_secs, @options);
 \@sec_list  = neuterify($binary_secs, [@options]);
 \@sec_list  = neuterify($binary_secs, {@options});

The C<neuterify> subroutine takes produces
a C<@sec_list> from a SEMI E5-94 packed
data structure C<$binary_secs> and produces
a C<@sec_list>.

The C<neuterify> subroutine uses option {format => 'P'}, 
or {format => 'S'} as the value for the leading
L<SECS list|Data::Secs2/SECS List>  U1 format byte.
SEMI E5-94 SECII item.

The return is either a reference to a  
L<SECS list|Data::Secs2/L<SECS list|Data::Secs2/SECS List> > 
or case of an error an error message.
To determine an error from a L<SECS list|Data::Secs2/SECS List> ,
check if the return is a reference or
a reference to an ARRAY.

=head2 scalarize subroutine

 $error = scalarize( \@sec_list );

The C<scalarize> subroutine ensures that
all the bodies in a
L<SECS list|Data::Secs2/SECS List> 
for numeric items,
format U, S, F, T, are scalar strings
packed in accordance with SEMI E5-97.

=head2 secsify subroutine

 $ascii_secs = secsify( \@sec_list);
 $ascii_secs = secsify( \@sec_list, @options);
 $ascii_secs = secsify( \@sec_list, [@options]);
 $ascii_secs = secsify( \@sec_list, {@options});

 $binary_secs = secsify( \@sec_list, type => 'binary');
 $binary_secs = secsify( \@sec_list, type => 'binary', @options);
 $binary_secs = secsify( \@sec_list, [type => 'binary',@options]);
 $binary_secs = secsify( \@sec_list, {type => 'binary',@options});

The C<secsify> subroutine/method walks a data structure and
converts all underlying array and hash references to arrays
by applying the 'arrayify' subroutine/method.

In this module, there are only three Perlified SECSII elements that 
will be listified into SECSII message as follows:

 OBJECT, INDEX OBJECT, and SCALAR

 OBJECT => 'L', $number-of-elements, 
           'A', $class,
           'A', $built-in-class,
           @elements

 @elements may contain a Perlified OBJECT, REFERENCE or SCALAR)

 INDEX OBJECT => 'L' '2', 'A' 'Index', 'U4', $number-of-indices, @indices 
 
 (reference is index into the nested list of lists)

 SCALAR = 'A', $scalar  (Perl built-in class)
                
=head2 stringify subroutine

The C<stringify> subroutined stringifies a Perl data structure
by applying the C<listify> and C<secify> subroutines.

=head2 transify subroutine

 \@sec_list  = transify($acsii_secs);
 \@sec_list  = transify($acsii_secs, @options);
 \@sec_list  = transify($acsii_secs, [@options]);
 \@sec_list  = transify($acsii_secs, {@options});

The C<transify> subroutine takes a free style
text consisting of list of secsii items and
converts it to L<SECS list|Data::Secs2/SECS List>.
The C<transify> subroutine is very liberal
in what it accepts as valid input. 

The number of body elements
may be supplied either as enclosed in brackets
of a "comma" after the unpacked format code.
Text strings may be enclosed in parentheses,
brackets, or any other character. 

The enclosing ending character may be
escaped with the backslash '\'.
List may be counted by suppling a count
in either brackets or following a comma
after the 'L' format character or
by enclosing parentheseses, bracketers or
any other character.

The C<transify> subroutine uses option {format => 'P'}, 
or {format => 'S'} as the value for the leading
L<SECS list|Data::Secs2/SECS List>  U1 format byte.
SEMI E5-94 SECII item.

The return is either a reference to a  
L<SECS list|Data::Secs2/L<SECS list|Data::Secs2/SECS List> > 
or case of an error an error message.
To determine an error from a L<SECS list|Data::Secs2/SECS List> ,
check if the return is a reference or
a reference to an ARRAY.

=head2 vectorize subroutine

 $error = vectorize( \@sec_list );

The C<vectorize> subroutine ensures that
all the bodies in a
L<SECS list|Data::Secs2/SECS List> 
for numeric items,
format U, S, F, T, are references
to an array of numbers.

=head1 REQUIREMENTS

The requirements are coming.

=head1 DEMONSTRATION

 ~~~~~~ Demonstration overview ~~~~~

Perl code begins with the prompt

 =>

The selected results from executing the Perl Code 
follow on the next lines. For example,

 => 2 + 2
 4

 ~~~~~~ The demonstration follows ~~~~~

 =>     use File::Package;
 =>     my $fp = 'File::Package';

 =>     use Data::Secs2 qw(arrayify itemify listify neuterify scalarize secsify 
 =>         stringify  transify vectorize);

 =>     my $uut = 'Data::Secs2';
 =>     my $loaded;
 => $uut->import( 'stringify' )
 => stringify( 'string' )
 'string'

 => stringify( 2 )
 2

 => stringify( '2', 'hello', 4 )
 'U1[1] 80
 U1[1] 2
 A[5] hello
 U1[1] 4
 '

 => stringify( ['2', 'hello', 4] )
 'U1[1] 80
 L[5]
   A[0]
   A[5] ARRAY
   U1[1] 2
   A[5] hello
   U1[1] 4
 '

 => stringify( {header => 'To: world', body => 'hello'})
 'U1[1] 80
 L[6]
   A[0]
   A[4] HASH
   A[4] body
   A[5] hello
   A[6] header
   A[9] To: world
 '

 => secsify( listify( ['2', 'hello', 4] ) )
 'U1[1] 80
 L[5]
   A[0]
   A[5] ARRAY
   U1[1] 2
   A[5] hello
   U1[1] 4
 '

 => secsify( listify( {header => 'To: world', body => 'hello'}) )
 'U1[1] 80
 L[6]
   A[0]
   A[4] HASH
   A[4] body
   A[5] hello
   A[6] header
   A[9] To: world
 '

 => secsify( listify( '2', ['hello', 'world'], 512 ) )
 'U1[1] 80
 U1[1] 2
 L[4]
   A[0]
   A[5] ARRAY
   A[5] hello
   A[5] world
 U2[1] 512
 '

 => my $obj = bless { To => 'nobody', From => 'nobody'}, 'Class::None'
 => secsify( listify( '2', { msg => ['hello', 'world'] , header => $obj } ) )
 'U1[1] 80
 U1[1] 2
 L[6]
   A[0]
   A[4] HASH
   A[6] header
   L[6]
     A[11] Class::None
     A[4] HASH
     A[4] From
     A[6] nobody
     A[2] To
     A[6] nobody
   A[3] msg
   L[4]
     A[0]
     A[5] ARRAY
     A[5] hello
     A[5] world
 '

 => secsify( listify( {msg => ['hello', 'world'] , header => $obj }, 
 =>                {msg => [ 'body' ], header => $obj} ) )
 'U1[1] 80
 L[6]
   A[0]
   A[4] HASH
   A[6] header
   L[6]
     A[11] Class::None
     A[4] HASH
     A[4] From
     A[6] nobody
     A[2] To
     A[6] nobody
   A[3] msg
   L[4]
     A[0]
     A[5] ARRAY
     A[5] hello
     A[5] world
 L[6]
   A[0]
   A[4] HASH
   A[6] header
   L[2]
     A[5] Index
     U1[3] 2 0 3
   A[3] msg
   L[3]
     A[0]
     A[5] ARRAY
     A[4] body
 '

 => my $big_secs2 = unpack('H*',secsify( listify( ['2', 'hello', 4] ), {type => 'binary'}))
 'a501500105410041054152524159a50102410568656c6c6fa50104'

 => secsify(neuterify (pack('H*',$big_secs2)))
 'U1[1] 80
 L[5]
   A[0]
   A[5] ARRAY
   U1[1] 2
   A[5] hello
   U1[1] 4
 '

 =>     my $ascii_secsii =
 => '
 => L
 => (
 =>   A \'\' A \'HASH\' A \'header\'
 =>   L [ A "Class::None"  A "HASH" 
 =>       A  "From" A "nobody"
 =>       A  "To" A "nobody"
 =>     ]
 =>   A "msg"
 =>   L,4 A[0] A[5] ARRAY
 =>     A  "hello" A "world"
 => )

 => L 
 => (
 =>   A[0] A "HASH"  A /header/
 =>   L[2] A \'Index\' U1 2 0 3
 =>   A  \'msg\'
 =>   L < A[0] A \'ARRAY\' A  \'body\' >
 => )

 => '
 => my $list = transify ($ascii_secsii, format_code => 'P');
 => ref($list)
 'ARRAY'

 => ref($list) ? secsify( $list ) : ''
 'U1[1] 80
 L[6]
   A[0]
   A[4] HASH
   A[6] header
   L[6]
     A[11] Class::None
     A[4] HASH
     A[4] From
     A[6] nobody
     A[2] To
     A[6] nobody
   A[3] msg
   L[4]
     A[0]
     A[5] ARRAY
     A[5] hello
     A[5] world
 L[6]
   A[0]
   A[4] HASH
   A[6] header
   L[2]
     A[5] Index
     U1[3] 2 0 3
   A[3] msg
   L[3]
     A[0]
     A[5] ARRAY
     A[4] body
 '

 => ref(my $number_list = listify( [ [78,45,25], [512,1024], 100000] ))
 'ARRAY'

 => secsify($number_list)
 'U1[1] 80
 L[5]
   A[0]
   A[5] ARRAY
   U1[3] 78 45 25
   U2[2] 512 1024
   U4[1] 100000
 '

 => vectorize($number_list)
 ''

 => [@{$number_list->[9]}]
 [
           78,
           45,
           25
         ]

 => [@{$number_list->[11]}]
 [
           512,
           1024
         ]

 => [@{$number_list->[13]}]
 [
           100000
         ]

 => scalarize($number_list)
 ''

 => unpack('H*', $number_list->[9])
 '4e2d19'

 => unpack('H*', $number_list->[11])
 '02000400'

 => unpack('H*', $number_list->[13])
 '000186a0'


=head1 QUALITY ASSURANCE

Running the test script 'Secs2.t' found in
the "Data-Secs2-$VERSION.tar.gz" distribution file verifies
the requirements for this module.

All testing software and documentation
stems from the 
Software Test Description (L<STD|Docs::US_DOD::STD>)
program module 't::Data::Secs2',
found in the distribution file 
"Data-Secs2-$VERSION.tar.gz". 

The 't::Data::Secs2' L<STD|Docs::US_DOD::STD> POD contains
a tracebility matix between the
requirements established above for this module, and
the test steps identified by a
'ok' number from running the 'Secs2.t'
test script.

The t::Data::Secs2' L<STD|Docs::US_DOD::STD>
program module '__DATA__' section contains the data 
to perform the following:

=over 4

=item *

to generate the test script 'Secs2.t'

=item *

generate the tailored 
L<STD|Docs::US_DOD::STD> POD in
the 't::Data::Secs2' module, 

=item *

generate the 'Secs2.d' demo script, 

=item *

replace the POD demonstration section
herein with the demo script
'Secs2.d' output, and

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

place the 't::Data::Secs2' at the same
level in the directory struture as the
directory holding the 'Data::Secs2'
module

=item *

execute the following in any directory:

 tmake -test_verbose -replace -run -pm=t::Data::Secs2

=back

=head1 NOTES

=head2 FILES

The installation of the
"Data-Secs2-$VERSION.tar.gz" distribution file
installs the 'Docs::Site_SVD::Data_Secs2'
L<SVD|Docs::US_DOD::SVD> program module.

The __DATA__ data section of the 
'Docs::Site_SVD::Data_Secs2' contains all
the necessary data to generate the POD
section of 'Docs::Site_SVD::Data_Secs2' and
the "Data-Secs2-$VERSION.tar.gz" distribution file.

To make use of the 
'Docs::Site_SVD::Data_Secs2'
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
__DATA__ section of the 'Docs::Site_SVD::Data_Secs2'
module.
For example, any changes to
'Data::Secs2' will impact the
at least 'Changes' field.

=item *

Execute the following:

 vmake readme_html all -pm=Docs::Site_SVD::Data_Secs2

=back

=head2 AUTHOR

The holder of the copyright and maintainer is

E<lt>support@SoftwareDiamonds.comE<gt>

=head2 COPYRIGHT NOTICE

Copyright � 2003 2004 Software Diamonds

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