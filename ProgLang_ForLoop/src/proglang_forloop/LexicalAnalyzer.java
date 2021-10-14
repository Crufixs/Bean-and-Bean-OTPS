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
public class LexicalAnalyzer {
    public static String getIdentifier(String s, int i) {
        int j = i;
        while(j < s.length()) {
            if(Character.isJavaIdentifierPart(s.charAt(j))) {
                j++;
            } else {
                return s.substring(i, j);
            }
        };
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
}
