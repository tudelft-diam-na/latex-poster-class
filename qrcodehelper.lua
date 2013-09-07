-- Copyright (c) 2013 Joost van Zwieten
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

qrencode = dofile(kpse.find_file("qrencode.lua"))

local function generate( codeword )

    local ok, tab = qrencode.qrcode( codeword )
    if not ok then
        tex.print(tab)
    else
        tex.print( '\\begingroup%' )
        tex.print( '\\def\\b#1#2{\\fill[black] (#1,#2) rectangle ++(1,1);}%' )
        tex.print( string.format( '\\begin{tikzpicture}[x=\\qrsize/%u,y=\\qrsize/%u]%%', #tab, #tab ) )
        for i=1,#tab do
            for j=1,#tab[i] do
                if tab[i][j] > 0 then
                    tex.print( string.format( '\\b{%u}{%u}%%', i-1, #tab-j ) )
                end
            end
        end
        tex.print( '\\end{tikzpicture}%' )
        tex.print( '\\endgroup%' )
    end

end

return { generate = generate }
