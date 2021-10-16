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
public class Production extends Token{
    private List<List<Type>> rules;

    public Production (Type t) {
        super(t);
        rules = new ArrayList();   
    }
    
    public Production (Type t, List<Type>... rule) {
        super(t);
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
    
    public String toString() {
        return super.toString();
    }
}
