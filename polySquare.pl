use strict; use 5.10.0;

my (@mult, @off);
for my $k (0..15){
	push @mult , 8*(4*$k+1) , (4*$k+2)/2 , 8*(4*$k+3) , 2*(4*$k+4) ;
	push @off , (4*$k-1)**2 , $k**2 , (4*$k+1)**2 , (4*$k+2)**2/4 ;
}

say "Multipliers: " . join ", ", @mult; say "Offsets: " . join ", ", @off;
