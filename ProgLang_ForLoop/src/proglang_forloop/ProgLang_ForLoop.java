/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proglang_forloop;

import java.util.List;
import java.util.Scanner;

/**
 *
 * @author Carlo
 */
public class ProgLang_ForLoop {
    //TITE
    //NI CARLUE
    //VOTE BBM
    //MAMINKMINK
    //123
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        LexicalAnalyzer la = new LexicalAnalyzer();
        //SyntaxAnalyzer sa = new SyntaxAnalyzer();
        
        // TODO code application logic here
        Scanner in = new Scanner(System.in);
        
        //INPUT FILE NALANG DAPAT INSTEAD OF SYSTEM.IN
        
        System.out.println("TEST: ");
        String s = in.nextLine();
        
        
        List<Token> rawr = la.lex(s);
        for(int i=0; i<rawr.size(); i++) {
            System.out.println(rawr.get(i).toString()+" ");
        }  
    }
    
}
