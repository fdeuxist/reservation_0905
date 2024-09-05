<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Header</title>
</head>
<body>
  <header class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <div class="container-fluid">
        <!-- 좌측 햄버거 버튼 -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <!-- 가운데 로고 -->
        <a class="navbar-brand mx-auto" href="#">Logo</a>

        <!-- 우측 로그인 드롭다운 -->
        <div class="dropdown">
          <button class="btn btn-primary dropdown-toggle" type="button" id="loginDropdown" data-bs-toggle="dropdown" aria-expanded="false">
            Login
          </button>
          <ul class="dropdown-menu dropdown-menu-end p-4" aria-labelledby="loginDropdown">
            <form>
              <div class="mb-3">
                <label for="emailInput" class="form-label">Email address</label>
                <input type="email" class="form-control" id="emailInput" placeholder="Enter email">
              </div>
              <div class="mb-3">
                <label for="passwordInput" class="form-label">Password</label>
                <input type="password" class="form-control" id="passwordInput" placeholder="Password">
              </div>
              <button type="submit" class="btn btn-primary w-100">Login</button>
            </form>
          </ul>
        </div>
      </div>
    </nav>
  </header>
<br><br>
loginEmail: ${loginEmail }
<br><br>
<c:forEach var="authority" items="${authorities}">
    <li>${authority.authority}</li>
</c:forEach>
</body>
</html>
