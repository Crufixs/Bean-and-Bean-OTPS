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

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Scanner;

public class SyntaxAnalyzer {  
    static int np = 0;
    //Insert grammer here
    private String start = "S";
    private Production[] rules;
    private List<Production> ans_mat[][];
    private List<Token> sentence;
    
    public static void main(String args[]) {
        Scanner in = new Scanner(System.in);

        //INPUT FILE NALANG DAPAT INSTEAD OF SYSTEM.IN
        System.out.println("TEST: ");
        String s = in.nextLine();
        List<Token> ROARR = new ArrayList();
        ROARR.add(new Token(Type.a));
        ROARR.add(new Token(Type.a));
        ROARR.add(new Token(Type.b));
        ROARR.add(new Token(Type.a));
        SyntaxAnalyzer sanal = new SyntaxAnalyzer(ROARR);
        sanal.printAns();
        sanal.analyzeSyntax();
        sanal.printAns();
    }
    SyntaxAnalyzer(List<Token> sentence) {
        BNF_Grammar rawr = new BNF_Grammar();
        rules = rawr.getGrammar();
        this.sentence = sentence;
        ans_mat = new List[sentence.size()][sentence.size()];
        Token word;   
        
        for(int j=0; j < rules.length;j++) {
            if(rules[j]==null) {
                System.out.print("null ");
            } else {
                System.out.print(rules[j] + "" + j + ", "); 
            }
            System.out.print("\t");
        }
        System.out.println();
        
        //Fill the diagnol of the matrix (first iteration of algorithm)
        for(int i = 0; i < sentence.size(); i++){
            word = sentence.get(i);
            List<Production> r = new ArrayList();
            for(int j = 0; j < rules.length; j++){
                List list = rules[j].getRules();
                for (Iterator<List<Type>> iter = list.iterator(); iter.hasNext(); ) {
                    List<Type> rule = iter.next();
                    for (Iterator<Type> iter2 = rule.iterator(); iter2.hasNext(); ) {
                        Type ASDMKop = iter2.next();
                        if(ASDMKop==word.getType()){
                            r.add(rules[j]);
                        }
                    }   
                }   
            }
            ans_mat[i][i] = r;
        }
    }
    //Checks if the passed string can be achieved for the grammer
    private List<Production> check(List<Type> a){
        List<Production> to_ret = new ArrayList();
        for(int i = 0; i < rules.length; i++){
            List list = rules[i].getRules();
            /*
            List<Type> test = new ArrayList();
            test.add(rules[i].getToken().getType());
            if(test.equals(a)) {
                to_ret.add(rules[i]);
            }
            */
            for (Iterator<List<Type>> iter = list.iterator(); iter.hasNext(); ) {
                List<Type> rule = iter.next();
                if(a.equals(rule)) {
                    to_ret.add(rules[i]);
                }
            }   
        }
        return to_ret;
    }    

    //Makes all possible combinations out of the two string passed
    private List<Production> combinat(List<Production> a, List<Production> b){
        List<Production> combination = new ArrayList();
        List<Type> temp = new ArrayList();
        for(int i = 0; i < a.size(); i++){
            for(int j = 0; j < b.size(); j++){
                temp.add(a.get(i).getToken().getType());
                temp.add(b.get(j).getToken().getType());
                combination.addAll(check(temp));
            }
        }
        return combination;
    }
    
    public void analyzeSyntax () {
        //Fill the rest of the matrix
        List<Production> prod; 
        for(int i = 1; i < sentence.size(); i++){
            for(int j = i; j < sentence.size(); j++){
                prod = new ArrayList();
                for(int k = j - i; k < j; k++){
                    prod.addAll(combinat(ans_mat[j - i][k], ans_mat[k + 1][j]));
                }
                ans_mat[j - i][j] = prod;
            }
        }
        //The last column of first row should have the start symbol
        if(ans_mat[0][sentence.size() - 1].indexOf(start) >= 0){
            accept();
        }
        else{
            reject();
        }
    }
            
    public static void accept(){
        System.out.println("String is accepted");

    }
    public static void reject(){
        System.out.println("String is rejected");
 
    }

    public void printAns() {
        System.out.println();
        for(int i=0; i < ans_mat.length; i++) {  
            for(int j=0; j < ans_mat[i].length;j++) {
                if(ans_mat[i][j]==null) {
                    System.out.print("null ");
                } else {
                    for(Iterator<Production> iter = ans_mat[i][j].iterator(); iter.hasNext(); ) {
                        Production rule = iter.next();
                        System.out.print(rule + ",");
                    }   
                }
                System.out.print("\t\t");
            }
            System.out.println();
        }
    }
}
