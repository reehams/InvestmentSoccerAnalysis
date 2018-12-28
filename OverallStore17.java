import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

public class OverallStore17 {
	private ArrayList<OverallPlayer> list; 
	public Scanner in; 
	public File dataFile; 
	public ArrayList<String> namelist; 
	
	public OverallStore17(File file) throws IOException {
		list = new ArrayList<OverallPlayer>(); 
		namelist = new ArrayList<String>(); 
		dataFile = file; 
		in = new Scanner(dataFile); 
		readDataFile(); 
	}
	public ArrayList<OverallPlayer> allInstances() {
		return list; 
	}
	public void readDataFile() {
		try {
			in.useDelimiter(","); 
			while(in.hasNext()) {
				OverallPlayer soccer_player = createInstance(); 
				list.add(soccer_player); 
				namelist.add(soccer_player.getName()); 
			}
			System.out.println(namelist.size());
		}
		catch (Exception e) {
			e.printStackTrace();
			
		}
	}
	public OverallPlayer createInstance() {
		String Name = in.next();
		String [] lineSplit = Name.split(" "); 
		String lastName = " "; 
		String firstName = " "; 
		if(lineSplit.length > 0) {
			firstName = lineSplit[0]; 
			lastName = lineSplit[lineSplit.length - 1]; 
		}
		else {
			firstName = ""; 
			lastName = Name; 
		}
		//System.out.println(firstName);
		String official_first_name = firstName.substring(0, 1); 
		String official_name = official_first_name+lastName; 
		//System.out.println(official_name);
		String overall = in.next(); 
		String final_overall = overall.substring(0,overall.length()); 
		String age = in.nextLine(); 
		String final_age = age.substring(1,age.length()); 
		return new OverallPlayer(official_name, final_overall, final_age);
	}
}
