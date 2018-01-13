#!/usr/bin/perl
#
# Simple test for gladiwashere-php-mysql.
#
# Copyright (C) 2014 and later, Indie Computing Corp. All rights reserved. License: see package.
#

use strict;
use warnings;

package GladIWasHere1PhpMysqlTest;

use UBOS::WebAppTest;

# The states and transitions for this test

my $TEST = new UBOS::WebAppTest(
    appToTest   => 'gladiwashere-php-mysql',
    description => 'Tests whether anonymous guests can leave messages on the gladiwashere-php-mysql app.',

    packageDbsToAdd => {
        'toyapps' => 'http://depot.ubos.net/$channel/$arch/toyapps'
    },

    checks => [
            new UBOS::WebAppTest::StateCheck(
                    name  => 'virgin',
                    check => sub {
                        my $c = shift;

                        $c->getMustContain(    '/', 'Glad-I-Was-Here Guestbook', undef, 'Wrong front page' );
                        $c->getMustNotContain( '/', 'This is a great site',      undef, 'Guestbook entry still there' );

                        return 1;
                    }
            ),
            new UBOS::WebAppTest::StateTransition(
                    name       => 'post-comment',
                    transition => sub {
                        my $c = shift;

                        my $postData = {
                            'name'    => 'Mr. Test User',
                            'email'   => 'test.user@example.com',
                            'comment' => 'This is a great site!',
                            'submit'  => 'submit' };

                        my $response = $c->post( '/', $postData );
                        $c->mustStatus( $response, 200, 'Guestbook entry failed to post' );

                        return 1;
                    }
            ),
            new UBOS::WebAppTest::StateCheck(
                    name  => 'comment-posted',
                    check => sub {
                        my $c = shift;

                        $c->getMustContain( '/', 'This is a great site', 200, 'Guestbook entry not posted' );
                        return 1;
                    }
            )
    ]
);

$TEST;
