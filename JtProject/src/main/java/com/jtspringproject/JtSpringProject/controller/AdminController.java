package com.jtspringproject.JtSpringProject.controller;

import java.sql.*;
import java.util.ArrayList;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.mysql.cj.protocol.Resultset;

@Controller
public class AdminController {
	int adminlogcheck = 0;
	static String usernameforclass = "";
	static int userID;
	@RequestMapping(value = {"/","/logout"})
	public String returnIndex() {
		adminlogcheck =0;
		usernameforclass = "";
		return "userLogin";
	}



	@GetMapping("/index")
	public String index(Model model) {
		if(usernameforclass.equalsIgnoreCase(""))
			return "userLogin";
		else {
			model.addAttribute("username", usernameforclass);
			return "index";
		}

	}
	@GetMapping("/userloginvalidate")
	public String userlog(Model model) {

		return "userLogin";
	}
	@RequestMapping(value = "userloginvalidate", method = RequestMethod.POST)
	public String userlogin( @RequestParam("username") String username, @RequestParam("password") String pass,Model model) {

		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery("select * from users where username = '"+username+"' and password = '"+ pass+"' ;");
			if(rst.next()) {
				usernameforclass = rst.getString(2);
				userID = rst.getInt(1);
				return "redirect:/index";
			}
			else {
				model.addAttribute("message", "Invalid Username or Password");
				return "userLogin";
			}

		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "userLogin";



	}


	@GetMapping("/admin")
	public String adminlogin(Model model) {

		return "adminlogin";
	}
	@GetMapping("/adminhome")
	public String adminHome(Model model) {
		if(adminlogcheck!=0)
			return "adminHome";
		else
			return "redirect:/admin";
	}
	@GetMapping("/loginvalidate")
	public String adminlog(Model model) {

		return "adminlogin";
	}
	@RequestMapping(value = "loginvalidate", method = RequestMethod.POST)
	public String adminlogin( @RequestParam("username") String username, @RequestParam("password") String pass,Model model) {

		if(username.equalsIgnoreCase("admin") && pass.equalsIgnoreCase("123")) {
			adminlogcheck=1;
			return "redirect:/adminhome";
		}
		else {
			model.addAttribute("message", "Invalid Username or Password");
			return "adminlogin";
		}
	}
	@GetMapping("/admin/categories")
	public String getcategory() {
		return "categories";
	}
	@RequestMapping(value = "admin/sendcategory",method = RequestMethod.GET)
	public String addcategorytodb(@RequestParam("categoryname") String catname)
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			Statement stmt = con.createStatement();

