<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="priderElement" tagdir="/WEB-INF/tags/elements" %>

<%@ attribute name="page" required="true" type="org.springframework.data.domain.Page" %>
<%@ attribute name="q" required="false" type="java.lang.String" %>
<%@ attribute name="ptmsFilters" required="false" type="java.util.Collection" %>

<%-- Pagination Bar--%>
<div class="grid_24">
    <div class="col_pager">
    <div class="pr-pager">
        <c:if test="${page.numberOfElements gt 0}">
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
            <c:if test="${page.totalPages gt 1}">
                <fmt:message key="search.page"/>
                <c:choose>
                    <c:when test="${0 eq page.number}">
                        <span>1</span>
                    </c:when>
                    <c:otherwise>
                        <a href="${first}">1</a>
                    </c:otherwise>
                </c:choose>
            </c:if>
            <c:if test="${page.number gt 3}">...</c:if>

            <c:forEach var="nPage" begin="${(page.number lt 4) ? 2 : (page.number-1)}" end="${(page.number gt (page.totalPages-3)) ? page.totalPages-1 : (page.number+3)}">
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
                <c:choose>
                    <c:when test="${nPage-1 eq page.number}">
                        <span>${nPage}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="${middle}">${nPage}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${page.number lt (page.totalPages-3)}">...</c:if>

            <c:if test="${page.totalPages gt 1}">
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
                <c:choose>
                    <c:when test="${page.totalPages-1 eq page.number}">
                        <span>${page.totalPages}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="${last}">${page.totalPages}</a>
                    </c:otherwise>
                </c:choose>

            </c:if>
        </c:if>
    </div>

    <div class="pr-page-size">
        <c:if test="${page.totalElements gt 10}">
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
            <c:choose>
                <c:when test="${page.size eq  10}">
                    <span>10</span>
                </c:when>
                <c:otherwise>
                    <a href="${ten}">10</a>
                </c:otherwise>
            </c:choose>
        </c:if>
        <c:if test="${page.totalElements ge 20}">
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
            <c:choose>
                <c:when test="${page.size eq  20}">
                    <span>20</span>
                </c:when>
                <c:otherwise>
                    <a href="${twenty}">20</a>
                </c:otherwise>
            </c:choose>
        </c:if>
        <c:if test="${page.totalElements ge 50}">
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
            <c:choose>
                <c:when test="${page.size eq  50}">
                    <span>50</span>
                </c:when>
                <c:otherwise>
                    <a href="${fifty}">50</a>
                </c:otherwise>
            </c:choose>
        </c:if>
        <c:if test="${page.totalElements ge 100}">
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
            <c:choose>
                <c:when test="${page.size eq  100}">
                    <span>100</span>
                </c:when>
                <c:otherwise>
                    <a href="${hundred}">100</a>
                </c:otherwise>
            </c:choose>
        </c:if>
    </div>
    <div class="pr-stats">
        Showing <span>${page.size * page.number + 1} - ${page.size * page.number + page.numberOfElements}</span> of <span>${page.totalElements}</span> results
    </div>
</div>
</div>
