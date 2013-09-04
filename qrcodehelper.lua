qrencode = dofile("qrencode.lua")

local function generate( codeword )

    local ok, tab = qrencode.qrcode( codeword )
    if not ok then
        tex.print(tab)
    else
        tex.print( '\\begingroup%' )
        tex.print( '\\def\\b#1#2{\\put(#1,#2){\\rule{\\unitlength}{\\unitlength}}}%' )
        tex.print( string.format( '\\deflength{\\unitlength}{\\qrsize/%u}%%', #tab ) )
        tex.print( string.format( '\\begin{picture}(%u,%u)%%', #tab, #tab ) )
        for i=1,#tab do
            for j=1,#tab[i] do
                if tab[i][j] > 0 then
                    tex.print( string.format( '\\b{%u}{%u}%%', i-1, #tab-j ) )
                end
            end
        end
        tex.print( '\\end{picture}%' )
        tex.print( '\\endgroup%' )
    end

end

return { generate = generate }
