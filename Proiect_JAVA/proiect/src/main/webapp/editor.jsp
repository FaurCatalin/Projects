<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Editor Mașini</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #eef2f5;
        }

        .container {
            width: 500px;
            margin: 35px auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 10px #aaa;
        }

        h2 {
            text-align: center;
        }

        input {
            width: 95%;
            padding: 8px;
            margin: 6px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        button {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            background: #d3d3d3;
            border: 1px solid #aaa;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background: #bfbfbf;
        }

        .delete-btn {
            background: #ffb3b3;
            border-color: #ff6666;
        }
        .delete-btn:hover {
            background: #ff9999;
        }

        .tbl-container {
            width: 95%;
            margin: 20px auto;
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
            text-align: center;
        }
        th {
            background: #f1f1f1;
            font-weight: bold;
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

    <h2>Editor Mașini</h2>

    <c:if test="${not empty msg}">
        <p style="color: green; text-align:center;">${msg}</p>
    </c:if>

    <form action="editor" method="post">

        <input type="text" name="nrInmatriculare"
               placeholder="Număr înmatriculare"
               value="${editMasina.nrInmatriculare}" required>

        <input type="text" name="marca" placeholder="Marca" value="${editMasina.marca}">
        <input type="text" name="model" placeholder="Model" value="${editMasina.model}">
        <input type="text" name="culoare" placeholder="Culoare" value="${editMasina.culoare}">
        <input type="number" name="anulFabricatiei" placeholder="An fabricație" value="${editMasina.anulFabricatiei}">
        <input type="number" name="capacitateaCilindrica" placeholder="Capacitate cilindrică" value="${editMasina.capacitateaCilindrica}">
        <input type="text" name="tipulDeCombustibil" placeholder="Tip combustibil" value="${editMasina.tipulDeCombustibil}">
        <input type="number" name="puterea" placeholder="Putere" value="${editMasina.puterea}">
        <input type="number" name="cuplul" placeholder="Cuplu" value="${editMasina.cuplul}">
        <input type="number" name="volumulPortbagajului" placeholder="Volum portbagaj" value="${editMasina.volumulPortbagajului}">
        <input type="number" name="pret" placeholder="Preț" value="${editMasina.pret}">

        <button type="submit" name="action" value="save">Salvează / Actualizează</button>
    </form>

</div>

<div class="tbl-container">

    <h3 style="text-align:center;">Toate mașinile</h3>

    <table>
        <tr>
            <th>Nr înmatriculare</th>
            <th>Marca</th>
            <th>Model</th>
            <th>Culoare</th>
            <th>An</th>
            <th>Cilindree</th>
            <th>Combustibil</th>
            <th>Putere</th>
            <th>Cuplu</th>
            <th>Portbagaj</th>
            <th>Preț</th>
            <th>Acțiuni</th>
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

                <td>
                    <a href="editor?edit=${m.nrInmatriculare}">Editează</a> |
                    <a href="editor?delete=${m.nrInmatriculare}"
                       onclick="return confirm('Sigur ștergi?');">Șterge</a>
                </td>
            </tr>
        </c:forEach>
    </table>

    <br>
    <div style="text-align:center;">
        <a href="masini">Înapoi la mașini</a> |
        <a href="logout">Logout</a>
    </div>
</div>

</body>
</html>
