<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="priderElement" tagdir="/WEB-INF/tags/elements" %>

<%@ attribute name="page" required="true" type="org.springframework.data.domain.Page" %>
<%@ attribute name="q" required="true" type="java.lang.String" %>
<%@ attribute name="ptmsFilters" required="true" type="java.util.Collection" %>

<!-- Pagination Bar -->
<spring:url value="" var="prev">
    <spring:param name="page" value="${page.number - 1}"/>
    <spring:param name="size" value="${page.size}"/>
    <spring:param name="q" value="${q}"/>

    <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
        <spring:param name="sort" value="${sortOrder}"/>
    </c:forEach>

    <c:forEach var="theFilter" items="${ptmsFilters}">
        <spring:param name="ptmsFilters" value="${theFilter}"/>
    </c:forEach>
</spring:url>

<spring:url value="" var="next">
    <spring:param name="page" value="${page.number + 1}"/>
    <spring:param name="size" value="${page.size}"/>
    <spring:param name="q" value="${q}"/>

    <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
        <spring:param name="sort" value="${sortOrder}"/>
    </c:forEach>

    <c:forEach var="theFilter" items="${ptmsFilters}">
        <spring:param name="ptmsFilters" value="${theFilter}"/>
    </c:forEach>
</spring:url>

<span>
    <c:choose>
        <c:when test="${page.number == 0}">
            <span title="previous page" class="prevPageGreyButton"></span>
        </c:when>
        <c:otherwise>
            <a id="previous" class="prevPageLink" href="${prev}">
                <span title="previous page" class="prevPageButton"></span>
            </a>
        </c:otherwise>
    </c:choose>

    <strong>${page.size * page.number}</strong>
     to
    <strong>${page.size * page.number + page.size}</strong>
     of
    <strong>${page.totalElements}</strong>


    <c:choose>
        <c:when test="${page.number == page.totalPages - 1}">
            <span title="next page" class="nextPageGreyButton"></span>
        </c:when>
        <c:otherwise>
            <a id="next" class="nextPageLink" href="${next}">
                <span title="next page" class="nextPageButton"></span>
            </a>
        </c:otherwise>
    </c:choose>
</span>
