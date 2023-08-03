<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">

<title>Document</title>
</head>
<body class="bg-light">
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<a class="navbar-brand" href="#"> <img
				th:src="@{/images/logo.png}" src="../static/images/logo.png"
				width="auto" height="40" class="d-inline-block align-top" alt="" />
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto"></ul>
				<ul class="navbar-nav">
					<li class="nav-item active"><a class="nav-link" href="/index">Home
							Page</a></li>
					<li class="nav-item active"><a class="nav-link" href="/logout">Logout</a>
					</li>

				</ul>

			</div>
		</div>
	</nav>
	<h4> ${username}'s Cart </h4>
	<div class="container-fluid">


		<table class="table">

			<tr>
				<th scope="col">Product Name</th>
				<th scope="col">Preview</th>
				<th scope="col">Quantity</th>
				<th scope="col">Price</th>
				<th scope="col">Weight</th>
				<th scope="col">Description</th>
				<th scope="col">Frequently purchased with</th>
				<th scope="col"></th>
			</tr>
			<tbody>
				<tr>
					<%
					try {
						String url = "jdbc:mysql://localhost:3306/springproject";
						Class.forName("com.mysql.cj.jdbc.Driver");

					%>
					<c:forEach var="item" items="${products}">
					<!-- Name -->
					<td>
						${item[1]}
					</td>
					<!-- Image -->
					<td>
						${item[2]}
					</td>
					<!-- Quantity-->
					<td id="quantity">
						${item[8]}
					</td>
					<!-- Price -->
                    <td id="price">
						${item[5]}
					</td>
					<!-- Weight -->
					<td>
						${item[6]}
					</td>
					<!-- Description -->
					<td>
						${item[7]}
					</td>
					<!-- FPW -->
					<td>
					       <p>TBD</p>
					</td>
					<td>
                    		<form action="/removeFromCart" method="post">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-cart" viewBox="0 0 16 16">
                                <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l1.313 7h8.17l1.313-7H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                            </svg>
                            <input type="hidden" name="productId" value=${item[0]}>
                            <input type="hidden" name="quantity" value=${item[8]}>
                            <input type="submit" value="Delete" class="btn btn-info btn-lg">
                            </form>
                    </td>

				</tr>
				</c:forEach>

			</tbody>
		</table>
		<h4> Total Price: </h4>
		<h4 id = "total"></h4>
		<form action="/buy" method="get">
        						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-cart" viewBox="0 0 16 16">
                                  <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l1.313 7h8.17l1.313-7H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                                </svg>
                                <input type="hidden" name="id" value=${item[0]}>
        							<input type="submit" value="Buy" class="btn btn-info btn-lg">
		<%
		} catch (Exception ex) {
		out.println("Exception Occurred:: " + ex.getMessage());
		}
		%>
	</div>

    <script>
        const quantityElements = document.querySelectorAll("#quantity");
            const priceElements = document.querySelectorAll("#price");

            // Calculate the total price by multiplying price with quantity
            let totalPrice = 0;
            for (let i = 0; i < quantityElements.length; i++) {
                const quantity = parseInt(quantityElements[i].textContent.trim(), 10);
                const price = parseFloat(priceElements[i].textContent.trim());
                totalPrice += price * quantity;
            }

            // Update the total price on the page
            const totalElement = document.getElementById("total");
            totalElement.textContent = totalPrice.toFixed(2);
    </script>

	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
		integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
		integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
		integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
		crossorigin="anonymous"></script>
</body>
</html>