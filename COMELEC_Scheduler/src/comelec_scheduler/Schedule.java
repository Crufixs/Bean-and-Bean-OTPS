/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comelec_scheduler;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Carlo
 */
public class Schedule {
    private ArrayList<TimeBlock> Monday;
    private ArrayList<TimeBlock> Tuesday;
    private ArrayList<TimeBlock> Wednessday;
    private ArrayList<TimeBlock> Thursday;
    private ArrayList<TimeBlock> Friday;
    private ArrayList<TimeBlock> Saturday; 
    
    Schedule (String[][] schedMatrix) {
        //RAWR
    }
    
    ArrayList<TimeBlock> getMonday() {
        return Monday;
    }
    ArrayList<TimeBlock> getTuesday() {
        return Tuesday;
    }
    ArrayList<TimeBlock> getWednessday() {
        return Wednessday;
    }
    ArrayList<TimeBlock> getThursday() {
        return Thursday;
    }
    ArrayList<TimeBlock> getFriday() {
        return Friday;
    }
    ArrayList<TimeBlock> getSaturday() {
        return Saturday;
    }
}


class TimeBlock {
    int lowerBound;
    int upperBound;
    
    TimeBlock(int lowerBound, int upperBound) {
        this.lowerBound = lowerBound;
        this.upperBound = upperBound;
    }
}