			PreparedStatement pst = con.prepareStatement("insert into categories(name) values(?);");
			pst.setString(1,catname);
			int i = pst.executeUpdate();

		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/admin/categories";
	}

	@GetMapping("/admin/categories/delete")
	public String removeCategoryDb(@RequestParam("id") int id)
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			Statement stmt = con.createStatement();

			PreparedStatement pst = con.prepareStatement("delete from categories where categoryid = ? ;");
			pst.setInt(1, id);
			int i = pst.executeUpdate();

		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/admin/categories";
	}

	@GetMapping("/admin/categories/update")
	public String updateCategoryDb(@RequestParam("categoryid") int id, @RequestParam("categoryname") String categoryname)
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			Statement stmt = con.createStatement();

			PreparedStatement pst = con.prepareStatement("update categories set name = ? where categoryid = ?");
			pst.setString(1, categoryname);
			pst.setInt(2, id);
			int i = pst.executeUpdate();

		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/admin/categories";
	}

	@GetMapping("/admin/products")
	public String getproduct(Model model) {
		try
		{
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			ArrayList<String[]> products= new ArrayList<String[]>();
			Statement pstmt = con.createStatement();
			ResultSet prst = pstmt.executeQuery("select * from products");
			while(prst.next()) {
				String[] currentProduct = new String[10];
				for(int j=1;j<=8;j++){
					if(j!=4){
						currentProduct[j-1] = prst.getString(j);
					}
					if(j==4){
						Statement cstmt = con.createStatement();
						ResultSet crst = cstmt.executeQuery("select * from categories where categoryid = '"+prst.getString(j)+"'");
						if(crst.next()){
							currentProduct[j-1] = crst.getString(2);
						}
					}
				}
				products.add(currentProduct);
			}
			for(String[] product : products){
				System.out.println(product[0]);
				Statement stmt = con.createStatement();
				ResultSet rst = stmt.executeQuery("SELECT p1.product_id AS main_product_id, \n" +
						"       p2.product_id AS frequently_purchased_product_id, \n" +
						"       COUNT(*) AS frequency\n" +
						"FROM purchases p1\n" +
						"JOIN purchases p2 ON p1.purchase_id = p2.purchase_id AND p1.product_id <> p2.product_id\n" +
						"WHERE p1.product_id = '"+product[0]+"'\n" +
						"GROUP BY p1.product_id, p2.product_id\n" +
						"ORDER BY frequency DESC\n" +
						"LIMIT 1;");
				if(rst.next()){
					product[9] = rst.getString(2);
					System.out.println(rst.getString(2));
				}
				else{
					product[9] = "NA";
				}
				rst.close();
				stmt.close();
			}
			for(String[] product : products){
				for(String[] product2 : products){
					if(product[9].toString().equals(product2[0].toString())){
						product[9] = product2[1];
					}
				}
			}
			model.addAttribute("test", products);

		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "products";
	}
	@GetMapping("/admin/products/add")
	public String addproduct(Model model) {
		return "productsAdd";
	}

	@GetMapping("/admin/products/update")
	public String updateproduct(@RequestParam("pid") int id,Model model) {
		String pname,pdescription,pimage;
		int pid,pprice,pweight,pquantity,pcategory;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			Statement stmt = con.createStatement();
			Statement stmt2 = con.createStatement();
			ResultSet rst = stmt.executeQuery("select * from products where id = "+id+";");

			if(rst.next())
			{
				pid = rst.getInt(1);
				pname = rst.getString(2);
				pimage = rst.getString(3);
				pcategory = rst.getInt(4);
				pquantity = rst.getInt(5);
				pprice =  rst.getInt(6);
				pweight =  rst.getInt(7);
				pdescription = rst.getString(8);
				model.addAttribute("pid",pid);
				model.addAttribute("pname",pname);
				model.addAttribute("pimage",pimage);
				ResultSet rst2 = stmt.executeQuery("select * from categories where categoryid = "+pcategory+";");
				if(rst2.next())
				{
					model.addAttribute("pcategory",rst2.getString(2));
				}
				model.addAttribute("pquantity",pquantity);
				model.addAttribute("pprice",pprice);
				model.addAttribute("pweight",pweight);
				model.addAttribute("pdescription",pdescription);
			}
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "productsUpdate";
	}
	@RequestMapping(value = "admin/products/updateData",method=RequestMethod.POST)
	public String updateproducttodb(@RequestParam("id") int id,@RequestParam("name") String name, @RequestParam("price") int price, @RequestParam("weight") int weight, @RequestParam("quantity") int quantity, @RequestParam("description") String description, @RequestParam("productImage") String picture )

	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");

			PreparedStatement pst = con.prepareStatement("update products set name= ?,image = ?,quantity = ?, price = ?, weight = ?,description = ? where id = ?;");
			pst.setString(1, name);
			pst.setString(2, picture);
			pst.setInt(3, quantity);
			pst.setInt(4, price);
			pst.setInt(5, weight);
			pst.setString(6, description);
			pst.setInt(7, id);
			int i = pst.executeUpdate();
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/admin/products";
	}

	@GetMapping("/admin/products/delete")
	public String removeProductDb(@RequestParam("id") int id)
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");


			PreparedStatement pst = con.prepareStatement("delete from products where id = ? ;");
			pst.setInt(1, id);
			int i = pst.executeUpdate();

		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/admin/products";
	}

	@PostMapping("/admin/products")
	public String postproduct() {
		return "redirect:/admin/categories";
	}
	@RequestMapping(value = "admin/products/sendData",method=RequestMethod.POST)
	public String addproducttodb(@RequestParam("name") String name, @RequestParam("categoryid") String catid, @RequestParam("price") int price, @RequestParam("weight") int weight, @RequestParam("quantity") int quantity, @RequestParam("description") String description, @RequestParam("productImage") String picture ) {

		try
		{
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("select * from categories where name = '"+catid+"';");
			if(rs.next())
			{
				int categoryid = rs.getInt(1);

				PreparedStatement pst = con.prepareStatement("insert into products(name,image,categoryid,quantity,price,weight,description) values(?,?,?,?,?,?,?);");
				pst.setString(1,name);
				pst.setString(2, picture);
				pst.setInt(3, categoryid);
				pst.setInt(4, quantity);
				pst.setInt(5, price);
				pst.setInt(6, weight);
				pst.setString(7, description);
				int i = pst.executeUpdate();
			}
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/admin/products";
	}

	@GetMapping("/admin/customers")
	public String getCustomerDetail() {
		return "displayCustomers";
	}


	@GetMapping("profileDisplay")
	public String profileDisplay(Model model) {
		String displayusername,displaypassword,displayemail,displayaddress;
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");
			Statement stmt = con.createStatement();
			ResultSet rst = stmt.executeQuery("select * from users where username = '"+usernameforclass+"';");

			if(rst.next())
			{
				int userid = rst.getInt(1);
				displayusername = rst.getString(2);
				displayemail = rst.getString(3);
				displaypassword = rst.getString(4);
				displayaddress = rst.getString(5);
				model.addAttribute("userid",userid);
				model.addAttribute("username",displayusername);
				model.addAttribute("email",displayemail);
				model.addAttribute("password",displaypassword);
				model.addAttribute("address",displayaddress);
			}
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		System.out.println("Hello");
		return "updateProfile";
	}

	@RequestMapping(value = "updateuser",method=RequestMethod.POST)
	public String updateUserProfile(@RequestParam("userid") int userid,@RequestParam("username") String username, @RequestParam("email") String email, @RequestParam("password") String password, @RequestParam("address") String address)

	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/springproject","root","");

			PreparedStatement pst = con.prepareStatement("update users set username= ?,email = ?,password= ?, address= ? where uid = ?;");
			pst.setString(1, username);
			pst.setString(2, email);
			pst.setString(3, password);
			pst.setString(4, address);
			pst.setInt(5, userid);
			int i = pst.executeUpdate();
			usernameforclass = username;
		}
		catch(Exception e)
		{
			System.out.println("Exception:"+e);
		}
		return "redirect:/index";
	}

}
