.PHONY: test 

SOURCE_FILES = node_modules/shed-hat/hat.shed node_modules/shed-duck/duck.shed node_modules/shed-lop/lib lib
COMPILER_SCRIPT = _build/compile.js
	
build-tests:
	mkdir -p _build
	node_modules/.bin/shed-compile $(SOURCE_FILES) test --main=hat.run > _build/tests.js

build:
	node_modules/.bin/shed-compile $(SOURCE_FILES) --main=shed.compiler.compilation.main > $(COMPILER_SCRIPT)

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

self-hosted-test: build
	node $(COMPILER_SCRIPT) $(SOURCE_FILES) --main=shed.compiler.compilation.main > _build/compile-self-hosted.js
	node $(COMPILER_SCRIPT) $(SOURCE_FILES) test --main=hat.run > _build/tests-self-hosted.js
	node _build/tests-self-hosted.js \
		shed.compiler.tokenising.tokeniserTests.testCases \
		shed.compiler.parsing.literalsTest.testCases \
		shed.compiler.parsing.expressionsTest.testCases \
		shed.compiler.parsing.statementsTest.testCases \
		shed.compiler.parsing.modulesTest.testCases \
		shed.compiler.codeGeneration.microJavaScriptTest.testCases \
		shed.compiler.javaScript.writingTest.testCases \
		shed.compiler.compilationTest.testCases
