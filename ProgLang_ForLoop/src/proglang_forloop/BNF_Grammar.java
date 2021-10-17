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
        new Production(Type.CONDITIONS, init(Type.EMPTY_SET), init(Type.H0, Type.BOOL_TERM), init(Type.H1, Type.BOOL_TERM), init(Type.BOOL_VALUE), init(Type.H2, Type.BOOL_TERM), init(Type.H4, Type.H3), init(Type.BOOL_VAR), init(Type.BOOL_VALUE), init(Type.H6, Type.H5), init(Type.STRING), init(Type.H7, Type.PRIMITIVE_VALUE), init(Type.NUM_VALUE), init(Type.STRING_VALUE), init(Type.CHAR_VALUE), init(Type.PRIMITIVE_VAR)),
        new Production(Type.BOOL_EXPRESSION, init(Type.H0, Type.BOOL_TERM), init(Type.H1, Type.BOOL_TERM), init(Type.BOOL_VALUE), init(Type.H2, Type.BOOL_TERM), init(Type.H4, Type.H3), init(Type.BOOL_VAR), init(Type.BOOL_VALUE), init(Type.H6,Type.H5), init(Type.STRING), init(Type.H7, Type.PRIMITIVE_VALUE), init(Type.NUM_VALUE), init(Type.STRING_VALUE), init(Type.CHAR_VALUE), init(Type.PRIMITIVE_VAR)),
        new Production(Type.BOOL_TERM, init(Type.BOOL_VALUE), init(Type.H2,Type.BOOL_TERM), init(Type.H4, Type.H3), init(Type.BOOL_VAR), init(Type.BOOL_VALUE), init(Type.H7, Type.PRIMITIVE_VALUE), init(Type.NUM_VALUE), init(Type.STRING_VALUE), init(Type.CHAR_VALUE), init(Type.PRIMITIVE_VAR), init(Type.H6, Type.H5), init(Type.STRING)),
        new Production(Type.PRIMITIVE_COMPARISON, init(Type.H7,Type.PRIMITIVE_VALUE), init(Type.NUM_VALUE), init(Type.STRING_VALUE), init(Type.CHAR_VALUE), init(Type.PRIMITIVE_VAR)),
        new Production(Type.STRING_COMPARISON, init(Type.H6,Type.H5), init(Type.STRING)),
        new Production(Type.PRIMITIVE_VALUE, init(Type.NUM_VALUE), init(Type.STRING_VALUE), init(Type.CHAR_VALUE), init(Type.PRIMITIVE_VAR)),
        new Production(Type.H0, init(Type.BOOL_EXPRESSION,Type.H8)),
        new Production(Type.H1, init(Type.BOOL_EXPRESSION, Type.H9)),
        new Production(Type.H2, init(Type.LOGICAL_NOT)),
        new Production(Type.H3, init(Type.CLOSE_PARENTHESIS)),
        new Production(Type.H4, init(Type.H10), init(Type.BOOL_TERM)),
        new Production(Type.H5, init(Type.STRING)),
        new Production(Type.H6, init(Type.STRING_COMPARISON, Type.H9)),
        new Production(Type.H7, init(Type.PRIMITIVE_COMPARISON,Type.H11)),
        new Production(Type.H8, init(Type.LOGICAL_OP)),
        new Production(Type.H9, init(Type.IS_EQUAL_OP)),
        new Production(Type.H10, init(Type.OPEN_PARENTHESIS)),
        new Production(Type.H11, init(Type.COMPARISON_OP))
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
