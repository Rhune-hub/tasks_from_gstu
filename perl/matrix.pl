use warnings;
use strict;
use 5.030;

sub main
{
    my $def_matrix = [
        [1, 2, 3, 4],
        [5, 6, 7, 8],
        [9, 0, 1, 2]
    ];
    my $input_matrix = input();    
    my ($n, $m, $matrix) = $input_matrix ? @$input_matrix : (3, 4, $def_matrix);
    print_matrix('Initial matrix', @$matrix);
    
    evaluate_matrix($n, \$m, $matrix);
    print_matrix('Evaluated matrix', @$matrix);
    
    sort_cols($n, $m, $matrix);
    print_matrix('Sorted matrix', @$matrix);
}

sub input 
{
    print 'Input sizes of array (n m) or skip to default matrix: ';
    my $sizes = <>;

    unless ($sizes =~ /^([+-]?\d+[\s\0]+){2}$/)
    { 
        say "\nInput was canceled. Using default array.";
        return 0;
    }
    my ($n, $m) = split ' ', $sizes;
    my @matrix = ();
    foreach (0..$n-1) 
    {
        print "Input ".($_+1)."-st row: ";
        my $raw = <>;
        chomp;
        unless ($raw =~ /^([+-]?\d+[\s\0]+){$m}$/) 
        { 
            say "Incorrect value. Try again. Input $m numbers.";
            redo;
        }
        my @row = split ' ', $raw;
        push @matrix, \@row;
    }
    return [$n, $m, \@matrix];

}

sub print_matrix 
{
    my ($title, @matrix) = @_;
    say "\t$title";
    for my $row (@matrix)
    {
        printf "%5d ", $_ for @$row; 
        print "\n";    
    }
    print "\n";
}

sub sort_cols
{
    my ($n, $m, $matrix) = @_;
    
    for my $j (0..$m-1)
    {
        for my $i (1..$n-1)
        {
            my $pre_i = $i-1;
            my $current = @{@$matrix[$i]}[$j];
            while ($pre_i >= 0 && @{@$matrix[$pre_i]}[$j] > $current)
            {
                @{@$matrix[$pre_i+1]}[$j] = @{@$matrix[$pre_i]}[$j];
                $pre_i--;
            }
            @{@$matrix[$pre_i+1]}[$j] = $current;
        }
    }
}

sub evaluate_matrix
{
    my ($n, $m, $matrix) = @_;
    
    for my $row (@$matrix) 
    {
        my $sum = 0;
        map { $sum += $_ } @$row;
        @$row =  map { $_ < -5 ? abs($_ * 2) : $_ > 5 ? ($_ * 2) - $_ : $_ ** 2}  @$row;
        
        push @$row, $sum;
        
    }
    $$m++;   
}


main();
