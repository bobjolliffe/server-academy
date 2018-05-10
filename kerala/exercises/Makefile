MD=pandoc
MDTEMPLATE=template.htm
MDFLAGS=-s --template $(MDTEMPLATE) --wrap=auto -f markdown_github -t html5 --toc

build: exercises_day1 exercises_day2 exercises_day3 exercises_day4 exercises_day5

exercises_day1: exercises_day1.md $(MDTEMPLATE)
	$(MD) $(MDFLAGS) $@.md -o $@.html

exercises_day2: exercises_day2.md $(MDTEMPLATE)
	$(MD) $(MDFLAGS) $@.md -o $@.html

exercises_day3: exercises_day3.md $(MDTEMPLATE)
	$(MD) $(MDFLAGS) $@.md -o $@.html

exercises_day4: exercises_day4.md $(MDTEMPLATE)
	$(MD) $(MDFLAGS) $@.md -o $@.html

exercises_day5: exercises_day5.md $(MDTEMPLATE)
	$(MD) $(MDFLAGS) $@.md -o $@.html

clean:
	rm -f *~ *.html 
