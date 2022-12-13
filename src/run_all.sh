eval $(opam env) 
dune build

dune exec src/main/ocaml/day1/day1.exe 
dune exec src/main/ocaml/day2/day2.exe 
dune exec src/main/ocaml/day3/day3.exe 
dune exec src/main/ocaml/day4/day4.exe 
dune exec src/main/ocaml/day5/day5.exe 
dune exec src/main/ocaml/day6/day6.exe 

javac -d _bin/ src/main/java/day7/*.java && java -cp _bin main.java.day7.App

python3 src/main/python/day8.py
python3 src/main/python/day9.py

dune exec src/main/ocaml/day10/day10.exe 
dune exec src/main/ocaml/day11/day11.exe 
dune exec src/main/ocaml/day12/day12.exe ç

python3 src/main/python/day13.py