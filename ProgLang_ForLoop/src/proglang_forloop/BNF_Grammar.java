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
    private Production grammar[] = 
        {new Production(new Token(Type.A), initList(Type.B, Type.A), initList(Type.a)),
        new Production(new Token(Type.B), initList(Type.C, Type.C), initList(Type.b)),
        new Production(new Token(Type.C), initList(Type.C, Type.C), initList(Type.a))
        }; 
        /*{"A", "BA", "a"}, 
        {"B", "CC", "b"}, 
        {"C", "AB", "a"}};
        <conditions> -> {}
                      | H0 <boolean_term>
                      | H2 H1
                      | H3 <boolean_term>
                      | <bool_var>
                      | true
                      | false
<boolean_expression> -> H0 <boolean_term>
                      | H2 H1
                      | H3 <boolean_term>
                      | <bool_var>
                      | true
                      | false
      <boolean_term> -> <bool_var>
                      | true
                      | false
  <boolean_operator> -> <
                      | >
                      | ==
                      | !=
                      | <=
                      | >=
                      | &&
                      | ||
                  H0 -> <boolean_expression> <boolean_operator>
                  H1 -> )
                  H2 -> H4 <boolean_expression>
                  H3 -> !
                  H4 -> (*/
    
    public Production[] getGrammar() {
        return grammar;
    }
    
    public static List<Type> initList(Type... type) {
        List<Type> rawr = new ArrayList();
        for(Type t : type) {
            rawr.add(t);
        }
        return rawr;
    }
    
}
