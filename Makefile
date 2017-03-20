MD=pandoc
MDTEMPLATE=template.htm
MDFLAGS=-s --template $(MDTEMPLATE) --wrap=auto -f markdown_github -t html5 --toc

build: exercises_day1

exercises_day1: exercises_day1.md $(MDTEMPLATE)
	$(MD) $(MDFLAGS) $@.md -o $@.html


clean:
	rm -f *~ *.html 
