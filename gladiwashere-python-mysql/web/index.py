#
# Main entry into gladiwashere-python-mysql.
#
# Copyright (C) 2017 and later, Indie Computing Corp. All rights reserved. License: see package.
#

import gladiwashere

import cgitb

def application(environ, start_response):

  cgitb.enable()

  status = '200 OK'
  response_headers = [('Content-type','text/html')]
  start_response(status, response_headers)

  return gladiwashere.doIt( environ )
