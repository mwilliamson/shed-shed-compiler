.PHONY: test 
	
build-tests:
	mkdir -p _build
	node_modules/.bin/shed-compile node_modules/shed-hat/hat.shed node_modules/shed-duck/duck.shed node_modules/shed-lop/lib lib test --main=hat.run > _build/tests.js

build:
	node_modules/.bin/shed-compile node_modules/shed-hat/hat.shed node_modules/shed-duck/duck.shed node_modules/shed-lop/lib lib --main=shed.compiler.compilation.compileFile > _build/compileFile.js

test: build-tests
	node _build/tests.js \
		shed.compiler.tokenising.tokeniserTests.testCases \
		shed.compiler.parsing.literalsTest.testCases \
		shed.compiler.parsing.expressionsTest.testCases \
		shed.compiler.parsing.statementsTest.testCases \
		shed.compiler.parsing.modulesTest.testCases \
		shed.compiler.codeGeneration.microJavaScriptTest.testCases \
		shed.compiler.javaScript.writingTest.testCases \
		shed.compiler.compilationTest.testCases
