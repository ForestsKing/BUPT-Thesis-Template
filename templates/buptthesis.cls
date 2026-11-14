%% 北京邮电大学硕博学位论文文档类：版式、章节标题、扉页与声明页排版，含盲审 blind 选项


%% -----------------------------------------------------------------
%% 北京邮电大学研究生学位论文 LaTeX 模板 - 文档类文件
%% 适配标准：北京邮电大学研究生院《学位论文写作与制作规范》（2025年1月15日修订）
%% 适用对象：学术型硕士、专业型硕士、学术型博士、专业型博士学位论文
%% -----------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{buptthesis}
  [2025/01/15 v1.0 Beijing University of Posts and Telecommunications (BUPT) Thesis Class]

%% -----------------------------------------------------------------
%% 1. 文档类选项定义与处理
%% -----------------------------------------------------------------
\newif\ifBUPT@option@phd             \BUPT@option@phdtrue
\newif\ifBUPT@option@master          \BUPT@option@masterfalse
\newif\ifBUPT@option@phil            \BUPT@option@philtrue
\newif\ifBUPT@option@eng             \BUPT@option@engfalse
\newif\ifBUPT@option@electronic      \BUPT@option@electronicfalse
\newif\ifBUPT@option@print           \BUPT@option@printtrue
\newif\ifBUPT@option@blind           \BUPT@option@blindfalse
\newcommand{\BUPTifblind}[2]{\ifBUPT@option@blind#1\else#2\fi}

%% 学位级别：硕士 / 博士
\DeclareOption{master}{%
  \BUPT@option@mastertrue%
  \BUPT@option@phdfalse}
\DeclareOption{phd}{%
  \BUPT@option@masterfalse%
  \BUPT@option@phdtrue}

%% 学位类别：学术学位 (phil) / 专业学位 (eng)
\DeclareOption{phil}{%
  \BUPT@option@philtrue%
  \BUPT@option@engfalse}
\DeclareOption{eng}{%
  \BUPT@option@philfalse%
  \BUPT@option@engtrue}

%% 输出版本：打印版补齐奇数页，电子版连续排页
\DeclareOption{electronic}{%
  \BUPT@option@electronictrue%
  \BUPT@option@printfalse}
\DeclareOption{print}{%
  \BUPT@option@electronicfalse%
  \BUPT@option@printtrue}

%% 盲审选项：扉页作者/学号/导师匿名，答辩委员会名单置空
\DeclareOption{blind}{\BUPT@option@blindtrue}

%% 传递其他参数给底层宏包
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}

%% 默认：学术学位博士打印版
\ExecuteOptions{phd,phil,print}
\ProcessOptions\relax

%% -----------------------------------------------------------------
%% 2. 载入 ctexbook 文档类
%% -----------------------------------------------------------------
\PassOptionsToPackage{no-math}{fontspec}

\LoadClass[
  UTF8,
  a4paper,
  zihao=-4,
  scheme=chinese,
  twoside,
  openright
]{ctexbook}

%% -----------------------------------------------------------------
%% 3. 基础依赖宏包载入
%% -----------------------------------------------------------------
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{etoolbox}
\RequirePackage{titletoc}
\RequirePackage{graphicx}
\RequirePackage{caption}
\RequirePackage{bicaption}
\RequirePackage{newfloat}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{longtable}
\RequirePackage{makecell}
\RequirePackage{multirow}
\RequirePackage{mathtools}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{enumitem}
\RequirePackage{xcolor}
\RequirePackage{url}
\RequirePackage{pdfpages}
\RequirePackage{subcaption}

%% 参考文献宏包 GB/T 7714-2015
\RequirePackage[sort]{gbt7714}

%% -----------------------------------------------------------------
%% 脚注使用带圈数字，每页重新编号。
%% 脚注文本宋体小五、单倍行距、首行无缩进；正文标记为上标
%% -----------------------------------------------------------------
\newcommand{\BUPT@circledfootnote}{%
  \ifnum\value{footnote}<21
    {\BUPT@footnotesymbol\symbol{\numexpr9311+\value{footnote}\relax}}%
  \else
    \textcircled{\scriptsize\arabic{footnote}}%
  \fi
}
\renewcommand{\thefootnote}{\protect\BUPT@circledfootnote}
\RequirePackage[perpage,bottom]{footmisc}
\setlength{\skip\footins}{16bp}
% 页底脚注与正文版心底部之间保留 2.65 磅。
\patchcmd{\@outputbox@appendfootnotes}{\unvbox\footins}
  {\dimen@=\dimexpr2.65bp-\dp\footins\relax\unvbox\footins\kern\dimen@}{}{}
\renewcommand{\footnoterule}{%
  \kern-7.1bp\hrule width 144bp height .48bp\kern 6.62bp
}
\long\def\@makefntext#1{%
  \parindent\z@
  \songti\zihao{-5}\setlength{\baselineskip}{11.7bp}%
  \noindent\hb@xt@1em{\raisebox{3bp}{\scalebox{.5}{\@thefnmark}}\hfil}#1
}

%% 超链接配置
\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
  linkcolor=black,
  citecolor=black,
  filecolor=black,
  urlcolor=black,
  hypertexnames=false,
  bookmarksnumbered=true,
  bookmarksopen=true,
  pdfstartview={FitH}
}

%% -----------------------------------------------------------------
%% 4. 页面尺寸与边距设置（严格遵照2025年1月15日规范）
%% 规范要求：上 2.54cm，下 2.54cm，左 3.17cm，右 3.17cm
%%           页眉边距 1.5cm，页脚边距 1.75cm，装订线 0cm
%% -----------------------------------------------------------------
\geometry{
  a4paper,
  left=3.17cm,
  right=3.17cm,
  top=2.54cm,
  bottom=2.54cm,
  headheight=15pt,
  headsep=0.57cm,    % 页眉基线与正文位置，与官方模板渲染一致
  footskip=19.6bp    % 页码基线与官方模板渲染一致
}

%% -----------------------------------------------------------------
%% 5. 字体与行距配置
%% 规范要求：所有英文字母、阿拉伯数字、半角标点用 Times New Roman
%%           正文宋体小四号，固定值20磅
%% -----------------------------------------------------------------
\RequirePackage{eso-pic}
\RequirePackage{fontspec}
\setmainfont{Times New Roman}

