
public class Player {
	private String name; 
	private String GK_preference; 
	private String CB_preference; 
	private String CM_preference; 
	private String ST_preference; 
	private String LM_preference; 
	private String RM_preference; 
	private String LB_preference; 
	private String RB_preference; 
	private String nationality; 
	
	public Player(String name, String GK_preference, String CB_preference, String CM_preference, String ST_preference, String LM_preference, String RM_preference,String LB_preference, String RB_preference, String nationality) {
		this.name = name; 
		this.GK_preference = GK_preference; 
		this.CB_preference = CB_preference; 
		this.CM_preference = CM_preference; 
		this.ST_preference = ST_preference; 
		this.LM_preference = LM_preference; 
		this.RM_preference = RM_preference; 
		this.LB_preference = LB_preference; 
		this.RB_preference = RB_preference; 
		this.nationality = nationality; 
	}
	
	public String getName() {
		return name; 
	}
	public String getGKPreference() { 
		return GK_preference; 
	}
	public String getCMPreference() { 
		return CM_preference; 
	}
	public String getCBPreference() { 
		return CB_preference; 
	}
	public String getSTPreference() { 
		return ST_preference; 
	}
	public String getLMPreference() { 
		return LM_preference; 
	}
	public String getRMPreference() { 
		return RM_preference; 
	}
	public String getLBPreference() { 
		return LB_preference; 
	}
	public String getRBPreference() { 
		return RB_preference; 
	}
	public String getNationality() {
		return nationality; 
	}
}
