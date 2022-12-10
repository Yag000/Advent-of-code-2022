package main.java.day7;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Scanner;
import java.util.Set;

/**
 * This class represents an arborescence, which is a tree-like structure used to
 * organize files and folders.
 */
public class Arborescence {
    // The root folder of the arborescence
    private Folder root;

    // The current folder of the arborescence
    private Folder current;

    // Hash map which contains all the folders and their sizes
    private HashMap<String, Integer> folders = new HashMap<>();

    /**
     * Creates a new arborescence with the given input Scanner.
     * 
     * @param sc the input Scanner
     */
    public Arborescence(Scanner sc) {
        this.root = new Folder("/", 0);
        this.current = this.root;

        treatInput(sc);
    }

    /**
     * Abstract class representing an element in the arborescence, either a file or
     * a folder.
     */
    private abstract class Element {
        private String name;
        private int size;

        /**
         * Creates a new Element with the given name and size.
         * 
         * @param name the name of the Element
         * @param size the size of the Element
         */
        public Element(String name, int size) {
            this.name = name;
            this.size = size;
        }

        /**
         * Returns the name of the Element.
         * 
         * @return the name of the Element
         */
        public String getName() {
            return this.name;
        }

        /**
         * Returns the size of the Element.
         * 
         * @return the size of the Element
         */
        public int getSize() {
            return this.size;
        }
    }

    /**
     * Class representing a file in the arborescence.
     */
    private class File extends Element {

        /**
         * Creates a new File with the given name and size.
         * 
         * @param name the name of the File
         * 
         * @param size the size of the File
         */
        public File(String name, int size) {
            super(name, size);
        }
    }

    /**
     * Class representing a folder in the arborescence.
     */
    private class Folder extends Element {

        // Set of elements contained in the folder
        private Set<Element> elements;

        // The parent folder of this folder
        private Folder parent;

        /**
         * Creates a new Folder with the given name and size, and sets the given parent
         * folder.
         * 
         * The name of the folder is the concatenation of the parent folder's name and
         * the given name.
         * 
         * @param name   the name of the Folder
         * 
         * @param size   the size of the Folder
         * 
         * @param parent the parent Folder
         */
        public Folder(String name, int size, Folder parent) {
            super(parent.getName() + name, size);

            this.parent = parent;

            this.elements = new HashSet<>();
        }

        /**
         * Creates a new Folder with the given name and size, and sets the parent folder
         * to be itself.
         * 
         * @param name the name of the Folder
         * 
         * @param size the size of the Folder
         */
        public Folder(String name, int size) {
            super(name, size);

            this.parent = this;

            this.elements = new HashSet<>();
        }

        /**
         * Returns the set of elements contained in the Folder.
         * 
         * @return the set of elements contained in the Folder
         */
        public Set<Element> getElements() {
            return this.elements;
        }

        /**
         * Adds the given element to the Folder.
         * 
         * @param element the element to add to the Folder
         */
        public void addElement(Element element) {
            this.elements.add(element);
        }

        /**
         * Returns the total size of all elements in the Folder.
         * 
         * @return the total size of all elements in the Folder
         */
        public int getSize() {
            int size = 0;
            for (Element element : this.elements) {
                size += element.getSize();
            }
            return size;
        }

        /**
         * We browse the folder recursively and we add the size of each folder to the
         * HashMap.
         */
        public void browseFolder() {
            for (Element element : this.elements) {
                if (element instanceof Folder) {
                    Folder folder = (Folder) element;
                    folders.put(folder.getName(), folder.getSize());
                    folder.browseFolder();
                }
            }

        }

    }

    /**
     * Changes the current folder to the root folder.
     */
    public void cd() {
        this.current = root;
    }

    /**
     * Changes the current folder to the parent folder.
     */
    public void cdBack() {
        this.current = this.current.parent;
    }

    /**
     * Changes the current folder to the folder with the given name.
     * 
     * @param name the name of the folder to change to
     */
    public void cd(String name) {
        for (Element element : this.current.getElements()) {
            if (element.getName().equals(this.current.getName() + name)) {
                this.current = (Folder) element;
            }
        }
    }

    /**
     * Creates a new folder with the given name in the current folder.
     * 
     * @param name the name of the new folder to create
     */
    public void createFolder(String name) {
        Folder folder = new Folder(name, 0, this.current);
        this.current.addElement(folder);
    }

    /**
     * Creates a new file with the given name and size in the current folder.
     * 
     * @param name the name of the new file to create
     * @param size the size of the new file
     */
    public void createFile(String name, int size) {
        File file = new File(name, size);
        this.current.addElement(file);
    }

    /**
     * Treats the input Scanner and updates the arborescence accordingly.
     * 
     * @param sc the input Scanner to process
     */
    public void treatInput(Scanner sc) {
        sc.nextLine();

        while (sc.hasNextLine()) {
            String line = sc.nextLine();
            String[] command = line.split(" ");

            switch (command[0]) {
                case "$":
                    if (command[1].equals("cd")) {
                        if (command.length == 2) {
                            this.cd();
                        } else if (command[2].equals("..")) {
                            this.cdBack();
                        } else {
                            this.cd(command[2]);
                        }
                    }
                    break;

                case "dir":
                    this.current.addElement(new Folder(command[1], 0, current));
                    break;
                default:
                    this.current.addElement(new File(command[1], Integer.parseInt((command[0]))));
            }
        }
    }

    /**
     * Browses the arborescence and updates the HashMap of folder sizes.
     */
    public void browseArborescence() {
        this.root.browseFolder();

        int size = 0;
        for (Element e : this.root.getElements()) {
            if (e instanceof Folder) {
                size += this.folders.get(e.getName());
            } else {
                size += e.getSize();
            }
        }
        this.folders.put("/", size);
    }

    /**
     * We browse the hash map and we find the folder which has the size of the
     * smallest folder which we need to remove to get {@code freeSpace} free space.
     * 
     * @param maxSize   the size of the file system
     * @param freeSpace the free space we need
     * @return the size of the folder we need to remove
     */
    public int findSizeFileToRemove(int maxSize, int freeSpace) {
        int localMin = Integer.MAX_VALUE;

        int neededSpace = freeSpace - (maxSize - this.folders.get("/"));

        for (String key : folders.keySet()) {
            if (folders.get(key) > neededSpace && folders.get(key) < localMin) {
                localMin = folders.get(key);
            }
        }

        return localMin;
    }

    /**
     * We browse the hash map and we sum the sizes of every folder wick has a size
     * of less tha {@code maxSize}
     * 
     * @param maxSize
     */
    public int browseHashMap(int maxSize) {
        int size = 0;

        for (String key : folders.keySet()) {
            if (folders.get(key) < maxSize) {
                size += folders.get(key);
            }
        }
        return size;
    }

    /**
     * Returns the size of the root folder.
     * 
     * @return the size of the root folder
     */
    public int getRootSize() {
        return this.folders.get("/");
    }

}
