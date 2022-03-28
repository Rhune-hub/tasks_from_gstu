use warnings;
use strict;
use 5.030;

sub main
{
    my $def_hash = {'name' => 'apple',
                    'cultivar' => 'golden',
                    'color' => 'red',
                    'props' => ['tasty', 'juicy', 'sweet']};
    
    
    my $input_hash = input_hash('name', 'cultivar', 'color', 'props');
    say "$input_hash";
                                
    my $hash = $input_hash ? $input_hash : $def_hash;
    print_hash($hash);
}

sub input_hash
{   
    my %hash = ();
    foreach (@_)
    {
        print "Input $_: ";
        my $value = <>;
        if ($value =~ m/,/)
        {
            $value = [split(/,\s+/, $value)];
        }
        $value =~ s/^\s+|\s+$//g;
        %hash = (%hash, ($_ => ($value eq '' ? '-' : $value)));
        
    }

    if (scalar(grep { $_ eq '-'} values %hash))
    {
        say "Not enough data. Using default hash.";
        return 0;
    }

    return \%hash;
}

sub print_hash
{
    my ($hash) = @_;
    while(my ($key, $value) = each %$hash)
    {
        $key =~ s/(^[a-z])/\u\L$1/;
        say "$key: ".(ref($value) eq 'ARRAY' ? join ', ', @$value : $value);    
    }
}

main();
