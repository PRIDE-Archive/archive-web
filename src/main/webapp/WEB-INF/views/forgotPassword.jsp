<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="grid_24 clearfix">
    <nav id="breadcrumb">
        <p>
            <spring:url var="prideUrl" value="//www.ebi.ac.uk/pride"/>
            <spring:url var="priderUrl" value="/"/>
            <a href="${prideUrl}"><fmt:message key="pride"/></a> &gt; <a href="${priderUrl}"><fmt:message key="prider"/></a>
            &gt; <fmt:message key="forgot.password.title"/>
        </p>
    </nav>
</div>

<div class="grid_23 clearfix">
    <div class="grid_24">
        <h2>
            <fmt:message key="forgot.password.title"/>
        </h2>
    </div>

    <div class="grid_24" style="border-top: solid #d9d9d9 1px;">

        <div style="padding-top: 20px;">
            <c:if test="${not empty error}">
                <div class="error">
                    <p><fmt:message key="forgot.password.unsuccessful"/></p>
                </div>
            </c:if>

            <spring:url var="forgotPasswordUrl" value="/users/forgotpassword"/>
            <form:form commandName="user" method="POST" action="${forgotPasswordUrl}">
                <div class="grid_24">
                    <label class="block-label">
                        <fmt:message key="forgot.password.email"/>
                    </label>
                    <form:input cssClass="input-box" path="email"/>
                    <form:errors cssClass="error" path="email"/>
                </div>

                <div>
                    <button class="button" type="submit">
                        <fmt:message key="forgot.password.submit"/>
                    </button>
                </div>
            </form:form>
        </div>
    </div>
</div>



