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
        while (j < s.length()) {
            if (Character.isJavaIdentifierPart(s.charAt(j))) {
                j++;
            } else {
                return s.substring(i, j);
            }
        };
        return s.substring(i, j);
    }

    public static boolean checkAssign(String s, int i) {
        int j = i;
        String boolbool = "";
        for (; j < s.length() && j < i + 3; j++) {
            boolbool += "" + s.charAt(j);
        }
        return boolbool.compareTo("x=1") == 0;
    }

    public static String getDigits(String s, int i) {
        int j = i;
        while (j < s.length()) {
            if (Character.isDigit(s.charAt(j))) {
                j++;
            } else {
                return s.substring(i, j);
            }
        };
        return s.substring(i, j);
    }

    public static List<Token> lex(String input) {
        List<Token> result = new ArrayList<Token>();
        for (int i = 0; i < input.length();) {
            char current = input.charAt(i);
            if (current == '(') {
                //OPEN CLOSE PARENTHESIS
                result.add(new Token(Type.OPEN_PARENTHESIS, "" + current));
                i++;
            } else if (current == ')') {
                // CLOSE PARENTHESIS
                result.add(new Token(Type.CLOSE_PARENTHESIS, "" + current));
                i++;
            } else if (current == '{') {
                // OPEN BRACKET
                result.add(new Token(Type.OPEN_BRACKET, "" + current));
                i++;
            } else if (current == '}') {
                // CLOSE BRACKET
                result.add(new Token(Type.CLOSE_BRACKET, "" + current));
                i++;
            } else if (current == ';') {
                // SEMI COLON
                result.add(new Token(Type.SEMI_COLON, "" + current));
                i++;
            } else if (current == ',') {
                // COMMA
                result.add(new Token(Type.COMMA, "" + current));
                i++;
            } else if (current == '+' || current == '*' || current == '/' || current == '-' || current == '^') {
                // ARITHMETIC OPERATORS AND ITERATION OPERATORS
                char next = input.charAt(i + 1);
                String operator = "";
                if (current == '+' && next == '+' || current == '-' && next == '-') { //ADDED ITERATION OP UNCHECKED
                    result.add(new Token(Type.INCREMENTATION_OP, "" + operator));
                    operator = "" + current + next;
                    i += operator.length();
                } else if (current == '+' && next == '=' || current == '-' && next == '=') {
                    result.add(new Token(Type.ASSIGNMENT_OP, "" + operator));
                    operator = "" + current + next;
                    i += operator.length();
                } else {
                    result.add(new Token(Type.ARITHMETIC_OP, "" + current));
                    i++;
                }
            } else if (current == '<' || current == '>' || current == '=' || current == '!' || current == '&' || current == '|') {
                // COMPARISON AND LOGICAL OPERATORS
                char next = input.charAt(i + 1);
                String operator = "";
                if (current == '!') {
                    if (next == '=') {
                        operator = "" + current + next;
                        result.add(new Token(Type.IS_EQUAL_OP, operator)); //FROM LOGICAL OP TO IS EQUAL_OP
                    } else {
                        operator = "" + current;
                        result.add(new Token(Type.LOGICAL_NOT, operator));
                    }
                } else if (current == '<' || current == '>' || current == '=') {
                    if (current == '=' && next == '=') { //ADDED CURRENT == '='
                        operator = "" + current + next;
                        result.add(new Token(Type.IS_EQUAL_OP, operator)); //FROM COMPARISON_OP TO IS_EQUAL_OP
                    } else if (current == '<' || current == '>') {
                        if (next == '=') {
                            operator = "" + current + next;
                            result.add(new Token(Type.COMPARISON_OP, operator)); //CREATED A NEW ELSE IF FOR > AND < TO CHECK FOR COMPARISON OP
                        } else {
                            operator = "" + current;
                            result.add(new Token(Type.COMPARISON_OP, operator));
                        }

                    } else {
                        //=== ERROR TINATAMAD AKO+
                        operator = "" + current;
                        result.add(new Token(Type.ASSIGNMENT_OP, operator));
                    }
                } else if (current == '|' || current == '&') {
                    if (next == current) {
                        operator = "" + current + next;
                        result.add(new Token(Type.LOGICAL_OP, operator));
                    } else {
                        operator = "" + current;
                        result.add(new Token(Type.LOGICAL_OP, operator));
                    }
                }
                i += operator.length();
            } else if (current == 'x') {
                //ASSIGNMENT
                if (checkAssign(input, i)) {
                    result.add(new Token(Type.ASSIGNMENT, "x=1"));
                    i += 3;
                } else {
                    String ident = getIdentifier(input, i);
                    result.add(new Token(Type.VAR, ident));
                    i += ident.length();
                }

            } else if (current == '"') { //ASSIGNMENT xx1
                char next = input.charAt(i + 1);
                String operator = "" + current;
                int x = i + 1;
                while (next != '"') {
                    x++;
                    operator += next;
                    next = input.charAt(x);
                }
                operator += next;
                i += operator.length();
                result.add(new Token(Type.STRING_VALUE, operator));
            } //HANGGANG DITO xx1
            else if (current == '\'') { //ASSIGNMENT xx1
                char next = input.charAt(i + 1);
                String operator = "" + current;
                int x = i + 1;
                while (next != '\'') {
                    x++;
                    operator += next;
                    next = input.charAt(x);
                }
                operator += next;
                i += operator.length();
                result.add(new Token(Type.CHAR_VALUE, operator));
            } //HANGGANG DITO xx1
            else if (Character.isDigit(current)) { //NUM OPERATOR LABYU
                String num = getDigits(input, i);
                result.add(new Token(Type.NUM_VALUE, num));
                i += num.length();
            } else if (Character.isWhitespace(current)) {
                i++;
            } else if (Character.isJavaIdentifierStart(current)) {
                String ident = getIdentifier(input, i);
                i += ident.length();
                if (ident.equals("true") || ident.equals("false")) {
                    result.add(new Token(Type.BOOL_VALUE, ident));
                } else if (ident.equals("int") || ident.equals("double") || ident.equals("float") || ident.equals("char") || ident.equals("boolean") || ident.equals("short") || ident.equals("long")) {
                    result.add(new Token(Type.DATA_TYPE, ident));
                } else if (SourceVersion.isName(ident)) {
                    result.add(new Token(Type.VAR, ident));
                } else if (SourceVersion.isKeyword(ident)) {
                    result.add(new Token(Type.KEYWORD, ident));
                }
            }
        }
        //if()
        return result;
    }

}
