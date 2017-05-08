<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="priderElement" tagdir="/WEB-INF/tags/elements" %>
<%@ taglib prefix="inspector" tagdir="/WEB-INF/tags/inspector" %>
<%@ taglib prefix="table" tagdir="/WEB-INF/tags/table" %>

<%-- bread crumb--%>
<div class="grid_24 clearfix">
    <nav id="breadcrumb">
        <p>
            <spring:url var="prideUrl" value="//www.ebi.ac.uk/pride"/>
            <spring:url var="priderUrl" value="/"/>
            <spring:url var="projectUrl" value="/projects/{accession}">
                <spring:param name="accession" value="${projectAccession}"/>
            </spring:url>
            <a href="${prideUrl}"><fmt:message key="pride"/></a> &gt; <a href="${priderUrl}"><fmt:message
                key="prider"/></a>
            &gt; <a href="${projectUrl}">${projectAccession}</a>
            <c:if test="${not empty assayAccession}">
                <spring:url var="assayUrl" value="/assays/{accession}">
                    <spring:param name="accession" value="${assayAccession}"/>
                </spring:url>
                &gt; <a href="${assayUrl}">${assayAccession}</a>
            </c:if>
            &gt; <span><fmt:message key="proteins"/></span>
        </p>
    </nav>

    <div class="grid_19 alpha">
        <h2>
        <span>
            <fmt:message key="proteins"/> in
            <c:if test="${not empty assayAccession}">
                <fmt:message key="assay"/> ${assayAccession}
            </c:if>
            <c:if test="${empty assayAccession}">
                <fmt:message key="project"/> ${projectAccession}
            </c:if>
        </span>
        </h2>
    </div>
    <div class="grid_5 omega right-justify">
        <%-- open pride inspector --%>
        <fmt:message key="pride.inspector.title" var="inspectorTitle"/>
        <h5>
            <span id="inspector-confirm" class="inspector_window icon icon-functional" data-icon="1" title="${inspectorTitle}">
                ${inspectorTitle}
            </span>
        </h5>
        <c:if test="${not empty assayAccession}">
            <inspector:inspectorDialog accession="${assayAccession}"/>
        </c:if>
        <c:if test="${empty assayAccession}">
            <inspector:inspectorDialog accession="${projectAccession}"/>
        </c:if>
    </div>
</div>

