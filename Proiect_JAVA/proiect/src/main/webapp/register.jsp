<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Crează un cont</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #eef2f5;
        }
        .box {
            width: 300px;
            margin: 90px auto;
            padding: 25px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 0 10px #b5b5b5;
            text-align: center;
        }
        input {
            width: 90%;
            padding: 8px;
            margin: 6px 0;
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

<div class="box">
    <h2>Crează un cont</h2>

    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <form action="register" method="post">
        <input type="text" name="nume" placeholder="Nume complet">
        <input type="text" name="username" placeholder="Username">
        <input type="password" name="password" placeholder="Parola">
        <button type="submit">Creează cont</button>
    </form>

    <a href="login">Înapoi la login</a>
</div>

</body>
</html>
