/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proglang_forloop;

import javax.lang.model.SourceVersion;

/**
 *
 * @author Carlo
 */
public class Token {
    private final Type t;
    private final String c; // contents mainly for atom tokens
    // could have column and line number fields too, for reporting errors later
    public Token(Type t, String c) {
        this.t = t;
        this.c = c;
    }
    
    public Token(Type t){
        this.t = t;
        this.c = null;
    }
    
    public Type getType() {
        return t;
    }
    
    public String toString() {
        return c+"\t"+t;
    }
}
