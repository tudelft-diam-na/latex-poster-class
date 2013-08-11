#! /usr/bin/env python
#
# Copyright (c) 2013 Joost van Zwieten
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

from __future__ import print_function

import sys
import os
sys.path.append( os.path.join( os.getcwd(), 'python-qrcode' ) )

import qrcode

use_tikz = False

if len( sys.argv ) > 1:
    files = []
    for f in sys.argv[ 1: ]:
        if f.endswith( '.qro' ):
            qro = f
        elif f.endswith( '.tex' ):
            qro = f[ :-3 ] + 'qro'
        elif os.path.exists( f + '.tex' ):
            qro = f + '.qro'
        elif os.path.exists( f + '.qro' ):
            qro = f + '.qro'
        else:
            raise ValueError( 'cannot find .qro file corresponding to `{0}`'.format( f ) )
        if not os.path.exists( qro ):
            print( 'Nothing to do for {0}.'.format( qro ) )
        else:
            files.append( qro )
else:
    files = [ f for f in os.listdir( '.' ) if f.endswith( '.qro' ) ]


for qro in files:

    assert qro.endswith( '.qro' )
    print( 'file: {0}'.format( qro ) )

    with open( qro.replace( '.qro', '.qri' ), 'w' ) as qri:

        if use_tikz:
            qri.write( '\\def\\b#1#2{\\fill[color=black] (#1,#2) rectangle (#1+1,#2+1);}' )
            qri.write( '\\def\\w#1#2{}%\n' ) #\\fill[color=white] (#1,#2) rectangle (#1+1,#2+1);}%\n' )
        else:
            qri.write( '\\def\\b#1#2{\\put(#1,#2){\\rule{\\unitlength}{\\unitlength}}}' )
            qri.write( '\\def\\w#1#2{}%\n' )

        for msg in sorted( set( open( qro ).readlines() ) ):

            if msg.endswith( '\n' ):
                msg = msg[ :-1 ]

            print( 'qr message: {0!r}'.format( msg ) )

            qri.write( '\\def\\qrmsgin{{{0}}}'.format( msg ) )
            qri.write( '\\ifdefequal{\\qrmsgout}{\\qrmsgin}{' )
            qri.write( '\\def\\qrcode{' )

            qr = qrcode.QRCode()
            qr.add_data( msg )
            qr.make( fit = True )

            if use_tikz:
                qri.write( '\\begin{{tikzpicture}}[x=\\qrsize/{0},y=\\qrsize/{0},yscale=-1]'.format( len( qr.modules ) ) )
                for j, data in enumerate( qr.modules ):
                    for i, v in enumerate( data ):
                        qri.write( '\\{0}{{{1}}}{{{2}}}'.format( v and 'b' or 'w', i, j ) )
                qri.write( '\\end{tikzpicture}' )
            else:
                qri.write( '\\deflength{{\\unitlength}}{{\\qrsize/{0}}}\\begin{{picture}}({0},{0})'.format( len( qr.modules ) ) )
                for j, data in enumerate( qr.modules ):
                    for i, v in enumerate( data ):
                        qri.write( '\\{0}{{{1}}}{{{2}}}'.format( v and 'b' or 'w', i, len( qr.modules ) - j - 1 ) )
                qri.write( '\\end{picture}' )
            qri.write( '}}{}%\n' )

    print()
