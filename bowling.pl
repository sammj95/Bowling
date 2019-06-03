#! usr/bin/perl

use strict;
use warnings;

#cpan modules
use Scalar::Util qw(looks_like_number);

print "Welcome to SJ Bowling!\n";

my ( $throw, $throw_score, $count_ahead );
my $frameScore = 0;
my $total_score = 0;
my $current_frame = 1;
my $current_throw = 1;
my @score = ();

while ( $current_frame <= 10 ) {
    print "Frame $current_frame, throw $current_throw: ";
    $throw = <>;
    chomp $throw;
    
    while ( !&validate_throw($throw) ) {
        print "Please enter a valid throw (0-9, \\, or X): ";
        $throw = <>;
        chomp $throw;
    }

    #TODO validate frame score 

    ($throw_score, $count_ahead) = &calculate_throw($throw, $count_ahead);
    $score[$current_frame] = $throw_score;
    if ( ($count_ahead == 3 || $count_ahead == 1) && $current_frame-1 > 0 ) {
        #previous frame was a strike or a spare
        $score[$current_frame-1] += $throw_score;
        $count_ahead--;
    } elsif ( $count_ahead == 2 && $current_frame-2 > 0 ) {
        #2 frames ago was a strike
        $score[$current_frame-2] += $throw_score;
        $count_ahead = 0;
    }

    if ( $throw_score == 10 || $current_throw == 2) {
        $current_frame++;
        $current_throw = 1;
    } else {
        $current_throw++;
    }
}

#game is now over
my $i = 1;
while ( $i <= 10 ) {
    $total_score += $score[$i];
    $i++;
}
print "Final score: ".$total_score;

sub calculate_throw {
    my ( $throw ) = @_;

    if ( $throw =~ /x/i ) {
        return (10, 3);
    } elsif ( $throw eq '\\' ) {
        return (10, 1);
    } else {
        return ($throw, 0);
    }
}

sub validate_throw {
    my ( $throw ) = @_;

    if ( $throw =~ /x/i || $throw eq '\\' ||
         (looks_like_number($throw) && $throw >= 0 && $throw <=9) ) {
        return 1;
    }
    return 0;
}
