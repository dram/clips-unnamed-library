# CLIPS Unnamed Library

Miscellaneous tools for CLIPS.

# Usage

## Generate library file

```shell
% ./compile-library unnamed.clp function-1 function-2 ...
```

## Include into project

```clips
(defmodule U
  (export deffunction ?ALL))

(load* "sources/unnamed.clp")

(defmodule MAIN)
...
```

You can choose any name for the containing module, but `U` or `UNNAMED` are recommended.
