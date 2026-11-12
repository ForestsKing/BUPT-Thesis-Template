# latexmk 编译配置：latexmk 自动读取，运行 `latexmk main.tex` 即可完成 xelatex + bibtex 全流程
# templates/ 前置到 TEXINPUTS 与 BSTINPUTS，保证文档类和 GB/T 7714 样式优先用本地副本


$ENV{'TEXINPUTS'} = './templates//:' . ($ENV{'TEXINPUTS'} // '');
$ENV{'BSTINPUTS'} = './templates//:' . ($ENV{'BSTINPUTS'} // '');
$pdf_mode = 5;   # 使用 xelatex 编译
