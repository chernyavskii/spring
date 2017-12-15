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

    <title>Панель Администратора</title>
</head>
<body>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="/">Общежитие</a>
        </div>
        <ul class="nav navbar-nav">
            <li class="active"><a href="/">На сайт</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a onclick="document.forms['logoutForm'].submit()">Выйти</a></li>
        </ul>
    </div>
</nav>
<div class="container">
    <div class="jumbotron">
        <h1 style="font-family: 'Lobster', cursive;">Панель Администратора</h1>
        <p>Предоставляет необходимый набор функций для управления системой. </p>
    </div>
    <h2>Количество свободных мест: <b>${countFreeRooms}</b></h2>
    <c:if test="${pageContext.request.userPrincipal.name != null}">
        <form id="logoutForm" method="post" action="${contextPath}/logout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
<%--        <h2>Панель АДМИНИСТРАТОРА ${pageContext.request.userPrincipal.name} | <a onclick="document.forms['logoutForm'].submit()">Выйти</a>
        </h2>--%>

        <div class="panel panel-primary">
            <div class="panel-heading">Оплата за проживание в общежитии</div>
            <div class="panel-body">
        <div class="panel panel-danger">
            <div class="panel-heading">Неподтверждённые транзакции</div>
                <div class="panel-body">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>Студент</th>
                            <th>Ключ</th>
                            <th>Месяц</th>
                            <th>Дата оплаты</th>
                            <th>Сумма</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${listPays}" var="pay">
                            <c:if test="${pay.status_pay == false}">
                                <tr>
                                    <c:forEach items="${pay.users}" var="user">
                                        <td>${user.firstName} ${user.lastName}</td>
                                    </c:forEach>
                                    <td>${pay.number_pay}</td>
                                    <td>${pay.month_pay}</td>
                                    <td>${pay.date_pay}</td>
                                    <td>${pay.cost}</td>
                                    <td><a style="float: right" href="<c:url value='/admin/pay/s/${pay.id}'/>" class="btn btn-success">Подтвердить</a></td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </tbody>
                    </table>
                    </div>
            </div>
        <div class="panel panel-success">
            <div class="panel-heading">Подтверждённые транзакции</div>
            <div class="panel-body">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>Студент</th>
                        <th>Ключ</th>
                        <th>Месяц</th>
                        <th>Дата оплаты</th>
                        <th>Сумма</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${listPays}" var="pay">
                        <c:if test="${pay.status_pay == true}">
                            <tr>
                                <c:forEach items="${pay.users}" var="user">
                                    <td>${user.firstName} ${user.lastName}</td>
                                </c:forEach>
                                <td>${pay.number_pay}</td>
                                <td>${pay.month_pay}</td>
                                <td>${pay.date_pay}</td>
                                <td>${pay.cost}</td>
                                <td><a style="float: right" href="<c:url value='/admin/pay/f/${pay.id}'/>" class="btn btn-danger">Отменить</a></td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
                </div>
            </div>
        <hr><br>

    <div class="panel panel-primary">
        <div class="panel-heading">Дежурство на этаже общежития</div>
        <div class="panel-body">
            <div class="panel panel-info">
            <div class="panel-heading">Добавить новую запись</div>
            <div class="panel-body">
            <form:form modelAttribute="dutyForm" action="/admin/duty/add" class="form-horizontal" method="post">
            <div class="form-group">
                <div class="form-group">
                    <label class="control-label col-xs-3" for="users">Студент:</label>
                    <div style="width: 500px;" class="col-xs-9 ${status.error ? 'has-error' : ''}">
                        <form:select  path="users" class="form-control" multiple="false" id="users">
                            <form:options items="${listUsers}" itemLabel="lastName" itemValue="id" />
                        </form:select>
                        <form:errors path="users"></form:errors>
                    </div>
                </div>
                <div class="form-group">
                <label class="control-label col-xs-3" for="date">Дата:</label>
                    <spring:bind path="date">
                        <div style="width: 500px;" class="col-xs-9 ${status.error ? 'has-error' : ''}">
                            <form:input path="date" type="date"
                                        class="form-control" id="date"/>
                            <form:errors path="date"></form:errors>
                        </div>
                    </spring:bind>
                </div>
                <div class="form-group">
                <label class="control-label col-xs-3" for="time_duty">Время:</label>
                    <spring:bind path="time_duty">
                        <div style="width: 500px;" class="col-xs-9 ${status.error ? 'has-error' : ''}">
                            <form:input path="time_duty" type="text"
                                        class="form-control" id="time_duty"/>
                            <form:errors path="time_duty"></form:errors>
                        </div>
                    </spring:bind>
                </div>
                <br />
                <div class="form-group">
                    <div class="col-xs-offset-3 col-xs-9">
                        <input type="submit" class="btn btn-primary" value="Добавить">
                        <input type="reset" class="btn btn-default" value="Очистить форму">
                    </div>
                </div>
            </div>

        </form:form>
            </div>
                </div>


                <div class="form-group">
                    <div class="panel panel-danger">
                        <div class="panel-heading">Неподтвержденные записи</div>
                        <div class="panel-body">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>Студент</th>
                                    <th>Дата</th>
                                    <th>Время</th>
                                </tr>
                                </thead>
                                <tbody id="myTableDutyDanger">
                                <c:forEach items="${listDuties}" var="duty">
                                    <tr>
                                        <c:if test="${duty.status == 0}">
                                            <c:forEach items="${duty.users}" var="user">
                                                <td>${user.username}</td>
                                            </c:forEach>
                                            <td>${duty.date}</td>
                                            <td>${duty.time_duty}</td>
                                        </c:if>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <hr><br>
                        </div>
                    </div>
                        <div class="panel panel-warning">
                        <div class="panel-heading">Записи, ожидающие подтверждения</div>
                        <div class="panel-body">
                            <h4><i>Запросы на подтверждение</i></h4>
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>Студент</th>
                                    <th>Дата</th>
                                    <th>Время</th>
                                    <th></th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody id="myTableDutyDanger2">
                                <c:forEach items="${listDuties}" var="duty">
                                    <tr>
                                    <c:if test="${duty.status == 1 && duty.reason == null}">
                                        <c:forEach items="${duty.users}" var="user">
                                            <td>${user.username}</td>
                                        </c:forEach>
                                        <td>${duty.date}</td>
                                        <td>${duty.time_duty}</td>
                                        <td><a style="float: right" href="<c:url value='/admin/duty/f/${duty.id}'/>" class="btn btn-danger">Отказать</a></td>
                                        <td><a style="float: right" href="<c:url value='/admin/duty/s/${duty.id}'/>" class="btn btn-success">Принять</a></td>
                                    </c:if>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <hr><br>

                            <h4><i>Запросы на отказ</i></h4>
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>Студент</th>
                                    <th>Дата</th>
                                    <th>Время</th>
                                    <th>Причина</th>
                                    <th></th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody id="myTableDutyDanger3">
                                <c:forEach items="${listDuties}" var="duty">
                                    <tr>
                                    <c:if test="${duty.status == 1 && duty.reason != null}">
                                        <c:forEach items="${duty.users}" var="user">
                                            <td>${user.username}</td>
                                        </c:forEach>
                                        <td>${duty.date}</td>
                                        <td>${duty.time_duty}</td>
                                        <td>${duty.reason}</td>
                                        <td><a style="float: right" href="<c:url value='/admin/duty/f/${duty.id}'/>" class="btn btn-danger">Отказать</a></td>
                                        <td><a style="float: right" href="<c:url value='/admin/duty/s/${duty.id}'/>" class="btn btn-success">Принять</a></td>
                                    </c:if>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        </div>


                    <div class="panel panel-success">
                        <div class="panel-heading">Успешные записи</div>
                        <div class="panel-body">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>Студент</th>
                                    <th>Дата</th>
                                    <th>Время</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody id="myTableDutyDanger4">
                                <c:forEach items="${listDuties}" var="duty">
                                    <tr>
                                    <c:if test="${duty.status == 2}">
                                        <c:forEach items="${duty.users}" var="user">
                                            <td>${user.username}</td>
                                        </c:forEach>
                                        <td>${duty.date}</td>
                                        <td>${duty.time_duty}</td>
                                        <td><a style="float: right" href="<c:url value='/admin/duty/f/${duty.id}'/>" class="btn btn-danger">Отменить</a></td>
                                    </c:if>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
