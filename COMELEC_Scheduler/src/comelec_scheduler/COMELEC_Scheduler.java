package comelec_scheduler;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

public class COMELEC_Scheduler {
    public static void main(String... args) {
        String path = "C:\\Users\\Carlo\\Dropbox\\My PC (DESKTOP-KM6VH5E)\\Documents\\NetBeansProjects\\Prog-Lang-Proj\\COMELEC.csv";
        String line = "";
        String[][] schedule = new String[100][];
        
        try {
            BufferedReader br = new BufferedReader(new FileReader(path));
            int i = 0;
            while ((line = br.readLine()) != null) {
                System.out.println(line);
                String[] values = line.split(",");
                schedule[i] = values;
                i++;
            }
        } catch (FileNotFoundException e ) {
            e.printStackTrace();
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }
        
        for(int i = 0; i < schedule.length; i++ ) {
            
        }
    }

}
