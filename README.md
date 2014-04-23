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

* Reference resolution
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

## Naming things

There are some programming language constructs come in both named and
anonymous forms, such as functions and classes. Rather than using distinct
syntax for each case, Shed only defines syntax to create anonymous instances of
each construct. The `def` statement can then name any such nameable construct.
For instance:

```
// Anonymous function
val id = fun(x) => x
// Named function
def id fun(x) => x
```