% 优先使用校方模板指定的字体，macOS 可直接读取 Word 自带字库。
\def\BUPT@wordfonts{/Applications/Microsoft Word.app/Contents/Resources/DFonts/}
\newcommand{\BUPT@CJKfont}[5]{%
  \IfFileExists{\BUPT@wordfonts#3}
    {\setCJKfamilyfont{#1}[Path=\BUPT@wordfonts,#4]{#3}}
    {\IfFontExistsTF{#2}
      {\setCJKfamilyfont{#1}[#4]{#2}}
      {\ClassWarningNoLine{buptthesis}{Font #2 unavailable; using #5}%
       \setCJKfamilyfont{#1}[#4]{#5}}}%
}
\IfFontExistsTF{STSongti-SC-Regular}{%
  \BUPT@CJKfont{buptsong}{SimSun}{SimSun.ttf}{AutoFakeBold=2.55}{STSongti-SC-Regular}%
  \BUPT@CJKfont{bupthei}{SimHei}{SimHei.ttf}{AutoFakeBold=2.25}{STHeiti}%
}{%
  \BUPT@CJKfont{buptsong}{SimSun}{SimSun.ttf}{AutoFakeBold=2.55}{FandolSong-Regular.otf}%
  \BUPT@CJKfont{bupthei}{SimHei}{SimHei.ttf}{AutoFakeBold=2.25}{FandolHei-Regular.otf}%
}
\IfFileExists{\BUPT@wordfonts Kaiti.ttf}{%
  \setCJKfamilyfont{buptkai}[Path=\BUPT@wordfonts]{Kaiti.ttf}%
}{%
  \IfFontExistsTF{KaiTi}{%
    \setCJKfamilyfont{buptkai}{KaiTi}%
  }{%
    \ClassWarningNoLine{buptthesis}{Font KaiTi unavailable; using KaiTi GB2312}%
    \setCJKfamilyfont{buptkai}[Path=templates/assets/]{gbkai-Regular.ttf}%
  }%
}
\IfFileExists{\BUPT@wordfonts SimSun.ttf}{%
  \newfontfamily\BUPT@footnotesymbol[Path=\BUPT@wordfonts]{SimSun.ttf}%
}{%
  \IfFontExistsTF{SimSun}{%
    \newfontfamily\BUPT@footnotesymbol{SimSun}%
  }{%
    \newfontfamily\BUPT@footnotesymbol{HaranoAjiMincho-Regular.otf}%
  }%
}
\renewcommand{\songti}{\CJKfamily{buptsong}}
\renewcommand{\heiti}{\CJKfamily{bupthei}}
\renewcommand{\kaishu}{\CJKfamily{buptkai}}
\renewcommand{\CJKrmdefault}{buptsong}

% 陈列公式的段前、段后均留 6 磅；短公式使用同一间距。
\newcommand{\BUPT@displayspacing}{%
  \setlength{\abovedisplayskip}{6bp}%
  \setlength{\belowdisplayskip}{6bp}%
  \setlength{\abovedisplayshortskip}{6bp}%
  \setlength{\belowdisplayshortskip}{6bp}%
}
\apptocmd{\normalsize}{\linespread{1}\fontsize{12bp}{20bp}\selectfont\BUPT@displayspacing}{}{}
\let\BUPT@zihao\zihao
\renewcommand{\zihao}[1]{\BUPT@zihao{#1}\BUPT@displayspacing}
\AtBeginDocument{\normalsize}

%% 行距与段落间距
%% 小四号为12bp，linespread 1.4 时基线间距 = 12bp × 1.2 × 1.4 ≈ 20.2bp，即固定值20磅
\linespread{1}\fontsize{12bp}{20bp}\selectfont
\setlength{\parskip}{0pt}
\setlength{\topskip}{16.1bp}
\setlength{\parindent}{2\ccwd}
\raggedbottom
%% 中文字距：采用 xeCJK 默认字间距，正文每行 32 字（首行缩进后 30 字），与官方模板渲染密度一致
% 模拟 Word 中文段落的标点压缩。两端对齐时优先调节标点留白。
\xeCJKDeclarePunctStyle{buptword}{fixed-punct-ratio=.6}
% 声明页的行内标点留白独立校准，正文沿用通用段落设置。
\xeCJKDeclarePunctStyle{buptstatement}{fixed-punct-ratio=.68}
\newcommand{\BUPT@wordparagraphspacing}[1][.025em]{%
  \xeCJKsetup{PunctStyle=buptword,CJKglue={\hskip 0pt plus #1}}%
}
\newcommand{\BUPT@normalparagraphspacing}{%
  \xeCJKsetup{PunctStyle=quanjiao,CJKglue={\hskip 0pt plus .08\baselineskip}}%
}

\setlength{\arrayrulewidth}{0.48pt}   % 表格框线宽度（官方模板 0.5 磅）

%% 列表间距压缩
\setlist{nosep}

%% -----------------------------------------------------------------
%% 6. 章节与各级标题格式（严格对齐2025规范）
%% 规范要求：
%% 章标题：黑体三号，居中，段前0行，段后2行，单倍行距，空两格
%% 二级标题：黑体四号，左对齐，段前0.5行，段后0.5行，单倍行距，空两格
%% 三级标题：黑体小四号，左对齐，段前0行，段后0行，固定值20磅，空两格
%% 四级标题：宋体小四号，首行缩进2字符，段前0行，段后0行，固定值20磅，空两格
%% -----------------------------------------------------------------
\setcounter{secnumdepth}{4}

\ctexset{
  chapter = {
    name = {第,章},
    number = \chinese{chapter},
    format = \linespread{1}\selectfont\heiti\zihao{3}\centering,
    beforeskip = -19.2bp,
    afterskip = 33.25bp,
    aftername = \hspace{1em},
    pagestyle = BUPThdrstyle,
  },
  section = {
    format = \linespread{1}\selectfont\heiti\zihao{4},
    beforeskip = 8.8bp,
    afterskip = 8.9bp,
    aftername = \hspace{1em},
  },
  subsection = {
    format = \heiti\zihao{-4}\setlength{\baselineskip}{20bp},
    beforeskip = 0pt,     % 段前0行
    afterskip = 0pt,      % 段后0行
    aftername = \hspace{1em},
  },
  subsubsection = {
    format = \songti\zihao{-4}\setlength{\baselineskip}{20bp},
    beforeskip = 0pt,     % 段前0行
    afterskip = 0pt,      % 段后0行
    indent = 2\ccwd,      % 首行缩进2字符（按本段字号折算）
    aftername = \hspace{1em},
  },
}

%% -----------------------------------------------------------------
%% 7. 页眉页脚配置（严格遵照2025规范）
%% 规范要求：
%% 偶数页页眉：“北京邮电大学硕士学位论文”或“北京邮电大学博士学位论文”
%% 奇数页页眉：本章标题（如“第一章  绪论”）
%% 宋体小五号居中书写，页眉下横线为单实线
%% 页码位于底端中央，Times New Roman五号居中，两侧不加“-”等修饰线
%% 摘要至正文前用罗马数字 (I, II, III...)，第一章起用阿拉伯数字 (1, 2, 3...)
%% -----------------------------------------------------------------
%% 载入配置文件
\InputIfFileExists{templates/buptthesis.cfg}{}{}

%% 学位与论文类别值设定
\ifBUPT@option@phd
  \def\BUPT@value@degree{\BUPT@label@phddegree}
  \def\BUPT@value@degreeEN{\BUPT@label@phddegreeEN}
  \def\BUPT@value@thesisEN{\BUPT@label@phdthesisEN}
  \def\BUPT@value@headerthesis{博士学位论文}
\else
  \def\BUPT@value@degree{\BUPT@label@masterdegree}
  \def\BUPT@value@degreeEN{\BUPT@label@masterdegreeEN}
  \def\BUPT@value@thesisEN{\BUPT@label@masterthesisEN}
  \def\BUPT@value@headerthesis{硕士学位论文}
\fi

\ifBUPT@option@phil
  \def\BUPT@value@degreemode{\BUPT@label@philmode}
  \def\BUPT@value@degreemodeEN{\BUPT@label@philmodeEN}
\else
  \def\BUPT@value@degreemode{\BUPT@label@engmode}
  \def\BUPT@value@degreemodeEN{\BUPT@label@engmodeEN}
\fi

\def\BUPT@value@trainingmode{\BUPT@label@fulltime}
\def\BUPT@value@trainingmodeEN{\BUPT@label@fulltimeEN}

%% 盲审模式匿名化学位与学习方式
\ifBUPT@option@blind
  \def\BUPT@value@degree{\BUPT@label@anonymousdegree}
  \def\BUPT@value@degreeEN{\BUPT@label@anonymousdegreeEN}
  \def\BUPT@value@degreemode{\BUPT@label@anonymousmode}
  \def\BUPT@value@degreemodeEN{\BUPT@label@anonymousmodeEN}
\fi

%% 定义页眉页脚样式（页眉线长度超出正文边距，与官方模板一致）
\fancyheadoffset[OL,OR]{5.3bp}
\fancyheadoffset[EL,ER]{1.55bp}
% 上移横线，保持页眉文字和正文基线的位置。
\newcommand{\BUPT@headrule}{%
  \vskip-.65bp\hrule height\headrulewidth width\headwidth
  \vskip\dimexpr .65bp-\headrulewidth\relax
}
% 同一页脚规则覆盖摘要、正文及章首页，校准奇偶页的 Word 基线。
\newcommand{\BUPT@pagefooter}{%
  \rmfamily\zihao{5}%
  \ifodd\value{page}%
    \if@mainmatter\raisebox{-.59bp}{\thepage}\else\raisebox{.13bp}{\thepage}\fi
  \else
    \raisebox{1.33bp}{\thepage}%
  \fi
}
\newcommand{\BUPT@runningpagestyle}{%
  \fancyhf{}%
  \fancyhead[OC]{\songti\zihao{-5}\nouppercase{\leftmark}}%
  \fancyhead[EC]{\songti\zihao{-5}\raisebox{1bp}{\BUPT@label@university\BUPT@value@headerthesis}}%
  \fancyfoot[C]{\BUPT@pagefooter}%
  \renewcommand{\headrulewidth}{0.48bp}%
  \let\headrule\BUPT@headrule
  \renewcommand{\footrulewidth}{0pt}%
}

\fancypagestyle{BUPThdrstyle}{\BUPT@runningpagestyle}
\fancypagestyle{plain}{\BUPT@runningpagestyle}

% 电子版保留分节换页，跳过为奇数页起排而插入的空白页。
\ifBUPT@option@electronic
  \let\cleardoublepage\clearpage
\fi

%% 前言与正文页码划分
\let\BUPT@orig@frontmatter\frontmatter
\renewcommand{\frontmatter}{%
  \BUPT@orig@frontmatter
  \pagenumbering{Roman}%
  \pagestyle{BUPThdrstyle}%
}

\let\BUPT@orig@mainmatter\mainmatter
\renewcommand{\mainmatter}{%
  \BUPT@orig@mainmatter
  \pagenumbering{arabic}%
  \setcounter{page}{1}%
  \pagestyle{BUPThdrstyle}%
  \BUPT@wordparagraphspacing
}

\AtBeginDocument{%
  % 封面、答辩委员会名单和声明之后的补白页沿用空白样式。
  \pagestyle{empty}%
}

%% -----------------------------------------------------------------
%% 8. 目录格式设置（严格遵照2025规范）
%% 规范要求：
%% “目录”标题黑体三号居中，单倍行距，段前0，段后2行
%% 一级目录项：黑体小四号，两端对齐，左缩进0字符，固定值20磅
%% 二级目录项：宋体小四号，两端对齐，左缩进2字符，固定值20磅
%% 三级目录项：宋体小四号，两端对齐，左缩进4字符，固定值20磅
%% 点线导引符，页码右对齐
%% -----------------------------------------------------------------
\ctexset{
  contentsname = {目\BUPT@titlegap 录}
}

\DeclareRobustCommand{\BUPT@titlegap}{\hspace{1em}}
\pdfstringdefDisableCommands{\def\BUPT@titlegap{ }}
\setcounter{tocdepth}{2}
\let\BUPT@tableofcontents\tableofcontents
\renewcommand{\tableofcontents}{%
  \begingroup
    \ctexset{chapter/beforeskip=-15.5bp,chapter/afterskip=36.3bp}%
    \BUPT@tableofcontents
  \endgroup
}

% 页码右对齐，导引点填到实际页码前，避免单数字页码左侧留出整列空白。
\newcommand{\BUPT@tocpage}{%
  \titlerule*[3bp]{.}\hspace{1.5bp}\mbox{\thecontentspage}%
}
\newcommand{\BUPT@tocline}{%
  \zihao{-4}\setlength{\baselineskip}{20bp}%
  \advance\rightskip-\@pnumwidth\relax
}
\titlecontents{chapter}[0em]
  {\heiti\BUPT@tocline}
  {\thecontentslabel\hspace{.7em}}
  {}
  {\BUPT@tocpage}

% 校方 Word 目录样式将两字符和四字符分别换算为 420 和 840 缇。
\titlecontents{section}[21bp]
  {\songti\BUPT@tocline}
  {\thecontentslabel\hspace{1em}}
  {}
  {\BUPT@tocpage}

\titlecontents{subsection}[42bp]
  {\songti\BUPT@tocline}
  {\thecontentslabel\hspace{1em}}
  {}
  {\BUPT@tocpage}

%% -----------------------------------------------------------------
%% 9. 图、表、公式与算法格式设置（严格对齐2025规范）
%% 规范要求：
%% 图题居中置于图下方，楷体五号，固定值20磅，图序与图名空一格，无句末标点
%% 表题居中置于表上方，楷体五号，固定值20磅，表序与表名空一格，无句末标点
%% 图注/表注：宋体五号，首行缩进2字符，固定值20磅
%% 公式居中横排，按章编号右端对齐如 (1-1)
%% -----------------------------------------------------------------
%% 9.1 公共题注、注释与随文块
\DeclareCaptionFont{buptcaption}{\zihao{5}\kaishu\setlength{\baselineskip}{20bp}}
\newcommand{\BUPT@captiongap}{\hspace{.5em}}
\DeclareCaptionLabelSeparator{buptspace}{\BUPT@captiongap}
\captionsetup{
  format=plain,
  labelformat=simple,
  labelsep=buptspace,
  justification=centering,
  font=buptcaption
}

% 图注与表注共用字体、首行缩进和行距。随文图表固定注末行的深度。
\newif\ifBUPT@inlinenote
\newcommand{\fignote}[1]{%
  \ifhmode\par\fi
  \parbox{\linewidth}{\BUPT@normalparagraphspacing
    \songti\zihao{5}\setlength{\baselineskip}{20bp}\setlength{\parindent}{2\ccwd}%
    \indent #1\ifBUPT@inlinenote\nobreak\rule[-3bp]{0pt}{3bp}\fi\par}%
}

% 随文图表和算法作为整块参与正文分页。参数为块宽和块前留白。
\newenvironment{BUPT@inlineblock}[2]{%
  \par\addvspace{#2}%
  \noindent\hfill\begin{minipage}{#1}%
}{%
  \end{minipage}\hfill\null\par
}

%% 9.2 插图与分图
\renewcommand{\thefigure}{\thechapter-\arabic{figure}}

\DeclareCaptionFont{buptsub}{\songti\zihao{5}\linespread{1}\selectfont}
\DeclareCaptionLabelSeparator{buptsubspace}{\hspace{.65em}}
\captionsetup[sub]{font=buptsub,skip=.8bp,labelsep=buptsubspace}
\captionsetup[figure][bi-second]{name=Figure,labelsep=space}
\captionsetup[figure]{skip=12.9bp}
\AfterEndEnvironment{subfigure}{\captionsetup{skip=6.85bp}}

% 默认随文排版。显式给出浮动参数时，沿用原有 figure 接口。
\NewDocumentEnvironment{thesisfigure}{o}{%
  \IfNoValueTF{#1}{%
    \begin{BUPT@inlineblock}{\linewidth}{7.14bp}%
    \captionsetup{type=figure}%
    \BUPT@inlinenotetrue
    \centering
  }{\begin{figure}[#1]}%
}{%
  \IfNoValueTF{#1}{%
    \end{BUPT@inlineblock}\addvspace{6.04bp}%
  }{\end{figure}}%
}

%% 9.3 表格与表注
\renewcommand{\thetable}{\thechapter-\arabic{table}}

\captionsetup[table][bi-second]{name=Table,labelsep=space}
% 普通表与长表使用不同的题注行框；分别分配框内留白，使题名到顶线的距离一致。
\captionsetup[table]{position=top,belowskip=1.75bp,aboveskip=.25bp}
\captionsetup[longtable]{position=top,belowskip=6.87bp,aboveskip=-4.87bp}

%% 表格线间距归零（官方模板三线表线紧贴行框）
\setlength{\aboverulesep}{0pt}
\setlength{\belowrulesep}{0pt}

% Word 表格行的最小高度为 374 缇，符号说明沿用 20 磅段落行距。
\newcommand{\BUPT@tablerows}[2][.7]{%
  \setlength{\baselineskip}{#2}%
  \setbox\strutbox\hbox{\vrule height #1\baselineskip
    depth \dimexpr\baselineskip-#1\baselineskip\relax width 0pt}%
  \setlength{\extrarowheight}{0pt}%
  \renewcommand{\arraystretch}{1}%
}
\AtBeginEnvironment{tabular}{\linespread{1}\selectfont}
\AtBeginEnvironment{longtable}{\songti\zihao{5}\BUPT@tablerows{18.7bp}}
\newcolumntype{B}[1]{>{\centering\arraybackslash}m{#1}}
\newsavebox{\BUPT@centeredtablebox}
% 可选参数依次为单侧列距与行框基线上方的比例。
\NewDocumentEnvironment{thesistabular}{O{3.45bp} O{.665} m}{%
  \linespread{1}\songti\zihao{5}\setlength{\tabcolsep}{#1}%
  \BUPT@tablerows[#2]{18.7bp}%
  \begin{lrbox}{\BUPT@centeredtablebox}%
    \tabular{#3}%
}{%
  \endtabular
  \end{lrbox}%
  \makebox[\linewidth][c]{\usebox{\BUPT@centeredtablebox}}%
}

\newlength{\BUPT@tablenotegap}
\setlength{\BUPT@tablenotegap}{5.6bp}
\newif\ifBUPT@hastablenote
\AtBeginEnvironment{table}{\BUPT@hastablenotefalse}
\newcommand{\tablenote}[1]{%
  \par
  \ifBUPT@hastablenote\else
    \vskip\BUPT@tablenotegap\relax
    \BUPT@hastablenotetrue
  \fi
  \fignote{#1}%
}
\AtEndEnvironment{table}{%
  \ifBUPT@hastablenote
    \ifBUPT@inlinenote\else\par\vskip-\BUPT@tablenotegap\relax\fi
  \fi
}

% 省略位置参数时随文排版，例如 [!t] 可交由 LaTeX 放置在页首。
\NewDocumentEnvironment{thesistable}{o}{%
  \IfNoValueTF{#1}{%
    \begin{BUPT@inlineblock}{\linewidth}{7.14bp}%
    \captionsetup{type=table}%
  }{\begin{table}[#1]}%
  \captionsetup{belowskip=1.05bp}%
  \centering
  \setlength{\BUPT@tablenotegap}{6.4bp}%
  \BUPT@inlinenotetrue
  \BUPT@hastablenotefalse
}{%
  \IfNoValueTF{#1}{%
    \ifBUPT@hastablenote
      \end{BUPT@inlineblock}\addvspace{6.04bp}%
    \else
      \end{BUPT@inlineblock}\addvspace{5.1bp}%
    \fi
  }{\end{table}}%
}

% 续表与专用表格。
\newcommand{\continuedtablecaption}[1]{%
  \multicolumn{\LT@cols}{c}{\BUPT@continuedcaption{续表\thetable\BUPT@captiongap#1}}%
}
\newcommand{\continuedtablecaptionEN}[1]{%
  \multicolumn{\LT@cols}{c}{\BUPT@continuedcaption{Table \thetable\space#1\space(continued)}}%
}
\newcommand{\BUPT@continuedcaption}[1]{%
  \kaishu\zihao{5}\rule[-6bp]{0pt}{20bp}\raisebox{-2.08bp}[0pt][0pt]{#1}%
}
\setlength{\heavyrulewidth}{1.5bp}
\setlength{\lightrulewidth}{0.75bp}
\newcommand{\thesisbottomrule}{\bottomrule}
\setlength{\LTpre}{3.9bp}
\setlength{\LTpost}{0pt}
% 扣除末行下部已占用的空白，再由后续标题或正文加入自己的段距。
\AfterEndEnvironment{longtable}{\kern-3.3bp}

% 边线在行框内上移，符号和说明文字的基线仍固定相隔 20 磅。
\newcommand{\BUPT@nomenclaturerule}{%
  \noalign{\vskip-2.2bp\hrule height\heavyrulewidth\vskip2.2bp}%
}
\newenvironment{nomenclaturetable}[1]{%
  \par\vspace{4.1bp}\centering
  \BUPT@tablerows{20bp}%
  \tabular{#1}\BUPT@nomenclaturerule
}{\BUPT@nomenclaturerule\endtabular\par}
% 学习经历表沿用 Word 表单的四列尺寸，表单独立于普通正文表宽。
\newcolumntype{E}[1]{B{#1}}
\newenvironment{experiencetable}[1][|E{79.68bp}|E{45.36bp}|E{165.84bp}|E{132.96bp}|]{%
  \par\vspace{1.8bp}\noindent\setlength{\tabcolsep}{3bp}%
  \BUPT@tablerows[.656]{27.87bp}%
  \begin{lrbox}{\BUPT@centeredtablebox}%
  \tabular{#1}%
}{%
  \endtabular
  \end{lrbox}%
  \makebox[\linewidth][c]{\kern-.52bp\usebox{\BUPT@centeredtablebox}\kern.52bp}\par
}

%% 9.4 普通浮动图表的兼容设置
\setlength{\textfloatsep}{0pt}
\apptocmd{\@floatboxreset}{\centering}{}{}

%% 插图与正文同页排版（官方模板图页均伴随正文，不出现浮动专属页）
\renewcommand{\floatpagefraction}{.8}
%% 页顶插图顶格（LaTeX 默认 \@fptop 带弹性使页顶插图下坠 17pt）
\AtBeginDocument{\setlength{\@fptop}{0pt}}

% 保留普通 figure 和 table 的浮动间距，兼容已有文档。
\setlength{\abovecaptionskip}{2bp}
\setlength{\belowcaptionskip}{0pt}
\setlength{\intextsep}{9bp}
% 随文图表已留出题注的行框，下方间距独立于上方间距。
\newcommand{\BUPT@inlinefloatbelowsep}{%
  \ifnum\@currtype=\numexpr32*\ftype@figure\relax
    0pt%
  \else
    \ifnum\@currtype=\numexpr32*\ftype@table\relax
      5.7bp%
    \else
      \intextsep
    \fi
  \fi
}
\patchcmd{\@addtocurcol}{\penalty\interlinepenalty\vskip\intextsep}{%
  \penalty\interlinepenalty\vskip\BUPT@inlinefloatbelowsep
}{}{%
  \ClassError{buptthesis}{Cannot set inline figure spacing}{Check the LaTeX output routine.}%
}
\patchcmd{\@addtocurcol}{\global\advance\@textfloatsheight 2\intextsep}{%
  \global\advance\@textfloatsheight\intextsep
  \global\advance\@textfloatsheight\BUPT@inlinefloatbelowsep
}{}{%
  \ClassError{buptthesis}{Cannot account for inline figure spacing}{Check the LaTeX output routine.}%
}

%% 9.5 公式、用例与引文
\renewcommand{\theequation}{\thechapter-\arabic{equation}}
% 点线从公式右侧延伸到编号左侧，公式及编号仍由 amsmath 定位。
\NewDocumentEnvironment{thesisequation}{+b}{%
  % 公式接在正文行末时，补足 Word 独立公式段落的行框。
  \ifhmode
    \advance\abovedisplayskip by 4.2bp\relax
    \advance\abovedisplayshortskip by 4.2bp\relax
    \advance\belowdisplayskip by \dimexpr\baselineskip-4bp\relax
    \advance\belowdisplayshortskip by \dimexpr\baselineskip-4bp\relax
  \fi
  \begin{equation}
    \setbox\z@\hbox{\m@th$\displaystyle #1$}%
    \setbox\tw@\hbox{\tagform@{\theequation}}%
    \dimen@=\dimexpr(\displaywidth-\wd\z@)/2-\wd\tw@-1em\relax
    \box\z@
    \ifdim\dimen@>0pt
      \rlap{\hskip.5em\hbox to\dimen@{\dotfill}}%
    \fi
  \end{equation}
}{}

\newcounter{thesiscase}[chapter]
\renewcommand{\thethesiscase}{\thechapter-\arabic{thesiscase}}
\newenvironment{thesiscase}{%
  \par\refstepcounter{thesiscase}\noindent(\thethesiscase)\quad\ignorespaces
}{\par}
\newenvironment{thesisquotation}{%
  \par\kaishu\zihao{5}\setlength{\baselineskip}{20bp}%
}{\par}

%% 9.6 算法
% 浮动环境仅负责位置，随文和浮动算法共用原有的按章编号。
\DeclareFloatingEnvironment[placement=tbp,within=none]{BUPT@algorithmfloat}
\newcounter{thesisalgorithm}[chapter]
\renewcommand{\thethesisalgorithm}{\thechapter-\arabic{thesisalgorithm}}
\NewDocumentEnvironment{thesisalgorithm}{o m}{%
  \IfNoValueTF{#1}{%
    \begin{BUPT@inlineblock}{.9\linewidth}{7.14bp}%
  }{%
    \begin{BUPT@algorithmfloat}[#1]%
    \centering\begin{minipage}{.9\linewidth}%
  }%
  \refstepcounter{thesisalgorithm}%
  \hrule height 1bp\smallskip
  \noindent\textbf{算法\thethesisalgorithm}\quad #2\par
  \smallskip\hrule height 0.5bp\smallskip
}{%
  \par\smallskip\hrule height 0.5bp
  \IfNoValueTF{#1}{%
    \end{BUPT@inlineblock}\addvspace{6.04bp}%
  }{%
    \end{minipage}\par
    \end{BUPT@algorithmfloat}%
  }%
}
\newenvironment{algorithmsteps}{%
  \begin{enumerate}[label=\arabic*:,leftmargin=2em,itemsep=2bp,topsep=2bp]%
}{%
  \end{enumerate}
}

%% -----------------------------------------------------------------
%% 10. 扉页与元数据宏定义及多行下划线自适应折行算法
%% -----------------------------------------------------------------
\RequirePackage{keyval}

\newlength{\BUPT@value@titlewidth}
\newlength{\BUPT@value@titlewidthEN}
\newlength{\BUPT@value@infowidth}
\newlength{\BUPT@value@infowidthEN}
\setlength{\BUPT@value@titlewidth}{10.18cm}
\setlength{\BUPT@value@titlewidthEN}{14.0cm}
\setlength{\BUPT@value@infowidth}{8.4cm}
\setlength{\BUPT@value@infowidthEN}{7.8cm}

\ExplSyntaxOn
\seq_new:N \l_bupt_chunks_seq
\seq_new:N \l_bupt_words_seq
\seq_new:N \l_bupt_final_seq
\tl_new:N \l_bupt_curr_tl
\box_new:N \l_bupt_measure_box

\cs_generate_variant:Nn \seq_set_split:Nnn { Nno, Nnx }
\cs_generate_variant:Nn \tl_range:nnn { Vnn }
\cs_generate_variant:Nn \tl_item:nn { Vn }
\cs_generate_variant:Nn \tl_count:n { V }

%% -----------------------------------------------------------------
%% 通用自适应断行核心函数
%% -----------------------------------------------------------------
\cs_new_protected:Npn \bupt_auto_wrap_text:nnn #1#2#3
% #1: 目标宽度, #2: 字体设置, #3: 待处理纯文本片段
{
  % 1. 首先检测是否能单行放下
  \hbox_set:Nn \l_bupt_measure_box { #2 #3 }
  \dim_compare:nTF { \box_wd:N \l_bupt_measure_box <= #1 }
  {
    \seq_put_right:Nn \l_bupt_final_seq { #3 }
  }
  {
    % 2. 放不下，检测是否有空格（英文或带空格中文）
    \seq_set_split:Nno \l_bupt_words_seq { ~ } { #3 }
    \int_compare:nNnTF { \seq_count:N \l_bupt_words_seq } > { 1 }
    {
      % 按单词贪心断行
      \tl_clear:N \l_bupt_curr_tl
      \seq_map_inline:Nn \l_bupt_words_seq
      {
        \tl_if_empty:nTF { \l_bupt_curr_tl }
        {
          \tl_set:Nn \l_bupt_curr_tl { ##1 }
        }
        {
          \hbox_set:Nn \l_bupt_measure_box { #2 \l_bupt_curr_tl ~ ##1 }
          \dim_compare:nNnTF { \box_wd:N \l_bupt_measure_box } > {#1}
          {
            \seq_put_right:NV \l_bupt_final_seq \l_bupt_curr_tl
            \tl_set:Nn \l_bupt_curr_tl { ##1 }
          }
          {
            \tl_put_right:Nn \l_bupt_curr_tl { ~ ##1 }
          }
        }
      }
      \tl_if_empty:nF { \l_bupt_curr_tl }
      {
        \seq_put_right:NV \l_bupt_final_seq \l_bupt_curr_tl
      }
    }
    {
      % 3. 中文无空格，按字符贪心断行
      \tl_clear:N \l_bupt_curr_tl
      \tl_map_inline:nn { #3 }
      {
        \tl_if_empty:nTF { \l_bupt_curr_tl }
        {
          \tl_set:Nn \l_bupt_curr_tl { ##1 }
        }
        {
          \hbox_set:Nn \l_bupt_measure_box { #2 \l_bupt_curr_tl ##1 }
          \dim_compare:nNnTF { \box_wd:N \l_bupt_measure_box } > {#1}
          {
            \tl_set:Nn \l_tmpa_tl { ##1 }
            \bool_set_false:N \l_tmpa_bool
            \tl_if_in:NnT \l_tmpa_tl { ， } { \bool_set_true:N \l_tmpa_bool }
            \tl_if_in:NnT \l_tmpa_tl { 、 } { \bool_set_true:N \l_tmpa_bool }
            \tl_if_in:NnT \l_tmpa_tl { ） } { \bool_set_true:N \l_tmpa_bool }
            \tl_if_in:NnT \l_tmpa_tl { ； } { \bool_set_true:N \l_tmpa_bool }
            \tl_if_in:NnT \l_tmpa_tl { ： } { \bool_set_true:N \l_tmpa_bool }
            \tl_if_in:NnT \l_tmpa_tl { 。 } { \bool_set_true:N \l_tmpa_bool }

            \bool_if:NTF \l_tmpa_bool
            {
              \tl_put_right:Nn \l_bupt_curr_tl { ##1 }
              \seq_put_right:NV \l_bupt_final_seq \l_bupt_curr_tl
              \tl_clear:N \l_bupt_curr_tl
            }
            {
              \seq_put_right:NV \l_bupt_final_seq \l_bupt_curr_tl
              \tl_set:Nn \l_bupt_curr_tl { ##1 }
            }
          }
          {
            \tl_put_right:Nn \l_bupt_curr_tl { ##1 }
          }
        }
      }
      \tl_if_empty:nF { \l_bupt_curr_tl }
      {
        \seq_put_right:NV \l_bupt_final_seq \l_bupt_curr_tl
      }
    }
  }
}

%% -----------------------------------------------------------------
%% 支持 \\ 强制换行分割的处理函数（个人信息等常规表单字段）
%% -----------------------------------------------------------------
\cs_new_protected:Npn \bupt_process_field_lines:nnn #1#2#3
% #1: 目标宽度, #2: 字体设置, #3: 用户输入内容
{
  \seq_clear:N \l_bupt_final_seq
  \seq_set_split:Nno \l_bupt_chunks_seq { \\ } { #3 }
  \seq_map_inline:Nn \l_bupt_chunks_seq
  {
    \bupt_auto_wrap_text:nnn {#1} {#2} { ##1 }
  }
}

%% -----------------------------------------------------------------
%% 中文题目自适应折行算法（支持显式 \\ 与超长平衡平分）
%% -----------------------------------------------------------------
\cs_new_protected:Npn \bupt_process_title_cn:n #1
{
  \seq_clear:N \l_bupt_final_seq
  \seq_set_split:Nno \l_bupt_chunks_seq { \\ } { #1 }
  \int_compare:nNnTF { \seq_count:N \l_bupt_chunks_seq } > { 1 }
  {
    % 用户显式指定了换行 \\
    \seq_map_inline:Nn \l_bupt_chunks_seq
    {
      \bupt_auto_wrap_text:nnn { \BUPT@value@titlewidth } { \songti\zihao{-2}\bfseries } { ##1 }
    }
  }
  {
    % 单行输入：检测是否能单行容纳
    \hbox_set:Nn \l_bupt_measure_box { \songti\zihao{-2}\bfseries #1 }
    \dim_compare:nTF { \box_wd:N \l_bupt_measure_box <= \BUPT@value@titlewidth }
    {
      \seq_put_right:Nn \l_bupt_final_seq { #1 }
    }
    {
      % 超过单行宽度，按中点平衡拆分为2行，并避让行首标点
      \tl_set:No \l_tmpc_tl { #1 }
      \int_set:Nn \l_tmpa_int { \tl_count:V \l_tmpc_tl }
      \int_set:Nn \l_tmpb_int { \int_div_truncate:nn { \l_tmpa_int + 1 } { 2 } }
      \tl_set:Nx \l_tmpa_tl { \tl_item:Vn \l_tmpc_tl { \l_tmpb_int + 1 } }
      \tl_if_in:NnT \l_tmpa_tl { ， } { \int_incr:N \l_tmpb_int }
      \tl_if_in:NnT \l_tmpa_tl { 、 } { \int_incr:N \l_tmpb_int }
      \tl_if_in:NnT \l_tmpa_tl { ） } { \int_incr:N \l_tmpb_int }
      \tl_if_in:NnT \l_tmpa_tl { ； } { \int_incr:N \l_tmpb_int }
      \tl_if_in:NnT \l_tmpa_tl { ： } { \int_incr:N \l_tmpb_int }
      \tl_if_in:NnT \l_tmpa_tl { 。 } { \int_incr:N \l_tmpb_int }

      \tl_set:Nx \l_bupt_curr_tl { \tl_range:Vnn \l_tmpc_tl { 1 } { \l_tmpb_int } }
      \seq_put_right:NV \l_bupt_final_seq \l_bupt_curr_tl
      \tl_set:Nx \l_bupt_curr_tl { \tl_range:Vnn \l_tmpc_tl { \l_tmpb_int + 1 } { -1 } }
      \seq_put_right:NV \l_bupt_final_seq \l_bupt_curr_tl
    }
  }
}

%% -----------------------------------------------------------------
%% 英文题目自适应折行算法
%% -----------------------------------------------------------------
\cs_new_protected:Npn \bupt_process_title_en:n #1
{
  \seq_clear:N \l_bupt_final_seq
  \seq_set_split:Nno \l_bupt_chunks_seq { \\ } { #1 }
  \int_compare:nNnTF { \seq_count:N \l_bupt_chunks_seq } > { 1 }
  {
    \seq_map_inline:Nn \l_bupt_chunks_seq
    {
      \bupt_auto_wrap_text:nnn { \BUPT@value@titlewidthEN } { \rmfamily\zihao{-2}\bfseries } { ##1 }
    }
  }
  {
    \hbox_set:Nn \l_bupt_measure_box { \rmfamily\zihao{-2}\bfseries #1 }
    \dim_compare:nTF { \box_wd:N \l_bupt_measure_box <= \BUPT@value@titlewidthEN }
    {
      \seq_put_right:Nn \l_bupt_final_seq { #1 }
    }
    {
      \bupt_auto_wrap_text:nnn { \BUPT@value@titlewidthEN } { \rmfamily\zihao{-2}\bfseries } { #1 }
    }
  }
}

%% -----------------------------------------------------------------
%% 渲染中文题目（表格排版，多行对齐下划线）
%% -----------------------------------------------------------------
\cs_new_protected:Npn \bupt_render_cn_title:n #1
{
  \bupt_process_title_cn:n { #1 }
  \parbox[t]{\linewidth}{%
    \centering
    \hspace*{-36.7bp}%
    \begin{tabular}[t]{@{}l@{}l@{}}
      \makebox[54.4bp][l]{\songti\zihao{-2}\bfseries
        \raisebox{-2.8bp}[\height][\depth]{\BUPT@label@title}} &
      \BUPTul[-2.9bp]{\BUPT@value@titlewidth}{1.68pt}{\songti\zihao{-2}\bfseries \seq_item:Nn \l_bupt_final_seq { 1 }}
      \int_step_inline:nnn { 2 } { \seq_count:N \l_bupt_final_seq }
      {
        \\ \noalign{\vspace{17.2pt}}
        & \BUPTul[-2.9bp]{\BUPT@value@titlewidth}{1.68pt}{\songti\zihao{-2}\bfseries \seq_item:Nn \l_bupt_final_seq {##1}}
      }
    \end{tabular}%
  }
}

%% -----------------------------------------------------------------
%% 渲染英文题目（表格居中排版，多行对齐下划线）
%% -----------------------------------------------------------------
\cs_new_protected:Npn \bupt_render_en_title:n #1
{
  \bupt_process_title_en:n { #1 }
  \parbox[t]{\linewidth}{%
    \centering\hspace*{17.2bp}%
    \begin{tabular}[t]{@{}c@{}}
      \BUPTul{\BUPT@value@titlewidthEN}{1.68pt}{\rmfamily\zihao{-2}\bfseries \seq_item:Nn \l_bupt_final_seq { 1 }}
      \int_step_inline:nnn { 2 } { \seq_count:N \l_bupt_final_seq }
      {
        \\ \noalign{\vspace{17.2pt}}
        \BUPTul{\BUPT@value@titlewidthEN}{1.68pt}{\rmfamily\zihao{-2}\bfseries \seq_item:Nn \l_bupt_final_seq {##1}}
      }
    \end{tabular}%
  }
}

%% -----------------------------------------------------------------
%% 渲染个人信息表单字段（支持自动折行与\\断行，每行独立下划线）
%% -----------------------------------------------------------------
\cs_new_protected:Npn \bupt_render_info_field:nnn #1#2#3
{
  \bupt_process_field_lines:nnn {#1} {#2} { #3 }
  \seq_clear:N \l_bupt_field_seq
  \seq_map_inline:Nn \l_bupt_final_seq
    { \seq_put_right:Nn \l_bupt_field_seq { \BUPTfieldline{#1}{#2##1} } }
  \begin{tabular}[t]{@{}l@{}}
    \seq_use:Nn \l_bupt_field_seq { \\[3pt] }
  \end{tabular}%
}
\seq_new:N \l_bupt_field_seq

\cs_set_eq:NN \BUPTRenderCnTitle \bupt_render_cn_title:n
\cs_set_eq:NN \BUPTRenderEnTitle \bupt_render_en_title:n
\cs_set_eq:NN \BUPTRenderField \bupt_render_info_field:nnn
\ExplSyntaxOff
%% 题目下划线按 Word 线宽绘制，文字基线可按扉页语言设定。
\newcommand{\BUPTul}[4][-2.65bp]{%
  \rlap{\smash{\rule[-\dimexpr#3+4.2pt\relax]{#2}{#3}}}%
  \makebox[#2][c]{\raisebox{#1}[0pt][0pt]{#4}}%
}

% 个人信息下划线距文字基线约 1.5 磅，供中英文扉页共用。
\newcommand{\BUPTfieldline}[2]{%
  \rlap{\smash{\rule[-2.8bp]{#1}{1.3bp}}}%
  \makebox[#1][c]{\smash{#2}}%
}

\def\BUPTdateOptions#1{\setkeys{BUPTdate}{#1}}
\define@key{BUPTdate}{pageYear}{\def\BUPT@value@pageYear{#1}}
\define@key{BUPTdate}{pageMonth}{\def\BUPT@value@pageMonth{#1}}
\define@key{BUPTdate}{pageDay}{\def\BUPT@value@pageDay{#1}}
\define@key{BUPTdate}{dissertationYear}{\def\BUPT@value@dissertationYear{#1}}
\define@key{BUPTdate}{dissertationMonth}{\def\BUPT@value@dissertationMonth{#1}}
\define@key{BUPTdate}{dissertationDay}{\def\BUPT@value@dissertationDay{#1}}

\def\BUPTthesiscntitlepage#1{\setkeys{BUPTcntitle}{#1}}
\define@key{BUPTcntitle}{confidential}{\def\BUPT@value@confidential{#1}}
\define@key{BUPTcntitle}{title}{\def\BUPT@value@title{#1}}
\define@key{BUPTcntitle}{studentid}{\def\BUPT@value@studentid{#1}}
\define@key{BUPTcntitle}{name}{\def\BUPT@value@name{#1}}
\define@key{BUPTcntitle}{major}{\def\BUPT@value@major{#1}}
\define@key{BUPTcntitle}{trainingmode}{\def\BUPT@value@trainingmode{#1}}
\define@key{BUPTcntitle}{supervisor}{\def\BUPT@value@supervisor{#1}}
\define@key{BUPTcntitle}{institute}{\def\BUPT@value@institute{#1}}

\def\BUPTthesisentitlepage#1{\setkeys{BUPTentitle}{#1}}
% 英文扉页不显示密级。
\define@key{BUPTentitle}{confidentialEN}{\def\BUPT@value@confidentialEN{#1}}
\define@key{BUPTentitle}{titleEN}{\def\BUPT@value@titleEN{#1}}
\define@key{BUPTentitle}{studentidEN}{\def\BUPT@value@studentidEN{#1}}
\define@key{BUPTentitle}{nameEN}{\def\BUPT@value@nameEN{#1}}
\define@key{BUPTentitle}{majorEN}{\def\BUPT@value@majorEN{#1}}
\define@key{BUPTentitle}{supervisorEN}{\def\BUPT@value@supervisorEN{#1}}
\define@key{BUPTentitle}{instituteEN}{\def\BUPT@value@instituteEN{#1}}

%% 下划线辅助命令
\newcommand{\BUPTunderline}[2]{\underline{\makebox[#1][c]{#2}}}

%% -----------------------------------------------------------------
%% 11. 中文扉页生成（内封）
%% -----------------------------------------------------------------
% 中英文扉页共用同一校徽图框，按原图比例等比缩放。
\newcommand{\BUPT@coverlogo}{%
  \makebox[97.9bp][c]{\includegraphics[width=94.65bp]{\BUPT@value@schoollogo}}%
}
\newcommand{\makechinesetitle}{%
  \begingroup
  \cleardoublepage
  \thispagestyle{empty}%
  %% 扉页为单倍行距版式（官方封面字段行距约31磅），独立于正文20磅行距
  \linespread{1}\zihao{-4}
  %% 盲审模式：作者、学号与导师匿名
  \ifBUPT@option@blind
    \def\BUPT@value@name{\BUPT@value@anonymousname}%
    \def\BUPT@value@supervisor{\BUPT@value@anonymoussupervisor}%
    \def\BUPT@value@studentid{\BUPT@value@anonymousstudentid}%
  \fi
  \vspace*{-21pt}%
  \begin{flushright}
    {\songti\zihao{4}\bfseries \raisebox{2.1bp}[0pt][0pt]{\BUPT@label@confidential\BUPT@value@confidential\hspace{8.3bp}}}
  \end{flushright}
  \vspace{-0.3cm}
  \begin{center}
    % 裁掉高清校名图的四周白边，校名的显示区域沿用扉页版式。
    \raisebox{5.6bp}[100.75bp][0pt]{%
      \kern3.76bp\includegraphics[trim=5.4bp 8.22bp 7.32bp 10.2bp,clip,
        width=342bp]{\BUPT@value@schoolname}\kern-3.76bp
    }\\[0.26cm]
    {\heiti\fontsize{32bp}{38bp}\selectfont\bfseries
      % 保留校方文案的全角括号，压缩括号外侧留白。
      \raisebox{1bp}[\height][\depth]{\BUPT@value@degree\BUPT@label@thesis
        \makebox[.5em][r]{（}\BUPT@value@degreemode\makebox[.5em][l]{）}}}%
    \\[0.98cm]
    \raisebox{-.35bp}[96.38bp][0pt]{%
      \BUPT@coverlogo
    }\\[1.39cm]
    \BUPTRenderCnTitle{\BUPT@value@title}\\[21.2bp]
    {\songti\zihao{4}\bfseries
      \renewcommand{\arraystretch}{1.86}
      \begin{tabular}{r@{\hspace{0.5em}}l}
        \BUPT@label@studentid    & \BUPTRenderField{\BUPT@value@infowidth}{\songti\zihao{4}\bfseries}{\BUPT@value@studentid}    \\
        \BUPT@label@name         & \BUPTRenderField{\BUPT@value@infowidth}{\songti\zihao{4}\bfseries}{\BUPT@value@name}         \\
        \BUPT@label@major        & \BUPTRenderField{\BUPT@value@infowidth}{\songti\zihao{4}\bfseries}{\BUPT@value@major}        \\
        \BUPT@label@trainingmode & \BUPTRenderField{\BUPT@value@infowidth}{\songti\zihao{4}\bfseries}{\BUPT@value@trainingmode} \\
        \BUPT@label@supervisor   & \BUPTRenderField{\BUPT@value@infowidth}{\songti\zihao{4}\bfseries}{\BUPT@value@supervisor}   \\
        \BUPT@label@institute    & \BUPTRenderField{\BUPT@value@infowidth}{\songti\zihao{4}\bfseries}{\BUPT@value@institute}
      \end{tabular}%
    }\\[1.22cm]
    {\songti\zihao{4}\bfseries \BUPT@value@pageYear{}年\BUPT@value@pageMonth{}月\BUPT@value@pageDay{}日}
  \end{center}
  \endgroup
  \clearpage
}

%% -----------------------------------------------------------------
%% 12. 英文扉页生成
%% -----------------------------------------------------------------
\newcommand{\makeenglishtitle}{%
  \begingroup
  \cleardoublepage
  \thispagestyle{empty}%
  \linespread{1}\zihao{-4}
  %% 盲审模式：隐藏作者、学号和导师。
  \ifBUPT@option@blind
    \def\BUPT@value@studentidEN{\BUPT@value@anonymousstudentid}%
    \def\BUPT@value@nameEN{\BUPT@value@anonymousnameEN}%
    \def\BUPT@value@supervisorEN{\BUPT@value@anonymoussupervisorEN}%
  \fi
  \begin{center}
    \vspace*{40.9bp}%
    \AddToShipoutPictureBG*{%
      \AtPageUpperLeft{\put(81.5bp,-221.05bp){%
        \BUPT@coverlogo}}}%
    \makebox[\linewidth][l]{\hspace*{99.3bp}\begin{minipage}{322bp}
      {\centering\fontsize{26bp}{31.2bp}\selectfont\rmfamily\bfseries
      \begin{tabular}{@{}c@{}}
        BEIJING UNIVERSITY OF\\ POSTS AND\\ TELECOMMUNICATIONS
      \end{tabular}\par}
    \end{minipage}}\par
    \vspace{42.7pt}%
    {\fontsize{24pt}{28.8pt}\selectfont\rmfamily \BUPT@value@thesisEN\par}%
    \vspace{59.5pt}%
    \BUPTRenderEnTitle{\BUPT@value@titleEN}\par
    \vspace{67.8bp}%
    {\rmfamily\fontsize{14pt}{16.8pt}\selectfont\bfseries
      \renewcommand{\arraystretch}{1.86}
      \begin{tabular}{r@{\hspace{0.5em}}l}
        \BUPT@label@studentidEN  & \BUPTRenderField{\BUPT@value@infowidthEN}{\rmfamily\fontsize{14pt}{16.8pt}\selectfont\bfseries}{\BUPT@value@studentidEN}  \\
        \BUPT@label@nameEN       & \BUPTRenderField{\BUPT@value@infowidthEN}{\rmfamily\fontsize{14pt}{16.8pt}\selectfont\bfseries}{\BUPT@value@nameEN}       \\
        \BUPT@label@majorEN      & \BUPTRenderField{\BUPT@value@infowidthEN}{\rmfamily\fontsize{14pt}{16.8pt}\selectfont\bfseries}{\BUPT@value@majorEN}      \\
        \BUPT@label@supervisorEN & \BUPTRenderField{\BUPT@value@infowidthEN}{\rmfamily\fontsize{14pt}{16.8pt}\selectfont\bfseries}{\BUPT@value@supervisorEN} \\
        \BUPT@label@instituteEN  & \BUPTRenderField{\BUPT@value@infowidthEN}{\rmfamily\fontsize{14pt}{16.8pt}\selectfont\bfseries}{\BUPT@value@instituteEN}
      \end{tabular}%
    }\par
    % 字段折行时按可用高度收缩日期上方的空白。
    \dimen@=\dimexpr\pagegoal-\pagetotal-\pagedepth-22bp\relax
    \ifdim\dimen@>96.5bp \dimen@=96.5bp\fi
    \ifdim\dimen@<0pt \dimen@=0pt\fi
    \vspace{\dimen@}%
    {\rmfamily\zihao{4}\bfseries Date~\BUPT@value@pageDay~Month~\BUPT@value@pageMonth~Year~\BUPT@value@pageYear}
  \end{center}
  \endgroup
  \clearpage
}

%% -----------------------------------------------------------------
%% 13. 答辩委员会名单生成
%% 规范要求：另起一页，黑体三号居中，单倍行距
%% -----------------------------------------------------------------
\def\BUPTdissertationcommitteepage#1{\setkeys{BUPTcommittee}{#1}}
\define@key{BUPTcommittee}{chairName}{\def\BUPT@value@committeeChairName{#1}}
\define@key{BUPTcommittee}{chairTitle}{\def\BUPT@value@committeeChairTitle{#1}}
\define@key{BUPTcommittee}{chairOrgan}{\def\BUPT@value@committeeChairOrgan{#1}}
\define@key{BUPTcommittee}{memberAName}{\def\BUPT@value@committeeMemberFirstName{#1}}
\define@key{BUPTcommittee}{memberATitle}{\def\BUPT@value@committeeMemberFirstTitle{#1}}
\define@key{BUPTcommittee}{memberAOrgan}{\def\BUPT@value@committeeMemberFirstOrgan{#1}}
\define@key{BUPTcommittee}{memberBName}{\def\BUPT@value@committeeMemberSecondName{#1}}
\define@key{BUPTcommittee}{memberBTitle}{\def\BUPT@value@committeeMemberSecondTitle{#1}}
\define@key{BUPTcommittee}{memberBOrgan}{\def\BUPT@value@committeeMemberSecondOrgan{#1}}
\define@key{BUPTcommittee}{memberCName}{\def\BUPT@value@committeeMemberThirdName{#1}}
\define@key{BUPTcommittee}{memberCTitle}{\def\BUPT@value@committeeMemberThirdTitle{#1}}
\define@key{BUPTcommittee}{memberCOrgan}{\def\BUPT@value@committeeMemberThirdOrgan{#1}}
\define@key{BUPTcommittee}{memberDName}{\def\BUPT@value@committeeMemberFourthName{#1}}
\define@key{BUPTcommittee}{memberDTitle}{\def\BUPT@value@committeeMemberFourthTitle{#1}}
\define@key{BUPTcommittee}{memberDOrgan}{\def\BUPT@value@committeeMemberFourthOrgan{#1}}
\define@key{BUPTcommittee}{secretaryName}{\def\BUPT@value@committeeSecretaryName{#1}}
\define@key{BUPTcommittee}{secretaryTitle}{\def\BUPT@value@committeeSecretaryTitle{#1}}
\define@key{BUPTcommittee}{secretaryOrgan}{\def\BUPT@value@committeeSecretaryOrgan{#1}}

\newcommand{\makecommitteelist}{%
  \begingroup
  \cleardoublepage
  \thispagestyle{empty}%
  \vspace*{5.7bp}%
  %% 盲审模式：答辩委员会名单整体置空
  \ifBUPT@option@blind
    \let\BUPT@value@dissertationYear\@empty
    \def\BUPT@value@committeeChairName{\@empty}%
    \def\BUPT@value@committeeChairTitle{\@empty}%
    \def\BUPT@value@committeeChairOrgan{\@empty}%
    \def\BUPT@value@committeeMemberFirstName{\@empty}%
    \def\BUPT@value@committeeMemberFirstTitle{\@empty}%
    \def\BUPT@value@committeeMemberFirstOrgan{\@empty}%
    \def\BUPT@value@committeeMemberSecondName{\@empty}%
    \def\BUPT@value@committeeMemberSecondTitle{\@empty}%
    \def\BUPT@value@committeeMemberSecondOrgan{\@empty}%
    \def\BUPT@value@committeeMemberThirdName{\@empty}%
    \def\BUPT@value@committeeMemberThirdTitle{\@empty}%
    \def\BUPT@value@committeeMemberThirdOrgan{\@empty}%
    \def\BUPT@value@committeeMemberFourthName{\@empty}%
    \def\BUPT@value@committeeMemberFourthTitle{\@empty}%
    \def\BUPT@value@committeeMemberFourthOrgan{\@empty}%
    \def\BUPT@value@committeeSecretaryName{\@empty}%
    \def\BUPT@value@committeeSecretaryTitle{\@empty}%
    \def\BUPT@value@committeeSecretaryOrgan{\@empty}%
  \fi
  \begin{center}
    {\linespread{1}\selectfont\heiti\zihao{3} \BUPT@label@committeelist}\\[7.78bp]
    \BUPT@tablerows[.654]{27.87bp}
    \songti
    % 按 Word 表格列宽设置内容区，横线厚度计入行距。
    \makebox[\linewidth][c]{%
    \kern-1.5bp%
    \tabular{|>{\centering\arraybackslash}m{49.75bp}|>{\centering\arraybackslash}m{51.45bp}|>{\centering\arraybackslash}m{65.55bp}|>{\centering\arraybackslash}m{207.2bp}|}
      \hline
      职务 & 姓\quad 名 & 职\quad 称 & 工\hspace{18bp}作\hspace{18bp}单\hspace{18bp}位 \\
      \hline
      主席 & \BUPT@value@committeeChairName & \BUPT@value@committeeChairTitle & \BUPT@value@committeeChairOrgan \\
      \hline
      委员 & \BUPT@value@committeeMemberFirstName & \BUPT@value@committeeMemberFirstTitle & \BUPT@value@committeeMemberFirstOrgan \\
      \hline
      委员 & \BUPT@value@committeeMemberSecondName & \BUPT@value@committeeMemberSecondTitle & \BUPT@value@committeeMemberSecondOrgan \\
      \hline
      委员 & \BUPT@value@committeeMemberThirdName & \BUPT@value@committeeMemberThirdTitle & \BUPT@value@committeeMemberThirdOrgan \\
      \hline
      委员 & \BUPT@value@committeeMemberFourthName & \BUPT@value@committeeMemberFourthTitle & \BUPT@value@committeeMemberFourthOrgan \\
      \hline
      秘书 & \BUPT@value@committeeSecretaryName & \BUPT@value@committeeSecretaryTitle & \BUPT@value@committeeSecretaryOrgan \\
      \hline
      答辩日期 & \multicolumn{3}{c|}{%
        \ifx\BUPT@value@dissertationYear\@empty\else
          \BUPT@value@dissertationYear~年~\BUPT@value@dissertationMonth~月~\BUPT@value@dissertationDay~日%
        \fi} \\
      \hline
    \endtabular\kern1.5bp}
  \end{center}
  \endgroup
  \clearpage
}

%% -----------------------------------------------------------------
%% 13. 独创性声明与授权使用说明生成（严格遵照2025年1月15日规范）
%% 规范要求：标题黑体三号居中，内容宋体小四号首行缩进2字符固定值20磅
%% -----------------------------------------------------------------
\newcommand{\statementpage}[1]{%
  \def\BUPT@value@statementscanfile{#1}%
}
\let\BUPT@value@statementscanfile\@empty
\newcommand{\BUPT@statementparagraph}[1]{%
  {\xeCJKsetup{PunctStyle=buptstatement,CJKglue={\hskip0pt plus .05em}}%
    \tolerance=1000\relax #1\par}%
}

\newcommand{\makestatement}{%
  \begingroup
  \cleardoublepage
  \ifx\BUPT@value@statementscanfile\@empty
    \thispagestyle{empty}%
    \vspace*{-13.2bp}%
    %% 标题段前段后均为零，正文与签名行连续排版。
    {\centering\linespread{1}\selectfont\heiti\zihao{3}%
      \xeCJKsetup{PunctStyle=quanjiao}\BUPT@label@innovationtitle\par}%
    \vspace{6.65pt}%
    {\songti\zihao{-4}\setlength{\baselineskip}{20bp}\setlength{\parindent}{2\ccwd}%
      \BUPT@statementparagraph{\BUPT@label@innovationparagraph}%
      \BUPT@label@authorsignature\BUPTunderline{108pt}{}\hspace{24pt}\BUPT@label@issuedate\BUPTunderline{120pt}{}\par
    }
    \vspace{46.97pt}
    {\centering\linespread{1}\selectfont\heiti\zihao{3}\BUPT@label@authorizationtitle\par}
    \vspace{6.66pt}%
    {\songti\zihao{-4}\setlength{\baselineskip}{20bp}\setlength{\parindent}{2\ccwd}%
      \BUPT@statementparagraph{\BUPT@label@authorizationparagraph}%
      \BUPT@label@authorsignature\BUPTunderline{108pt}{}\hspace{24pt}\BUPT@label@issuedate\BUPTunderline{120pt}{}\par
      \BUPT@label@supervisorsignature\BUPTunderline{108pt}{}\hspace{24pt}\BUPT@label@issuedate\BUPTunderline{120pt}{}\par
    }
  \else
    \includepdf[pages={1}]{\BUPT@value@statementscanfile}
  \fi
  \endgroup
  \clearpage
}

%% -----------------------------------------------------------------
%% 14. 中文摘要环境（严格对齐2025规范）
%% 规范要求：
%% “摘要”标题黑体三号居中，段前0行，段后1行，单倍行距，中间空1个全角空格
%% 摘要内容：四号宋体，两端对齐，首行缩进2字符，段前0，段后0，固定值20磅
%% 关键词：“关键词：”黑体四号，其后宋体四号，全角分号隔开，末尾无标点
%% -----------------------------------------------------------------
\newenvironment{cnabstract}{%
  \cleardoublepage
  \markboth{\BUPT@label@abstract}{\BUPT@label@abstract}%
  \phantomsection
  \addcontentsline{toc}{chapter}{\BUPT@label@abstract}%
  {\centering\linespread{1}\selectfont\heiti\zihao{3}\BUPT@label@abstract\par}%
  \vspace{16.95bp}%
  \BUPT@wordparagraphspacing
  \songti\zihao{4}\setlength{\baselineskip}{20bp}\setlength{\parindent}{2\ccwd}%
}{%
  \par\clearpage
}

\newcommand{\cnkeywords}[1]{%
  \par\addvspace{16.3bp}%
  {\BUPT@normalparagraphspacing\noindent\hspace*{2\ccwd}%
   {\heiti\zihao{4}\BUPT@label@keywords}%
   {\songti\zihao{4}#1}\par}%
}

%% -----------------------------------------------------------------
%% 15. 英文摘要环境（严格对齐2025规范）
%% 规范要求：
%% “ABSTRACT”标题 Times New Roman三号加粗居中，段前0行，段后2行，单倍行距
%% 摘要内容：四号字体，两端对齐，首行缩进2字符，固定值20磅
%% 关键词：“KEY WORDS:”四号加粗，其后四号，半角分号隔开，末尾无标点，段前2行
%% -----------------------------------------------------------------
\newenvironment{enabstract}{%
  \begingroup
  \cleardoublepage
  \markboth{\BUPT@label@abstractEN}{\BUPT@label@abstractEN}%
  \phantomsection
  \addcontentsline{toc}{chapter}{\BUPT@label@abstractEN}%
  {\centering\linespread{1}\selectfont\rmfamily\zihao{3}\bfseries
    \raisebox{1.2bp}[\height][\depth]{\BUPT@label@abstractEN}\par}%
  \vspace{30.9bp}%
  \rmfamily\zihao{4}\setlength{\baselineskip}{20bp}\setlength{\parindent}{2\ccwd}%
  % Word 的字母使用自然字宽，两端对齐通过词间空白实现。
  \spaceskip=4.5bp plus 1.5bp minus .3bp\relax
  \frenchspacing
}{%
  \par\endgroup\clearpage
}

\newcommand{\enkeywords}[1]{%
  \par\addvspace{32.6bp}\noindent\hspace*{2\ccwd}%
  \spaceskip=0pt\relax
  {\rmfamily\zihao{4}\bfseries\BUPT@label@keywordsEN~}%
  {\rmfamily\zihao{4}#1}%
}

%% -----------------------------------------------------------------
%% 16. 符号说明环境
%% 规范要求：黑体三号居中，段前0，段后2行，内容宋体小四号固定值20磅
%% -----------------------------------------------------------------
\newenvironment{nomenclature}{%
  \cleardoublepage
  \markboth{\BUPT@label@nomenclature}{\BUPT@label@nomenclature}%
  {\centering\linespread{1}\selectfont\heiti\zihao{3}\BUPT@label@nomenclature\par}%
  \vspace{32.6bp}%
  \songti\zihao{-4}\setlength{\baselineskip}{20bp}%
}{%
  \par\clearpage
}

%% -----------------------------------------------------------------
%% 17. 附录、致谢、创新成果、学习经历环境
% 附录正文采用宋体小四号、单倍行距。
%% -----------------------------------------------------------------
\newlength{\BUPT@backmatterheadingsep}
\setlength{\BUPT@backmatterheadingsep}{33.25bp}
% Word 的宋体小四单倍行距实测为 15.6 磅，普通段落沿用这一自然行框。
\newcommand{\BUPT@appendixbody}{%
  \linespread{1}\songti\fontsize{12bp}{15.6bp}\selectfont
  \setlength{\parindent}{2\ccwd}%
}
\apptocmd{\appendix}{\BUPT@appendixbody}{}{}
\newenvironment{appendixpage}{%
  \cleardoublepage
  \markboth{\BUPT@label@appendix}{\BUPT@label@appendix}%
  \phantomsection
  \addcontentsline{toc}{chapter}{\BUPT@label@appendix}%
  {\centering\linespread{1}\selectfont\heiti\zihao{3}\BUPT@label@appendix\par}%
  \vspace{\BUPT@backmatterheadingsep}%
  \BUPT@appendixbody
}{%
  \par\clearpage
}

%% 致谢
\newenvironment{acknowledgement}{%
  \cleardoublepage
  \markboth{\BUPT@label@acknowledgement}{\BUPT@label@acknowledgement}%
  \phantomsection
  \addcontentsline{toc}{chapter}{\BUPT@label@acknowledgement}%
  {\centering\linespread{1}\selectfont\heiti\zihao{3}\BUPT@label@acknowledgement\par}%
  \vspace{\BUPT@backmatterheadingsep}%
  \songti\zihao{-4}\setlength{\baselineskip}{20bp}\setlength{\parindent}{2\ccwd}%
}{%
  \par\clearpage
}

%% 创新成果目录（2025规范最新命名：攻读学位期间取得的创新成果目录）
\newenvironment{publication}{%
  \cleardoublepage
  \markboth{\BUPT@label@publications}{\BUPT@label@publications}%
  \phantomsection
  \addcontentsline{toc}{chapter}{\BUPT@label@publications}%
  {\centering\linespread{1}\selectfont\heiti\zihao{3}\BUPT@label@publications\par}%
  \vspace{\BUPT@backmatterheadingsep}%
  \songti\zihao{-4}\setlength{\baselineskip}{20bp}%
}{%
  \par\clearpage
}

%% 作者学习经历（全文最后一节，结束时不产生多余空白页）
\newenvironment{experience}{%
  \cleardoublepage
  \markboth{\BUPT@label@experience}{\BUPT@label@experience}%
  \phantomsection
  \addcontentsline{toc}{chapter}{\BUPT@label@experience}%
  {\centering\linespread{1}\selectfont\heiti\zihao{3}\BUPT@label@experience\par}%
  \vspace{32.6bp}%
  \songti\zihao{-4}\setlength{\baselineskip}{20bp}%
}{%
  \par
}

%% -----------------------------------------------------------------
%% 18. 参考文献环境与样式适配
%% 规范要求：标题黑体三号居中段后2行，内容宋体五号固定值20磅，另起一页；
%% 编号1-9悬挂缩进0.6厘米、10-99悬挂缩进0.74厘米、100以上悬挂缩进
%% 0.9厘米，序号左顶格，序号与文献内容间空一格
%% -----------------------------------------------------------------
\renewcommand{\bibfont}{\songti\zihao{5}\setlength{\baselineskip}{20bp}}
\setlength{\bibsep}{0pt}

\newlength{\BUPT@bibhang}
\newcommand{\BUPT@setbibhang}{%
  \ifnum\c@NAT@ctr<10\relax
    \setlength{\BUPT@bibhang}{0.6cm}%
  \else\ifnum\c@NAT@ctr<100\relax
    \setlength{\BUPT@bibhang}{0.74cm}%
  \else
    \setlength{\BUPT@bibhang}{0.9cm}%
  \fi\fi
  %% 悬挂缩进由 TeX 原生 \hangindent 实现（\list 固定的 \parshape 需先清零）
  \global\parshape\z@
  \global\hangindent=\BUPT@bibhang
  \global\hangafter=1
  \global\labelwidth=\z@
  \global\labelsep=\z@
  \global\itemindent=\z@
}
%% natbib 在每个文献条目计数器步进之后、\item 之前调用 \bibitem@fin，在此挂载分级悬挂
\g@addto@macro\bibitem@fin{\BUPT@setbibhang}
%% 序号左顶格，其后空一格；标签宽度与悬挂宽度精确相等
\renewcommand{\@biblabel}[1]{\makebox[\dimexpr\BUPT@bibhang-1em\relax][l]{[#1]}\hspace{1em}}

\let\BUPT@orig@bibliography\bibliography
\renewcommand{\newblock}{\hskip 0pt}

\renewcommand{\bibliography}[1]{%
  \cleardoublepage
  \BUPT@normalparagraphspacing
  \markboth{参考文献}{参考文献}%
  \phantomsection
  \addcontentsline{toc}{chapter}{参考文献}%
  {\centering\linespread{1}\selectfont\heiti\zihao{3}参考文献\par}%
  \vspace{20.4bp}%
  \begingroup
    \renewcommand{\chapter}[2]{}%
    \BUPT@orig@bibliography{#1}%
  \endgroup
}

\endinput
%% End of file `buptthesis.cls`.