<div id="search-result" class="grid_24">

    <%--Title and count--%>
    <h3>
        <strong>${page.totalElements}</strong> <fmt:message key="search.result.title"/>
        <c:if test="${q!= null and q!=''}">
            <fmt:message key="search.result.forterm"/> <span class="searchterm" id="query">${q}</span>
        </c:if>
        <c:set var="numFilters" value="${fn:length(ptmsFilters)}" />
        <c:if test="${numFilters>0}">+ ${numFilters} filters</c:if>
    </h3>

    <br>
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
                    <input id="psm-searchbox" type="text" name="q" autocomplete="on" value="${q}"/>
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
                <h5><fmt:message key="modifications"/></h5>
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

    <%--paginator--%>
    <table:paginator page="${page}" q="${q}" ptmsFilters="${ptmsFilters}"/>
        <table id="proteinTable" class="summary-table footable table toggle-arrow-small">
            <thead>
            <tr>
            <%-- Count column--%>
            <th><strong>#</strong></th>
            <%-- Submitted protein accession column--%>
            <th>
                    <strong><fmt:message key="submitted.acc"/></strong>
            </th>
            <%-- Optional assay accession column --%>
            <c:if test="${empty assayAccession}">
                <th>
                    <span>
                        <table:proteinSortUrl page="${page}" q="${q}" ptmsFilters="${ptmsFilters}" urlType="assayAccSortURL"/>
                        <strong><fmt:message key="assay"/></strong>
                    </span>
                </th>
            </c:if>
            <%-- Clean protein accession column--%>
            <th>
                <span>
                    <table:proteinSortUrl page="${page}" q="${q}" ptmsFilters="${ptmsFilters}" urlType="proteinAccSortURL"/>
                    <strong><fmt:message key="cleaned.acc"/></strong>
                </span>
            </th>
            <th><strong><fmt:message key="cross.ref"/></strong></th>
            <%-- Description column--%>
            <th><strong><fmt:message key="description"/></strong></th>
            <%-- Modifications column--%>
            <th><strong><fmt:message key="modifications"/></strong></th>
            <%-- Ambiguity group column--%>
            <th><strong><fmt:message key="ambiguity.members"/></strong></th>
            <%-- Alternative mappings --%>
            <th data-hide="all"><strong><fmt:message key="alternative.mappings"/></strong></th>
            </tr>
            </thead>

            <%-- Table rows which contains proteins--%>
            <tbody>
            <c:set var="first" value="${page.size * page.number}"/>
            <c:forEach items="${mongoProteinIdentifications}" var="protein" varStatus="status">
                <tr>
                    <td style="white-space: nowrap;">${first + status.count}</td>
                    <%-- Submitted protein accession column--%>
                    <td>
                        <span style="white-space: nowrap">
                            <spring:url var="psmTableUrl"
                                        value="/projects/{projectAccession}/assays/{assayAccession}/psms?q={proteinAccession}">
                                <spring:param name="projectAccession" value="${projectAccession}"/>
                                <spring:param name="assayAccession" value="${protein.assayAccession}"/>
                                <spring:param name="proteinAccession" value="${protein.submittedAccession}"/>
                            </spring:url>
                                <fmt:message key="jump.peptide.table" var="jumpPeptideTable"/>
                                <c:choose>
                                    <c:when test="${fn:contains(highlights[protein], 'submitted_accession')}">
                                        <c:forEach var="highlight" items="${highlights[protein]['submitted_accession']}">
                                            <a href="${psmTableUrl}" title="${jumpPeptideTable}">${highlight}</a>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${psmTableUrl}" title="${jumpPeptideTable}">${protein.submittedAccession}</a>
                                    </c:otherwise>
                                </c:choose>


                            <%-- hyperlink to protein webapp view --%>
                            <spring:url var="proteinViewerUrl"
                                        value="/projects/{accession}/viewer/protein/{proteinID}">
                                <spring:param name="accession" value="${projectAccession}"/>
                                <spring:param name="proteinID" value="${protein.assayAccession}__${protein.submittedAccession}"/>
                            </spring:url>
                            <c:if test="${not empty protein.inferredSequence or not empty protein.submittedSequence}">
                                <a class="no_visual_link" target="_blank" href="${proteinViewerUrl}"><img class=table_icon title="Protein Viewer"  id='protein_viewer' src='${pageContext.request.contextPath}/resources/img/proteinViewer.png'></a>
                            </c:if>
                        </span>
                    </td>
                    <%-- Optional assay accession column --%>
                    <c:if test="${empty assayAccession}">
                        <spring:url var="proteinAssayUrl" value="/assays/{accession}">
                            <spring:param name="accession" value="${protein.assayAccession}"/>
                        </spring:url>
                        <td>
                            <a href="${proteinAssayUrl}">${protein.assayAccession}</a>
                        </td>
                    </c:if>

                    <%-- Clean protein accession column--%>
                    <td>
                        <c:choose>
                            <c:when test="${fn:contains(highlights[protein], 'accession')}">
                                <c:forEach var="highlight" items="${highlights[protein]['accession']}">
                                    ${highlight}
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                ${protein.accession}
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>
                        <%-- Uniprot protein accession --%>
                        <spring:url var="uniprotUrl" value="http://www.uniprot.org/uniprot/{uniprotAcc}">
                            <spring:param name="uniprotAcc" value="${protein.uniprotMapping}"/>
                        </spring:url>
                        <c:choose>
                            <c:when test="${fn:contains(highlights[protein], 'uniprot_mapping')}">
                                <a class="no_visual_link" target="_blank" href="${uniprotUrl}"><img class=table_icon_hl title="${protein.uniprotMapping}"  id='uniprot_hl' src='${pageContext.request.contextPath}/resources/img/uniprot.ico'></a>
                                <%--<c:forEach var="highlight" items="${highlights[protein]['uniprot_mapping']}">--%>
                                <%--<a href="${uniprotUrl}">${highlight}</a>--%>
                                <%--</c:forEach>--%>
                            </c:when>
                            <c:otherwise>
                                <c:if test="${not empty protein.uniprotMapping}">
                                    <a class="no_visual_link"  target="_blank" href="${uniprotUrl}"><img class=table_icon id='uniprot' title="${protein.uniprotMapping}" src='${pageContext.request.contextPath}/resources/img/uniprot.ico'></a>
                                </c:if>
                                <%--${protein.uniprotMapping}--%>
                            </c:otherwise>
                        </c:choose>
                        <%-- Ensembl protein accession --%>
                        <spring:url var="ensemblUrl" value="http://www.ensembl.org/id/{ensemblAcc}">
                            <spring:param name="ensemblAcc" value="${protein.ensemblMapping}"/>
                        </spring:url>
                        <c:choose>
                            <c:when test="${fn:contains(highlights[protein], 'ensembl_mapping')}">
                                <a class="no_visual_link"  target="_blank" href="${ensemblUrl}"><img class=table_icon_hl id='ensembl_hl' title="${protein.ensemblMapping}" src='${pageContext.request.contextPath}/resources/img/ensembl.png'></a>
                                <%--<c:forEach var="highlight" items="${highlights[protein]['ensembl_mapping']}">--%>
                                <%--<a href="${ensemblUrl}">${highlight}</a>--%>
                                <%--</c:forEach>--%>
                            </c:when>
                            <c:otherwise>
                                <c:if test="${not empty protein.ensemblMapping}">
                                    <a class="no_visual_link" target="_blank" href="${ensemblUrl}"><img class=table_icon id='ensembl' title="${protein.ensemblMapping}" src='${pageContext.request.contextPath}/resources/img/ensembl.png'></a>
                                </c:if>
                                <%--${protein.ensemblMapping}--%>
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <%-- Description column--%>
                    <td><span class="longtext">${protein.name}</span></td>

                    <%-- Modifications column--%>
                    <%-- At modification level we display only the modification name --%>
                    <td>
                        <ul>
                            <c:choose>
                                <c:when test="${not empty protein.modificationAccessionName}">
                                    <c:forEach var="modification" items="${protein.modificationAccessionName}">
                                        <c:choose>
                                            <c:when test="${fn:containsIgnoreCase(modification.value, 'UNIMOD:')}">
                                                <c:set var="accNum" value="${fn:replace(modification.value,'UNIMOD:','')}"/>
                                                <spring:url var="url" value="http://www.unimod.org/modifications_view.php?editid1={accession}">
                                                    <spring:param name="accession" value="${accNum}"/>
                                                </spring:url>
                                            </c:when>
                                            <c:when test="${not fn:containsIgnoreCase(modification.value, 'UNIMOD:') and
                                                    not fn:containsIgnoreCase(modification.value, 'CHEMMOD:')}">
                                                <spring:url var="url" value="http://www.ebi.ac.uk/ontology-lookup/?termId={accession}">
                                                    <spring:param name="accession" value="${modification.value}"/>
                                                </spring:url>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="url" value="" />
                                            </c:otherwise>
                                        </c:choose>
                                        <spring:url var="olsUrl" value="http://www.ebi.ac.uk/ontology-lookup/?termId={accession}">
                                            <spring:param name="accession" value="${modification.value}"/>
                                        </spring:url>
                                        <li>
                                            <a href="${url}">${modification.key}</a>
                                        </li>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="modification" items="${protein.modificationNames}">
                                        <li>
                                            ${modification}
                                        </li>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </td>
                    <%-- Ambiguity group column--%>
                    <td>
                        <ul>
                            <c:forEach var="submittedAccession" items="${protein.ambiguityGroupSubmittedAccessions}">
                                <c:choose>
                                    <c:when test="${fn:contains(highlights[protein], 'ambiguity_group')}">
                                        <c:forEach var="highlight" items="${highlights[protein]['ambiguity_group']}">
                                            <c:choose>
                                                <c:when test="${fn:contains(highlight, submittedAccession)}">
                                                    <li style="white-space: nowrap">${highlight}</li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li style="white-space: nowrap">${submittedAccession}</li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <li style="white-space: nowrap">${submittedAccession}</li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </ul>
                    </td>
                    <%-- Alternative mappings --%>
                    <td>
                        <c:forEach var="alternativeMapping" items="${protein.otherMappings}">
                            <c:choose>
                                <c:when test="${fn:contains(highlights[protein], 'other_mappings')}">
                                    <c:forEach var="highlight" items="${highlights[protein]['other_mappings']}">
                                        <c:choose>
                                            <c:when test="${fn:contains(highlight, alternativeMapping)}">
                                                ${highlight}
                                            </c:when>
                                            <c:otherwise>
                                                ${alternativeMapping}
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    ${alternativeMapping}
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <%--paginator--%>
        <table:paginator page="${page}" q="${q}" ptmsFilters="${ptmsFilters}"/>
    </div> <%--grid_19--%>
</div> <%--grid_24--%>

<spring:url var="readMoreJavascriptUrl" value="/resources/javascript/readmore.min.js"/>
<script src="${readMoreJavascriptUrl}"></script>
<%--responsive table style and read more--%>
<script type="text/javascript">
    $(document).ready(function () {
        $(".longtext").readmore({
            maxHeight: 38,
            heightMargin: 10,
            moreLink: '<span><a href="#">More</a></span>',
            lessLink: '<span><a href="#">Close</a></span>'
        });
    });
</script>
