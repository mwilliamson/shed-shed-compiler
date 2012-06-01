.PHONY: test 
	
build-tests:
	mkdir -p _build
	node_modules/.bin/shed-compile node_modules/shed-hat/hat.shed node_modules/shed-duck/duck.shed lib test --main=hat.run > _build/tests.js

test: build-tests
	node _build/tests.js shed.compiler.tokenising.tokeniserTests
	node _build/tests.js shed.compiler.parsing.expressionsTest
	node _build/tests.js shed.compiler.parsing.rulesTest
