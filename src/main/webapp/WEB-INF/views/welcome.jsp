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

    <title>Студенческое общежитие</title>
</head>
<body>
<form id="logoutForm" method="post" action="${contextPath}/logout">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>
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
            <li><a style="color: #46b8da" href="/users/user/${user.id}">${user.username}</a></li>

            <li><a onclick="document.forms['logoutForm'].submit()">Выйти</a></li>
        </ul>
    </div>
</nav>
<div class="container" >
    <div class="jumbotron">
        <h1 style="font-family: 'Lobster', cursive;">Студенческое Общежитие</h1>
        <p>Данный ресурс предназначен для централизованного управления внутренними процессами общежития. </p>
    </div>
    <h2>Информация</h2>
    <p>Доступные модули системы. Управление осуществляется перейдя по необходимому пункту главного меню.</p>
    <br>
    <div class="panel panel-info" >
        <div class="panel-heading">Студенты, проживающие с вами в комнате</div>
        <div class="panel-body">
            <div class="form-group" >
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
    <div class="panel panel-info">
        <div class="panel-heading">Оплата за проживание в общежитии</div>
        <div class="panel-body">
            <div class="form-group" >
                <div class="panel panel-danger">
                    <div class="panel-heading">Неподтвержденные транзакции</div>
                    <div class="panel-body">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>Ключ</th>
                                <th>Месяц</th>
                                <th>Дата оплаты</th>
                                <th>Сумма</th>
                            </tr>
                            </thead>
                            <tbody id="myTablePayTrue">
                            <c:forEach items="${user.pays}" var="item">
                                <c:if test="${item.status_pay == false}">
                                    <tr>
                                        <td>${item.number_pay}</td>
                                        <td>${item.month_pay}</td>
                                        <td>${item.date_pay}</td>
                                        <td>${item.cost} б.р.</td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="panel panel-success">
                    <div class="panel-heading">Успешные транзакции</div>
                    <div class="panel-body">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>Ключ</th>
                                <th>Месяц</th>
                                <th>Дата оплаты</th>
                                <th>Сумма</th>
                            </tr>
                            </thead>
                            <tbody id="myTablePayFalse">
                            <c:forEach items="${user.pays}" var="item">
                                <c:if test="${item.status_pay == true}">
                                    <tr>
                                        <td>${item.number_pay}</td>
                                        <td>${item.month_pay}</td>
                                        <td>${item.date_pay}</td>
                                        <td>${item.cost} б.р.</td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-info">
        <div class="panel-heading">Оценка чистоты и порядка в проживаемой комнате</div>
        <div class="panel-body">
            <div class="form-group">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>Дата смотра</th>
                                <th>Оценка чистоты</th>
                                <th>Оценка порядка</th>
                            </tr>
                            </thead>
                            <tbody id="myTableControl">
                            <c:forEach items="${user.rooms}" var="rooms">
                                <c:forEach items="${rooms.controls}" var="control">
                                    <tr>
                                        <td>${control.date_control}</td>
                                        <td>
                                            <c:if test="${control.cleanliness < 5}">
                                                <p>${control.cleanliness} <i style="color:red">(неуд.)</i></p>
                                            </c:if>
                                            <c:if test="${control.cleanliness >= 5 && control.cleanliness < 7}">
                                                <p>${control.cleanliness} <i style="color:sandybrown">(удовл.)</i></p>
                                            </c:if>
                                            <c:if test="${control.cleanliness >= 7}">
                                                <p>${control.cleanliness} <i style="color:green">(отлично)</i></p>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:if test="${control.tidiness < 5}">
                                                <p>${control.tidiness} <i style="color:red">(неуд.)</i></p>
                                            </c:if>
                                            <c:if test="${control.tidiness >= 5 && control.tidiness < 7}">
                                                <p>${control.tidiness} <i style="color:sandybrown">(удовл.)</i></p>
                                            </c:if>
                                            <c:if test="${control.tidiness >= 7}">
                                                <p>${control.tidiness} <i style="color:green">(отлично)</i></p>
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

    <div class="panel panel-info" >
        <div class="panel-heading">Дежурство на этаже общежития</div>
        <div class="panel-body">
            <div class="form-group">
                <div class="panel panel-danger">
                    <div class="panel-heading">Неподтвержденные записи</div>
                    <div class="panel-body">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th style="text-align: center;">Дата</th>
                                <th style="text-align: center;">Время</th>
                            </tr>
                            </thead>
                            <tbody id="myTableDutyDanger">
                            <c:forEach items="${user.duties}" var="item">
                                <c:if test="${item.status == 0}">
                                    <tr>
                                        <td style="text-align: center;">${item.date}</td>
                                        <td style="text-align: center;">${item.time_duty}</td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="panel panel-warning">
                    <div class="panel-heading">Записи, находящиеся в очереди</div>
                    <div class="panel-body">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th style="text-align: center;">Дата</th>
                                <th style="text-align: center;">Время</th>
                            </tr>
                            </thead>
                            <tbody id="myTableDutyWarning">
                            <c:forEach items="${user.duties}" var="item">
                                <c:if test="${item.status == 1}">
                                    <tr>
                                        <td style="text-align: center;">${item.date}</td>
                                        <td style="text-align: center;">${item.time_duty}</td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="panel panel-success">
                    <div class="panel-heading">Подтверждённые записи</div>
                    <div class="panel-body">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th style="text-align: center;">Дата</th>
                                <th style="text-align: center;">Время</th>
                            </tr>
                            </thead>
                            <tbody id="myTableDutySuccess">
                            <c:forEach items="${user.duties}" var="item">
                                <c:if test="${item.status == 2}">
                                    <tr>
                                        <td style="text-align: center;">${item.date}</td>
                                        <td style="text-align: center;">${item.time_duty}</td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>