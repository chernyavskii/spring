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

    <link href="https://fonts.googleapis.com/css?family=Ledger" rel="stylesheet">

    <title>Оплата за проживание</title>
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
<div class="container" style="font-family: 'Ledger', serif;">
    <c:forEach items="${user.rooms}" var="room">
        <div style="margin-top:-5px;">
            <h2><b>Комната № ${room.level}</b></h2>
            <h4>Общее количество: ${room.full_count}</h4>
            <h4>Текущее количество: ${room.current_count}</h4>
        </div>
    </c:forEach>
    <hr>
    <div class="panel panel-info" style="width: 900px; padding: 10px; margin: auto;">
        <div class="panel-heading">Дежурство на этаже общежития</div>
        <div class="panel-body">
            <div class="form-group" style="width: 750px; padding: 10px; margin: auto;">
                <div class="panel panel-danger">
                    <div class="panel-heading">Неподтвержденные записи</div>
                    <div class="panel-body">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>Дата</th>
                                <th>Время</th>
                                <th></th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody id="myTableDutyDanger">
                            <c:forEach items="${user.duties}" var="item">
                                <c:if test="${item.status == 0}">
                                    <tr>
                                        <td>${item.date}</td>
                                        <td>${item.time_duty}</td>
                                        <td>
                                            <button style="float:right;" <%--href="<c:url value='/users/duty/f/${item.id}'/>"--%> type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Отказ</button>
                                            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="exampleModalLabel">Новое сообщение администратору</h5>
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form:form action="/users/duty/${item.id}" method="post" modelAttribute="dutyForm">
                                                                <label class="control-label col-xs-3" for="reason">Причина:</label>
                                                                <spring:bind path="reason">
                                                                    <div class="col-xs-9 ${status.error ? 'has-error' : ''}">
                                                                        <form:textarea path="reason" class="form-control" id="reason" />
                                                                        <form:errors path="reason"></form:errors>
                                                                    </div>
                                                                </spring:bind>
                                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                                <br><br>
                                                                <div class="modal-footer">
                                                                    <input type="submit" class="btn btn-primary" value="Добавить">
                                                                    <input type="reset" class="btn btn-default" value="Очистить форму">
                                                                </div>
                                                            </form:form>
                                                        </div>
                                                            <%--<div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                <button type="button" class="btn btn-primary">Send message</button>
                                                            </div>--%>
                                                    </div>
                                                </div>
                                            </div>
<%--
                                            <a  href="<c:url value='/users/duty/f/${item.id}'/>" class="btn btn-success">Отказ</a>
--%>
                                            <td><a style="float:right;" href="<c:url value='/users/duty/r/${item.id}'/>" class="btn btn-success">Принять</a></td>
                                        </td>
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
                                <th>Дата</th>
                                <th>Время</th>
                            </tr>
                            </thead>
                            <tbody id="myTableDutyWarning">
                            <c:forEach items="${user.duties}" var="item">
                                <c:if test="${item.status == 1}">
                                    <tr>
                                        <td>${item.date}</td>
                                        <td>${item.time_duty}</td>
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
                                <th>Дата</th>
                                <th>Время</th>
                            </tr>
                            </thead>
                            <tbody id="myTableDutySuccess">
                            <c:forEach items="${user.duties}" var="item">
                                <c:if test="${item.status == 2}">
                                    <tr>
                                        <td>${item.date}</td>
                                        <td>${item.time_duty}</td>
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
    <hr><br>
</div>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
<script>
    $('#exampleModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        /*var recipient = button.data('whatever') // Extract info from data-* attributes
        // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        var modal = $(this)
        modal.find('.modal-title').text('New message to ' + recipient)
        modal.find('.modal-body input').val(recipient)*/
    })
</script>
</body>
</html>