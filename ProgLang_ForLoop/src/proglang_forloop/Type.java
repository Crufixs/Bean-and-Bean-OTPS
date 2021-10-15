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
public enum Type{
    S, A, B, C, a, b, c,
    
    //CONDITIONS
    CONDITIONS, BOOL_EXPRESSION, BOOL_TERM, LOGICAL_OP, LOGICAL_NOT, COMPARISON_OP, 
    BOOL_VALUE, BOOL_OP,
    
    //
    H0,H1,H2,H3,H4,H5,
    
    EMPTY_SET,
    //ETO YUNG MGA TOKENS
    OPEN_PARENTHESIS, CLOSE_PARENTHESIS, KEYWORD, NAME , ARITHMETIC_OP, FOR, SEMICOLON, 
    OPEN_BRACKET, CLOSE_BRACKET, SEMI_COLON, COMMA, BOOL_VAR, 
    ;
}
