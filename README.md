# Parallel OFMC

This repository contains the source code for the [Open-source Fixed-point Model Checker](https://www.imm.dtu.dk/~samo/) extended with parallel processing capabilities.

This version of OFMC utilises all available cores during both the BFS and the DFS phases and can achieve massive speedups depending on the number of cores.

## Performance

Tested on an 8-core CPU (2 x 2064MHz + 6 x 3228MHz), both versions of OFMC executed with `--numSess 2` on an example protocol:

<center>

|             | OFMC  | Parallel OFMC | speedup |
|-------------|:----------:|----------|---------|
| **typed**   | 50s        | 11s      | 4,55    | 
| **untyped** | 47m        | 8m       | 5,86    |

</center>

The workload seems to be evenly distributed across all 8 cores during both breadth-first and then depth-first searches:

![threadscope screenshot](./extras/threadscope.png)
## Requirements

- [The Haskell Tool Stack](https://docs.haskellstack.org/en/stable/README/)
- [Alex](https://www.haskell.org/alex/)
- [Happy](https://www.haskell.org/happy/)
- make
- (optional) [Threadscope](https://github.com/haskell/ThreadScope)

Alex, Happy and Threadscope can be installed using the `stack install` command. You might have to add some dependencies to `extra-deps` in `stack.yaml` for them to install, but you can remove those later.

## Build

Run `make` to generate lexer and parser source files in `src` and build the project using `stack build`.

Run `stack install` to copy the `ofmc` executable to your default stack installation path (e.g. `~/.local/bin`).

