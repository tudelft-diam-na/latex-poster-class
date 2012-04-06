\ProvidesClass{tudelftposter}[2012/03/29, v. 1.1]
\NeedsTeXFormat{LaTeX2e}[1995/06/01]
% \RequirePackage{ifthen}
\RequirePackage{etoolbox}

\DeclareOption{draft}{\PassOptionsToClass{draft}{article}}
\DeclareOption{final}{\PassOptionsToClass{final}{article}}

\ExecuteOptions{final}
\ProcessOptions

\LoadClass[twocolumn]{article}
\setlength{\columnsep}{3cm}
\RequirePackage[a0paper,hmargin=3cm,vmargin={0cm,14.5cm}]{geometry}

% color definitions [[[

\RequirePackage[cmyk]{xcolor}
\definecolor{tudbluergb}{rgb}{0,0.6484375,0.8359375}
\definecolor{tudblue}{cmyk}{1,0,0,0}

% ]]]
% font size definitions (TODO: should be placed in sizeXXposter.clo files ...) [[[

\RequirePackage{fix-cm}

%% size 24.88pt
%\renewcommand{\tiny}{\fontsize{12}{14}\selectfont}
%\renewcommand{\scriptsize}{\fontsize{14.4}{18}\selectfont}   
%\renewcommand{\footnotesize}{\fontsize{17.28}{22}\selectfont}
%\renewcommand{\small}{\fontsize{20.74}{25}\selectfont}
%\renewcommand{\normalsize}{\fontsize{24.88}{30}\selectfont}
%\renewcommand{\large}{\fontsize{29.86}{37}\selectfont}
%\renewcommand{\Large}{\fontsize{35.83}{45}\selectfont}
%\renewcommand{\LARGE}{\fontsize{43}{54}\selectfont}
%\renewcommand{\huge}{\fontsize{51.6}{64}\selectfont}
%\renewcommand{\Huge}{\fontsize{61.92}{77}\selectfont}
%\newcommand{\veryHuge}{\fontsize{74.3}{93}\selectfont}
%\newcommand{\VeryHuge}{\fontsize{89.16}{112}\selectfont}
%\newcommand{\VERYHuge}{\fontsize{107}{134}\selectfont}

% size 43pt
\renewcommand{\tiny}{\fontsize{20.74}{25}\selectfont}
\renewcommand{\scriptsize}{\fontsize{24.88}{30}\selectfont}
\renewcommand{\footnotesize}{\fontsize{29.86}{37}\selectfont}
\renewcommand{\small}{\fontsize{35.83}{45}\selectfont}
\renewcommand{\normalsize}{\fontsize{43}{54}\selectfont}
\renewcommand{\large}{\fontsize{51.6}{64}\selectfont}
\renewcommand{\Large}{\fontsize{61.92}{77}\selectfont}
\renewcommand{\LARGE}{\fontsize{74.3}{93}\selectfont}
\renewcommand{\huge}{\fontsize{89.16}{112}\selectfont}
\renewcommand{\Huge}{\fontsize{107}{134}\selectfont}

\normalsize
\setlength\parindent{2em}
\setlength\parskip{0pt}
%\setlength\parindent{0pt}
%\setlength\parskip{2ex}
\setlength\floatsep{45pt plus 5pt minus 5pt}
\setlength\textfloatsep{86pt plus 9pt minus 18pt}
\setlength\intextsep{45pt plus 5pt minus 15pt}
\setlength\dblfloatsep{45pt plus 5pt minus 5pt}
\setlength\dbltextfloatsep{86pt plus 9pt minus 18pt}

% ]]]

\RequirePackage{graphicx}

