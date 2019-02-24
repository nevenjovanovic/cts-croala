for $h in //*[@n="head1"]
where not($h/following-sibling::*:head[@n="head2"])
return replace value of node $h/@n with "head"