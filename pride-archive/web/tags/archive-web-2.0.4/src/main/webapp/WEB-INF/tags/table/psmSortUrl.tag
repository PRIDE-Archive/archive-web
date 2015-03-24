<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="page" required="true" type="org.springframework.data.domain.Page" %>
<%@ attribute name="q" required="true" type="java.lang.String" %>
<%@ attribute name="ptmsFilters" required="true" type="java.util.Collection" %>
<%@ attribute name="urlType" required="true" type="java.lang.String" %>

<%-- Construct sort URL for peptide sequence --%>
<spring:url var="peptideSequenceSortURL" value="">
    <spring:param name="page" value="${page.number}"/>
    <spring:param name="size" value="${page.size}"/>
    <spring:param name="q" value="${q}"/>

    <c:set var="found" value="false"/>

    <%--If peptide_sequence was there we toggle the value--%>
    <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
        <c:if test="${not empty sortOrder}">
            <c:choose>
                <c:when test="${sortOrder eq 'peptide_sequence: ASC'}">
                    <spring:param name="sort" value="peptide_sequence: DESC"/>
                    <c:set var="found" value="true"/>
                </c:when>
                <c:when test="${sortOrder eq 'peptide_sequence: DESC'}">
                    <spring:param name="sort" value="peptide_sequence: ASC"/>
                    <c:set var="found" value="true"/>
                </c:when>
                <c:otherwise>
                    <spring:param name="sort" value="${sortOrder}"/>
                </c:otherwise>
            </c:choose>
        </c:if>
    </c:forEach>

    <%--peptide_sequence wasn't there so we add the value at the end --%>
    <c:if test="${not found}">
        <spring:param name="sort" value="${fn:containsIgnoreCase(page.sort, 'peptide_sequence: ASC') ? 'peptide_sequence: DESC' : 'peptide_sequence: ASC'}"/>
    </c:if>

    <c:forEach var="theFilter" items="${ptmsFilters}">
        <spring:param name="ptmsFilters" value="${theFilter}"/>
    </c:forEach>
</spring:url>

<%-- Construct sort URL for protein accession --%>
<spring:url var="proteinAccSortURL" value="">
    <spring:param name="page" value="${page.number}"/>
    <spring:param name="size" value="${page.size}"/>
    <spring:param name="q" value="${q}"/>

    <c:set var="found" value="false"/>

    <%--If protein_accession was there we toggle the value--%>
    <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
        <c:if test="${not empty sortOrder}">
            <c:choose>
                <c:when test="${sortOrder eq 'protein_accession: ASC'}">
                    <spring:param name="sort" value="protein_accession: DESC"/>
                    <c:set var="found" value="true"/>
                </c:when>
                <c:when test="${sortOrder eq 'protein_accession: DESC'}">
                    <spring:param name="sort" value="protein_accession: ASC"/>
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
        <spring:param name="sort" value="${fn:containsIgnoreCase(page.sort, 'protein_accession: ASC') ? 'protein_accession: DESC' : 'protein_accession: ASC'}"/>
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

<%-- Construct sort URL for experimental m/z --%>
<spring:url var="expMzSortURL" value="">
    <spring:param name="page" value="${page.number}"/>
    <spring:param name="size" value="${page.size}"/>
    <spring:param name="q" value="${q}"/>

    <c:set var="found" value="false"/>

    <%--If exp_mass_to_charge was there we toggle the value--%>
    <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
        <c:if test="${not empty sortOrder}">
            <c:choose>
                <c:when test="${sortOrder eq 'exp_mass_to_charge: ASC'}">
                    <spring:param name="sort" value="exp_mass_to_charge: DESC"/>
                    <c:set var="found" value="true"/>
                </c:when>
                <c:when test="${sortOrder eq 'exp_mass_to_charge: DESC'}">
                    <spring:param name="sort" value="exp_mass_to_charge: ASC"/>
                    <c:set var="found" value="true"/>
                </c:when>
                <c:otherwise>
                    <spring:param name="sort" value="${sortOrder}"/>
                </c:otherwise>
            </c:choose>
        </c:if>
    </c:forEach>

    <%--exp_mass_to_charge wasn't there so we add the value at the end --%>
    <c:if test="${not found}">
        <spring:param name="sort" value="${fn:containsIgnoreCase(page.sort, 'exp_mass_to_charge: ASC') ? 'exp_mass_to_charge: DESC' : 'exp_mass_to_charge: ASC'}"/>
    </c:if>

    <c:forEach var="theFilter" items="${ptmsFilters}">
        <spring:param name="ptmsFilters" value="${theFilter}"/>
    </c:forEach>
