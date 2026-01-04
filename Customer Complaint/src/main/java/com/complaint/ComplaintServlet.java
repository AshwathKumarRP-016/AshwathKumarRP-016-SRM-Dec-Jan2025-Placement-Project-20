package com.complaint;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;


@SuppressWarnings("serial")
@WebServlet("/ComplaintServlet")
public class ComplaintServlet extends HttpServlet {
	 protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        String name = request.getParameter("name");
	        String complaint = request.getParameter("complaint");

	        try {
	            Class.forName("com.mysql.cj.jdbc.Driver");

	            Connection con = DriverManager.getConnection(
	                "jdbc:mysql://localhost:3306/complaintdb", "root", "root");

	            String sql = "INSERT INTO complaints (name, complaint) VALUES (?, ?)";
	            PreparedStatement ps = con.prepareStatement(sql);
	            ps.setString(1, name);
	            ps.setString(2, complaint);

	            ps.executeUpdate();
	            con.close();

	            response.sendRedirect("viewStatus.jsp");

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

}
