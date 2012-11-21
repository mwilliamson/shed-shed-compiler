# Shed compiler

A compiler for the Shed programming language, written in Shed itself.

The language itself is still very much in a state of change, and is currently
intended for trying out some thoughts on language design rather than any
practical use.

Run the tests with:

    make test
    
This will use a pre-compiled version of the compiler. To compile the compiler,
and then compile the tests using the just-compiled compiler, run:

    make self-hosted-test
    
To compile Shed files:

    make build
    node _build/compile.js <list-of-shed-files>
    
The output of the compiler is currently a single JavaScript file that can
be run in node.js. However, there's no particular reason why Shed couldn't be
compiled to other targets.

## TODO

* Update import syntax to improve clarity. Currently, to import the value `baz`
  from the module `foo.bar`, you can write `import foo.bar.baz`. However,
  importing the module `foo.bar.baz` requires the exact same syntax. Possible
  solutions:
    * use a different separate separator (e.g. `import foo/bar.baz`)
    * disallow direct imports of values within modules
    * convert imports to expressions (so `import foo.bar.baz` becomes something
      like `val baz = (import foo.bar).baz`)
* Reference resolution
* Adjust tokeniser/grammar to allow new lines instead of semi-colons. Requires
  some careful treatment of indentation to tell whether a new line is a
  continuation of the previous line, or a new statement.
* Add a pipeline operator or similar (see `|>` in F#, or thrush/thread in Clojure)
* Add simple syntax for partial application, such as using # as an operator. For
  instance, instead of `partial(filter, partial(strings.startsWith, "bob"))`, we could
  have `filter#(strings.startsWith#("bob"))`. This removes the noise of using
  `partial` all over the place, which isn't actually relevant to the problem
  at hand, but is the rewritten code actually easy to read?
* Interface declarations
* Sum type declarations
* Contravariance/covariance
* Type-checking
* Do-notation?
