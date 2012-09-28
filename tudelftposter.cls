\ProvidesClass{tudelftposter}[2012/03/29, v. 1.1]
\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\RequirePackage{etoolbox}

\newif\iftud@usetikz
\tud@usetikzfalse
\IfFileExists{tikz.sty}{\tud@usetikztrue}{\tud@usetikzfalse}

\newif\iftud@experimentalheadergradient
\tud@experimentalheadergradientfalse

% options [[[

\DeclareOption{draft}{\PassOptionsToClass{draft}{article}}
\DeclareOption{final}{\PassOptionsToClass{final}{article}}
\DeclareOption{experimentalheadergradient}{\tud@experimentalheadergradienttrue}

\ExecuteOptions{final}
\ProcessOptions

% ]]]

\LoadClass[onecolumn]{article}
\setlength{\columnsep}{3cm}

% packages [[[

\RequirePackage[paper=a0paper,hmargin=\columnsep,vmargin={0cm,0cm},footskip=\columnsep]{geometry}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\iftud@usetikz
  \RequirePackage{tikz}
  \usetikzlibrary{calc}
  \usetikzlibrary{fadings}
\else%
  \RequirePackage{eso-pic}
\fi
\RequirePackage{multicol}

% ]]]

% color definitions [[[

\definecolor{tudcyan}{HTML}{00a6d6}

% ]]]
% font size definitions (TODO: should be placed in sizeXXposter.clo files ...) [[[

\RequirePackage{lmodern}
\RequirePackage[T1]{fontenc}
\rmfamily

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
\setlength\parskip{0pt plus .5ex}
%\setlength\parindent{0pt}
%\setlength\parskip{2ex}
\setlength\floatsep{45pt plus 5pt minus 5pt}
\setlength\textfloatsep{86pt plus 9pt minus 18pt}
\setlength\intextsep{45pt plus 5pt minus 15pt}
\setlength\dblfloatsep{45pt plus 5pt minus 5pt}
\setlength\dbltextfloatsep{86pt plus 9pt minus 18pt}

\setlength\abovedisplayskip{32pt plus 3pt minus 3pt}
\setlength\abovedisplayshortskip{14pt plus 3pt minus 3pt}
\setlength\belowdisplayskip{\abovedisplayskip}
\setlength\belowdisplayshortskip{\abovedisplayskip}

% ]]]

