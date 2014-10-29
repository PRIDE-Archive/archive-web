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
            &gt; <span><fmt:message key="peptide.spectrum.match"/></span>
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
        <table id="psmTable" class="summary-table footable table toggle-arrow-small">
            <thead>
            <tr>
            <%-- Count column--%>
            <th><strong>#</strong></th>
            <%-- Peptide Sequence Column--%>
            <th>
                <span>
                    <table:psmSortUrl page="${page}" q="${q}" ptmsFilters="${ptmsFilters}" urlType="peptideSequenceSortURL"/>
                    <strong><fmt:message key="peptide.sequence"/></strong>
                </span>
            </th>
            <%-- Protein accession column--%>
            <th>
                <span>
                    <table:psmSortUrl page="${page}" q="${q}" ptmsFilters="${ptmsFilters}" urlType="proteinAccSortURL"/>
                    <strong><fmt:message key="submitted.acc"/></strong>
                </span>
            </th>
            <%-- Optional assay accession column --%>
            <c:if test="${empty assayAccession}">
                <th>
                    <span>
                        <table:psmSortUrl page="${page}" q="${q}" ptmsFilters="${ptmsFilters}" urlType="assayAccSortURL"/>
                        <strong><fmt:message key="assay"/></strong>
                    </span>
                </th>
            </c:if>
            <%-- Search engine score column--%>
            <th><strong><fmt:message key="search.engine.score"/></strong></th>
            <%-- Experimental m/z column--%>
            <th data-hide="phone">
                <span>
                    <table:psmSortUrl page="${page}" q="${q}" ptmsFilters="${ptmsFilters}" urlType="expMzSortURL"/>
                    <strong><fmt:message key="experimental.m.z"/></strong>
                </span>
            </th>
            <%-- Charge state column --%>
            <th data-hide="phone">
                        <span>
                            <table:psmSortUrl page="${page}" q="${q}" ptmsFilters="${ptmsFilters}" urlType="chargeSortURL"/>
                            <strong><fmt:message key="charge"/></strong>
                        </span>
            </th>
            <th data-hide="all"><strong><fmt:message key="start"/></strong></th>
            <th data-hide="all"><strong><fmt:message key="stop"/></strong></th>
            <th data-hide="all"><strong><fmt:message key="pre"/></strong></th>
            <th data-hide="all"><strong><fmt:message key="post"/></strong></th>
            <th data-hide="all"><strong><fmt:message key="reported.id"/></strong></th>
            <%-- Modifications column--%>
            <th data-hide="all"><strong><fmt:message key="modifications"/></strong></th>
            </tr>
            </thead>

            <%-- Table rows which contains all the psms--%>
            <tbody>
            <c:set var="first" value="${page.size * page.number}"/>
            <c:forEach items="${page.content}" var="psm" varStatus="status">
                <tr>
                    <td style="white-space: nowrap;">${first + status.count}</td>
                    <%--  peptide_sequence  --%>
                    <td style="white-space: nowrap;">
                        <span id="sequence_${status.index}">
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
                        </span>
                            <%-- hyperlink to psm webapp view --%>
                        <%--<spring:url var="psmViewerUrl" value="/projects/{accession}/viewer/protein/{proteinID}&peptide={peptideID}&variance={peptiformID}">--%>
                            <%--<spring:param name="accession" value="${psm.projectAccession}"/>--%>
                            <%--<spring:param name="proteinID" value="${psm.assayAccession}__${psm.proteinAccession}"/>--%>
                            <%--<spring:param name="peptideID" value="${psm.assayAccession}__${psm.proteinAccession}__${psm.peptideSequence}"/>--%>
                            <%--<spring:param name="peptiformID" value="${psm.assayAccession}__${psm.proteinAccession}__${psm.peptideSequence}__${psm.reportedId}"/>--%>
                        <%--</spring:url>--%>
                            <%--todo checking to disable the link--%>
                        <%--<a class="no_visual_link" target="_blank" href="${proteinViewerUrl}"><img class=table_icon title="Protein Viewer"  id='protein_viewer' src='${pageContext.request.contextPath}/resources/img/proteinViewer.png'></a>--%>
                    </td>
                    <%-- protein  --%>
                    <td>
                        <%-- hyperlink to protein table --%>
                        <span style="white-space: nowrap">
                            <spring:url var="proteinTableUrl"
                                        value="/projects/{projectAccession}/assays/{assayAccession}/proteins?q={proteinAccession}">
                                <spring:param name="projectAccession" value="${projectAccession}"/>
                                <spring:param name="assayAccession" value="${psm.assayAccession}"/>
                                <spring:param name="proteinAccession" value="${psm.proteinAccession}"/>
                            </spring:url>

                                <c:choose>
                                    <c:when test="${fn:contains(highlights[psm], 'protein_accession')}">
                                        <c:forEach var="highlight" items="${highlights[psm]['protein_accession']}">
                                            <a href="${proteinTableUrl}">${highlight}</a>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${proteinTableUrl}">${psm.proteinAccession}</a>
                                    </c:otherwise>
                                </c:choose>

                            <%-- hyperlink to protein webapp view --%>
                            <%--<spring:url var="proteinViewerUrl" value="/projects/{accession}/viewer/protein/{proteinID}">--%>
                                <%--<spring:param name="accession" value="${psm.projectAccession}"/>--%>
                                <%--<spring:param name="proteinID" value="${psm.assayAccession}__${psm.proteinAccession}"/>--%>
                            <%--</spring:url>--%>
                            <%--todo checking to disable the link--%>
                            <%--<a class="no_visual_link" target="_blank" href="${proteinViewerUrl}"><img class=table_icon title="Protein Viewer"  id='protein_viewer' src='${pageContext.request.contextPath}/resources/img/proteinViewer.png'></a>--%>
                        </span>
                    </td>

                        <%-- assay  --%>
                    <c:if test="${empty assayAccession}">
                        <spring:url var="psmAssayUrl" value="/assays/{accession}">
                            <spring:param name="accession" value="${psm.assayAccession}"/>
                        </spring:url>
                        <td>
                            <a href="${psmAssayUrl}">${psm.assayAccession}</a>
                        </td>
                    </c:if>
                    <%-- search engine score  --%>
                    <td>
                        <ul>
                            <c:forEach var="searchEngineScore" items="${psm.searchEngineScores}">
                                <spring:url var="olsUrl" value="http://www.ebi.ac.uk/ontology-lookup/?termId={accession}">
                                    <spring:param name="accession" value="${searchEngineScore.accession}"/>
                                </spring:url>
                                <li><a href="${olsUrl}">${searchEngineScore.name}</a> ${searchEngineScore.value}</li>
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
                    <%-- modification  --%>
                    <td>
                        <ul id="modification_${status.index}">
                            <c:forEach var="modification" items="${psm.modifications}" varStatus="modStatus">
                                <spring:url var="olsUrl" value="http://www.ebi.ac.uk/ontology-lookup/?termId={accession}">
                                    <spring:param name="accession" value="${modification.accession}"/>
                                </spring:url>
                                <c:choose>
                                    <c:when test="${not empty modification.name}">
                                        <li>
                                            <c:if test="${not empty modification.mainPosition}">
                                                <span class="pos">${modification.mainPosition}</span> -
                                            </c:if>
                                            <a href="${olsUrl}">${modification.name}</a>
                                        </li>
                                    </c:when>
                                    <c:when test="${not empty modification.neutralLoss}">
                                        <li>
                                            <c:if test="${not empty modification.mainPosition}">
                                                <span>${modification.mainPosition}</span> -
                                            </c:if>
                                            ${modification.neutralLoss.name} (${modification.neutralLoss.value})
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li>
                                            <c:if test="${not empty modification.mainPosition}">
                                                <span class="pos">${modification.mainPosition}</span> -
                                            </c:if>
                                            <a href="${olsUrl}">${modification.accession}</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </ul>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    <%--paginator--%>
    <table:paginator page="${page}" q="${q}" ptmsFilters="${ptmsFilters}"/>
    </div> <%--grid_19--%>
