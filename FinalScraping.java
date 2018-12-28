import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class FinalScraping {
	private static final String COMMA_DELIMITER = ",";
	private static final String NEW_LINE_SEPARATOR = "\n";
	
	private static final String FILE_HEADER = "Player Index, Differences, Age";
	public static void main(String[] args) throws IOException { 
		OverallStore17 store17 = new OverallStore17(new File("gustav.csv")); 
		OverallStore18 store18 = new OverallStore18(new File("tristan.csv")); 
		//int size = store17.allInstances().size(); 
		ArrayList<Integer> differences = new ArrayList<Integer>(); 
		ArrayList<Integer> indexNumbers = new ArrayList<Integer>(); 
		ArrayList<Integer> ages = new ArrayList<Integer>(); 
		//System.out.println(size);
		for(int i = 1; i < store18.allInstances().size() - 1; i++) {
			OverallPlayer player2018 = store18.allInstances().get(i); 
			String current_name = store18.allInstances().get(i).getName();  
			for(int j = 1; j < store17.allInstances().size() - 1; j++) {
				OverallPlayer player2017 = store17.allInstances().get(j); 
				int age2017 = Integer.parseInt(player2017.getAge()); 
				int age2018 = Integer.parseInt(player2018.getAge()); 
				if (player2017.getName().equals(current_name) && ((age2017 == age2018) || (age2017 == age2018 - 1))) {
					int overallScore17 = Integer.parseInt(player2017.getOverall()); 
					int overallScore18 = Integer.parseInt(player2018.getOverall());
					int difference = overallScore18 - overallScore17; 
					int age = Integer.parseInt(player2018.getAge()); 
					//System.out.println(player2017.getName());
					//System.out.println(difference);
					differences.add(difference); 
					ages.add(age); 
			}
			}
		}
		int maximum = 0;
		int minimum = 0; 
		int sum = 0;
		for(int x: differences) {
			sum+= x; 
			if (x > maximum) {
				maximum = x; 
			}
			if(x < minimum) {
				minimum = x; 
			}
		}
		//System.out.println(sum/ differences.size());
		System.out.println(maximum);
		System.out.println(minimum);
		FileWriter fileWriter = null;
		for(int i = 0; i < 20000; i++) {
			indexNumbers.add(i); 
		}
		try {
			fileWriter = new FileWriter("result.csv"); 
			fileWriter.append(FILE_HEADER.toString()); 
			fileWriter.append(NEW_LINE_SEPARATOR); 
			int i = 0; 
			for(int x: differences) {
				fileWriter.append(Integer.toString(indexNumbers.get(i))); 
				fileWriter.append(COMMA_DELIMITER); 
				fileWriter.append(Integer.toString(x)); 
				fileWriter.append(COMMA_DELIMITER); 
				fileWriter.append(Integer.toString(ages.get(i))); 
				i++; 
				fileWriter.append(NEW_LINE_SEPARATOR); 
			}
			System.out.println("CSV file created!");
		} catch (Exception e) {
			System.out.println("Error in CsvFileWriter !!!");
			e.printStackTrace();
		} finally {
			try {
				fileWriter.flush();
				fileWriter.close();
			} catch(IOException e) {
				e.printStackTrace();
			}
		}
	}
}
