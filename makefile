.PHONY: test 

BOOTSTRAP_VERSION = 0.1.1
BOOTSTRAP_COMPILER_SCRIPT = _build/shed-compiler-$(BOOTSTRAP_VERSION).js
DEFAULT_COMPILER = node $(BOOTSTRAP_COMPILER_SCRIPT)
SOURCE_FILES = node_modules/shed-hat/hat.shed node_modules/shed-duck/duck.shed node_modules/shed-lop/lib lib
COMPILER_SCRIPT = _build/compile.js
COMPILE_COMPILER_ARGS = $(SOURCE_FILES) --main=shed.compiler.compilation.main
COMPILE_TESTS_ARGS = $(SOURCE_FILES) test --main=hat.run
TEST_CASES = shed.compiler.tokenising.tokeniserTests.testCases \
	shed.compiler.parsing.literalsTest.testCases \
	shed.compiler.parsing.expressionsTest.testCases \
	shed.compiler.parsing.statementsTest.testCases \
	shed.compiler.parsing.modulesTest.testCases \
	shed.compiler.codeGeneration.microJavaScriptTest.testCases \
	shed.compiler.javaScript.writingTest.testCases \
	shed.compiler.referenceResolvingTest.testCases \
	shed.compiler.compilationTest.testCases
	
build-tests:
	mkdir -p _build
	$(DEFAULT_COMPILER) $(COMPILE_TESTS_ARGS) > _build/tests.js || (cat _build/tests.js && false)

build: bootstrap
	$(DEFAULT_COMPILER) $(COMPILE_COMPILER_ARGS) > $(COMPILER_SCRIPT) || (cat $(COMPILER_SCRIPT) && false)

test: build-tests
	node _build/tests.js $(TEST_CASES)

self-hosted-test: build
	node $(COMPILER_SCRIPT) $(COMPILE_COMPILER_ARGS) > _build/compile-self-hosted.js
	node $(COMPILER_SCRIPT) $(COMPILE_TESTS_ARGS) > _build/tests-self-hosted.js
	node _build/tests-self-hosted.js $(TEST_CASES)

bootstrap: $(BOOTSTRAP_COMPILER_SCRIPT)

$(BOOTSTRAP_COMPILER_SCRIPT):
	mkdir -p `dirname $(BOOTSTRAP_COMPILER_SCRIPT)`
	curl -L https://github.com/downloads/mwilliamson/shed-shed-compiler/shed-compiler-$(BOOTSTRAP_VERSION).js > $(BOOTSTRAP_COMPILER_SCRIPT)
