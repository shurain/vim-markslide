function! SlideMKD()
python << PYTHON
import os.path
import vim
import sys

for path in vim.eval('&runtimepath').split(','):
    syspath = os.path.join(path, 'plugin', 'markslide')
    sys.path.append(syspath)
import markslide

inputfile = vim.current.buffer.name

if not inputfile:
    print 'Save the file first'
else:
    name = os.path.split(inputfile)[1]
    outputfile = os.path.join('/tmp', name + '.html')
    template = os.path.join(os.path.split(markslide.__file__)[0], 'base.html')

    try:
        markslide.make_slide(ifile=inputfile, ofile=outputfile, templatefile=template)
        vim.command("silent !open '%s'" % outputfile)
    except IOError:
        print 'Save the file first'
PYTHON

endfunction

:command! Ms :call SlideMKD()
