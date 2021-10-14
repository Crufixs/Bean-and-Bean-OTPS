/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proglang_forloop;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Carlo
 */
public class Production{
    private final Token t;
    private List<List<Type>> rules;
    
    public Production (Token t) {
        this.t = t;
        rules = new ArrayList();   
    }
    public Production (Token t, List<Type>... rule) {
        this.t = t;
        rules = new ArrayList();
        for(List<Type> rawr : rule) {
            rules.add(rawr);
        }
    }
    
    public void setRules (List<Type>... rule) {
        rules = new ArrayList();
        for(List<Type> rawr : rule) {
            rules.add(rawr);
        }
    }
    
    public List<List<Type>> getRules() {
        return rules;
    }
    
    public Token getToken() {
        return t;
    }
    
    public String toString() {
        return t.toString();
    }
}
