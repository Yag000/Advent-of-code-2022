package main.java.day7;

import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;
import java.text.DecimalFormat;

public class App {
    public static void main(String[] args) {

        long startTime = System.nanoTime();


        String fileName = "resources/day7.txt";

        try {
            Scanner sc = new Scanner(new File(fileName));
            Arborescence arborescence = new Arborescence(sc);
            sc.close();

            arborescence.browseArborescence();

            System.out.println("----------------- Day 7 -----------------");
            System.out.println();

            System.out.println("Part 1");
            System.out.println();
            System.out.println(arborescence.browseHashMap(100000));
            System.out.println();

            long endTime1 = System.nanoTime();
            DecimalFormat df = new DecimalFormat("0.0000000");
            String formatted = df.format((endTime1 - startTime) / 10E9);
            System.out.println("Time: " + formatted + "s");
            System.out.println();

            System.out.println("Part 2");
            System.out.println();
            System.out.println(arborescence.findSizeFileToRemove(70000000, 30000000));
            System.out.println();

            long endTime2 = System.nanoTime();
            df = new DecimalFormat("0.0000000");
            formatted = df.format((endTime2 - endTime1) / 10E9);
            System.out.println("Time: " + formatted + "s");
            System.out.println();


        } catch (FileNotFoundException e) {
            e.printStackTrace();
            System.out.println("File not found");
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
