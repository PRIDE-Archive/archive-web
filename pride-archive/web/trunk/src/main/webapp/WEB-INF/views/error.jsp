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
        </p>
    </nav>
</div>

<div id="errors" class="grid_24">

    <c:choose>
        <c:when test="${not empty errorTitle}">
            <%-- if error message is passed as model attributes--%>
            <h3>${errorTitle}</h3>
            <p style="font-size: 14px">${errorMessage}</p>
            <p style="font-size: 14px">${errorAdvice}</p>
        </c:when>
        <c:otherwise>
            <%-- if error message passed as request parameter --%>
            <h3>${param.errorTitle}</h3>
            <p style="font-size: 14px">${param.errorMessage}</p>
            <p style="font-size: 14px">${param.errorAdvice}</p>
        </c:otherwise>
    </c:choose>

</div>
