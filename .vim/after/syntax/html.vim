unlet b:current_syntax

" Read the HTML syntax to start with
syn include @HTML $VIMRUNTIME/syntax/html.vim

" Script type=“text/template”
syn region htmlTemplate start=+<script [^>]*type *=[^>]*text/template[^>]*>+
\	end=+</script>+me=s-1 keepend
\	contains=@HTML,htmlScriptTag,@htmlPreproc

" Underscore.js inner highlights
syn region jstBlock containedin=ALL start="<%=" keepend end="%>"
\	contains=@htmlJavaScript,htmlCssStyleComment,htmlScriptTag,@htmlPreproc
syn region jstBlock containedin=ALL start="<%" keepend end="%>"
\	contains=@htmlJavaScript,htmlCssStyleComment,htmlScriptTag,@htmlPreproc
