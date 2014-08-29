<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div>
    <h3><fmt:message key="register.successful"/></h3>
    <spring:url var="loginUrl" value="/login"/>
    <p style="font-size: 14px"><fmt:message key="register.successful.message.part1"/> ${user.email}. <fmt:message key="register.successful.message.part2"/> <a href="${loginUrl}"><fmt:message key="login.title"/></a></p>
</div>
