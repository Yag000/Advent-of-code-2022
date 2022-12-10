# Advent of Code 2022 Solutions

This repository contains my solutions to the [Advent of Code 2022](https://adventofcode.com/2022) programming challenges. I have implemented my solutions in three languages: OCaml, Java, and Python. The majority of my solutions are written in OCaml, with a few in Java and Python for specific challenges where those languages are better suited.

## Folder Structure

This project is structured as a [dune](https://dune.build) project, with the following layout:

* `src/`: Contains the source code for my solutions, organized by language
  * `src/main/ocaml/`: Contains my OCaml solutions
  * `src/main/java/`: Contains my Java solutions
  * `src/main/python/`: Contains my Python solutions
* `resources/`: Contains the input files for the challenges

## Running the Solutions

To run the solutions, you will need to have [dune](https://dune.build) installed. You can then navigate to the root of the project and run the following command to build the executables for each solution:

```bash
dune build
```

This will create executables for each solution in the `_build` directory. You can then run a specific solution by navigating to the appropriate directory and running the executable, for example:

```bash
cd _build/default/src/main/ocaml/day1
./day1.exe
```

This will run the solution for Day 1 in OCaml, using the input from the `resources/day1.txt` file.

Alternatively, you can run `dune exec` to run a specific solution directly, without building all of the executables first. For example:

```bash
dune exec src/main/ocaml/day1/day1.exe
```

To run all solutions, you can run the following command:

```bash
src/run_all.sh
```
