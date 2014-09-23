<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="priderElement" tagdir="/WEB-INF/tags/elements" %>

<%@ attribute name="page" required="true" type="org.springframework.data.domain.Page" %>
<%@ attribute name="q" required="true" type="java.lang.String" %>
<%@ attribute name="ptmsFilters" required="true" type="java.util.Collection" %>

<!-- Pagination Bar -->
<span class="float_l">
    <spring:url value="" var="first">
        <spring:param name="page" value="${0}"/>
        <spring:param name="size" value="${page.size}"/>
        <spring:param name="q" value="${q}"/>

        <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
            <spring:param name="sort" value="${sortOrder}"/>
        </c:forEach>

        <c:forEach var="theFilter" items="${ptmsFilters}">
            <spring:param name="ptmsFilters" value="${theFilter}"/>
        </c:forEach>
    </spring:url>
    <a href="${first}" class="${0==page.number?'selected':''}">1</a>

    <c:if test="${page.number>3}">...</c:if>

    <c:forEach var="nPage" begin="${(page.number<4) ? 2 : (page.number-1)}" end="${(page.number>(page.totalPages-3)) ? page.totalPages-1 : (page.number+2)}">
        <spring:url value="" var="middle">
            <spring:param name="page" value="${nPage-1}"/>
            <spring:param name="size" value="${page.size}"/>
            <spring:param name="q" value="${q}"/>

            <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
                <spring:param name="sort" value="${sortOrder}"/>
            </c:forEach>

            <c:forEach var="theFilter" items="${ptmsFilters}">
                <spring:param name="ptmsFilters" value="${theFilter}"/>
            </c:forEach>
        </spring:url>
        <a href="${middle}" class="${nPage-1==page.number?'selected':''}">${nPage}</a>
    </c:forEach>

    <c:if test="${page.number<(page.totalPages-3)}">...</c:if>

    <c:if test="${page.totalPages > 1}">
        <spring:url value="" var="last">
            <spring:param name="page" value="${page.totalPages-1}"/>
            <spring:param name="size" value="${page.size}"/>
            <spring:param name="q" value="${q}"/>

            <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
                <spring:param name="sort" value="${sortOrder}"/>
            </c:forEach>

            <c:forEach var="theFilter" items="${ptmsFilters}">
                <spring:param name="ptmsFilters" value="${theFilter}"/>
            </c:forEach>
        </spring:url>
        <a href="${last}" class="${page.totalPages-1==page.number?'selected':''}">${page.totalPages}</a>
    </c:if>
</span>

<span class="float_r">
    <c:if test="${page.totalElements>10}">
        <fmt:message key="search.show.entries"/>
        <spring:url value="" var="ten">
            <spring:param name="page" value="0"/>
            <spring:param name="size" value="10"/>
            <spring:param name="q" value="${q}"/>

            <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
                <spring:param name="sort" value="${sortOrder}"/>
            </c:forEach>

            <c:forEach var="theFilter" items="${ptmsFilters}">
                <spring:param name="ptmsFilters" value="${theFilter}"/>
            </c:forEach>
        </spring:url>
        <a href="${ten}" class="${page.size==10?'selected':''}">10</a>
    </c:if>
    <c:if test="${page.totalElements>20}">
        <spring:url value="" var="twenty">
            <spring:param name="page" value="0"/>
            <spring:param name="size" value="20"/>
            <spring:param name="q" value="${q}"/>

            <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
                <spring:param name="sort" value="${sortOrder}"/>
            </c:forEach>

            <c:forEach var="theFilter" items="${ptmsFilters}">
                <spring:param name="ptmsFilters" value="${theFilter}"/>
            </c:forEach>
        </spring:url>
        <a href="${twenty}" class="${page.size==20?'selected':''}">20</a>
    </c:if>
    <c:if test="${page.totalElements>50}">
        <spring:url value="" var="fifty">
            <spring:param name="page" value="0"/>
            <spring:param name="size" value="50"/>
            <spring:param name="q" value="${q}"/>

            <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
                <spring:param name="sort" value="${sortOrder}"/>
            </c:forEach>

            <c:forEach var="theFilter" items="${ptmsFilters}">
                <spring:param name="ptmsFilters" value="${theFilter}"/>
            </c:forEach>
        </spring:url>
        <a href="${fifty}" class="${page.size==50?'selected':''}">50</a>
    </c:if>
    <c:if test="${page.totalElements>100}">
        <spring:url value="" var="hundred">
            <spring:param name="page" value="0"/>
            <spring:param name="size" value="100"/>
            <spring:param name="q" value="${q}"/>

            <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
                <spring:param name="sort" value="${sortOrder}"/>
            </c:forEach>

            <c:forEach var="theFilter" items="${ptmsFilters}">
                <spring:param name="ptmsFilters" value="${theFilter}"/>
            </c:forEach>
        </spring:url>
        <a href="${hundred}" class="${page.size==100?'selected':''}">100</a>
    </c:if>
</span>
