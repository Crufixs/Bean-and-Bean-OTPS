/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proglang_forloop;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.List;
import java.util.Scanner;

import java.io.IOException;

/**
 *
 * @author Carlo
 */
public class ProgLang_ForLoop {

    //Issues:://
    //Does not recognize numbers - lexical op
    //Assignment operator = recognized as comparison operator
    //iteration to comparison op e.g: a+= b >= x
    //Working://
    //comparison op
    //logical op
    //
    //Lexical (fix)://
    //Numerical Values
    //Bool
    //Iteration ops??
    //
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws IOException {
        BNF_Grammar grammarList = new BNF_Grammar();
        LexicalAnalyzer la = new LexicalAnalyzer();
        //
        // TODO code application logic here
        Scanner in = new Scanner(System.in);

        //INPUT FILE NALANG DAPAT INSTEAD OF SYSTEM.IN
        System.out.println("TEST: ");
        String s = in.nextLine();
        try {

            String ss[] = separate(s);
        } catch (Exception e) {
            System.out.println("shutacca");
            System.exit(0);
        }
        List<Token> rawr = la.lex(s);
        for (int i = 0; i < rawr.size(); i++) {
            System.out.println(rawr.get(i).toString() + " ");
        }

        SyntaxAnalyzer sa = new SyntaxAnalyzer(rawr, grammarList.getConditionGrammar(), Type.CONDITIONS);
        //SyntaxAnalyzer sa1 = new SyntaxAnalyzer(rawr,grammarList.getInitDeclare());
        //SyntaxAnalyzer sa2 = new SyntaxAnalyzer(rawr,grammarList.getInc_Dec());

        sa.analyzeSyntax();
        sa.printGrammar();
        sa.printAns();
        if (sa.isAccepted()) {
            System.out.println("SENTENCE IS ACCEPTED");
        } else {
            System.out.println("SENTENCE IS REJECTED");
        }
        /*
         System.out.println("Input path file: ");
         String textContent = in.nextLine(); //path example = C:\\Users\\user\\Desktop\\file.txt
         fileRead(textContent);
        
        
         */
    }

    public static String[] separate(String s) {
        String str[] = {"", "", ""};
        int x = 0;
        while (s.charAt(x) != '(') {
            x++;
        }
        x++;
        while (s.charAt(x) != ';') {
            str[0] += ("" + s.charAt(x));
            x++;
        }
        System.out.println("String 1: " + str[0]);
        x++;
        while (s.charAt(x) != ';') {
            str[1] += ("" + s.charAt(x));
            x++;
        }
        System.out.println("String 2: " + str[1]);
        x++;
        int val = 1;
        while (val != 0) {
            if (s.charAt(x) == '(') {
                val += 1;
            } else if (s.charAt(x) == ')') {
                val -= 1;
            }
            if (val == 0) {
                break;
            }
            str[2] += ("" + s.charAt(x));
            x++;
        }
        System.out.println("String 3: " + str[2]);
        boolean openB = false, closeB = false;
        while (openB == false || closeB == false) {
            if (s.charAt(x) == '{') {
                openB = true;
            } else if (s.charAt(x) == '}') {
                closeB = openB & true;
            }
            if ((openB == false || closeB == false) && s.charAt(x) == ';') {
                break;
            }
            x++;
        }
        return str;
    }

    public static String fileRead(String path) throws FileNotFoundException, IOException {
        BufferedReader reader = new BufferedReader(new FileReader(path));
        StringBuilder stringBuilder = new StringBuilder();
        String line = null;
        while ((line = reader.readLine()) != null) {
            stringBuilder.append(line);
            stringBuilder.append(" ");
        }
// delete the last new line separator
        stringBuilder.deleteCharAt(stringBuilder.length() - 1);
        reader.close();

        String content = stringBuilder.toString();
        System.out.println(content);
        return content;
    }
}
//C:\\Users\\chuah_000\\Desktop\\kalokohan.txt
