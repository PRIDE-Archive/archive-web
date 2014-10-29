<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div class="grid_24 clearfix">
    <nav id="breadcrumb">
        <p>
            <spring:url var="prideUrl" value="http://www.ebi.ac.uk/pride"/>
            <spring:url var="priderUrl" value="/"/>
            <a href="${prideUrl}"><fmt:message key="pride"/></a> &gt; <a href="${priderUrl}"><fmt:message key="prider"/></a>
            &gt; <fmt:message key="login.title"/>
        </p>
    </nav>
</div>

<div class="grid_23 clearfix">
    <div class="grid_24">
        <h2>
            <fmt:message key="login.title"/>
        </h2>
    </div>

    <div class="grid_24" style="border-top: solid #d9d9d9 1px;">
        <div class="grid_11" style="border-right: solid #d9d9d9 1px;">

            <div style="padding-top: 20px;">

                <c:choose>
                    <c:when test="${not empty param.error}">
                        <div class="error">
                            <p><fmt:message key="login.unsuccessful"/></p>
                        </div>
                    </c:when>
                    <c:when test="${not empty loginErrorMessage}">
                        <div class="error">
                            <p>${loginErrorMessage}</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="success">
                            <p><fmt:message key="login.using.email"/></p>
                        </div>
                    </c:otherwise>
                </c:choose>

                <form action="<c:url value='/j_spring_security_check'/>" method="post">
                    <div>
                        <label for="j_username" class="block-label">
                            <fmt:message key="email"/>
                        </label>

                        <input class="input-box" type='text' id='j_username' name='j_username' value='<c:out value="${user}"/>'/>
                    </div>

                    <div>
                        <label for="j_password" class="block-label">
                            <fmt:message key="login.password"/>
                        </label>

                        <input class="input-box" type='password' id='j_password' name='j_password'
                               placeholder="Password"
                               required="true"
                               />

                        <div>
                            <label>
                                <input type="checkbox" id="show-password"> Show Password
                            </label>
                        </div>
                    </div>

                    <div>
                        <button class="button" type="submit">
                            <fmt:message key="login.submit"/>
                        </button>

                        <a href="<c:url value='/users/forgotpassword' />">
                            <fmt:message key="forgot.password"/>
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <div class="grid_12">
            <div style="padding-top: 20px">
                <h3>
                    <fmt:message key="login.no.account"/>
                </h3>

                <p>
                    Go to <a href="<c:url value='/register'/>">Registration</a>.
                </p>
            </div>
        </div>
    </div>
</div>

