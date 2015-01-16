#!/usr/bin/perl
#
# Simple test for gladiwashere. Compare with test for
# gladiwashere-java
#
# This file is part of gladiwashere.
# (C) 2012-2015 Indie Computing Corp.
#
# gladiwashere is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# gladiwashere is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with gladiwashere.  If not, see <http://www.gnu.org/licenses/>.
#

use strict;
use warnings;

package GladIWasHere1Test;

use UBOS::WebAppTest;

# The states and transitions for this test

my $TEST = new UBOS::WebAppTest(
    appToTest   => 'gladiwashere',
    description => 'Tests whether anonymous guests can leave messages on the gladiwashere app.',
    checks      => [
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
