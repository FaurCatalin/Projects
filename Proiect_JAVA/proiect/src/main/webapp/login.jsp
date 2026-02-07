<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #eef2f5;
        }
        .login-box {
            width: 300px;
            margin: 100px auto;
            padding: 25px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 10px #b5b5b5;
            text-align: center;
        }
        input {
            width: 90%;
            padding: 8px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            width: 95%;
            padding: 10px;
            background: #d3d3d3;
            border: 1px solid #aaa;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background: #c5c5c5;
        }
        .error {
            color: red;
            font-size: 14px;
        }
        .msg {
            color: green;
            font-size: 14px;
        }
        a {
            display: block;
            margin-top: 10px;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="login-box">

    <h2>Login</h2>

    <!-- Mesaj de eroare -->
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <!-- Mesaj: te-ai delogat -->
    <c:if test="${param.logout == 1}">
        <p class="msg">Te-ai delogat cu succes.</p>
    </c:if>

    <form action="login" method="post">
        <input type="text" name="username" placeholder="Username"><br>
        <input type="password" name="password" placeholder="Password"><br>
        <button type="submit">Login</button>
    </form>

    <a href="register">Creează un cont</a>

</div>

</body>
</html>