% utilities: string [[[

\def\tud@string@new{\@ifnextchar[{\tud@string@new@i}{\tud@string@new@i[]}}%]

\def\tud@string@new@i[#1]#2{%
  \csgdef{tud@string@separator@#2}{#1}}

\def\tud@string@append#1#2{%
  \def\tud@tmp{#2}%
  \ifcsdef{tud@string@data@#1}{%
    \csxdef{tud@string@data@#1}{\csexpandonce{tud@string@data@#1}\csexpandonce{tud@string@separator@#1}\expandonce\tud@tmp}}{%
    \csxdef{tud@string@data@#1}{\expandonce\tud@tmp}}}

\def\tud@string@use#1{%
  \csuse{tud@string@data@#1}}

\long\def\tud@string@ifempty#1#2#3{%
  \ifcsdef{tud@string@data@#1}{#3}{#2}}

% ]]]

% fonts and sections [[[

\renewcommand{\familydefault}{\sfdefault}

\setcounter{secnumdepth}{0}
\renewcommand\section{%
  \@startsection{section}{1}{0pt}%
   {-.5ex plus -1ex minus -.2ex}%
   {.5ex plus .5ex}%
   {\large\bfseries\color{tudblue}}%
}

% ]]]
% authors [[[

% \addauthornote{key}[symbol]{description}

\def\tud@authornote@getsymbol#1{%
  \ifcsdef{tud@authornote@symbol@#1}{%
    \csuse{tud@authornote@symbol@#1}}{%
    \ClassWarning{tudelftposter}{unknown author note '#1'}%
    \textsuperscript{{\bfseries??}}}}

\def\addauthornote#1{\@ifnextchar[{\tud@authornote@addi{#1}}{\tud@authornote@addii{#1}}}%]

\def\tud@authornote@addi#1[#2]#3{%
  \csgdef{tud@authornote@symbol@#1}{\textsuperscript{{#2}}}%
  \tud@authornote@addiii{#1}{#3}}%

\newcounter{tud@authornote@symbolcounter}
\setcounter{tud@authornote@symbolcounter}{0}

\def\tud@authornote@addii#1#2{%
  \stepcounter{tud@authornote@symbolcounter}%
  \csxdef{tud@authornote@symbol@#1}{%
    \noexpand\textsuperscript{\fnsymbol{tud@authornote@symbolcounter}}}
  \tud@authornote@addiii{#1}{#2}}%

\tud@string@new[,\quad]{authornotes}
\def\tud@authornote@addiii#1#2{%
  \tud@string@append{authornotes}{\mbox{\tud@authornote@getsymbol{#1}{#2}}}}

% \addauthor[authornote1,authornote2]{name}

\tud@string@new[, ]{authors}
\def\addauthor{\@ifnextchar [{\tud@addauthor}{\tud@addauthor[]}}%]
\def\tud@addauthor[#1]#2{%
  \tud@string@append{authors}{%
    \mbox{%
      {#2}%
      \@for\tud@tmp:=#1\do{%
        \tud@authornote@getsymbol{\tud@tmp}}}}}

% ]]]
% header and footer [[[

\RequirePackage{tikz}
\usetikzlibrary{calc}

\newlength\safetymargin
\setlength\safetymargin{1cm}

\newlength\titleheaderheight
\def\@maketitle{%
  \newpage%
  \null%
  \setbox\@tempboxa\vbox{%
    \vskip 2em%
    \begin{center}%
    \let \footnote \thanks
      {\color{white}\huge\bfseries \@title \par}%
      \vskip 1.5em%
      {\Large
        \lineskip .5em%
        \tud@string@ifempty{authors}{%
          % old style authors
          \begin{tabular}[t]{c}%
            \@author
          \end{tabular}%
        }{%
          % new style authors
          \tud@string@use{authors}%
          \par\vskip .5em%
          \fontsize{32}{45}\selectfont%
          \tud@string@use{authornotes}%
        }%
        \par}%
    \end{center}%
    \par%
    \vskip 3cm}% or 1.5em
  \setlength\titleheaderheight{\ht\@tempboxa}%
  \addtolength\titleheaderheight{\dp\@tempboxa}%
% \addtolength\titleheaderheight{1.5em}%
  \begin{tikzpicture}[remember picture,overlay]
    \node at (current page.north west)
      {\begin{tikzpicture}[remember picture, overlay]
        \draw[draw=none,top color=tudbluergb,bottom color=white] (-\safetymargin,\safetymargin) rectangle (\paperwidth+\safetymargin,-\titleheaderheight);
       \end{tikzpicture}
      };
   \end{tikzpicture}%
  \unvbox\@tempboxa%
}

\AfterEndPreamble{\maketitle} % in package etoolbox

\newlength\footerlinewidth
\setlength\footerlinewidth{1pt}
\newlength\footerheight
\setlength\footerheight{.1\paperheight}
\newlength\footerblueheight
\setlength\footerblueheight{.4\footerheight}
\newlength\footerbluewhitelineheight
\setlength\footerbluewhitelineheight{.115\footerheight}
\newlength\footerbluewhitelinewidth
\setlength\footerbluewhitelinewidth{.01\footerheight}
\newlength\footerlogosmargin
\setlength\footerlogosmargin{.085\footerheight}
\newlength\footerlogosheight
\setlength\footerlogosheight{\footerheight}
\addtolength\footerlogosheight{-\footerblueheight}
\addtolength\footerlogosheight{-2\footerlogosmargin}

\newcommand{\footerlogotstextformat}{\color{white}\small\bfseries}
\settoheight\@tempdima{\footerlogotstextformat x}
\setlength\@tempdima{-\@tempdima}
\addtolength\@tempdima{\footerblueheight}
\addtolength\@tempdima{-\footerbluewhitelineheight}
\addtolength\@tempdima{-.5\footerbluewhitelinewidth}
\newlength\footerlogostextheight
\setlength\footerlogostextheight{\footerbluewhitelineheight}
\addtolength\footerlogostextheight{.5\footerbluewhitelinewidth}
\addtolength\footerlogostextheight{.5\@tempdima}

\tud@string@new{footer}

\def\ps@plain{%
  \let\@mkboth\@gobbletwo%
  \let\@oddhead\@empty%
  \def\@oddfoot{%
    \reset@font%
    \begin{tikzpicture}[remember picture,overlay]
      \node at (current page.south west)
        {\begin{tikzpicture}[remember picture, overlay]
          \fill[tudblue] (-\safetymargin,-\safetymargin) rectangle (\paperwidth+\safetymargin,\footerblueheight);
          \draw[white,line width=\footerbluewhitelinewidth] (-\safetymargin,\footerbluewhitelineheight) -- ++(\paperwidth+2\safetymargin,0cm);
          \draw[black,line width=\footerlinewidth] (-\safetymargin,\footerheight) -- ++(\paperwidth+2\safetymargin,0cm);
          \tud@string@use{footer}
         \end{tikzpicture}
        };
     \end{tikzpicture}%
     \hfil}%
  \let\@evenhead\@empty%
  \let\@evenfoot\@oddfoot}

\pagestyle{plain}

\def\addfootimage(#1:#2){%
  \@ifnextchar [{\tud@footer@addimage{#1}{#2}}{\tud@footer@addimage{#1}{#2}[]}}%]

\def\tud@footer@addimage#1#2[#3]#4{%
  \tud@footer@addtotextbar{#1}{#2}{#3}%
  \tud@footer@addtoimagebar{#1}{#2}{\includegraphics[height=\footerlogosheight]{#4}}}

\def\addfootobject{%
  \@ifstar{\tud@footer@addrawobject}{\tud@footer@addobject}}

\def\tud@footer@addrawobject(#1:#2){%
  \@ifnextchar [{\tud@footer@addrawobjecti{#1}{#2}}{\tud@footer@addrawobjecti{#1}{#2}[]}}%]

\def\tud@footer@addrawobjecti#1#2[#3]#4{%
  \tud@footer@addtotextbar{#1}{#2}{#3}%
  \tud@footer@addtoimagebar{#1}{#2}{#4}}

\def\tud@footer@addobject(#1:#2){%
  \@ifnextchar [{\tud@footer@addobjecti{#1}{#2}}{\tud@footer@addobjecti{#1}{#2}[]}}%]

\def\tud@footer@addobjecti#1#2[#3]#4{%
  \tud@footer@addtotextbar{#1}{#2}{#3}%
  \tud@footer@addtoimagebar{#1}{#2}{\resizebox{!}{\footerlogosheight}{#4}}}

\def\addfoottext(#1:#2)#3{%
  \tud@footer@addtotextbar{#1}{#2}{#3}}

\def\addfootqrcode(#1:#2){%
  \@ifnextchar [{\tud@footer@addqrcode{#1}{#2}}{\tud@footer@addqrcode{#1}{#2}[]}}%]

\def\tud@footer@addqrcode#1#2[#3]#4{%
  \tud@footer@addtotextbar{#1}{#2}{#3}%
  \tud@footer@addtoimagebar{#1}{#2}{\tud@qr@insert{#4}{\footerlogosheight}}}

\def\tud@footer@getposition#1{\csuse{tud@footer@position@#1}}
\def\tud@footer@position@c{above}
\def\tud@footer@position@l{above right}
\def\tud@footer@position@r{above left}

\def\tud@footer@addtoimagebar#1#2#3{%
  \tud@string@append{footer}{%
    \node[inner sep=0pt,\tud@footer@getposition{#1}] at (#2,\footerblueheight+\footerlogosmargin) {%
      {#3}};}}

\def\tud@footer@addtotextbar#1#2#3{%
  \tud@string@append{footer}{%
    \node[inner sep=0pt,\tud@footer@getposition{#1},baseline=0cm] at (#2,\footerlogostextheight) {%
      \raisebox{0pt}[\height][0pt]{{#3}}};}}

% ]]]
% floats [[[

\RequirePackage{float}
\floatplacement{figure}{h}
\floatplacement{table}{h}

\RequirePackage[font={small,sl}]{caption}

% ]]]
% list environments [[[

\setlength\leftmargini  {2em}
\leftmargin  \leftmargini
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\setlength\leftmarginv  {.5em}
\setlength\leftmarginvi {.5em}
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\labelitemi{{\rmfamily\textbullet}}
\renewcommand\labelitemii{\normalfont\bfseries \textendash}
\renewcommand\labelitemiii{\textasteriskcentered}
\renewcommand\labelitemiv{\textperiodcentered}

% ]]]

% QR code [[[

\newwrite\tud@qr@out
\immediate\openout\tud@qr@out\jobname.qro

\newlength{\qrsize}

\def\tud@qr@insert#1#2{%
  \bgroup%
    \immediate\write\tud@qr@out{#1}%
    \def\qrcode{%
      \ClassWarningNoLine{tudelftposter}{Please run `python generate-qrcode.py \jobname` to generate the QR codes}%
      \begin{tikzpicture}[x=#2,y=#2]%
        \fill[color=red] (0,0) rectangle (1,1);%
        \node[below right,color=white] at (0,1) {\parbox{#2}{\tiny\raggedright run generate-qrcode.py}};%
      \end{tikzpicture}}%
    \edef\qrmsgout{#1}%
    \setlength{\qrsize}{#2}%
    \IfFileExists{\jobname.qri}{\input{\jobname.qri}}{}%
    \qrcode%
  \egroup}

% ]]]

\let\theinstitution\relax%
\def\institution#1{%
  \gdef\theinstitution{#1}}%

% block [[[

\newlength\tud@block@inset%
\newlength\tud@block@vmargin%
\newlength\tud@block@hmargin%
\newlength\tud@block@textwidth%

\newcommand{\experimentalblockleft}[1]{%
  \begin{figure}[h]%
    \setlength\tud@block@inset{\oddsidemargin}%
    \addtolength\tud@block@inset{1in}%
    \addtolength\tud@block@inset{\safetymargin}%
    \setlength\tud@block@vmargin{.5\columnsep}%
    \setlength\tud@block@hmargin{\columnsep}%
    \setlength\tud@block@textwidth{\columnwidth}%
    \addtolength\tud@block@textwidth{-\tud@block@hmargin}%
    \hspace{-\tud@block@inset}%
    \makebox[0pt][l]{%
      \colorbox{black}{%
        \vbox{%
          \vbox to\tud@block@vmargin{\vfill}%
          \hbox{%
            \hspace{\tud@block@inset}\parbox{\tud@block@textwidth}{%
              \color{white}%
              \bfseries%
              #1%
            }\hspace{\tud@block@hmargin}%
          }%
          \vbox to\tud@block@vmargin{\vfill}%
        }%
      }%
    }%
  \end{figure}%
}

\newcommand{\experimentalblockright}[1]{%
  \begin{figure}[h]%
    \setlength\tud@block@inset{\evensidemargin}%
    \addtolength\tud@block@inset{1in}%
    \addtolength\tud@block@inset{\safetymargin}%
    \setlength\tud@block@vmargin{.5\columnsep}%
    \setlength\tud@block@hmargin{\columnsep}%
    \setlength\tud@block@textwidth{\columnwidth}%
    \addtolength\tud@block@textwidth{-\tud@block@hmargin}%
%   \hspace{-\tud@block@inset}%
    \makebox[0pt][l]{%
      \colorbox{black}{%
        \vbox{%
          \vbox to\tud@block@vmargin{\vfill}%
          \hbox{%
            \hspace{\tud@block@hmargin}\parbox{\tud@block@textwidth}{%
              \color{white}%
              \bfseries%
              #1%
            }\hspace{\tud@block@inset}%
          }%
          \vbox to\tud@block@vmargin{\vfill}%
        }%
      }%
    }%
  \end{figure}%
}

% ]]]

% vim: ts=2:sts=2:sw=2:et:fdm=marker:fmr=[[[,]]]
