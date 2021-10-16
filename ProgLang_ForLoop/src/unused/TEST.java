/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package unused;

/**
 *
 * @author Carlo
 */
public class TEST {
    enum Test {
        a;
    }
    public static void main (String args[]) {
        String rawr = "rawr";
        //rawr++;       EXPLAIN KO MAMAYA RAWR
        
        //String input = new file("tite");
        
        System.out.println(rawr);
        for(int f = 0; ; f++) {
            System.out.println(Test.a.toString());
            break;
        }
        boolean b;
        //bool_expression -> bool_expression bool_op bool_term | bool_term
        //bool_term -> primitive_comparison | String comparison | boolean_comparison
        //primitive_comparison -> primitive_val comparison_op primitive val

        //b = "q">"q";    //incomparable
        b = "q"=="q";
        //b = "q"&"q";    //logical op
        //b = 'q'>"q";    //invalid data type
        b = 'q'>'q';
        b = 't'=='t';
        //b = 't'&'t';    //logical op
        b = '3' > 3;
        b = 3 > 2.9;
        b = 5.99f > 6;
        b = '3' == 3.52f;
        //b = true == 3.53f;
        //b = '3' > 3 == '3'<4 == "s"=="f";
        
        for(String s = new String();true || true; s = new String()) {
            System.out.println(Test.a.toString());
            break;
        }

        
        
    }
}
