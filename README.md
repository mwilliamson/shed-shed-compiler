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

* Allow trailing commas in argument list
* Remove let in favour of :: blocks
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

## Monads

The type system of Shed should be able to support monads, but with some notable
differences from the support in Haskell (I mention Haskell specifically since
it's the most prominent example).

Since Shed has no notion of type classes, monads must instead be represented by
values. For instance, for the Option type:

```
val optionMonad = object ::
    implements Monad[Option]
    members ::
        unit fun[T] => (value: T) => Some(value)
        
        bind fun[T, R] => (monad: Option[T], func: Function[T, Option[R]]) =>
            match(monad,
                isNone, fun() => none,
                isSome, fun(some) => func(some.value())
            )
```

This monad type is then explicitly passed as an argument when a monad is
required. For instance, the equivalent of Haskell's do-notation could be
supported by explicitly passing the monad to `do`. This is more verbose than
using type classes, but also more in keeping with the philosophy of Shed
i.e. explicit rather than implicit, fewer language features where possible.

## Naming things

Some programming language constructs come in both named and
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

`def` is actually just a bit of syntatic sugar:

```
def id fun(x) => x
// is equivalent to
val id = (fun(x) => x).define("x")
```

## Ordering

(Note: this doesn't work yet since statement reordering hasn't been implemented)

In many contexts, the order of execution of statements in a block is irrelevant.
The goal is to allow statements to be defined in any order,
and the compiler will reorder statements to satisfy dependencies.
The value of a block is indicated with a keyword, such as `pick`.
In order to preserve ordering (for instance, when outputting to stdout),
a special block should be used (probably `do`).

This would replace the `let` and `where` constructs found in some languages.

For instance (apologies for triteness), using let:

```
def f(x, y, z) => let
    val a = x + y
    val b = x + z
    in a / b
```

Using `where`:

```
def f(x, y, z) =>
    a / b
    where a = x + y
          b = x + z
```

In Shed, either can be expressed using the same constructs:

```
// Equivalent of let
def f(x, y, z) => ::
    val a = x + y
    val b = x + z
    pick a / b
    
// Equivalent of where
def f(x, y, z) => ::
    pick a / b
    val a = x + y
    val b = x + z

// Mixing it up
def f(x, y, z) => ::
    val b = x + z
    pick a / b
    val a = x + y
```
