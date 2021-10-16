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
    private Production condition[] = {
        new Production(Type.CONDITIONS, init(Type.EMPTY_SET), init(Type.H0, Type.BOOL_TERM), init(Type.H2, Type.H1), init(Type.H3, Type.BOOL_TERM), init(Type.BOOL_VAR), init(Type.BOOL_VALUE)),
        new Production(Type.BOOL_EXPRESSION, init(Type.H0, Type.BOOL_TERM), init(Type.H2, Type.H1), init(Type.H3, Type.BOOL_TERM), init(Type.BOOL_VAR), init(Type.BOOL_VALUE)),
        new Production(Type.BOOL_TERM, init(Type.BOOL_VAR), init(Type.BOOL_VALUE)),
        new Production(Type.BOOL_OP, init(Type.COMPARISON_OP), init(Type.LOGICAL_OP)),
        new Production(Type.H0, init(Type.BOOL_EXPRESSION, Type.BOOL_OP)),
        new Production(Type.H1, init(Type.CLOSE_PARENTHESIS)),
        new Production(Type.H2, init(Type.H4, Type.BOOL_EXPRESSION)),
        new Production(Type.H3, init(Type.LOGICAL_NOT)),
        new Production(Type.H4, init(Type.OPEN_PARENTHESIS))
    };  

    private Production forLoop[] = {
        //FORLOOP
    };
    private Production initDeclare[] = {
        //INITDECLARE
    };
    private Production inc_dec[] = {
        //INC_DEC
    };
    
    public Production[] getConditionGrammar() {
        return condition;
    }
    public Production[] getForLoopGrammar() {
        return condition;
    }
    public Production[] getInitDeclare() {
        return condition;
    }
    public Production[] getInc_Dec() {
        return inc_dec;
    }
    
    public static List<Type> init(Type... type) {
        List<Type> rawr = new ArrayList();
        for(Type t : type) {
            rawr.add(t);
        }
        return rawr;
    }
    
}
