/*
 * SQL schema for gladiwashere-php-postgresql
 *
 * Copyright (C) 2014 and later, Indie Computing Corp. All rights reserved. License: see package.
 */

CREATE TABLE Comment (
    id      SERIAL,
    created TIMESTAMP,
    name    VARCHAR(80),
    email   VARCHAR(80),
    comment VARCHAR(1024),
    PRIMARY KEY( id )
)
