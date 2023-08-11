//package com.jtspringproject.JtSpringProject;
//
//import com.jtspringproject.JtSpringProject.controller.UserController;
//import org.junit.jupiter.api.Test;
//import org.mockito.Mockito;
//import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.ui.Model;
//
//import java.sql.*;
//
//import static org.junit.jupiter.api.Assertions.assertEquals;
//import static org.mockito.Mockito.mock;
//import static org.mockito.Mockito.when;
//
//@SpringBootTest
//class JtSpringProjectApplicationTests {
//
//	@Test
//	void contextLoads() {
//	}
//	@Test
//	public void testAddToCart() {
//		UserController controller = new UserController();
//		String productId = "123";
//		String quantity = "2";
//
//		// Mock the request parameters and the database connection
//		controller.currentUser = 123; // Set the user ID for testing purposes
//		Connection mockConnection = mock(Connection.class);
//		PreparedStatement mockPreparedStatement = mock(PreparedStatement.class);
//		try {
//			when(mockConnection.prepareStatement(Mockito.anyString())).thenReturn(mockPreparedStatement);
//			when(DriverManager.getConnection(Mockito.anyString(), Mockito.anyString(), Mockito.anyString()))
//					.thenReturn(mockConnection);
//
//			// Test the method
//			String result = controller.addToCart(productId, quantity);
//
//			// Assert the result
//			assertEquals("redirect:/user/products", result);
//			// Add more assertions if needed
//		} catch (Exception e) {
//			// Handle exceptions if needed
//			e.printStackTrace();
//		}
//	}
//
//	@Test
//	public void testRemoveFromCart() {
//		UserController controller = new UserController();
//		String productId = "123";
//		String quantity = "2";
//
//		// Mock the request parameters and the database connection
//		controller.currentUser = 123; // Set the user ID for testing purposes
//		Connection mockConnection = mock(Connection.class);
//		PreparedStatement mockPreparedStatement = mock(PreparedStatement.class);
//		try {
//			when(mockConnection.prepareStatement(Mockito.anyString())).thenReturn(mockPreparedStatement);
//			// Test the method
//			String result = controller.addToCart(productId, quantity);
//
//			// Assert the result
//			assertEquals("redirect:/user/products", result);
//			// Add more assertions if needed
//		} catch (Exception e) {
//			// Handle exceptions if needed
//			e.printStackTrace();
//		}
//	}
//
//	@Test
//	public void testGetProduct() {
//		UserController controller = new UserController();
//		Model mockModel = mock(Model.class);
//
//		// Mock the database connection and result set
//		Connection mockConnection = mock(Connection.class);
//		Statement mockStatement = mock(Statement.class);
//		ResultSet mockResultSet = mock(ResultSet.class);
//		try {
//			when(mockConnection.createStatement()).thenReturn(mockStatement);
//			when(mockStatement.executeQuery(Mockito.anyString())).thenReturn(mockResultSet);
//
//			// Mock the data returned by the database
//			when(mockResultSet.next()).thenReturn(true).thenReturn(false);
//			when(mockResultSet.getInt(2)).thenReturn(1);
//			when(mockResultSet.getInt(3)).thenReturn(2);
//
//			// Test the method
//			String result = controller.getproduct(mockModel);
//
//			// Assert the result
//			assertEquals("uproduct", result);
//			// Add more assertions if needed
//		} catch (Exception e) {
//			// Handle exceptions if needed
//			e.printStackTrace();
//		}
//	}
//}
