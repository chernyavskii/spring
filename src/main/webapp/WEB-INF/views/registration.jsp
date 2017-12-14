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

    <title>Регистрация</title>
</head>
<body>
<div class="container">
    <h2>Регистрация</h2>
    <div class="panel panel-default">
        <div class="panel-body">
        <form:form modelAttribute="userForm" class="form-horizontal" method="post">
            <div class="form-group">
                <label class="control-label col-xs-3" for="firstName">Имя:</label>
                <spring:bind path="firstName">
                <div class="col-xs-9 ${status.error ? 'has-error' : ''}">
                    <form:input path="firstName" type="text"
                                    class="form-control" id="firstName" placeholder="Введите имя"/>
                    <form:errors path="firstName"></form:errors>
                </div>
                </spring:bind>
            </div>
            <div class="form-group">
                <label class="control-label col-xs-3" for="lastName">Фамилия:</label>
                <spring:bind path="lastName">
                    <div class="col-xs-9 ${status.error ? 'has-error' : ''}">
                        <form:input path="lastName" type="text"
                                    class="form-control" id="lastName" placeholder="Введите фамилию"/>
                        <form:errors path="lastName"></form:errors>
                    </div>
                </spring:bind>
            </div>
            <div class="form-group">
                <label class="control-label col-xs-3" for="birth">Дата рождения:</label>
                <spring:bind path="birth">
                    <div class="col-xs-9 ${status.error ? 'has-error' : ''}">
                        <form:input path="birth" type="date"
                                    class="form-control" id="birth" placeholder="Введите дату рождения"/>
                        <form:errors path="birth"></form:errors>
                    </div>
                </spring:bind>
            </div>
            <div class="form-group">
                <label class="control-label col-xs-3" for="username">Логин:</label>
                <spring:bind path="username">
                    <div class="col-xs-9 ${status.error ? 'has-error' : ''}">
                        <form:input path="username" type="text"
                                    class="form-control" id="username" placeholder="Введите логин"/>
                        <form:errors path="username"></form:errors>
                    </div>
                </spring:bind>
            </div>
            <div class="form-group">
                <label class="control-label col-xs-3" for="password">Пароль:</label>
                <spring:bind path="password">
                    <div class="col-xs-9 ${status.error ? 'has-error' : ''}">
                        <form:input path="password" type="password"
                                    class="form-control" id="password" placeholder="Введите пароль"/>
                        <form:errors path="password"></form:errors>
                    </div>
                </spring:bind>
            </div>
            <div class="form-group">
                <label class="control-label col-xs-3" for="confirmPassword">Подтвердите пароль:</label>
                <spring:bind path="confirmPassword">
                    <div class="col-xs-9 ${status.error ? 'has-error' : ''}">
                        <form:input path="confirmPassword" type="password"
                                    class="form-control" id="confirmPassword" placeholder="Введите пароль ещё раз"/>
                        <form:errors path="confirmPassword"></form:errors>
                    </div>
                </spring:bind>
            </div>
            <div class="form-group">
                <label class="control-label col-xs-3" for="phone">Телефон:</label>
                <spring:bind path="phone">
                    <div class="col-xs-9 ${status.error ? 'has-error' : ''}">
                        <form:input path="phone" type="text"
                                    class="form-control" id="phone" placeholder="Введите номер телефона"/>
                        <form:errors path="phone"></form:errors>
                    </div>
                </spring:bind>
            </div>
            <div class="form-group">
                <label class="control-label col-xs-3" for="address">Адрес:</label>
                <div class="col-xs-9 ${status.error ? 'has-error' : ''}">
                    <form:textarea path="address" rows="3"
                                   class="form-control" id="address" placeholder="Введите адрес"/>
                    <form:errors path="phone"></form:errors>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-xs-3" for="rooms">Комната:</label>
                <div class="col-xs-9 ${status.error ? 'has-error' : ''}">
                    <form:select path="rooms" class="form-control" multiple="false" id="rooms">
                        <form:options items="${listRooms}" itemLabel="level" itemValue="id" />
                    </form:select>
                    <form:errors path="rooms"></form:errors>
                </div>
            </div>
            <br />
            <div class="form-group">
                <div class="col-xs-offset-3 col-xs-9">
                    <input type="submit" class="btn btn-primary" value="Регистрация">
                    <input type="reset" class="btn btn-default" value="Очистить форму">
                </div>
            </div>
        </form:form>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>