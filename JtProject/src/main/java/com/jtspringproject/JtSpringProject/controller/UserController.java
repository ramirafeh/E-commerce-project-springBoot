package com.jtspringproject.JtSpringProject.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import static com.jtspringproject.JtSpringProject.controller.AdminController.userID;
import static com.jtspringproject.JtSpringProject.controller.AdminController.usernameforclass;


@Controller
public class UserController{
	public String currentUser;
	@GetMapping("/register")
	public String registerUser()
	{
		return "register";
	}
	@GetMapping("/contact")
	public String contact()
	{
		return "contact";
	}
	@GetMapping("/buy")
	public String updateCouponsDb(@RequestParam("user_id") int id)
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			Statement stmt = con.createStatement();
			
			PreparedStatement pst = con.prepareStatement("select coupons from users where user_id = "+id+";");
			PreparedStatement pst1 = con.prepareStatement("select amount from purchases where user_id = "+id+";");
			
			if(pst.getInt(1)>1){
				pst.setInt(1)--
				pst1.setInt(1)= pst1.getInt(1)-5
			}
			
			
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/buy";
	}
	@PostMapping("/addToCart")
	public String addToCart(@RequestParam("productId") String productId, @RequestParam("quantity") String quantity)
	{
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			Statement stmt = con.createStatement();
			String query = "INSERT INTO userBaskets (user_id, product_id, product_quantity) VALUES ('"+userID+"', '"+productId+"', '"+quantity+"')";
			PreparedStatement ps = con.prepareStatement(query);
			ps.executeUpdate();
			ps.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/user/products";
	}
	@PostMapping("/removeFromCart")
	public String removeFromCart(@RequestParam("productId") String productId, @RequestParam("quantity") String quantity)
	{
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			Statement stmt = con.createStatement();
			String query = "DELETE FROM userBaskets WHERE user_id='"+userID+"' AND product_id='"+productId+"' AND product_quantity='"+quantity+"'";
			PreparedStatement ps = con.prepareStatement(query);
			ps.executeUpdate();
			ps.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/user/products";
	}

	@GetMapping("/user/products")
	public String getproduct(Model model) {
		model.addAttribute("username", usernameforclass);
		ArrayList<String[]> products= new ArrayList<String[]>();
		ArrayList<Integer> productIDs= new ArrayList<Integer>();
		ArrayList<Integer> productQtys= new ArrayList<Integer>();
		try
		{
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery("select * from userBaskets where user_id = '"+userID+"'");
			while(rst.next()) {
				productIDs.add(rst.getInt(2));
				productQtys.add(rst.getInt(3));
			}
			int counter =0;
			for(Integer productID : productIDs){
				Statement pstmt = con.createStatement();
				ResultSet prst = pstmt.executeQuery("select * from products where id = '"+productID+"'");
				while(prst.next()) {
					String[] currentProduct = new String[9];
					for(int k=1;k<=8;k++){
						currentProduct[k-1] = prst.getString(k);
					}
					currentProduct[8] = Integer.toString(productQtys.get(counter));
					products.add(currentProduct);
					counter++;
				}
			}

		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		model.addAttribute("productQtys", productQtys);
		model.addAttribute("products", products);
		return "uproduct";
	}
	@RequestMapping(value = "newuserregister", method = RequestMethod.POST)
	public String newUseRegister(@RequestParam("username") String username,@RequestParam("password") String password,@RequestParam("email") String email)
	{
		try
		{
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","pass");
			PreparedStatement pst = con.prepareStatement("insert into users(username,password,email) values(?,?,?);");
			pst.setString(1,username);
			pst.setString(2, password);
			pst.setString(3, email);


			//pst.setString(4, address);
			int i = pst.executeUpdate();
			System.out.println("data base updated"+i);

		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/";
	}
}
