GENERATED = src/NewIfLexer.hs src/NewIfParser.hs src/TheoLexer.hs src/TheoParser.hs src/Lexer.hs src/AnBParser.hs

########################

.PHONY: ofmc

ofmc: $(GENERATED)
	stack build

########################

src/NewIfLexer.hs: resources/NewIfLexer.x
	alex resources/NewIfLexer.x -o src/NewIfLexer.hs

########################

src/NewIfParser.hs:	resources/NewIfParser.y
	happy resources/NewIfParser.y -o src/NewIfParser.hs

########################

src/TheoLexer.hs: resources/TheoLexer.x
	alex resources/TheoLexer.x -o src/TheoLexer.hs

########################

src/TheoParser.hs: resources/TheoParser.y
	happy resources/TheoParser.y -o src/TheoParser.hs

########################

src/Lexer.hs: resources/Lexer.x
	alex resources/Lexer.x -o src/Lexer.hs

########################

src/AnBParser.hs: resources/AnBParser.y
	happy resources/AnBParser.y -o src/AnBParser.hs

########################

install:
	cp ofmc release/bin.`uname`/

########################

test:	
	pushd ../examples ; time ./runall ; popd

#########################

clean: 
	rm -f *\.hi *\.o ofmc 
	rm $(GENERATED)

release:	$(SRCFILES)
	mkdir release
	mkdir release/src
	cp $(SRCFILES)	release/src
	cp Makefile release/src
	cp "BSD License.txt" release/src
	cp "BSD License.txt" release
	mkdir release/AnB-tutorial
	cp ../AnB-tutorial/anb-tutorial.pdf release/AnB-tutorial
	cp ../AnB-tutorial/KeyEx*AnB	release/AnB-tutorial
	cp ../manual.pdf release
#cp ../README.txt release
	cp -r ../examples release
	cd release
	find . -name ".svn" -exec echo {} \; #rm -rf {} \;
