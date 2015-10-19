<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%-- PRIDE archive web check --%>

<%-- breadcrumb--%>
<div class="grid_24 clearfix">
    <nav id="breadcrumb">
        <p>
            <spring:url var="prideUrl" value="//www.ebi.ac.uk/pride"/>
            <spring:url var="priderUrl" value="/"/>
            <a href="${prideUrl}"><fmt:message key="pride"/></a>
            &gt; <a href="${priderUrl}"><fmt:message key="prider"/></a>
            &gt; <fmt:message key="web.check.title"/>
        </p>
    </nav>
</div>


<div class="grid_23 clearfix">
    <div class="grid_24">
        <h2>
            <fmt:message key="web.check.title"/>
        </h2>
        <p>

            <c:choose>
                <c:when test="${checkSuccess}">
                    <fmt:message key="web.check.success.msg"/>
                </c:when>
                <c:otherwise>
                    <fmt:message key="web.check.failure.msg"/>
                </c:otherwise>
            </c:choose>

        </p>
        <pre>${report}</pre>
    </div>


</div>
