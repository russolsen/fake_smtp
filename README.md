FakeSmtp
=======

This is a completely trivial SMTP server, written in Ruby and packaged as a gem.

Why?
----

Sometimes you just want to be sure that the mail is getting formated and
sent the way you think it is.

Usage
-----

The gem comes with a simple script `fake_smtp` that will run the server.
To run the server, just run the script:

    $ gem install fake_smtp

    $ fake_smtp
    FakeSmtp: Listening on port 2025

As you can see, by default the server runs on port 2025. You can change
the port by passing in the --port option:

    $ fake_smtp --port 3333
    FakeSmtp: Listening on port 3333

The server implements just enough of the SMTP protocol to convince
an SMTP client (well ActiveMailer anyway) that there is a *there* there.

Contributors
------------

* Russ Olsen
* I also shamelessly borrowed bits, including some of this readme file
from `https://github.com/livinginthepast/fake_ftp.git`.

License
-------

The MIT License

Copyright (c) 2013 by Russ Olsen

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