<hr><br>
        <div class="panel panel-primary">
            <div class="panel-heading">Контроль проживания в общежитии</div>
            <div class="panel-body">
                <div class="panel panel-info">
                    <div class="panel-heading">Добавить новую запись</div>
                    <div class="panel-body">
                <form:form modelAttribute="controlForm" action="admin/control/add" class="form-horizontal" method="post">
                    <div class="form-group">
                        <div class="form-group">
                            <label class="control-label col-xs-3" for="rooms">Комната:</label>
                            <div style="width: 500px;" class="col-xs-9 ${status.error ? 'has-error' : ''}">
                                <form:select  path="rooms" class="form-control" multiple="false" id="rooms">
                                    <form:options items="${listRooms}" itemLabel="level" itemValue="id" />
                                </form:select>
                                <form:errors path="rooms"></form:errors>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-xs-3" for="cleanliness">Чистота:</label>
                            <spring:bind path="cleanliness">
                                <div style="width: 500px;" class="col-xs-9 ${status.error ? 'has-error' : ''}">
                                    <form:input path="cleanliness" type="number"
                                                class="form-control" id="cleanliness"/>
                                    <form:errors path="cleanliness"></form:errors>
                                </div>
                            </spring:bind>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-xs-3" for="tidiness">Порядок:</label>
                            <spring:bind path="tidiness">
                                <div style="width: 500px;" class="col-xs-9 ${status.error ? 'has-error' : ''}">
                                    <form:input path="tidiness" type="number"
                                                class="form-control" id="tidiness"/>
                                    <form:errors path="tidiness"></form:errors>
                                </div>
                            </spring:bind>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-xs-3" for="date_control">Дата:</label>
                            <spring:bind path="date_control">
                                <div style="width: 500px;" class="col-xs-9 ${status.error ? 'has-error' : ''}">
                                    <form:input path="date_control" type="date"
                                                class="form-control" id="date_control"/>
                                    <form:errors path="date_control"></form:errors>
                                </div>
                            </spring:bind>
                        </div>
                        <br />
                        <div class="form-group">
                            <div class="col-xs-offset-3 col-xs-9">
                                <input type="submit" class="btn btn-primary" value="Добавить">
                                <input type="reset" class="btn btn-default" value="Очистить форму">
                            </div>
                        </div>
                    </div>

                </form:form>
                        </div></div>
            <%--    <div class="panel panel-default">
