<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="page" required="true" type="org.springframework.data.domain.Page" %>
<%@ attribute name="q" required="true" type="java.lang.String" %>
<%@ attribute name="ptmsFilters" required="true" type="java.util.Collection" %>
<%@ attribute name="urlType" required="true" type="java.lang.String" %>

<%-- Construct sort URL for the clean protein accession --%>
<spring:url var="proteinAccSortURL" value="">
    <spring:param name="page" value="${page.number}"/>
    <spring:param name="size" value="${page.size}"/>
    <spring:param name="q" value="${q}"/>

    <c:set var="found" value="false"/>

    <%--If protein_accession was there we toggle the value--%>
    <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
        <c:if test="${not empty sortOrder}">
            <c:choose>
                <c:when test="${sortOrder eq 'accession: ASC'}">
                    <spring:param name="sort" value="accession: DESC"/>
                    <c:set var="found" value="true"/>
                </c:when>
                <c:when test="${sortOrder eq 'accession: DESC'}">
                    <spring:param name="sort" value="accession: ASC"/>
                    <c:set var="found" value="true"/>
                </c:when>
                <c:otherwise>
                    <spring:param name="sort" value="${sortOrder}"/>
                </c:otherwise>
            </c:choose>
        </c:if>
    </c:forEach>

    <%--protein_accession wasn't there so we add the value at the end --%>
    <c:if test="${not found}">
        <spring:param name="sort" value="${fn:containsIgnoreCase(page.sort, 'accession: ASC') ? 'accession: DESC' : 'accession: ASC'}"/>
    </c:if>

    <c:forEach var="theFilter" items="${ptmsFilters}">
        <spring:param name="ptmsFilters" value="${theFilter}"/>
    </c:forEach>
</spring:url>

<%-- Construct sort URL for submitted protein accession --%>
<spring:url var="submittedProteinAccSortURL" value="">
    <spring:param name="page" value="${page.number}"/>
    <spring:param name="size" value="${page.size}"/>
    <spring:param name="q" value="${q}"/>

    <c:set var="found" value="false"/>

    <%--If protein_accession was there we toggle the value--%>
    <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
        <c:if test="${not empty sortOrder}">
            <c:choose>
                <c:when test="${sortOrder eq 'submitted_accession: ASC'}">
                    <spring:param name="sort" value="submitted_accession: DESC"/>
                    <c:set var="found" value="true"/>
                </c:when>
                <c:when test="${sortOrder eq 'submitted_accession: DESC'}">
                    <spring:param name="sort" value="submitted_accession: ASC"/>
                    <c:set var="found" value="true"/>
                </c:when>
                <c:otherwise>
                    <spring:param name="sort" value="${sortOrder}"/>
                </c:otherwise>
            </c:choose>
        </c:if>
    </c:forEach>

    <%--protein_accession wasn't there so we add the value at the end --%>
    <c:if test="${not found}">
        <spring:param name="sort" value="${fn:containsIgnoreCase(page.sort, 'submitted_accession: ASC') ? 'submitted_accession: DESC' : 'submitted_accession: ASC'}"/>
    </c:if>

    <c:forEach var="theFilter" items="${ptmsFilters}">
        <spring:param name="ptmsFilters" value="${theFilter}"/>
    </c:forEach>
</spring:url>

<%-- Construct sort URL for assay accession --%>
<spring:url var="assayAccSortURL" value="">
    <spring:param name="page" value="${page.number}"/>
    <spring:param name="size" value="${page.size}"/>
    <spring:param name="q" value="${q}"/>

    <c:set var="found" value="false"/>

    <%--If assay_accession was there we toggle the value--%>
    <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
        <c:if test="${not empty sortOrder}">
            <c:choose>
                <c:when test="${sortOrder eq 'assay_accession: ASC'}">
                    <spring:param name="sort" value="assay_accession: DESC"/>
                    <c:set var="found" value="true"/>
                </c:when>
                <c:when test="${sortOrder eq 'assay_accession: DESC'}">
                    <spring:param name="sort" value="assay_accession: ASC"/>
                    <c:set var="found" value="true"/>
                </c:when>
                <c:otherwise>
                    <spring:param name="sort" value="${sortOrder}"/>
                </c:otherwise>
            </c:choose>
        </c:if>
    </c:forEach>

    <%--assay_accession wasn't there so we add the value at the end --%>
    <c:if test="${not found}">
        <spring:param name="sort" value="${fn:containsIgnoreCase(page.sort, 'assay_accession: ASC') ? 'assay_accession: DESC' : 'assay_accession: ASC'}"/>
    </c:if>

    <c:forEach var="theFilter" items="${ptmsFilters}">
        <spring:param name="ptmsFilters" value="${theFilter}"/>
    </c:forEach>
</spring:url>

<%--URLS--%>
<c:if test="${fn:contains(urlType, 'proteinAccSortURL')}">
    <a class="sortLink" href="${proteinAccSortURL}">
            <%--We need to split the list to avoid mapping charge to exp_mass_to_charge--%>
        <c:set var="found" value="false"/>
        <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
            <c:if test="${not empty sortOrder}">
                <c:if test="${sortOrder eq 'accession: DESC'}">
                    <span title="sort descending" class="sortDescButton"></span>
                    <c:set var="found" value="true"/>
                </c:if>
                <c:if test="${sortOrder eq 'accession: ASC'}">
                    <span title="sort ascending" class="sortAscButton"></span>
                    <c:set var="found" value="true"/>
                </c:if>
            </c:if>
        </c:forEach>

        <c:if test="${not found}">
            <span title="sort" class="sortButton"></span>
        </c:if>
    </a>
</c:if>
<c:if test="${fn:contains(urlType, 'submittedProteinAccSortURL')}">
    <a class="sortLink" href="${submittedProteinAccSortURL}">
        <c:choose>
            <c:when test="${fn:containsIgnoreCase(page.sort, 'submitted_accession: DESC')}">
                <span title="sort descending" class="sortDescButton"></span>
            </c:when>
            <c:when test="${fn:containsIgnoreCase(page.sort, 'submitted_accession: ASC')}">
                <span title="sort ascending" class="sortAscButton"></span>
            </c:when>
            <c:otherwise>
                <span title="sort" class="sortButton"></span>
            </c:otherwise>
        </c:choose>
    </a>
</c:if>
<c:if test="${fn:contains(urlType, 'assayAccSortURL')}">
    <a class="sortLink" href="${assayAccSortURL}">
        <c:choose>
            <c:when test="${fn:containsIgnoreCase(page.sort, 'assay_accession: DESC')}">
                <span title="sort descending" class="sortDescButton"></span>
                <span title="sort descending" class="sortDescButton"></span>
            </c:when>
            <c:when test="${fn:containsIgnoreCase(page.sort, 'assay_accession: ASC')}">
                <span title="sort ascending" class="sortAscButton"></span>
            </c:when>
            <c:otherwise>
                <span title="sort" class="sortButton"></span>
            </c:otherwise>
        </c:choose>
    </a>
</c:if>
