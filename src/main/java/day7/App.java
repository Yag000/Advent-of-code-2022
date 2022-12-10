package main.java.day7;

import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;

public class App {
    public static void main(String[] args) {
        System.out.println("----------------------- Day 7.1 -----------------------");

        String fileName = "resources/day7.txt";

        try {
            Scanner sc = new Scanner(new File(fileName));
            Arborescence arborescence = new Arborescence(sc);
            sc.close();

            arborescence.browseArborescence();

            System.out.println("Day 7.1");
            System.out.println(arborescence.browseHashMap(100000));
            System.out.println("Day 7.2");
            System.out.println(arborescence.findSizeFileToRemove(70000000, 30000000));

        } catch (FileNotFoundException e) {
            e.printStackTrace();
            System.out.println("File not found");
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
