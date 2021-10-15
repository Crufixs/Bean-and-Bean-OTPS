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
    //Does not recognize numbers
    //Assignment operator = recognized as comparison operator
    //
    
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
        LexicalAnalyzer la = new LexicalAnalyzer();
        //
        // TODO code application logic here
        Scanner in = new Scanner(System.in);

        //INPUT FILE NALANG DAPAT INSTEAD OF SYSTEM.IN
        System.out.println("TEST: ");
        String s = in.nextLine();
        List<Token> rawr = la.lex(s);
        for (int i = 0; i < rawr.size(); i++) {
            System.out.println(rawr.get(i).toString() + " ");
        }
        
        SyntaxAnalyzer sa = new SyntaxAnalyzer(rawr);
        sa.analyzeSyntax();
        //sa.printAns();
        if(sa.isAccepted()) {
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