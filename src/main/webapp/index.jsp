<%@ page import="com.tictactoe.Sign" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html>
<head>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <link href="static/main.css" rel="stylesheet">
    <script src="<c:url value="/static/jquery-3.6.0.min.js"/>"></script>
    <title>Tic-Tac-Toe</title>
</head>
<body>
<h1>Tic-Tac-Toe</h1>
<table>
    <tr>
        <td onclick="window.location='/logic?click=0'">${data.get(0).getSign()}</td>
        <td onclick="window.location='/logic?click=1'">${data.get(1).getSign()}</td>
        <td onclick="window.location='/logic?click=2'">${data.get(2).getSign()}</td>
    </tr>
    <tr>
    <td onclick="window.location='/logic?click=3'">${data.get(3).getSign()}</td>
    <td onclick="window.location='/logic?click=4'">${data.get(4).getSign()}</td>
    <td onclick="window.location='/logic?click=5'">${data.get(5).getSign()}</td>
    </tr>
    <tr>
    <td onclick="window.location='/logic?click=6'">${data.get(6).getSign()}</td>
    <td onclick="window.location='/logic?click=7'">${data.get(7).getSign()}</td>
    <td onclick="window.location='/logic?click=8'">${data.get(8).getSign()}</td>
    </tr>
</table>

<hr>
<c:set var="Crosses" value="<%=Sign.CROSS%>"/>
<c:set var="Noughts" value="<%=Sign.NOUGHT%>"/>

<c:if test="${winner == Crosses}">
    <h1>Crosses Win</h1>
    <button onclick="restart()">Start again</button>
</c:if>
<c:if test="${winner == Noughts}">
    <h1>Noughts Win</h1>
    <button onclick="restart()">Start again</button>
</c:if>
<c:if test="${draw}">
    <h1>It s a draw</h1>
    <br>

    <button onclick="restart()">Start again</button>
</c:if>


<script>
    function restart() {
        $.ajax({
            url:'/restart',
            type:'POST',
            contentType: 'application/json;charset=UTF-8',
            async:false,
            success:function () {
                location.reload();
            }
        });
    }

</script>

</body>
</html>