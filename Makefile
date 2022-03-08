STACK 	   = stack
HAPPY      = happy
HAPPY_OPTS = --array --ghc --coerce
ALEX       = alex
ALEX_OPTS  = --ghc
GENERATED = src/NewIfLexer.hs src/NewIfParser.hs src/TheoLexer.hs src/TheoParser.hs src/Lexer.hs src/AnBParser.hs
EXECUTABLE = ofmc
ARGS 	   = --numSess 2 sources/test.AnB

.PHONY: ofmc clean

ofmc: $(GENERATED)
	${STACK} build

src/%.hs : resources/%.y
	${HAPPY} ${HAPPY_OPTS} $< -o $@

src/%.hs : resources/%.x
	${ALEX} ${ALEX_OPTS} $< -o $@

clean: 
	-rm $(GENERATED)
	-rm -f *.aux *.hp *.ps *.eventlog *.prof *.prof.html *.svg

bench:
	${STACK} build
	${STACK} exec -- $(EXECUTABLE) +RTS -s -RTS $(ARGS)

threadscope:
	${STACK} build
	-${STACK} exec -- $(EXECUTABLE) +RTS -ls -lf -s -RTS $(ARGS)
	threadscope $(EXECUTABLE).eventlog
