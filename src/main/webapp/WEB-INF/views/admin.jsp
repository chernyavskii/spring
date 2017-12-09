<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Admin Panel</title>
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<%--<a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
    Link with href
</a>
<div class="collapse" id="collapseExample">
    <div class="card card-body">
        testtest
    </div>
</div>--%>
<div class="container">
    <c:if test="${pageContext.request.userPrincipal.name != null}">
        <form id="logoutForm" method="post" action="${contextPath}/logout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
        <h2>Admin Page ${pageContext.request.userPrincipal.name} | <a onclick="document.forms['logoutForm'].submit()">Logout</a>
        </h2>
        <h2>Striped Rows</h2>
        <p>The .table-striped class adds zebra-stripes to a table:</p>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>id</th>
                <th>username</th>
                <th>password</th>
                <th>room</th>
                <th>info</th>
                <th>update</th>
                <th>delete</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${listUsers}" var="user">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.username}</td>
                    <td>${user.password}</td>
                    <c:forEach items="${user.roles}" var="role">
                        <td>${role.name}</td>
                    </c:forEach>
                    <td><a href="<c:url value='/info/${user.id}'/>" class="btn btn-info">Info</a></td>
                    <td><a href="<c:url value='/update/${user.id}'/>" class="btn btn-warning">Update</a></td>
                    <td><a href="<c:url value='/delete/${user.id}'/>" class="btn btn-danger">Delete</a></td>
                </tr>
            </c:forEach>
            <div id="infoUser">
                <b>${userInfo.id}</b>
                <b>${userInfo.username}</b>
                <b>${userInfo.password}</b>
            </div>
            </tbody>
        </table>

    </c:if>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>

</body>
</html>