use warnings;
use strict;
use 5.030;

sub main
{
    my $def_str = "Lorem Ipsum has been the industry`s standard dummy text ever since the 1500s,".
        "when an unknown printer took a galley of type and scrambled it to make a type specimen book.";
        
    my $input_str = input_string("Input string or skip to use default", "Input was empty. Using default string.");    
    say "$input_str";
    my $str = $input_str ne "" ? $input_str : $def_str;
    say "$str";
    
    find_substr($str);
    replace_substr($str);
    
    salary_generator(length($str));
}

sub input_string
{
    my ($request, $error) = @_;
    say "$request:";
    my $str = <>;
    chomp($str);
    
    if ($str eq "")
    { 
        say "\n$error";
        return '';
    }
    
    return $str;
}

sub find_substr
{
    say "\n\tFinding";
    my ($str) = @_;
    my $substr = input_string('Input substring for search','Input was empty.');
  
    my $substr_i = index($str, $substr);
    if ($substr_i > -1)
    {
        say "String contains '$substr' firstly from $substr_i-st to ".($substr_i+length($substr))." character.";
        my $count = () = ($str =~ /$substr/g);
        say "'$substr' repeated $count times.";
    }
    else
    {
        say "String doesn't contains '$substr'";
    }
}

sub replace_substr
{
    say "\n\tReplacing";
    my ($str) = @_;
    my $replaced_str = input_string('Input replaced substring','Input was empty.');
    my $replaces_count = 0;
    my $substr;
    unless ($replaced_str eq '')
    {
        $substr = input_string('Input substring for replace','Input was empty.');
        $replaces_count = ($str =~ s/$replaced_str/$substr/g);
    }
    
    if ($replaces_count > 0) 
    {
        say "'$replaced_str' was sucsessfully replaced by '$substr' $replaces_count times.";
        say "Edited string:\n$str";
    }
    else
    {
        say "No replacing.";
    }
}

sub salary_generator
{
    say "\n\tSalary";
    my ($str_len) = @_;
    my $value = int(rand($str_len % 15));
    my $salary = $value.('0' x $value);
    say "Well done! Your salary is $salary pieces of nothing.";
}

main();
