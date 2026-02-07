<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Mașini</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #eef2f5;
        }

        .container {
            width: 90%;
            margin: 30px auto;
            text-align: center;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px #b5b5b5;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            background: #fff;
        }

        th, td {
            padding: 8px;
            border: 1px solid #ddd;
        }

        th {
            background: #f1f1f1;
            font-weight: bold;
        }

        input {
            padding: 8px;
            margin: 5px;
            width: 150px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            padding: 8px 12px;
            background: #d3d3d3;
            border: 1px solid #aaa;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background: #c0c0c0;
        }

        .logout {
            margin-top: 20px;
        }

        a {
            color: blue;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

    </style>
</head>

<body>

<div class="container">

    <h2>Bine ai venit, ${sessionScope.user.nume}</h2>

    <form action="masini" method="get">
        <input type="text" name="marca" placeholder="marca" value="${param.marca}">
        <input type="text" name="culoare" placeholder="culoare" value="${param.culoare}">
        <input type="text" name="combustibil" placeholder="combustibil" value="${param.combustibil}">
        <button type="submit">Filtrează</button>
    </form>

    <h3>${msg}</h3>

    <table>
        <tr>
            <th>Număr înmatriculare</th>
            <th>Marca</th>
            <th>Model</th>
            <th>Culoare</th>
            <th>An fabricație</th>
            <th>Capacitate cilindrică</th>
            <th>Combustibil</th>
            <th>Putere</th>
            <th>Cuplu</th>
            <th>Volum portbagaj</th>
            <th>Preț</th>
        </tr>

        <c:forEach var="m" items="${masini}">
            <tr>
                <td>${m.nrInmatriculare}</td>
                <td>${m.marca}</td>
                <td>${m.model}</td>
                <td>${m.culoare}</td>
                <td>${m.anulFabricatiei}</td>
                <td>${m.capacitateaCilindrica}</td>
                <td>${m.tipulDeCombustibil}</td>
                <td>${m.puterea}</td>
                <td>${m.cuplul}</td>
                <td>${m.volumulPortbagajului}</td>
                <td>${m.pret}</td>
            </tr>
        </c:forEach>

    </table>

    <div class="logout">
        <a href="logout">Logout</a>
    </div>

    <!-- DOAR EDITOR -->
    <c:if test="${sessionScope.user.rol == 'ROLE_EDITOR'}">
        <br>
        <a href="editor">Mergi la Editor</a>
    </c:if>

</div>

</body>
</html>
