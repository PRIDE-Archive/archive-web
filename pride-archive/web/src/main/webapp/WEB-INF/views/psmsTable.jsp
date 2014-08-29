<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="priderElement" tagdir="/WEB-INF/tags/elements" %>
<%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>

<%-- bread crumb--%>
<div class="grid_24 clearfix">
    <nav id="breadcrumb">
        <p>
            <spring:url var="prideUrl" value="http://www.ebi.ac.uk/pride"/>
            <spring:url var="priderUrl" value="/"/>
            <spring:url var="projectUrl" value="/projects/{accession}">
                <spring:param name="accession" value="${projectAccession}"/>
            </spring:url>
            <a href="${prideUrl}"><fmt:message key="pride"/></a> &gt; <a href="${priderUrl}"><fmt:message key="prider"/></a>
            &gt; <a href="${projectUrl}">${projectAccession}</a>
            <c:if test="${not empty assayAccession}">
                <spring:url var="assayUrl" value="/assays/{accession}">
                    <spring:param name="accession" value="${assayAccession}"/>
                </spring:url>
                &gt; <a href="${assayUrl}">${assayAccession}</a>
            </c:if>
            &gt; <span>Peptide spectrum match</span>
        </p>
    </nav>
</div>

<div id="search-result" class="grid_24">

<%--Title and count--%>
<h2>
    <strong>${page.totalElements}</strong> <fmt:message key="search.result.title"/>
    <c:if test="${q!= null and q!=''}">
        <fmt:message key="search.result.forterm"/> <span class="searchterm" id="query">${q}</span>
    </c:if>
    <c:set var="numFilters" value="${fn:length(ptmsFilters)}" />
    <c:if test="${numFilters>0}">+ ${numFilters} filters</c:if>
</h2>

<%--Filters--%>
<div class="grid_5 left-column search-filters">

<h4>Filter your results</h4>
<spring:url var="searchUrl" value=""/>

<%--search box--%>
<form id="psm-search" action="${searchUrl}"  method="get">
    <fieldset>
        <input type='hidden' name='size' value='${page.size}'/>
        <%--We show the first page--%>
        <input type='hidden' name='page' value='0'/>
        <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
            <input type='hidden' name="sort" value="${sortOrder}"/>
        </c:forEach>

        <%--active filters: used to keep a list of active filters and send them back to the server--%>
        <priderElement:inputHiddenList items="${ptmsFilters}" name="ptmsFilters"/>
        <label>
            <input id="psm-searchbox" type="text" name="q" autocomplete="true" value="${q}"/>
        </label>
        <button type="submit">Filter</button>
    </fieldset>
</form>

<%-- ADD filter form--%>
<form id="psm-add-filter" action="${searchUrl}" method="get">
    <fieldset>
        <input type='hidden' name='q' value='${q}'/>
        <input type='hidden' name='size' value='${page.size}'/>
        <%--we show the first page--%>
        <input type='hidden' name='page' value='0'/>
        <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
            <input type='hidden' name="sort" value="${sortOrder}"/>
        </c:forEach>

        <%--active filters: used to keep a list of active filters and give it back to the server--%>
        <priderElement:inputHiddenList items="${ptmsFilters}" name="ptmsFilters"/>

        <ul id="filter-options">
            <!-- filter field -->
            <li>Field</li>
            <select id="filter-field" name="filterField" style="overflow:hidden; max-width:100px">
                <option value="ptm-filter" ${(filterField == 'ptm')?'selected':''}>Modification</option>
            </select>

            <li>Contains</li>
            <!-- select fitlers -->
            <priderElement:selectFilter id="ptm-filter" items="${availablePtmList}" name="newPtmsFilter"/>

            <li>
                </br>
                <button type="submit">
                    Add filter
                </button>
            </li>
        </ul>

    </fieldset>
</form>

