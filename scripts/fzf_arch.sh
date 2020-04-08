# Search the arch-wiki-docs using fzf
fzad(){find /usr/share/doc/arch-wiki/html/en/ -name "*.html"  | fzf | xargs -r firefox}
