package dyc.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Properties;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dyc.action.Action;

/**
 * Servlet implementation class APIController
 */
@WebServlet(
		urlPatterns = { 
				"/APIController", 
				"*.api"
		}, 
		initParams = { 
				@WebInitParam(name = "propertyConfig", value = "apiMapping.properties")
		})
public class APIController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HashMap<String, Object> commandMap = new HashMap<String, Object>();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public APIController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		//initParams�뿉�꽌 propertyConfig�쓽 媛믪쓣 �씫�뼱�샂
		String props = config.getInitParameter("propertyConfig");
		String realFolder = "/property"; //properties�뙆�씪�씠 ���옣�맂 �뤃�뜑
		//�쎒�뼱�뵆由ъ��씠�뀡 猷⑦듃 寃쎈줈
		ServletContext context = config.getServletContext();
		//realFolder瑜� �쎒�뼱�뵆由ъ��씠�뀡 �떆�뒪�뀥�긽�쓽 �젅��寃쎈줈濡� 蹂�寃�
		String realPath = context.getRealPath(realFolder) +File.separator+props;
							    
		//紐낅졊�뼱�� 泥섎━�겢�옒�뒪�쓽 留ㅽ븨�젙蹂대�� ���옣�븷 Properties媛앹껜 �깮�꽦
		Properties pr = new Properties();
		FileInputStream f = null;
		try{
			//command.properties�뙆�씪�쓽 �궡�슜�쓣 �씫�뼱�샂
			f = new FileInputStream(realPath); 
			//command.properties�쓽 �궡�슜�쓣 Properties媛앹껜 pr�뿉 ���옣
			pr.load(f);
		}catch (IOException e) {
			e.printStackTrace();
		}finally {
			if (f != null) try { f.close(); } catch(IOException ex) {}
		}
		//Set媛앹껜�쓽 iterator()硫붿냼�뱶瑜� �궗�슜�빐 Iterator媛앹껜瑜� �뼸�뼱�깂
		Iterator<?> keyIter = pr.keySet().iterator();
		//Iterator媛앹껜�뿉 ���옣�맂 紐낅졊�뼱�� 泥섎━�겢�옒�뒪瑜� commandMap�뿉 ���옣
		while( keyIter.hasNext() ) {
			String command = (String)keyIter.next();
			String className = pr.getProperty(command);
			try{
				Class<?> commandClass = Class.forName(className);
				Object commandInstance = commandClass.getDeclaredConstructor().newInstance();
				commandMap.put(command, commandInstance);
			}catch (ClassNotFoundException|NoSuchMethodException|InvocationTargetException e) {
				e.printStackTrace();
			}catch (InstantiationException|IllegalAccessException e) {
				e.printStackTrace();
			}
		}	
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		requestProcess(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		requestProcess(request, response);
	}
	
	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		requestProcess(req, resp);
	}
	
	private void requestProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String result = null;
		Action action=null;
		
		response.setCharacterEncoding("utf-8");
        response.setContentType("application/json");
		
		try {
			String command = request.getRequestURI();
	        if(command.indexOf(request.getContextPath()) == 0) 
	           command = command.substring(request.getContextPath().length());
	        action = (Action)commandMap.get(command);  
	        if(action == null)
	        	result = "";
	        else
	        	result = action.requestProcess(request, response);
		}catch(Throwable e) {
			e.printStackTrace();
		}
		PrintWriter out = response.getWriter();
		out.write(result);
		out.flush();
		out.close();
	}

}
