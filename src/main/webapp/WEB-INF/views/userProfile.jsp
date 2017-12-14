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
            <a class="navbar-brand" href="#">Общежитие</a>
        </div>
        <ul class="nav navbar-nav">
            <li class="active"><a href="/">Главная</a></li>
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown">Комната<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="#">Соседи по комнате</a></li>
                    <li><a href="#">Контроль чистоты и порядка</a></li>
                </ul>
            </li>
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">Оплата за проживание<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="#">Добавить новую запись</a></li>
                    <li><a href="#">Список активных</a></li>
                </ul>
            </li>
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">Дежурство<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="#">Добавить новую запись</a></li>
                    <li><a href="#">Список активных</a></li>
                </ul>
            </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="#"><span class="glyphicon glyphicon-user"></span> Профиль</a></li>
            <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Выйти</a></li>
        </ul>
    </div>
</nav>
<div class="container">
        <table class="table table-striped">
            <tbody id="myTable">
            <tr align="center">
                <td>id</td>
                <td>${userProfile.id}</td>
            </tr>
            <tr align="center">
                <td>Username</td>
                <td>${userProfile.username}</td>
            </tr>
            <tr align="center">
                <td>Password</td>
                <td>${userProfile.password}</td>
            </tr>
            </tbody>
        </table>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>
