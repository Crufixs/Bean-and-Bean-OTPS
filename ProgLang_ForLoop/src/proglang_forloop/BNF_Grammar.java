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
public class BNF_Grammar {
    List<Type> placeholder;
    private Production grammar[]  /*
        {new Production(new Token(Type.S), initList(Type.A, Type.B), initList(Type.B, Type.C)),
        new Production(new Token(Type.A), initList(Type.B, Type.A), initList(Type.a)),
        new Production(new Token(Type.B), initList(Type.C, Type.C), initList(Type.b)),
        new Production(new Token(Type.C), initList(Type.A, Type.B), initList(Type.a))
        }; */
            
        = {new Production(new Token(Type.CONDITIONS), init(Type.EMPTY_SET), init(Type.H0, Type.BOOL_TERM), init(Type.H2, Type.H1), init(Type.H3, Type.BOOL_TERM), init(Type.BOOL_VAR), init(Type.BOOL_VALUE)),
        new Production(new Token(Type.BOOL_EXPRESSION), init(Type.H0, Type.BOOL_TERM), init(Type.H2, Type.H1), init(Type.H3, Type.BOOL_TERM), init(Type.BOOL_VAR), init(Type.BOOL_VALUE)),
        new Production(new Token(Type.BOOL_TERM), init(Type.BOOL_VAR), init(Type.BOOL_VALUE)),
        new Production(new Token(Type.BOOL_OP), init(Type.COMPARISON_OP), init(Type.LOGICAL_OP)),
        new Production(new Token(Type.H0), init(Type.BOOL_EXPRESSION, Type.BOOL_OP)),
        new Production(new Token(Type.H1), init(Type.CLOSE_PARENTHESIS)),
        new Production(new Token(Type.H2), init(Type.H4, Type.BOOL_EXPRESSION)),
        new Production(new Token(Type.H3), init(Type.LOGICAL_NOT)),
        new Production(new Token(Type.H4), init(Type.OPEN_PARENTHESIS)),
        };  
        /*{"A", "BA", "a"}, 
        {"B", "CC", "b"}, 
        {"C", "AB", "a"}};*/
        
    
    public Production[] getGrammar() {
        return grammar;
    }
    
    public static List<Type> init(Type... type) {
        List<Type> rawr = new ArrayList();
        for(Type t : type) {
            rawr.add(t);
        }
        return rawr;
    }
    
}
