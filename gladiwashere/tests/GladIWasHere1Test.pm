#!/usr/bin/perl
#
# Simple test for gladiwashere
#
# This file is part of gladiwashere.
# (C) 2012-2014 Indie Computing Corp.
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

use IndieBox::WebAppTest;

# The states and transitions for this test

my $TEST = new IndieBox::WebAppTest(
    appToTest   => 'gladiwashere',
    description => 'Tests whether anonymous guests can leave messages on the gladiwashere app.',
    checks      => [
            new IndieBox::WebAppTest::StateCheck(
                    name  => 'virgin',
                    check => sub {
                        my $c = shift;
                        
                        my $response = $c->httpGetRelativeContext( '/' );
                        unless( $response->{content} =~ /Glad-I-Was-Here Guestbook/ ) {
                            $c->reportError( 'Wrong front page', $response->{content} );
                        }
                        if( $response->{content} =~ /This is a great site/ ) {
                            $c->reportError( 'Guestbook entry still there', $response->{content} );
                        }
                        return 1;
                    }
            ),
            new IndieBox::WebAppTest::StateTransition(
                    name       => 'post-comment',
                    transition => sub {
                        my $c = shift;

                        my $postData = {
                            'name'    => 'Mr. Test User',
                            'email'   => 'test.user@example.com',
                            'comment' => 'This is a great site!',
                            'submit'  => 'submit' };

                        my $response = $c->httpPostRelativeContext( '/', $postData );
                        unless( $response->{headers} =~ m!HTTP/1.1 200 OK! ) {
                            $c->reportError( 'Guestbook entry failed to post', $response->{headers} );
                        }
                        return 1;
                    }
            ),
            new IndieBox::WebAppTest::StateCheck(
                    name  => 'comment-posted',
                    check => sub {
                        my $c = shift;

                        my $response = $c->httpGetRelativeContext( '/' );
                        unless( $response->{content} =~ /This is a great site/ ) {
                            $c->reportError( 'Guestbook entry not posted', $response->{content} );
                        }
                        return 1;
                    }
            )
    ]
);

$TEST;