</spring:url>

<%-- Construct sort URL for charge state --%>
<spring:url var="chargeSortURL" value="">
    <spring:param name="page" value="${page.number}"/>
    <spring:param name="size" value="${page.size}"/>
    <spring:param name="q" value="${q}"/>

    <c:set var="found" value="false"/>

    <%--If exp_mass_to_charge was there we toggle the value--%>
    <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
        <c:if test="${not empty sortOrder}">
            <c:choose>
                <c:when test="${sortOrder eq 'charge: ASC'}">
                    <spring:param name="sort" value="charge: DESC"/>
                    <c:set var="found" value="true"/>
                </c:when>
                <c:when test="${sortOrder eq 'charge: DESC'}">
                    <spring:param name="sort" value="charge: ASC"/>
                    <c:set var="found" value="true"/>
                </c:when>
                <c:otherwise>
                    <spring:param name="sort" value="${sortOrder}"/>
                </c:otherwise>
            </c:choose>
        </c:if>
    </c:forEach>

    <%--exp_mass_to_charge wasn't there so we add the value at the end --%>
    <c:if test="${not found}">
        <spring:param name="sort" value="${fn:containsIgnoreCase(page.sort, 'charge: ASC') ? 'charge: DESC' : 'charge: ASC'}"/>
    </c:if>

    <c:forEach var="theFilter" items="${ptmsFilters}">
        <spring:param name="ptmsFilters" value="${theFilter}"/>
    </c:forEach>
</spring:url>

<%--URLS--%>
<c:if test="${fn:contains(urlType, 'peptideSequenceSortURL')}">
    <a class="sortLink" href="${peptideSequenceSortURL}">
        <c:choose>
            <c:when test="${fn:containsIgnoreCase(page.sort, 'peptide_sequence: DESC')}">
                <span title="sort descending" class="sortDescButton"></span>
            </c:when>
            <c:when test="${fn:containsIgnoreCase(page.sort, 'peptide_sequence: ASC')}">
                <span title="sort ascending" class="sortAscButton"></span>
            </c:when>
            <c:otherwise>
                <span title="sort" class="sortButton"></span>
            </c:otherwise>
        </c:choose>
    </a>
</c:if>
<c:if test="${fn:contains(urlType, 'proteinAccSortURL')}">
    <a class="sortLink" href="${proteinAccSortURL}">
        <c:choose>
            <c:when test="${fn:containsIgnoreCase(page.sort, 'protein_accession: DESC')}">
                <span title="sort descending" class="sortDescButton"></span>
            </c:when>
            <c:when test="${fn:containsIgnoreCase(page.sort, 'protein_accession: ASC')}">
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
<c:if test="${fn:contains(urlType, 'expMzSortURL')}">
    <a class="sortLink" href="${expMzSortURL}">
        <c:choose>
            <c:when test="${fn:containsIgnoreCase(page.sort, 'exp_mass_to_charge: DESC')}">
                <span title="sort descending" class="sortDescButton"></span>
            </c:when>
            <c:when test="${fn:containsIgnoreCase(page.sort, 'exp_mass_to_charge: ASC')}">
                <span title="sort ascending" class="sortAscButton"></span>
            </c:when>
            <c:otherwise>
                <span title="sort" class="sortButton"></span>
            </c:otherwise>
        </c:choose>
    </a>
</c:if>
<c:if test="${fn:contains(urlType, 'chargeSortURL')}">
    <a class="sortLink" href="${chargeSortURL}">
        <%--We need to split the list to avoid mapping charge to exp_mass_to_charge--%>
            <c:set var="found" value="false"/>
            <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
            <c:if test="${not empty sortOrder}">
                <c:if test="${sortOrder eq 'charge: DESC'}">
                    <span title="sort descending" class="sortDescButton"></span>
                    <c:set var="found" value="true"/>
                </c:if>
                <c:if test="${sortOrder eq 'charge: ASC'}">
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
