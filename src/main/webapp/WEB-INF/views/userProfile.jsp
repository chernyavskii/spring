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

    <title>Профиль</title>
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
        <table class="table table-striped">
            <tbody id="myTable">
            <tr align="center">
                <td><b>id</b></td>
                <td>${userProfile.id}</td>
            </tr>
            <tr align="center">
                <td><b>Логин</b></td>
                <td>${userProfile.username}</td>
            </tr>
            <tr align="center">
                <td><b>Имя</b></td>
                <td>${userProfile.firstName}</td>
            </tr>
            <tr align="center">
                <td><b>Фамилия</b></td>
                <td>${userProfile.lastName}</td>
            </tr>
            <tr align="center">
                <td><b>Дата рождения</b></td>
                <td>${userProfile.birth}</td>
            </tr>
            <tr align="center">
                <td><b>Номер телефона</b></td>
                <td>${userProfile.phone}</td>
            </tr>
            <tr align="center">
                <td><b>Адрес</b></td>
                <td>${userProfile.address}</td>
            </tr>
            <hr>
            <tr align="center">
                <td><b>Комната</b></td>
                <c:forEach items="${userProfile.rooms}" var="room">
                    <td>${room.level}</td>
                </c:forEach>
            </tr>
            </tbody>
        </table>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>
