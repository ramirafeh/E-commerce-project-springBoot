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
	public int currentUser = userID;
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
	public String buy()
	{
		return "buy";
	}
	@PostMapping("/addToCart")
	public String addToCart(@RequestParam("productId") String productId, @RequestParam("quantity") String quantity)
	{
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			Statement stmt = con.createStatement();
			String query = "INSERT INTO userBaskets (user_id, product_id, product_quantity) VALUES ('"+currentUser+"', '"+productId+"', '"+quantity+"')";
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
			String query = "DELETE FROM userBaskets WHERE user_id='"+currentUser+"' AND product_id='"+productId+"' AND product_quantity='"+quantity+"'";
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
			ResultSet rst = stmt.executeQuery("select * from userBaskets where user_id = '"+currentUser+"'");
			while(rst.next()) {
				productIDs.add(rst.getInt(2));
				productQtys.add(rst.getInt(3));
			}
			int counter =0;
			for(Integer productID : productIDs){
				Statement pstmt = con.createStatement();
				ResultSet prst = pstmt.executeQuery("select * from products where id = '"+productID+"'");
				while(prst.next()) {
					String[] currentProduct = new String[10];
					for(int k=1;k<=8;k++){
						currentProduct[k-1] = prst.getString(k);
					}
					currentProduct[8] = Integer.toString(productQtys.get(counter));
					products.add(currentProduct);
					counter++;
				}
			}
			for(String[] product : products){
				System.out.println(product[0]);
				Statement stmt2 = con.createStatement();
				ResultSet rst2 = stmt2.executeQuery("SELECT p1.product_id AS main_product_id, \n" +
						"       p2.product_id AS frequently_purchased_product_id, \n" +
						"       COUNT(*) AS frequency\n" +
						"FROM purchases p1\n" +
						"JOIN purchases p2 ON p1.purchase_id = p2.purchase_id AND p1.product_id <> p2.product_id\n" +
						"WHERE p1.product_id = '"+product[0]+"'\n" +
						"GROUP BY p1.product_id, p2.product_id\n" +
						"ORDER BY frequency DESC\n" +
						"LIMIT 1;");
				if(rst2.next()){
					product[9] = rst2.getString(2);
					System.out.println(rst2.getString(2));
				}
				else{
					product[9] = "NA";
				}
				rst2.close();
				stmt2.close();
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
