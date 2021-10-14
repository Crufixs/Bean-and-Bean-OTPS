/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proglang_forloop;

/**
 *
 * @author Carlo
 */

/* Example
    S->AB|BC      {"S", "AB", "BC"}
    A->BA|a       {"A", "BA", "a"}
    B->CC|b       {"B", "CC", "b"}
    C->AB|a       {"C", "AB", "a"}
So, the grammer[][] is {
    {"S", "AB", "BC"}, 
    {"A", "BA", "a"}, 
    {"B", "CC", "b"}, 
    {"C", "AB", "a"}
   }
*/

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Scanner;

public class SyntaxAnalyzer {  
    static int np = 0;
    //Insert grammer here
    static String grammer[][] = {{"S", "AB", "BC"}, {"A", "BA", "a"}, {"B", "CC", "b"}, {"C", "AB", "a"}};
    private String start = "S";
    private Production[] rules;
    private List<Token> ans_mat[][];
    private List<Token> sentence;
    
    SyntaxAnalyzer(List<Token> sentence) {
        BNF_Grammar rawr = BNF_Grammar();
        rules = rawr.getGrammar();
        this.sentence = sentence;
        ans_mat = new List[sentence.size()][sentence.size()];
         Token word;   
        //Fill the diagnol of the matrix (first iteration of algorithm)
        for(int i = 0; i < sentence.size(); i++){
            word = sentence.get(i);
            List<Token> r = new ArrayList();
            for(int j = 0; j < rules.length; j++){
                List list = rules[j].getRules();
                for (Iterator<List<Type>> iter = list.iterator(); iter.hasNext(); ) {
                    List<Type> rule = iter.next();
                    for (Iterator<Type> iter2 = list.iterator(); iter2.hasNext(); ) {
                        Type ASDMKop = iter2.next();
                        if(ASDMKop==word.getType()){
                            r.add(rules[j].getToken());
                        }
                    }   
                }   
            }
            ans_mat[i][i] = r;
        }
    }
    //Checks if the passed string can be achieved for the grammer
    static String check(String a){
        String to_ret = "";
        int count = 0;
        for(int i = 0; i < np; i++) {
            for(count = 0; count < grammer[i].length; count++){
                if(grammer[i][count].equals(a)){
                    to_ret += grammer[i][0];
                }
            }
        }
        return to_ret;
    }    
    
    //Makes all possible combinations out of the two string passed
    static String combinat(String a, String b){
        String to_ret = "", temp = "";
            for(int i = 0; i < a.length(); i++){
                for(int j = 0; j < b.length(); j++){
                    temp = "";
                    temp += a.charAt(i) + "" +  b.charAt(j);
                    to_ret += check(temp);
                }
            }
        return to_ret;
    }
    
    public boolean analyzeSyntax () {
        //Fill the rest of the matrix
        for(int i = 1; i < str.length(); i++){
            for(int j = i; j < str.length(); j++){
                r = "";
                for(int k = j - i; k < j; k++){
                    r += combinat(ans_mat[j - i][k], ans_mat[k + 1][j]);
                }
                ans_mat[j - i][j] = r;
            }
        }

        //The last column of first row should have the start symbol
        if(ans_mat[0][str.length() - 1].indexOf(start) >= 0){
            accept();
        }
        else{
            reject();
        }
        return true;
    }
            
    
    public static void accept(){
        System.out.println("String is accepted");
        System.exit(0);
    }
    public static void reject(){
        System.out.println("String is rejected");
        System.exit(0);
    }
    
    public static void printAns(String[][] ans_mat) {
        System.out.println();
        for(int i=0; i < ans_mat.length; i++) {  
            for(int j=0; j < ans_mat[i].length;j++) {
                System.out.print(ans_mat[i][j]+"\t");
            }
            System.out.println();
        }
    }

    private BNF_Grammar BNF_Grammar() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
