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
        System.out.println("=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=");
        System.out.println("=+=+=+=+=+=+=+=+ FOR LOOP SYNTAX CHECKER =+=+=+=+=+=+=+=+");
        System.out.println("=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=");
        System.out.print("\nINPUT: \t");
        String s = in.nextLine();
        System.out.println("");
        String ss[] = new String[3];
        try {
            ss = separate(s);
        } catch (Exception e) {
            System.out.println("=+=+=+=+ SYSTEM: THE FOR LOOP SYNTAX IS INCORRECT =+=+=+=+");
            System.exit(0);
        }
        /*System.out.println();
         List<Token> rawr = la.lex(ss[1]);
         for (int i = 0; i < rawr.size(); i++) {
         System.out.println("rawr: " + rawr.get(i).toString());
         }*/
        System.out.println();
        SyntaxAnalyzer sa1 = new SyntaxAnalyzer(la.lex(ss[0]), grammarList.getInitDeclare(), Type.INIT_DECLARE);
        SyntaxAnalyzer sa2 = new SyntaxAnalyzer(la.lex(ss[1]), grammarList.getConditionGrammar(), Type.COND);
        SyntaxAnalyzer sa3 = new SyntaxAnalyzer(la.lex(ss[2]), grammarList.getInc_Dec(), Type.INC_DEC);

        sa1.analyzeSyntax();

        //sa1.printAns();
        if (sa1.isAccepted()) {
            System.out.println("DECLARATION:\t   ACCEPTED");
        } else {
            System.out.println("DECLARATION:\t   REJECTED");
        }
        sa2.analyzeSyntax();
        if (sa2.isAccepted()) {
            System.out.println("CONDITION:\t   ACCEPTED");
        } else {
            System.out.println("CONDITION:\t   REJECTED");
        }
        sa3.analyzeSyntax();
        if (sa3.isAccepted()) {
            System.out.println("INCREMENTATION:\t   ACCEPTED");
        } else {
            System.out.println("INCREMENTATION:\t   REJECTED");
        }

        if (sa1.isAccepted() && sa2.isAccepted() && sa3.isAccepted()) {
            System.out.println("\n=+=+=+=+ SYSTEM: THE FOR LOOP SYNTAX IS CORRECT =+=+=+=+");
        } else {
            System.out.println("\n=+=+=+=+ SYSTEM: THE FOR LOOP SYNTAX IS INCORRECT =+=+=+=+");
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
        System.out.println("Declaration:\t   " + str[0]);
        x++;
        while (s.charAt(x) != ';') {
            str[1] += ("" + s.charAt(x));
            x++;
        }
        System.out.println("CONDITION:\t   " + str[1]);
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
        System.out.println("INCREMENTATION:\t   " + str[2]);
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
