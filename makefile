.PHONY: test 
	
build-tests:
	mkdir -p _build
	node_modules/.bin/shed-compile node_modules/shed-hat/hat.shed node_modules/shed-duck/duck.shed node_modules/shed-lop/lib lib test --main=hat.run > _build/tests.js

test: build-tests
	node _build/tests.js shed.compiler.tokenising.tokeniserTests.testCases
	node _build/tests.js shed.compiler.parsing.literalsTest.testCases
	node _build/tests.js shed.compiler.parsing.expressionsTest.testCases
	node _build/tests.js shed.compiler.parsing.statementsTest.testCases
	node _build/tests.js shed.compiler.parsing.modulesTest.testCases
	node _build/tests.js shed.compiler.codeGeneration.microJavaScriptTest.testCases
	node _build/tests.js shed.compiler.javaScript.writingTest.testCases
	node _build/tests.js shed.compiler.compilationTest.testCases
