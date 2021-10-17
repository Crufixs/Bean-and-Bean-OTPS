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
    COND, BOOL_EXPR, BOOL_TERM, LOGICAL_OP, LOGICAL_NOT, COMPARISON_OP,
    BOOL_VALUE, BOOL_OP, IS_EQUAL_OP,//INSERTED IS_EQUAL_OP
    
    //Init_declare
    INIT_DECLARE, DECLARATION,
    
    //NEWLY ADDED
    PRIMITIVE_COMPARISON, PRIMITIVE_VALUE, STRING_COMPARISON, STRING, NUM_VALUE, STRING_VALUE, CHAR_VALUE,
    INC_DEC, INCREMENTATION, ASSIGNMENT, VAR, 

    //
    H0,H1,H2,H3,H4,H5,H6,H7,H8,H9,H10,H11,

    EMPTY_SET,
    //ETO YUNG MGA TOKENS
    OPEN_PARENTHESIS, CLOSE_PARENTHESIS, KEYWORD, NAME , ARITHMETIC_OP, FOR, SEMICOLON, DATA_TYPE, //ADDED DATA_TYPE
    OPEN_BRACKET, CLOSE_BRACKET, SEMI_COLON, COMMA,INCREMENTATION_OP, ASSIGNMENT_OP //ADDED ITERATION OP
    ;
}