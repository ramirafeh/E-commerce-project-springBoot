<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <!-- Add necessary head content -->
</head>
<body class="bg-dark">
<div class="container my-5" style="width: 1800px;" ><br>
    <div class="jumbotron border col-sm-5 mx-auto">
        <h2 class="text-center">Admin Login</h2><br>
        <form action="loginvalidate" method="post">
            <div class="form-group">
                <label for="username">Username :</label>
                <input type="text" name="username" id="username" placeholder="Admin username" required class="form-control form-control-lg border border-danger">
            </div>

            <div class="form-group">
                <label for="password">Password :</label>
                <input type="password" class="form-control form-control-lg border border-danger	" placeholder="Admin Password" required name="password" id="password">
            </div><br>

            <input type="submit" value="Login" class="btn btn-primary btn-block">
            <br>
            <h3 style="color:red;">${message}</h3>
            <br>

            <!-- Display the SQL query results -->
            <h3>Recent Purchases:</h3>
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>Purchase ID</th>
                    <th>Username</th>
                    <th>Role</th>
                    <th>Email</th>
                </tr>
                </thead>
                <tbody>
                <tr th:each="purchase : ${purchases}">
                    <td th:text="${purchase.purchaseId}"></td>
                    <td th:text="${purchase.username}"></td>
                    <td th:text="${purchase.role}"></td>
                    <td th:text="${purchase.email}"></td>
                </tr>
                </tbody>
            </table>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>
