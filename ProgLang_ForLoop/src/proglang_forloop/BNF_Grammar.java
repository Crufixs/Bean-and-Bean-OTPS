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

    };  

    private Production forLoop[] = {
        //FORLOOP
    };
    private Production initDeclare[] = {
        new Production(Type.INIT_DECLARE, init(Type.H0, Type.DECLARATION), init(Type.EMPTY_SET),init(Type.H1, Type.DECLARATION),init(Type.ASSIGNMENT)),
        new Production(Type.DECLARATION, init(Type.H1, Type.DECLARATION), init(Type.ASSIGNMENT)),
        new Production(Type.H0, init(Type.DATA_TYPE)),
        new Production(Type.H1, init(Type.DECLARATION,Type.H2)),
        new Production(Type.H2, init(Type.COMMA))
        //INITDECLARE
    };
    private Production inc_dec[] = {
        //INC_DEC
    };
    
    public Production[] getConditionGrammar() {
        return condition;
    }
    public Production[] getForLoopGrammar() {
        return forLoop;
    }
    public Production[] getInitDeclare() {
        return initDeclare;
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