<%--active filters & REMOVE filters forms--%>
<c:if test="${numFilters>0}">
    <h4>Current active filters</h4>

    <%--Remove all--%>
    <form id=psm-remove-filters action="${searchUrl}" method="get">
        <fieldset>
            <input type='hidden' name='q' value='${q}'/>
            <input type='hidden' name='size' value='${page.size}'/>
            <input type='hidden' name='page' value='${page.number}'/>
            <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
                <input type='hidden' name="sort" value="${sortOrder}"/>
            </c:forEach>
            <button type="submit">
                Remove all
            </button>
        </fieldset>
    </form>

    <%--PTMs filters--%>
    <c:if test="${not empty ptmsFilters}">
        <h5>Modifications </h5>
        <c:forEach var="thePtmsFilter" items="${ptmsFilters}">
            <form id="psms-remove-ptm-filter" action="${searchUrl}" method="get">
                <fieldset>
                    <input type='hidden' name='q' value='${q}'/>
                    <input type='hidden' name='size' value='${page.size}'/>
                    <input type='hidden' name='page' value='${page.number}'/>
                    <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
                        <input type='hidden' name="sort" value="${sortOrder}"/>
                    </c:forEach>
                    <priderElement:inputHiddenListExcluding items="${ptmsFilters}" name="ptmsFilters" excludeItem="${thePtmsFilter}"/>
                        ${thePtmsFilter}
                    <button type="submit" class="remove-filter-button">
                        x
                    </button>
                    </br>
                </fieldset>
            </form>
        </c:forEach>
        </br>
    </c:if>
</c:if> <!--end of any filters check-->
    <form id="psm-clear-search" method="get" action="${searchUrl}" name="psm-search">
        <fieldset>
            <button type="submit">
                Clear
            </button>
        </fieldset>
    </form>
</div> <!-- end of filters -->

<%--Table--%>
<div class="grid_19">
<%-- todo: add underline--%>
<%-- todo: review the css layout, need to make the whole thing right align --%>

<div class="grid_5 push_19 omega">
    <table:paginator page="${page}" q="${q}" ptmsFilters="${ptmsFilters}"/>
</div>

