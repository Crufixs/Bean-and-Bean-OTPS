/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proglang_forloop;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import javax.lang.model.SourceVersion;
/**
 *
 * @author Carlo
 */
public class ConditionChecker {
    private static enum Type{
        //ETO YUNG MGA TOKENS
        OPEN_PARENTHESIS, CLOSE_PARENTHESIS, KEYWORD, NAME ,
        ARITHMETIC_OP, LOGICAL_OP, LOGICAL_NOT, COMPARISON_OP;
    }

    public static class Token {
        SourceVersion sc = SourceVersion.RELEASE_8;
       
        public final Type t;
        public final String c; // contents mainly for atom tokens
        // could have column and line number fields too, for reporting errors later
        public Token(Type t, String c) {
            this.t = t;
            this.c = c;
        }
        public String toString() {
            return c+"\t"+t;
        }
    }
    
    public static class Production{
        public final Type t;
        public final List<Token> rules;
        
        public Production (Type t, Token... token) {
            this.t = t;
            rules = new ArrayList();
            for(Token test : token) {
                rules.add(test);
            }      
        }
    }
    
    public static String getIdentifier(String s, int i) {
        int j = i;
        for( ; j < s.length(); ) {
            if(Character.isJavaIdentifierPart(s.charAt(j))) {
                j++;
            } else {
                return s.substring(i, j);
            }
        }
        return s.substring(i, j);
    }
    
    public static List<Token> lex(String input) {
        List<Token> result = new ArrayList<Token>();
        for(int i = 0; i < input.length(); ) {
            char current = input.charAt(i);
            if(current=='(') {
                //OPEN CLOSE PARENTHESIS
                result.add(new Token(Type.OPEN_PARENTHESIS, ""+current));
                i++;
            } else if(current==')') {
                // CLOSE PARENTHESIS
                result.add(new Token(Type.CLOSE_PARENTHESIS, ""+current));
                i++;
            }else if(current=='+'||current=='*'||current=='/'||current=='-'||current=='^') {
                // ARITHMETIC OPERATORS
                result.add(new Token(Type.ARITHMETIC_OP, ""+current));
                i++;
            } else if (current=='<'||current=='>'||current=='='||current=='!'||current=='&'||current=='|') {
                // COMPARISON AND LOGICAL OPERATORS
                char next = input.charAt(i+1);
                String operator ="";
                if(current=='!') { 
                    if(next=='=') {
                        operator = ""+current+next;
                        result.add(new Token(Type.LOGICAL_OP,operator));
                    } else {
                        operator = ""+current;
                        result.add(new Token(Type.LOGICAL_NOT,operator));
                    }
                } else if(current=='<'||current=='>'||current=='=') {
                    if(next=='=') {
                        operator = ""+current+next;
                        result.add(new Token(Type.COMPARISON_OP,operator));
                    } else {
                        operator = ""+current;
                        result.add(new Token(Type.COMPARISON_OP,operator));
                    }
                } else if(current=='|'||current=='&'){
                    if(next==current) {
                        operator = ""+current+next;
                        result.add(new Token(Type.LOGICAL_OP,operator));
                    } else {
                    operator = ""+current;
                    result.add(new Token(Type.LOGICAL_OP,operator));
                    }
                }
                i += operator.length();            
            } else if(Character.isWhitespace(current)) {
                i++;
            } else if (Character.isJavaIdentifierStart(current)){
                String ident = getIdentifier(input, i);
                i += ident.length();
                if(SourceVersion.isName(ident)) {
                    result.add(new Token(Type.NAME, ident));
                } else if (SourceVersion.isKeyword(ident)) {
                    result.add(new Token(Type.KEYWORD, ident));
                }
            }
        }
        //if()
        return result;
    }
   
    public static void main(String args[]) { 
        Scanner in = new Scanner(System.in);
        System.out.println("TEST: ");
        String s = in.nextLine();
        List<Token> rawr = lex(s);
        for(int i=0; i<rawr.size(); i++) {
            System.out.println(rawr.get(i).toString()+" ");
        }     
    }
    
    
    
}
