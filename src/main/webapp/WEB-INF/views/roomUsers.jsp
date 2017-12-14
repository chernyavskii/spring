﻿<%@ page import="java.time.Month" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">

    <title>Моя комната</title>
</head>
<body>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="/">Общежитие</a>
        </div>
        <ul class="nav navbar-nav">
            <li class="active"><a href="/">Главная</a></li>
            <li><a href="/users">Моя комната</a></li>
            <li><a href="/users/pay">Оплата за проживание</a></li>
            <li><a href="/users/duty">Дежурство</a></li>

        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="/users/user/${user.id}">Профиль</a></li>
            <li><a href="#">Выйти</a></li>
        </ul>
    </div>
</nav>
<div class="container">
    <c:forEach items="${user.rooms}" var="room">
        <div style="margin-top:-5px;">
            <h2><b>Комната № ${room.level}</b></h2>
            <h4>Общее количество: ${room.full_count}</h4>
            <h4>Текущее количество: ${room.current_count}</h4>
        </div>
    </c:forEach>
    <hr>
    <div class="panel panel-info" style="width: 900px; padding: 10px; margin: auto;">
        <div class="panel-heading">Студенты, проживающие с вами в комнате</div>
        <div class="panel-body">
            <div class="form-group" style="width: 750px; padding: 10px; margin: auto;">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <table class="table table-striped">
                        <tbody id="myTable">
                        <c:forEach items="${user.rooms}" var="rooms">
                            <c:forEach items="${rooms.users}" var="room" varStatus="status">
                                <c:if test="${user.username == room.username }">

                                </c:if>
                                <c:if test="${user.username != room.username }">
                                    <tr>
                                        <td>${room.firstName} ${room.lastName} </td>
                                        <td><a style="float:right;" href="<c:url value='/users/user/${room.id}'/>" class="btn btn-danger">Профиль</a></td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </c:forEach>
                        </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <hr>

    <div class="panel panel-success" style="width: 900px; padding: 10px; margin: auto;">
        <div class="panel-heading">Оценка чистоты и порядка в проживаемой комнате</div>
        <div class="panel-body">
            <div class="form-group" style="width: 750px; padding: 10px; margin: auto;">
                <div class="panel panel-default">
                    <div class="panel-body">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th style="text-align: center;">Дата смотра</th>
                            <th style="text-align: center;">Оценка чистоты</th>
                            <th style="text-align: center;">Оценка порядка</th>
                        </tr>
                        </thead>
                        <tbody id="myTableControl">
                        <c:forEach items="${user.rooms}" var="rooms">
                            <c:forEach items="${rooms.controls}" var="control">
                                <tr>
                                    <td align="center">${control.date_control}</td>
                                    <td>
                                        <c:if test="${control.cleanliness < 5}">
                                            <p style="padding-left: 100px;">${control.cleanliness} <i style="color:red">(неуд.)</i></p>
                                        </c:if>
                                        <c:if test="${control.cleanliness >= 5 && control.cleanliness < 7}">
                                            <p style="padding-left: 100px;">${control.cleanliness} <i style="color:sandybrown">(удовл.)</i></p>
                                        </c:if>
                                        <c:if test="${control.cleanliness >= 7}">
                                            <p style="padding-left: 100px;">${control.cleanliness} <i style="color:green">(отлично)</i></p>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:if test="${control.tidiness < 5}">
                                            <p style="padding-left: 100px;">${control.tidiness} <i style="color:red">(неуд.)</i></p>
                                        </c:if>
                                        <c:if test="${control.tidiness >= 5 && control.tidiness < 7}">
                                            <p style="padding-left: 100px;">${control.tidiness} <i style="color:sandybrown">(удовл.)</i></p>
                                        </c:if>
                                        <c:if test="${control.tidiness >= 7}">
                                            <p style="padding-left: 100px;">${control.tidiness} <i style="color:green">(отлично)</i></p>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:forEach>
                        </tbody>
                    </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <hr>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>