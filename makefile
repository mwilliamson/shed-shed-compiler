.PHONY: test 

SOURCE_FILES = node_modules/shed-hat/hat.shed node_modules/shed-duck/duck.shed node_modules/shed-lop/lib lib
COMPILER_SCRIPT = _build/compile.js
COMPILE_COMPILER_ARGS = $(SOURCE_FILES) --main=shed.compiler.compilation.main
COMPILE_TESTS_ARGS = $(SOURCE_FILES) test --main=hat.run
	
build-tests:
	mkdir -p _build
	node_modules/.bin/shed-compile $(COMPILE_TESTS_ARGS) > _build/tests.js

build:
	node_modules/.bin/shed-compile $(COMPILE_COMPILER_ARGS) > $(COMPILER_SCRIPT)

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
	node $(COMPILER_SCRIPT) $(COMPILE_COMPILER_ARGS) > _build/compile-self-hosted.js
	node $(COMPILER_SCRIPT) $(COMPILE_TESTS_ARGS) > _build/tests-self-hosted.js
	node _build/tests-self-hosted.js \
		shed.compiler.tokenising.tokeniserTests.testCases \
		shed.compiler.parsing.literalsTest.testCases \
		shed.compiler.parsing.expressionsTest.testCases \
		shed.compiler.parsing.statementsTest.testCases \
		shed.compiler.parsing.modulesTest.testCases \
		shed.compiler.codeGeneration.microJavaScriptTest.testCases \
		shed.compiler.javaScript.writingTest.testCases \
		shed.compiler.compilationTest.testCases
