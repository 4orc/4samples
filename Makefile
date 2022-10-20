-include ../etc/Makefile

D=auto2 auto93 nasa93dem china coc1000 healthCloseIsses12mths0011-easy \
   healthCloseIsses12mths0001-hard pom #SSN SSM#
trees: ## trees test
	$(foreach d,$D, lua samples.lua -f $R/data/$d.csv -g tree; )

sneaks: ## sneak test
	$(foreach d,$D, lua samples.lua -f $R/data/$d.csv -g sneak; )

sways: ## sway test
	$(foreach d,$D, lua samples.lua -f $R/data/$d.csv -g sway; )

swaysneak: ## swaysneak
	$(foreach d,$D, lua samples.lua -f $R/data/$d.csv -g swaysneak; )

f=nasa93dem
knowns: ## compare items
	(lua samples.lua -f ../data/$f.csv -g sway; \
   lua samples.lua -f ../data/$f.csv -g sneak;  \
	 lua samples.lua -f ../data/$f.csv -g swaysneak) #| grep KNOWN

README.md: ../readme/readme.lua samples.lua  ## update readme
	printf "\n# Sample\nSampling via recursive random projections\n" > README.md
	lua $< samples.lua >> README.md
