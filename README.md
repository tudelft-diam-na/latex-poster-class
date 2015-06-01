tudelft-poster
==============

A latex class for TU Delft posters.

*   This class requires a latex compiler generating a pdf, e.g. `pdflatex` or
    `lualatex`.  Plain `latex` is not supported.

*   As this document class uses absolute positioning with tikz, it is sometimes
    necessary to compile your document twice to get the positions of the poster
    header and footer right.

[![example](preview.jpg?raw=true)](preview.pdf?raw=true)
[![example_tikz](preview_tikz.jpg?raw=true)](preview_tikz.pdf?raw=true)

For the source of these examples, see `example.tex` and `example_tikz.tex`.

Requirements
============

This document class requires the following latex packages:

* geometry,
* xcolor,
* graphicx,
* tikz (with libraries calc and fadings),
* etoolbox,
* multicol and
* caption.

In Debian Wheezy and Jessie, installing `texlive-latex-extra` is sufficient.

Installation
============

Either clone [this repository][github-repository] using git or download and
unzip [this zip file][github-zip].  No installation is required as long as you
put your `.tex` file in the same directory as `tudelftposter.cls`.

[github-repository]: https://github.com/joostvanzwieten/tudelft-poster.git
[github-zip]: https://github.com/joostvanzwieten/tudelft-poster/archive/master.zip

Linux
-----

If you do want to install the document class in a texmf tree, you can use the
`install` python script.  For example, run

    ./install --home

from within the tudelft-poster directory to install the document class in your
`TEXMFHOME` directory.  For other installation options, run `install` without
arguments.

Usage
=====

Begin your latex document with the line

    \documentclass{tudelftposter}

Header
------

In the preamble, i.e. the code before `\begin{document}`, you must specify the
title of the poster with the following command:

    \title{TITLE}

A subtitle is not supported.

Authors must be added one by one using the command `\addauthor`:

    \addauthor{NAME}
    \addauthor[LABEL1,LABEL2,...]{NAME}

Optionally, you can attach one or more notes to this author be specifying a
comma-separated list of labels (`LABEL1,LABEL2,...`) pointing to notes defined
by the command `\addauthornote`:

    \addauthornote{LABEL}{TEXT}
    \addauthornote{LABEL}[MARK]{TEXT}

This command defines footnotes in the header, which can be used to specify
affiliations or email addresses.  The argument `LABEL` should be a unique label
pointing to this note.  The optional argument `MARK` can be used to change the
default symbol of this note to `MARK`.

The style of the title, authors and author notes are defined in the commands

* `\tudstyleheadtitle`,
* `\tudstyleheadauthors` and
* `\tudstyleheadauthornotes`.

You can redefine the styles in the preamble using `\renewcommand`.  For example:

    \renewcommand{\tudstyleheadtitle}{%
        \normalfont\rmfamily\color{white}\large\scshape}

Footer
------

The following commands are available in the preamble to add logos and text to
the footer:

    \addfootimage(ALIGNMENT:POSITION){FILENAME}
    \addfootimage(ALIGNMENT:POSITION)[TEXT]{FILENAME}

    \addfootobject(ALIGNMENT:POSITION){CODE}
    \addfootobject(ALIGNMENT:POSITION)[TEXT]{CODE}
    \addfootobject*(ALIGNMENT:POSITION){CODE}
    \addfootobject*(ALIGNMENT:POSITION)[TEXT]{CODE}

    \addfootqrcode(ALIGNMENT:POSITION){QRMESSAGE}        % requires lualatex!
    \addfootqrcode(ALIGNMENT:POSITION)[TEXT]{QRMESSAGE}  % requires lualatex!

    \addfoottext(ALIGNMENT:POSITION){TEXT}

The argument `POSITION` specifies the position of the object.  There are several
predefined positions:

* `page.center`,
* `page.left`,
* `page.right`,
* `left column.center`,
* `left column.left`,
* `left column.right`,
* `right column.center`,
* `right column.left` and
* `right column.right`.

You can also specify a length.  The argument `ALIGNMENT` controls the alignment
with respect to `POSITION` and must be one of

* `l` (align left),
* `c` (align centre) or
* `r` (align right).

In the command `\addfootimage` the argument `FILENAME` should refer to an image.
The image will be resized to fit the height of the image bar.  If the optional
argument `TEXT` is given, this will be placed underneath the image using the
same position and alignment as the image.

The command `\addfootobject` can be used to place any object defined by `CODE`
in the image bar.  The object will be resized to fit the height of the image
bar.  The starred version does not resize the object.

The command `\addfootqrcode` generates a QR code containing `QRMESSAGE`, usually
a URL.  This command only works when you compile the document with `lualatex`
instead of e.g. `pdflatex`.

The command `\addfoottext` places `TEXT` on the text bar.

Note that the TU Delft logo is *not* automatically added.  See the example below
how to add the logo.

Document body
-------------

The class inherits the `article` class, hence supports all the commands and
environments defined there.

The default font is Latin Modern, a font based on Computer Modern Roman.  The
default font family is sans serif.  If you want to change the default family to
e.g. serif, add the following line to the preamble:

    \renewcommand{\familydefault}{\rmdefault}

The style of sections, the title, authors and author notes are defined in the
command `\tudstylesection`.  You can redefine the styles in the preamble using
`\renewcommand`.  For example:

    \renewcommand{\tudstylesection}{%
        \normalfont\rmfamily\Large\scshape\color{tudcyan}}

Tikz body
---------

Alternatively, you can design the poster body completely using tikz.  Just
create a `tikzpicture` environment and start drawing.  This class provides a
special tikz node `body` which defines the drawable area.  The following example
draws a rectangle indicating the drawable area.

    \documentclass{tudelftposter}
    % preamble ...
    \begin{document}
        \begin{tikzpicture}[remember picture,overlay]
            \draw (body.south west) rectangle (body.north east);
        \end{tikzpicture}
    \end{document}

You can use the preamble from the example below.

Example
-------

    \documentclass{tudelftposter}

    \title{The title}

    \addauthor[mail One,A]{Author One}
    \addauthor[A,B]{Author Two}

    \addauthornote{mail One}[@]{\ttfamily author.one@tudelft.nl}
    \addauthornote{A}{Delft Institute of Applied Mathematics}
    \addauthornote{B}{Some other institute}

    \addfootimage(c:right column.center)[DIAM, TU Delft]{tudelft}
    % NOTE: the following line is only supported when compiling with lualatex
    \addfootqrcode(l:left column.left)[web page]{http://ta.twi.tudelft.nl}

    \begin{document}
        \section{Introduction}
        ...
        \section{Conclusions}
        ...
        \section{References}
        ...
    \end{document}