<div class="grid_24">
     <%--Table--%>
    <table id="psmTable" class="summary-table footable table toggle-arrow-small">
        <thead>
            <tr>     
                <%-- todo: add width distribution --%>
                <%-- todo: add additional columns and review the existing columns --%>
                <%-- Count column--%>
                <th><strong>#</strong></th>

                <%-- Peptide Sequence Column--%>
                <th>
                    <span>
                        <strong>Peptide Sequence</strong>
                        <table:psmSortUrl page="${page}" q="${q}" ptmsFilters="${ptmsFilters}" urlType="peptideSequenceSortURL"/>
                    </span>
                </th>

                <%-- Protein accession column--%>
                <th>
                    <span>
                        <strong>Protein</strong>
                        <table:psmSortUrl page="${page}" q="${q}" ptmsFilters="${ptmsFilters}" urlType="proteinAccSortURL"/>
                    </span>
                </th>

                <%-- Optional assay accession column --%>
                <c:if test="${empty assayAccession}">
                    <th>
                        <span>
                            <strong>Assay</strong>
                            <table:psmSortUrl page="${page}" q="${q}" ptmsFilters="${ptmsFilters}" urlType="assayAccSortURL"/>
                        </span>
                    </th>
                </c:if>

                <%-- Modifications column--%>
                <th><strong>Modifications</strong></th>

                <%-- Search engine score column--%>
                <th><strong>Search Engine Score</strong></th>

                <%-- Experimental m/z column--%>
                <th data-hide="phone">
                    <span>
                        <strong>Experimental m/z</strong>
                        <table:psmSortUrl page="${page}" q="${q}" ptmsFilters="${ptmsFilters}" urlType="expMzSortURL"/>
                    </span>
                </th>

                <%-- Charge state column --%>
                <th data-hide="phone">
                    <span>
                        <strong>Charge</strong>
                        <table:psmSortUrl page="${page}" q="${q}" ptmsFilters="${ptmsFilters}" urlType="chargeSortURL"/>
                    </span>
                </th>

                <th data-hide="all"><strong>Start</strong></th>
                <th data-hide="all"><strong>Stop</strong></th>
                <th data-hide="all"><strong>Pre</strong></th>
                <th data-hide="all"><strong>Post</strong></th>
                <th data-hide="all"><strong>Reported Id</strong></th>
            </tr>
        </thead>

        <%-- Table rows which contains all the psms--%>
        <tbody>
        <c:set var="first" value="${page.size * page.number}"/>
        <c:forEach items="${page.content}" var="psm" varStatus="status">
            <%-- todo: add table row colour alternation --%>
            <tr>
                <td style="white-space: nowrap;">${first + status.count}</td>
                <%--  peptide_sequence  --%>
                <td>
                    <spring:url var="psmViewerUrl" value="/projects/{accession}/viewer/protein/{proteinID}&peptide={peptideID}&variance={peptiformID}">
                        <spring:param name="accession" value="${psm.projectAccession}"/>
                        <spring:param name="proteinID" value="${psm.assayAccession}__${psm.proteinAccession}"/>
                        <spring:param name="peptideID" value="${psm.assayAccession}__${psm.proteinAccession}__${psm.peptideSequence}"/>
                        <spring:param name="peptiformID" value="${psm.assayAccession}__${psm.proteinAccession}__${psm.peptideSequence}__${psm.reportedId}"/>
                    </spring:url>
                    <a href="${psmViewerUrl}">
                        <c:choose>
                            <c:when test="${fn:contains(highlights[psm], 'peptide_sequence')}">
                                <c:forEach var="highlight" items="${highlights[psm]['peptide_sequence']}">
                                    ${highlight}
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                ${psm.peptideSequence}
                            </c:otherwise>
                        </c:choose>
                    </a>
                </td>
                <%-- protein  --%>
                <td>
                    <spring:url var="proteinViewerUrl" value="/projects/{accession}/viewer/protein/{proteinID}">
                        <spring:param name="accession" value="${psm.projectAccession}"/>
                        <spring:param name="proteinID" value="${psm.assayAccession}__${psm.proteinAccession}"/>
                    </spring:url>

                    <a href="${proteinViewerUrl}">
                        <c:choose>
                            <c:when test="${fn:contains(highlights[psm], 'protein_accession')}">
                                <c:forEach var="highlight" items="${highlights[psm]['protein_accession']}">
                                    ${highlight}
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                ${psm.proteinAccession}
                            </c:otherwise>
                        </c:choose>
                    </a>
                </td>
                <%-- assay  --%>
                <c:if test="${empty assayAccession}">
                    <spring:url var="psmAssayUrl" value="/assays/{accession}">
                        <spring:param name="accession" value="${psm.assayAccession}"/>
                    </spring:url>
                    <td>
                        <a href="${psmAssayUrl}">
                            ${psm.assayAccession}
                        </a>
                    </td>
                </c:if>
                <%-- modification  --%>
                <td>
                    <ul>
                        <c:forEach var="modification" items="${psm.modifications}">
                            <c:choose>
                                <c:when test="${not empty modification.name}">
                                    <li>
                                        <c:if test="${not empty modification.mainPosition}">
                                            ${modification.mainPosition} -
                                        </c:if>
                                         ${modification.name}
                                    </li>
                                </c:when>
                                <c:when test="${not empty modification.neutralLoss}">
                                    <li>
                                        <c:if test="${not empty modification.mainPosition}">
                                            ${modification.mainPosition} -
                                        </c:if>
                                        ${modification.neutralLoss.name} (${modification.neutralLoss.value})
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li>
                                        <c:if test="${not empty modification.mainPosition}">
                                            ${modification.mainPosition} -
                                        </c:if>
                                        ${modification.accession}
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </ul>
                </td>
                <%-- search engine score  --%>
                <td>
                    <ul>
                        <c:forEach var="searchEngineScore" items="${psm.searchEngineScores}">
                            <li>${searchEngineScore.name} ${searchEngineScore.value}</li>
                        </c:forEach>
                    </ul>
                </td>
                <td>${psm.expMassToCharge}</td>
                <td>${psm.charge}</td>
                <td>${psm.startPosition}</td>
                <td>${psm.endPosition}</td>
                <td>${psm.preAminoAcid}</td>
                <td>${psm.postAminoAcid}</td>
                <td>${psm.reportedId}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

</div>

<%--pagination--%>
<div class="grid_5 push_19 omega">
    <table:paginator page="${page}" q="${q}" ptmsFilters="${ptmsFilters}"/>
</div>

</div> <%--grid_19--%>
</div> <%--grid_24--%>

<%--responsive table style--%>
<script type="text/javascript">
    $(function () {
        $('#psmTable').footable({
            breakpoints: {
                phone: 750,
                tablet: 960
            }
        });
    });
</script>
