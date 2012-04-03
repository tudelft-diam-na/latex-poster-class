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
        \begin{tabular}[t]{c}%
          \tud@author
        \end{tabular}\par}%
    \end{center}%
    \par%
    \vskip 3cm}%
%   \vskip 1.5em}%
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
%         \node[inner sep=0pt,above] at (.25\paperwidth,\footerblueheight+\footerlogosmargin) {\includegraphics[height=\footerlogosheight]{sponsor_logo}};
          \node[inner sep=0pt,above] at (.75\paperwidth,\footerblueheight+\footerlogosmargin) {\includegraphics[height=\footerlogosheight]{tud_logo}};
          \node[inner sep=0pt,above] at (\theqrcodeposition\paperwidth,\footerblueheight+\footerlogosmargin) {\theqrcode};
%         \node[inner sep=0pt,above,baseline=0cm] at (.25\paperwidth,\footerlogostextheight) {\raisebox{0pt}[\height][0pt]{\footerlogotstextformat project sponsored by ...}};
          \node[inner sep=0pt,above,baseline=0cm] at (.75\paperwidth,\footerlogostextheight) {\raisebox{0pt}[\height][0pt]{\footerlogotstextformat\theinstitution}};
         \end{tikzpicture}
        };
     \end{tikzpicture}%
     \hfil}%
  \let\@evenhead\@empty%
  \let\@evenfoot\@oddfoot}

\pagestyle{plain}

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

\let\theqrcode\relax%
\def\qrcodefilename#1{%
  \gdef\theqrcode{%
    \includegraphics[height=\footerlogosheight]{#1}}}%
\def\qrcodeposition#1{%
  \gdef\theqrcodeposition{#1}}%
\qrcodeposition{.95}%

% ]]]

\def\@namegdef#1{\expandafter\gdef\csname #1\endcsname}

% authors [[[

% \addauthornote{key}[symbol]{description}

\gdef\tud@authornotes@list{}

\def\tud@authornote@getsymbol#1{%
  {\csname tud@authornote@symbol@#1\endcsname}}

\def\addauthornote#1{\@ifnextchar[{\tud@authornote@addi{#1}}{\tud@authornote@addii{#1}}}%]

\def\tud@authornote@addi#1[#2]#3{%
  \expandafter\gdef\csname tud@authornote@symbol@#1\endcsname{#2}%
  \tud@authornote@addiii{#1}{#3}}%

\newcounter{tud@authornote@symbolcounter}
\setcounter{tud@authornote@symbolcounter}{0}

\def\tud@authornote@addii#1#2{%
  \stepcounter{tud@authornote@symbolcounter}%
  \expandafter\edef\csname tud@authornote@symbol@#1\endcsname{%
    \noexpand\textsuperscript{\fnsymbol{tud@authornote@symbolcounter}}}
  \tud@authornote@addiii{#1}{#2}}%

\def\tud@authornote@addiii#1#2{%
  \ifx\tud@authornotes@list\empty%
    \gdef\tud@authornotes@list{\tud@authornote@getsymbol{#1}{#2}}%
  \else%
    \expandafter\gdef\expandafter\tud@authornotes@list\expandafter{\tud@authornotes@list, \tud@authornote@getsymbol{#1}{#2}}%
  \fi}

% \addauthor[authornote1,authornote2]{name}

\def\addauthor{\@ifnextchar [{\tud@addauthor}{\tud@addauthor[]}}%]
\gdef\tud@authors@list{}
\def\tud@addauthor[#1]#2{%
  \ifx\tud@authors@list\empty%
  \else%
    \expandafter\gdef\expandafter\tud@authors@list\expandafter{\tud@authors@list, }%
  \fi%
  \expandafter\gdef\expandafter\tud@authors@list\expandafter{\tud@authors@list{#2}}%
  \expandafter\gdef\expandafter\tud@authors@list\expandafter{%
    \tud@authors@list%
    \@for\tud@tmp:=#1\do{\tud@authornote@getsymbol{\tud@tmp}}}}%

\def\tud@author{%
  \ifx\@authors@list\empty%
    \@author%
  \else%
    \tud@authors@list\\%
    \fontsize{32}{45}\selectfont%
    \tud@authornotes@list%
  \fi}

% ]]]

\let\theinstitution\relax%
\def\institution#1{%
  \gdef\theinstitution{#1}}%

% vim: ts=2:sts=2:sw=2:et:fdm=marker:fmr=[[[,]]]
