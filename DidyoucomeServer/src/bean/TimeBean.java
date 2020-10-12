package bean;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeBean {
	public String getTime() {
		SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
		
		Date time = new Date();
		
		return format.format(time);
	}
}
