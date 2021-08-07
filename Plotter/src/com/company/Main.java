package com.company;

import processing.core.PApplet;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

public class Main extends PApplet {
    final int readAmount = 30, min = -350, max = 350;
    File data, flag;
    Scanner sc;
    ArrayList<Integer> values1, values2;

    public void settings() {
        size(600, 400);
    }

    public void setup() {
        data = new File("data.txt");
        flag = new File("flag4.txt");
        values1 = new ArrayList();
        values2 = new ArrayList();
    }

    public void draw() {
        background(25);
        stroke(255);
        strokeWeight(2);
        line(0, height/2, width, height/2);

        try {
            sc = new Scanner(flag);
            if(sc.hasNextLine() && sc.nextLine().equals("0")) {
                try {
                    sc = new Scanner(data);
                    boolean flag = true;
                    while(sc.hasNextLine()) {
                        if(flag) {
                            values1.add(Integer.parseInt(sc.nextLine()));
                        } else {
                            values2.add(Integer.parseInt(sc.nextLine()));
                        }
                        flag = !flag;
                    }

                    try {
                        FileWriter myWriter = new FileWriter("flag4.txt", false);
                        myWriter.write("1");
                        myWriter.close();
                    } catch (IOException e) {
                        System.out.println(e.getMessage());
                    }
                } catch(Exception e) {
                    System.out.println(e.getMessage());
                }
            }
        } catch(Exception e) {
            System.out.println(e.getMessage());
        }
        int size;

        noFill();
        strokeWeight(3);
        stroke(24, 219, 216);
        beginShape();
        size = values1.size();
        if(size > 0) {
            //curveVertex(0, values1.get(0));
            for (int i = nonNeg(size - readAmount); i < size; i++) {
                curveVertex((i - nonNeg(size - readAmount)) * (width / readAmount), map(values1.get(i), min, max, 380, 20));
            }
            //curveVertex((size - 1) * (width / readAmount), map(values1.get(size - 1), min, max, 380, 20));
        }
        endShape();

        stroke(219, 24, 193);
        beginShape();
        size = values2.size();
        if(size > 0) {
            //curveVertex(0, values2.get(0));
            size = values2.size();
            for (int i = nonNeg(size - readAmount); i < size; i++) {
                curveVertex((i - nonNeg(size - readAmount)) * (width / readAmount), map(values2.get(i), min, max, 380, 20));
            }
            //curveVertex((size - 1) * (width / readAmount), map(values2.get(size - 1), min, max, 380, 20));
        }
        endShape();
    }

    public int nonNeg(int number) {
        if(number < 0)
            return 0;
        else
            return number;
    }

    public static void main(String[] args) {
        String[] appletArgs = new String[] {"com.company.Main"};
        if (args != null) {
            PApplet.main(concat(appletArgs, args));
        } else {
            PApplet.main(appletArgs);
        }
    }
}