</div> <%--grid_24--%>

<%--responsive table style--%>
<script type="text/javascript">
    $(function () {
        var x = document.getElementById("psmTable").rows.length;

        for (var j = 0; j < x; j++) {
            var sequence = document.getElementById('sequence_' + j);

            //if the highlighting is active
            if (sequence != null) {
                if (sequence.getElementsByTagName('span') != null) {
                    if (sequence.getElementsByTagName('span').length == 1){
                        sequence = sequence.getElementsByTagName('span').item(0);
                    }
                }
            }

            var modifications = document.getElementById('modification_' + j);

            var mod_pos = [];
            var mod_names = [];

            if (modifications != null) {
                var pos = modifications.getElementsByClassName('pos');
                var name = modifications.getElementsByTagName('a');

                if (pos.length == name.length) {
                    console.log(j + "->" + sequence + ": " + pos);

                    for (var k = 0; k < pos.length; k++) {
                        mod_pos[k] = pos.item(k).textContent;
                        mod_names[k] = name.item(k).textContent;
                    }
                }
                sequence.innerHTML = highlightAminoAcids(sequence.innerHTML, mod_pos, mod_names);
            }
        }
    });

    function highlightAminoAcids(sequence, mod_pos, mod_names) {

        console.log(sequence);

        for (var k = 0; k < mod_pos.length; k++) {
            console.log("position:" + mod_pos[k]);
            console.log("name:" + mod_names[k]);
        }

        var pepSeq = $.trim(sequence);
        //add terminals to the peptide
        pepSeq = "." + pepSeq + ".";

        var result = "";
        var aux;
        //term representations
        var cterm = ".-";
        var nterm = "-.";

        for (var i = 0; i < pepSeq.length; i++) {
            if (i == 0) {
                aux = "<span style='font-weight: bold'>" + nterm + "</span>";
            }
            else if (i == pepSeq.length - 1) {
                aux = "<span style='font-weight: bold'>" + cterm + "</span>";
            }
            else {
                aux = pepSeq[i];
            }
            for (var j = 0; j < mod_pos.length; j++) {
                if (mod_pos[j] == i) {
                    aux = "<span title=\"" + mod_names[j] + "\" class=modified_aa>" + pepSeq[i] + "</span>";
                    if (mod_pos[j] == 0) {
                        aux = "<span title=\"" + mod_names[j] + "\" style='font-weight: bold' class=modified_aa>" + nterm + "</span>";
                    }
                    else if (mod_pos[j] == pepSeq.length - 1) {
                        aux = "<span title=\"" + mod_names[j] + "\" style='font-weight: bold' class=modified_aa>" + cterm + "</span>";
                    }
                }
            }
            result = result + aux;
        }
        return result;
    }

</script>