% utilities: string [[[

\def\tud@string@new{%
  \@ifnextchar [{\tud@string@new@i}{\tud@string@new@ii[][]}}%]

\def\tud@string@new@i[#1]{%
  \@ifnextchar [{\tud@string@new@ii[#1]}{\tud@string@new@ii[#1][]}}%]

\def\tud@string@new@ii[#1][#2]#3{%
  \csgdef{tud@string@separator@#3}{#1}%
  \csgdef{tud@string@end@#3}{#2}}

\def\tud@string@append#1#2{%
  \def\tud@tmp{#2}%
  \ifcsdef{tud@string@data@#1}{%
    \csxdef{tud@string@data@#1}{\csexpandonce{tud@string@data@#1}\csexpandonce{tud@string@separator@#1}\expandonce\tud@tmp}}{%
    \csxdef{tud@string@data@#1}{\expandonce\tud@tmp}}}

\def\tud@string@use#1{%
  \csuse{tud@string@data@#1}{\csuse{tud@string@end@#1}}}

\long\def\tud@string@ifempty#1#2#3{%
  \ifcsdef{tud@string@data@#1}{#3}{#2}}

% ]]]

% fonts and sections [[[

\renewcommand{\familydefault}{\sfdefault}
\newcommand{\tudstylesection}{\normalfont\sffamily\large\bfseries\color{tudcyan}}

\setcounter{secnumdepth}{0}
\renewcommand\section{%
  \@startsection{section}{1}{0pt}%
   {-2ex plus -1ex minus -.2ex}%
   {1ex plus 1ex}%
   {\tudstylesection}%
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

\newbox\tud@authors@tempboxa
\newbox\tud@authors@tempboxb

\def\tud@authors@foo#1#2{%
  \setbox\tud@authors@tempboxa\hbox{#1}%
  \setbox\tud@authors@tempboxb\hbox{#2}%
  \ifdimgreater{\wd\tud@authors@tempboxa}{\wd\tud@authors@tempboxb}{\makebox[0pt][l]{#2}#1}{\makebox[0pt][l]{#1}#2}}

\tud@string@new[,\quad][\null]{authors}
\def\addauthor{\@ifnextchar [{\tud@authors@add}{\tud@authors@add[]}}%]
\def\tud@authors@add[#1]#2{%
  \tud@string@append{authors}{%
    \mbox{#2}%
    \tud@authors@foo{%
    \@for\tud@tmp:=#1\do{%
      \tud@authornote@getsymbol{\tud@tmp}}}}}

% ]]]
% header [[[

\newcommand{\tudstyleheadtitle}{\normalfont\sffamily\color{white}\huge\bfseries}
\newcommand{\tudstyleheadauthors}{\normalfont\sffamily\Large}
\newcommand{\tudstyleheadauthornotes}{\normalfont\sffamily\fontsize{32}{45}\selectfont}

\newlength\safetymargin
\setlength\safetymargin{1cm}

\def\@maketitle{%
  \newpage%
  \null%
  \setbox\@tempboxa\vbox{%
    \vskip 2em%
    \begin{center}%
    \let \footnote \thanks
      {\tudstyleheadtitle \@title \par}%
      \vskip 1.5em%
      {\Large
        \lineskip .5em%
        \tud@string@ifempty{authors}{{%
          \tudstyleheadauthors%
          % old style authors
          \begin{tabular}[t]{c}%
            \@author
          \end{tabular}}%
        }{%
          % new style authors
          {\tudstyleheadauthors%
          \tud@string@use{authors}}%
          \par\vskip .5em%
          {\tudstyleheadauthornotes%
          \tud@string@use{authornotes}}%
        }%
        \par}%
    \end{center}%
    \par%
    \vskip\columnsep}%
  \tud@headergradient{\ht\@tempboxa+\dp\@tempboxa}%
  \unvbox\@tempboxa%
}

\newlength\tud@titleheaderheight
\def\tud@headergradient#1{%
  \global\deflength\tud@titleheaderheight{#1}%
  \iftud@usetikz%
    \begin{tikzpicture}[remember picture,overlay]
      \node at (current page.north west)
        {\begin{tikzpicture}[remember picture,overlay]
          \iftud@experimentalheadergradient
            \fill[tudcyan,path fading=south] (-\safetymargin,\safetymargin) rectangle (\paperwidth+\safetymargin,-\tud@titleheaderheight);
          \else
            \draw[draw=none,top color=tudcyan,bottom color=white] (-\safetymargin,\safetymargin) rectangle (\paperwidth+\safetymargin,-\tud@titleheaderheight);
          \fi
         \end{tikzpicture}
        };
    \end{tikzpicture}%
  \else%
    \null%
    \AddToShipoutPicture*{%
      \newlength\tud@header@tmpi%
      \newlength\tud@header@tmpii%
      \newlength\tud@header@tmpiii%
      \deflength{\tud@header@tmpi}{\paperheight-\tud@titleheaderheight}%
      \deflength{\tud@header@tmpii}{\paperwidth+2\safetymargin}%
      \deflength{\tud@header@tmpiii}{\tud@titleheaderheight+\safetymargin}%
      \put(0,0){\hspace{-\safetymargin}\raisebox{\tud@header@tmpi}{\includegraphics[height=\tud@header@tmpiii,width=\tud@header@tmpii]{tudelftgradient}}}%
    }%
  \fi}

\AfterEndPreamble{\maketitle\begin{multicols}{2}} % in package etoolbox
\AtEndDocument{\end{multicols}}

% ]]]
% footer [[[

\newlength\footerheight
\deflength\footerheight{.1\paperheight}
\newlength\footerheightwithmargin
\deflength\footerheightwithmargin{\footerheight+\columnsep}
\geometry{vmargin={0cm,\footerheightwithmargin}}

\newlength\footerblacklinewidth
\deflength\footerblacklinewidth{1pt}
\newlength\footerwhiteliney
\deflength\footerwhiteliney{.115\footerheight}
\newlength\footerwhitelinewidth
\deflength\footerwhitelinewidth{.01\footerheight}
\newlength\footerblueyi
\deflength\footerblueyi{\footerwhiteliney-.5\footerwhitelinewidth}
\newlength\footerblueyii
\deflength\footerblueyii{\footerwhiteliney+.5\footerwhitelinewidth}
\newlength\footerblueyiii
\deflength\footerblueyiii{.4\footerheight}
\newlength\footerimagemargin
\deflength\footerimagemargin{.085\footerheight}
\newlength\footerimageheight
\deflength\footerimageheight{\footerheight-\footerblueyiii-2\footerimagemargin}

\newlength\footerimagey
\deflength\footerimagey{\footerblueyiii+\footerimagemargin}

\newcommand{\tudstylefooter}{\normalfont\sffamily\color{white}\small\bfseries}
\newlength\footertextheight
\settoheight\footertextheight{\tudstylefooter X}
\newlength\footerimagetexty
\deflength\footerimagetexty{.5\footerblueyii+.5\footerblueyiii-.5\footertextheight}

\tud@string@new{footer}

\iftud@usetikz

  \def\ps@plain{%
    \let\@mkboth\@gobbletwo%
    \let\@oddhead\@empty%
    \def\@oddfoot{%
      \reset@font%
      \begin{tikzpicture}[remember picture,overlay]
        \node at (current page.south west)
          {\begin{tikzpicture}[remember picture, overlay]
            \fill[tudcyan] (-\safetymargin,-\safetymargin) rectangle (\paperwidth+\safetymargin,\footerblueyi);
            \fill[tudcyan] (-\safetymargin,\footerblueyii) rectangle (\paperwidth+\safetymargin,\footerblueyiii);
            \fill[black] (-\safetymargin,\footerheight) rectangle (\paperwidth+\safetymargin,\footerheight+\footerblacklinewidth);
            \tud@string@use{footer}
           \end{tikzpicture}
          };
       \end{tikzpicture}%
       \hfil}%
    \let\@evenhead\@empty%
    \let\@evenfoot\@oddfoot}

  \def\tud@footer@getposition#1{\csuse{tud@footer@position@#1}}
  \def\tud@footer@position@c{above}
  \def\tud@footer@position@l{above right}
  \def\tud@footer@position@r{above left}

  \def\tud@footer@addtoimagebar#1#2#3{%
    \tud@string@append{footer}{%
      \node[inner sep=0pt,\tud@footer@getposition{#1}] at (\tud@xpos@resolve{#2},\footerimagey) {%
        {#3}};}}

  \def\tud@footer@addtotextbar#1#2#3{%
    \tud@string@append{footer}{%
      \node[inner sep=0pt,\tud@footer@getposition{#1},baseline=0cm] at (\tud@xpos@resolve{#2},\footerimagetexty) {%
        \raisebox{0pt}[\height][0pt]{{\tudstylefooter #3}}};}}

\else

  \newlength\tud@put@x
  \newlength\tud@put@y
  \def\tud@put(#1,#2)#3{%
    \deflength\tud@put@x{#1}%
    \deflength\tud@put@y{#2}%
    \makebox[0pt][l]{\raisebox{\tud@put@y}{\hspace{\tud@put@x}#3}}}

  \newlength\tud@rectangle@width
  \newlength\tud@rectangle@height
  \def\tud@rectangle[#1](#2,#3)(#4,#5){%
    \deflength\tud@rectangle@width{(#4)-(#2)}%
    \deflength\tud@rectangle@height{(#5)-(#3)}%
    \tud@put(#2,#3){{\color{#1}\rule{\tud@rectangle@width}{\tud@rectangle@height}}}}

  \def\ps@plain{%
    \let\@mkboth\@gobbletwo%
    \let\@oddhead\@empty%
    \def\@oddfoot{%
      \reset@font%
      \makebox[0pt][l]{\raisebox{-\footerheight}{%
        \hspace{-\columnsep}%
        \tud@rectangle[black](-\safetymargin,\footerheight)(\paperwidth+\safetymargin,\footerheight+\footerblacklinewidth)%
        \tud@rectangle[tudcyan](-\safetymargin,-\safetymargin)(\paperwidth+\safetymargin,\footerblueyi)%
        \tud@rectangle[tudcyan](-\safetymargin,\footerblueyii)(\paperwidth+\safetymargin,\footerblueyiii)%
        \tud@string@use{footer}%
      }}\hfil}%
    \let\@evenhead\@empty%
    \let\@evenfoot\@oddfoot}

  \def\tud@footer@addtoimagebar#1#2#3{%
    \tud@string@append{footer}{%
      \tud@put(\tud@xpos@resolve{#2},\footerimagey){\makebox[0pt][#1]{{#3}}}}}

  \def\tud@footer@addtotextbar#1#2#3{%
    \tud@string@append{footer}{%
      \tud@put(\tud@xpos@resolve{#2},\footerimagetexty){\makebox[0pt][#1]{{\tudstylefooter #3}}}}}

\fi

\pagestyle{plain}

\def\addfootimage(#1:#2){%
  \@ifnextchar [{\tud@footer@addimage{#1}{#2}}{\tud@footer@addimage{#1}{#2}[]}}%]

\def\tud@footer@addimage#1#2[#3]#4{%
  \tud@footer@addtotextbar{#1}{#2}{#3}%
  \tud@footer@addtoimagebar{#1}{#2}{\includegraphics[height=\footerimageheight]{#4}}}

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
  \tud@footer@addtoimagebar{#1}{#2}{\resizebox{!}{\footerimageheight}{#4}}}

\def\addfoottext(#1:#2)#3{%
  \tud@footer@addtotextbar{#1}{#2}{#3}}

\def\addfootqrcode(#1:#2){%
  \@ifnextchar [{\tud@footer@addqrcode{#1}{#2}}{\tud@footer@addqrcode{#1}{#2}[]}}%]

\def\tud@footer@addqrcode#1#2[#3]#4{%
  \tud@footer@addtotextbar{#1}{#2}{#3}%
  \tud@footer@addtoimagebar{#1}{#2}{\tud@qr@insert{#4}{\footerimageheight}}}

% position aliases

\def\tud@xpos@resolve#1{%
  \ifcsdef{tud@xpos@@\detokenize{#1}}{\csuse{tud@xpos@@#1}}{#1}}

\csdef{tud@xpos@@page.center}{.5\paperwidth}%
\csdef{tud@xpos@@left column.center}{.26\paperwidth}% FIXME
\csdef{tud@xpos@@left column.left}{\columnsep}%
\csdef{tud@xpos@@left column.right}{.48\paperwidth}% FIXME
\csdef{tud@xpos@@right column.center}{.74\paperwidth}% FIXME
\csdef{tud@xpos@@right column.left}{.52\paperwidth}% FIXME
\csdef{tud@xpos@@right column.right}{.96\paperwidth}% FIXME

% ]]]
% floats [[[

% TODO: redefine figure and table
%\RequirePackage{float}
%\floatplacement{figure}{h}
%\floatplacement{table}{h}
%
%\RequirePackage[font={small,sl}]{caption}

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
\renewcommand\labelitemi{{\fontfamily{lmr}\selectfont\textbullet}}
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