&lt;%&ndash;
                    <div class="panel-heading">Неподтверждённые транзакции</div>
&ndash;%&gt;
                    <div class="panel-body">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>Комната</th>
                                <th>Чистота</th>
                                <th>Порядок</th>
                                <th>Дата</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${listRooms}" var="room">
                                <tr>
                                    <td>${room.level}</td>
                                    <c:forEach items="${room.controls}" var="control">
                                        <td>${control.cleanliness}</td>
                                        <td>${control.tidiness}</td>
                                        <td>${control.date_control}</td>
                                </c:forEach>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>--%>
            </div>
        </div>

<%--</div>--%>
    <hr><br>
<div class="panel panel-success">
    <div class="panel-heading">Управление пользователями</div>
    <div class="panel-body">
        <table class="table table-striped">
            <thead>
            <tr>
                <th>id</th>
                <th>Логин</th>
                <th>Пароль</th>
                <th>Комната</th>
                <th></th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${listUsers}" var="user">
                <tr>
                    <td>${user.id}</td>
                    <td>${user.username}</td>
                    <td>${user.password}</td>
                    <c:forEach items="${user.rooms}" var="room">
                        <td>${room.level}</td>
                    </c:forEach>
                    <td><a href="<c:url value='/users/user/${user.id}'/>" class="btn btn-info">Профиль</a></td>
                    <td><a href="<c:url value='/admin/users/delete/${user.id}'/>" class="btn btn-danger">Delete</a></td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
</div>
</div>
    <hr><br>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>

</body>
</html>