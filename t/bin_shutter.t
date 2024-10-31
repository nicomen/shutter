#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Test::Output;

use Capture::Tiny ':all';
use FindBin qw/$Bin/;

my @command = ("$Bin/../bin/shutter", "-n", "-f", "-e");

# Capture output
my ($out, $err, $exit) = capture {
    system(@command);  # Add necessary arguments
};

# Test the outputs
is($exit, 0, 'Command exited successfully') or diag $err;

TODO: {
  local $TODO = 'Fixing the failures properly takes some time';
  unlike($err, qr{will not stay shared}, 'No warnings about variables not staying shared') or do { diag $& while $err =~ m/.*will not stay shared.*/g; };
};

done_testing();

