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
            <a href="${prideUrl}"><fmt:message key="pride"/></a> &gt; <a href="${priderUrl}"><fmt:message
                key="prider"/></a>
            &gt; <a href="${projectUrl}">${projectAccession}</a>
            <c:if test="${not empty assayAccession}">
                <spring:url var="assayUrl" value="/assays/{accession}">
                    <spring:param name="accession" value="${assayAccession}"/>
                </spring:url>
                &gt; <a href="${assayUrl}">${assayAccession}</a>
            </c:if>
            &gt; <span>Proteins</span>
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
            <input type='hidden' name='page' value='${0}'/>
            <c:forEach var="sortOrder" items="${fn:split(page.sort,',')}">
                <input type='hidden' name="sort" value="${sortOrder}"/>
            </c:forEach>
            <%--active filters: used to keep a list of active filters and give it back to the server--%>
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

    <div class="grid_20 push_4 omega">
        <table:paginator2 page="${page}" q="${q}" ptmsFilters="${ptmsFilters}"/>
    </div>

    <div class="grid_24">
        <%--Table--%>

        <table id="proteinTable" class="summary-table footable table toggle-arrow-small">
            <thead>
            <tr>     
                <%-- Count column--%>
                <th>
                    <strong>#</strong>
                </th>

                <%-- Submitted protein accession column--%>
                <th>
                    <span>
                        <strong>Submitted Protein</strong>
                        <table:proteinSortUrl page="${page}" q="${q}" ptmsFilters="${ptmsFilters}"  urlType="submittedProteinAccSortURL"/>
                    </span>
                </th>

                <%-- Optional assay accession column --%>
                <c:if test="${empty assayAccession}">
                    <th>
                        <span>
                            <strong>Assay</strong>
                            <table:proteinSortUrl page="${page}" q="${q}" ptmsFilters="${ptmsFilters}" urlType="assayAccSortURL"/>
                        </span>
                    </th>
                </c:if>

                <%-- Clean protein accession column--%>
                <th>
                    <span>
                        <strong>Protein</strong>
                        <table:proteinSortUrl page="${page}" q="${q}" ptmsFilters="${ptmsFilters}" urlType="proteinAccSortURL"/>
                    </span>
                </th>

                <th><strong>Uniprot Ref</strong></th>

                <th><strong>Ensembl Ref</strong></th>


                <%-- Description column--%>
                <th><strong>Name</strong></th>

                <%-- Modifications column--%>
                <th><strong>Modifications</strong></th>

                <%-- Ambiguity group column--%>
                <th><strong>Ambiguity Group</strong></th>

                <%-- Alternative mappings --%>
                <th data-hide="all"><strong>Alternative mappings</strong></th>

            </tr>
            </thead>

            <%-- Table rows which contains proteins--%>
            <tbody>
            <c:set var="first" value="${page.size * page.number}"/>
            <c:forEach items="${page.content}" var="protein" varStatus="status">
                <%-- todo: add table row colour alternation --%>
                <tr>
                    <td style="white-space: nowrap;">${first + status.count}</td>

                    <%-- Submitted protein accession column--%>


                        <td>
                            <%-- hyperlink to protein webapp view --%>
                            <spring:url var="proteinViewerUrl" value="/projects/{accession}/viewer/protein/{proteinID}">
                                <spring:param name="accession" value="${projectAccession}"/>
                                <spring:param name="proteinID" value="${protein.assayAccession}__${protein.submittedAccession}"/>
                            </spring:url>
                            <c:choose>
                                <c:when test="${not empty protein.inferredSequence or not empty protein.submittedSequence}">
                                    <a href="${proteinViewerUrl}">
                                        <c:choose>
                                            <c:when test="${fn:contains(highlights[protein], 'submitted_accession')}">
                                                <c:forEach var="highlight" items="${highlights[protein]['submitted_accession']}">
                                                    ${highlight}
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                ${protein.submittedAccession}
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${fn:contains(highlights[protein], 'submitted_accession')}">
                                            <c:forEach var="highlight" items="${highlights[protein]['submitted_accession']}">
                                                ${highlight}
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            ${protein.submittedAccession}
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
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

                    <%-- Uniprot protein accession column--%>
                    <td>
                        <spring:url var="uniprotUrl" value="http://www.uniprot.org/uniprot/{uniprotAcc}">
                            <spring:param name="uniprotAcc" value="${protein.uniprotMapping}"/>
                        </spring:url>
                        <c:choose>
                            <c:when test="${fn:contains(highlights[protein], 'uniprot_mapping')}">
                                <c:forEach var="highlight" items="${highlights[protein]['uniprot_mapping']}">
                                    <a href="${uniprotUrl}">${highlight}</a>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <a href="${uniprotUrl}">${protein.uniprotMapping}</a>
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <%-- Ensembl protein accession column--%>
                    <td>
                        <c:choose>
                            <c:when test="${fn:contains(highlights[protein], 'ensembl_mapping')}">
                                <c:forEach var="highlight" items="${highlights[protein]['ensembl_mapping']}">
                                    ${highlight}
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                ${protein.ensemblMapping}
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <%-- Description column--%>
                    <td>${protein.name}</td>

                    <%-- Modifications column--%>
                    <%-- At modification level we display only the modification name --%>
                    <td>
                        <ul>
                            <c:forEach var="modification" items="${protein.modificationNames}">
                                <li>
                                    ${modification}
                                </li>

                                <%--<c:choose>--%>
                                    <%--<c:when test="${not empty modification.name}">--%>
                                        <%--<li>--%>
                                            <%--<c:if test="${not empty modification.mainPosition}">--%>
                                                <%--${modification.mainPosition} ---%>
                                            <%--</c:if>--%>
                                                <%--${modification.name}--%>
                                        <%--</li>--%>
                                    <%--</c:when>--%>
                                    <%--<c:when test="${not empty modification.neutralLoss}">--%>
                                        <%--<li>--%>
                                            <%--<c:if test="${not empty modification.mainPosition}">--%>
                                                <%--${modification.mainPosition} ---%>
                                            <%--</c:if>--%>
                                                <%--${modification.neutralLoss.name} (${modification.neutralLoss.value})--%>
                                        <%--</li>--%>
                                    <%--</c:when>--%>
                                    <%--<c:otherwise>--%>
                                        <%--<li>--%>
                                            <%--<c:if test="${not empty modification.mainPosition}">--%>
                                                <%--${modification.mainPosition} ---%>
                                            <%--</c:if>--%>
                                                <%--${modification.accession}--%>
                                        <%--</li>--%>
                                    <%--</c:otherwise>--%>
                                <%--</c:choose>--%>
                            </c:forEach>
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
        $('#proteinTable').footable({
            breakpoints: {
                phone: 750,
                tablet: 960
            }
        });
    });
</script>

