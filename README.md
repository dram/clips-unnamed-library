# CLIPS Unnamed Library

Miscellaneous tools for CLIPS.

# Usage

## Generate library file

```shell
% ./compile-library output-path/ function-1 function-2 ...
```

Following command can be used to generate function list automatically:

```shell
grep -hoP 'U::\K(\S+)' foo.clp bar.clp ... | sort -u
```

## Include into project

```clips
(defmodule U
  (export deffunction ?ALL))

(load* "sources/unnamed.clp")

(defmodule MAIN)
...
```

You can choose any name for the containing module, but `U` or `UNNAMED` are recommended. Or you can load code into `MAIN` module directly.
