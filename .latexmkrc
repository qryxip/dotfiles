$latex = 'uplatex -synctex=1 -halt-on-error -kanji=utf8';
$latex_silent = 'uplatex -synctex=1 -halt-on-error -interaction=batchmode';
$bibtex = 'pbibtex';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'mendex %O -o %D %S';
$max_repeat = 10;
$pdf_mode = 3; # generates pdf via dvipdfmx
$pvc_view_file_via_temporary = 0; # Prevent latexmk from removing PDF after typeset.
