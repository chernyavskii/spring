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
                    <li><a href="/users">Соседи по комнате</a></li>
                    <li><a href="#">Контроль чистоты и порядка</a></li>
                </ul>
            </li>
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">Оплата за проживание<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="#">Добавить новую запись</a></li>
                    <li><a href="/users/pay">Список активных</a></li>
                </ul>
            </li>
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">Дежурство<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="#">Добавить новую запись</a></li>
                    <li><a href="/users/duty">Список активных</a></li>
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
    <div class="jumbotron">
        <h1>Студенческое Общежитие</h1>
        <p>Здравствуйте, ${user.username}</p>
    </div>
    <h2>Filterable Table</h2>
    <p>Type something in the input field to search the table for first names, last names or emails:</p>
    <br>
       <div class="panel panel-info">
           <div class="panel-heading">Студенты, проживающие с Вами в комнате</div>
           <div class="panel-body">
           <div class="table-responsive">
        <table class="table table-striped">
        <thead>
        <tr>
            <th>Имя</th>
            <th>Пароль</th>
            <th>Телефон</th>
            <th>Профиль</th>
        </tr>
        </thead>
        <tbody id="myTable">
        <c:forEach items="${user.rooms}" var="rooms">
            <c:forEach items="${rooms.users}" var="room" varStatus="status">
                <c:if test="${user.username == room.username }">
                    <tr>
                        <td>${room.username}<a href="<c:url value='/users/user/${room.id}'/>"> (Вы)</a></td>
                        <td><b>${room.password}</b></td>
                        <td><b>dasdasda</b></td>
                    </tr>
                </c:if>
            </c:forEach>
            <c:forEach items="${rooms.users}" var="room" varStatus="status">
                <c:if test="${user.username != room.username }">
                    <tr>
                        <td>${room.username}</td>
                        <td><b>${room.password}</b></td>
                        <td><b>dasdasda</b></td>
                        <td><a href="<c:url value='/users/user/${room.id}'/>" class="btn btn-danger">Профиль</a></td>
                    </tr>
                </c:if>
            </c:forEach>
        </c:forEach>
        </tbody>
    </table>
               </div>
               </div>
    </div>
       <div class="panel panel-info">
           <div class="panel-heading">Оплата за проживание в общежитии</div>
           <div class="panel-body">
               <div class="panel panel-danger">
                   <div class="panel-heading">TEST</div>
                   <div class="panel-body">
                       <div class="table-responsive">
                           <table class="table table-striped">
                               <thead>
                               <tr>
                                   <th>id</th>
                                   <th>cost</th>
                                   <th>status_pay</th>
                               </tr>
                               </thead>
                               <tbody id="myTablePayTrue">
                               <c:forEach items="${user.pays}" var="item">
                                   <c:if test="${item.status_pay == true}">
                                       <tr>
                                           <td>${item.id}</td>
                                           <td>${item.cost}</td>
                                           <td>${item.status_pay}</td>
                                       </tr>
                                   </c:if>
                               </c:forEach>
                               </tbody>
                           </table>
                       </div>
                   </div>
               </div>
               <div class="panel panel-success">
                   <div class="panel-heading">QWERTY</div>
                        <div class="panel-body">
                                    <div class="table-responsive">
                                        <table class="table table-striped">
                                            <thead>
                                            <tr>
                                                <th>id</th>
                                                <th>cost</th>
                                                <th>status_pay</th>
                                            </tr>
                                            </thead>
                                            <tbody id="myTablePayFalse">
                                            <c:forEach items="${user.pays}" var="item">
                                            <c:if test="${item.status_pay == false}">
                                                <tr>
                                                    <td>${item.id}</td>
                                                    <td>${item.cost}</td>
                                                    <td>${item.status_pay}</td>
                                                </tr>
                                            </c:if>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                        </div>
               </div>
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
               <form:form method="post" action="/users/pay" modelAttribute="payForm">
                   <div class="form-group">
                       <form:label path="cost">Стоимость</form:label>
                       <form:input type="number" path="cost" class="form-control"/>
                   </div>
                   <div class="form-group">
                       <form:label path="month_pay">Месяц</form:label>
                       <form:select path="month_pay" items="${alphabet}" class="form-control"/>
                   </div>
                   <div class="form-group">
                       <form:label path="date_pay">Дата подачи</form:label>
                       <form:input path="date_pay" type="date" class="form-control"/>
                   </div>
                   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                   <button type="submit"/>
               </form:form>
           </div>
       </div>
    <div class="panel panel-info">
        <div class="panel-heading">Оценка чистоты и порядка в проживаемой комнате</div>
        <div class="panel-body">
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>cleanliness</th>
                        <th>tidiness</th>
                        <th>date_control</th>
                    </tr>
                    </thead>
                    <tbody id="myTableControl">
                    <c:forEach items="${user.rooms}" var="rooms">
                        <c:forEach items="${rooms.controls}" var="control">
                            <tr>
                                <td>${control.id}</td>
                                <td>
                                    <c:if test="${control.cleanliness < 5}">
                                        <p>${control.cleanliness} <i style="color:red">(неудовлетворительно)</i></p>
                                    </c:if>
                                    <c:if test="${control.cleanliness >= 5 && control.cleanliness < 7}">
                                        <p>${control.cleanliness} <i style="color:sandybrown">(удовлетворительно)</i></p>
                                    </c:if>
                                    <c:if test="${control.cleanliness >= 7}">
                                        <p>${control.cleanliness} <i style="color:lawngreen">(отлично)</i></p>
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${control.tidiness < 5}">
                                        <p>${control.tidiness} <i style="color:red">(неудовлетворительно)</i></p>
                                    </c:if>
                                    <c:if test="${control.tidiness >= 5 && control.tidiness < 7}">
                                        <p>${control.tidiness} <i style="color:sandybrown">(удовлетворительно)</i></p>
                                    </c:if>
                                    <c:if test="${control.tidiness >= 7}">
                                        <p>${control.tidiness} <i style="color:lawngreen">(отлично)</i></p>
                                    </c:if>
                                </td>
                                <td>${control.date_control}</td>
                            </tr>
                        </c:forEach>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="panel panel-info">
        <div class="panel-heading">Контроль дежурства на этаже</div>
        <div class="panel-body">
            <form:form action="/users/duty" method="post" modelAttribute="dutyForm">
                <spring:bind path="date">
                    <form:input path="date" type="date"/>
                </spring:bind>
                <spring:bind path="reason">
                    <form:textarea path="reason"/>
                </spring:bind>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <button type="submit" name="SUBMIT">
            </form:form>
            <%--<div class="table-responsive">
                <table class="table table-striped">

                </table>
            </div>--%>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>