import java.util.Scanner;
import java.io.File;

public class App {
    public static void main(String[] args) {
        System.out.println("----------------------- Day 7.1 -----------------------");

        // Open the file resources/day7Input.txt with a Scanner

        String fileName = "resources/day7Input";

        try {
            Scanner sc = new Scanner(new File(fileName));
            Arborescence arborescence = new Arborescence(sc);
            sc.close();

            arborescence.browseArborescence();
            System.out.println(arborescence.browseHashMap(100000));
            System.out.println(arborescence.findSizeFileToRemove(70000000, 30000000));
            System.out.println(arborescence.getRootSize());
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("File not found");
        }

    }
}
