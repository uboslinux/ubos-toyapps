/*
 * SQL schema for gladiwashere-php-postgresql
 *
 * This file is part of gladiwashere-php-postgresql.
 * (C) 2012-2017 Indie Computing Corp.
 *
 * gladiwashere-php-postgresql is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * gladiwashere-php-postgresql is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with gladiwashere-php-postgresql.  If not, see <http://www.gnu.org/licenses/>.
 */

CREATE TABLE Comment (
    id      SERIAL,
    created TIMESTAMP,
    name    VARCHAR(80),
    email   VARCHAR(80),
    comment VARCHAR(1024),
    PRIMARY KEY( id )
)
