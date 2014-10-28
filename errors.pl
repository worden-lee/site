undef $/;

$_ = <>;

print if /make: [*]{3}/;
