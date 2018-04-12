package Servletwright;

import java.io.IOException;
import java.sql.ResultSet;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.DriverManager;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import DTO.dpj;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

public class servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		String sql = "select id,data,CURRENT_TIME time from dpj";
		String sql = "select * from dpj";
		Connection conn = null;// 代表当前数据库链接
		Statement st = null;// 向数据库发送SQL语句
		ResultSet rs = null;// 代表结果集
		// List<JSONObject> jsonarray= new ArrayList<JSONObject>();
		// 设置响应内容类型
		// 设置响应内容类型
		resp.setContentType("text/json; charset=utf-8");
		PrintWriter out = resp.getWriter();
		try {
			Class.forName("com.mysql.jdbc.Driver");// 注册MySQLjdbc驱动程序
			conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "123456");
			st = (Statement) conn.createStatement();// 创建对象
			rs = st.executeQuery(sql);
			JSONArray jsonarray = new JSONArray();
			JSONObject jsonobj = new JSONObject();

			while (rs.next()) {
				// java.sql.Timestamp d1 = rs.getTimestamp(3);
				// System.out.println(new SimpleDateFormat("yyyy-MM-dd
				// HH:mm:ss")
				// .format(d1));
				// 通过字段检索
//				jsonobj.put("myid", rs.getString("id"));
				jsonobj.put("voltage", rs.getString("data"));
				 jsonobj.put("currenttime", rs.getString("time"));
				jsonarray.add(jsonobj);
			}
			// 输出数据
			resp.setContentType("text/json;charset=utf-8");
			resp.setCharacterEncoding("utf-8");
			out = resp.getWriter();
			out.println(jsonarray);
			// out.write(jsonarray.to);
			// 完成后关闭
			rs.close();
			st.close();
			conn.close();
		} catch (Exception e) {
			out.print("get data error!");
			e.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}
	// request.setCharacterEncoding("utf-8");
	// ArrayList<dpj> infos=new TimeTest().getInfoForCharacter();
	// String result=newJSONArray(infos).toString();
	//
	// response.setContentType("text/plain;charset=utf-8");
	// response.setCharacterEncoding("utf-8");
	// PrintWriter out = response.getWriter();
	// out.print(result);
}
