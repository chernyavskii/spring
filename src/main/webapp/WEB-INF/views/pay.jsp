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

    <title>Оплата за проживание</title>
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
    <c:set var="alphabet" value="${['Январь',
                                                       'Февраль',
                                                       'Март',
                                                       'Апрель',
                                                       'Май',
                                                       'Июнь',
                                                       'Июль',
                                                       'Август',
                                                       'Сентябрь',
                                                       'Октябрь',
                                                       'Ноябрь',
                                                       'Декабрь']}" />
    <c:forEach items="${user.rooms}" var="room">
    <div style="margin-top:-5px;">
        <h2><b>Комната № ${room.level}</b></h2>
        <h4>Общее количество: ${room.full_count}</h4>
        <h4>Текущее количество: ${room.current_count}</h4>
    </div>
    </c:forEach>
    <hr>

        <div class="panel panel-info" style="width: 900px; padding: 10px; margin: auto;">
            <div class="panel-heading">Добавить новую транзакцию</div>
            <div class="panel-body">
                INFO
                <div class="form-group" style="width: 750px; padding: 10px; margin: auto;">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <form:form method="post" class="form-horizontal" action="/users/pay" modelAttribute="payForm">
                                <div class="form-group">
                                    <label class="control-label col-xs-3" for="number_pay">Ключ:</label>
                                    <spring:bind path="number_pay">
                                        <div class="col-xs-9 ${status.error ? 'has-error' : ''}">
                                            <form:input path="number_pay" type="text"
                                                        class="form-control" id="number_pay" placeholder="Введите идентификационный ключ"/>
                                            <form:errors path="number_pay"></form:errors>
                                        </div>
                                    </spring:bind>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-xs-3" for="month_pay">Месяц:</label>
                                    <spring:bind path="month_pay">
                                        <div class="col-xs-9 ${status.error ? 'has-error' : ''}">
                                            <form:select path="month_pay" items="${alphabet}" class="form-control"/>
                                            <form:errors path="month_pay"></form:errors>
                                        </div>
                                    </spring:bind>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-xs-3" for="date_pay">Дата оплаты:</label>
                                    <spring:bind path="date_pay">
                                        <div class="col-xs-9 ${status.error ? 'has-error' : ''}">
                                            <form:input path="date_pay" type="date"
                                                        class="form-control" id="date_pay" />
                                            <form:errors path="date_pay"></form:errors>
                                        </div>
                                    </spring:bind>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-xs-3" for="cost">Сумма:</label>
                                    <spring:bind path="cost">
                                        <div class="col-xs-9 ${status.error ? 'has-error' : ''}">
                                            <form:input path="cost" type="number"
                                                        class="form-control" id="cost" />
                                            <form:errors path="cost"></form:errors>
                                        </div>
                                    </spring:bind>
                                </div>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <br />
                                <div class="form-group">
                                    <div class="col-xs-offset-3 col-xs-9">
                                        <input type="submit" class="btn btn-primary" value="Добавить">
                                        <input type="reset" class="btn btn-default" value="Очистить форму">
                                    </div>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
<hr>

    <div class="panel panel-info" style="width: 900px; padding: 10px; margin: auto;">
    <div class="panel-heading">Оплата за проживание в общежитии</div>
    <div class="panel-body">
        <div class="form-group" style="width: 750px; padding: 10px; margin: auto;">
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
    <hr>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>
