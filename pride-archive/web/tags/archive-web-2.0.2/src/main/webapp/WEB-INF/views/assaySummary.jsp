<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="inspector" tagdir="/WEB-INF/tags/inspector" %>


<%-- Breadcrumb for navigation --%>
<%-- PRIDE > PRIDE Archive > Project accession > Assay accession --%>
<%-- Or PRIDE > PRIDE Archive > Assay accession --%>
<div class="grid_23 clearfix">
    <p>
        <spring:url var="prideUrl" value="http://www.ebi.ac.uk/pride"/>
        <spring:url var="priderUrl" value="/"/>
        <c:choose>
            <%-- linked from project page--%>
            <c:when test="${not empty projectAccession}">
                <spring:url var="projectUrl" value="/projects/{accession}">
                    <spring:param name="accession" value="${projectAccession}"/>
                </spring:url>
                <a href="${prideUrl}"><fmt:message key="pride"/></a> &gt; <a href="${priderUrl}"><fmt:message key="prider"/></a> &gt; <a
                    href="${projectUrl}">${projectAccession}</a> &gt; ${assaySummary.accession}
            </c:when>
            <%-- direct access to assay page --%>
            <c:otherwise>
                <a href="${prideUrl}"><fmt:message key="pride"/></a> &gt; <a href="${priderUrl}"><fmt:message key="prider"/></a> &gt; ${assaySummary.accession}
            </c:otherwise>
        </c:choose>
    </p>
</div>

<div class="grid_23 clearfix project-title">
    <div class="grid_18 alpha">
        <h3><fmt:message key="assay"/> : ${assaySummary.accession}</h3>
    </div>

    <div class="grid_6 omega right-justify">
        <h5>
            <span class="icon icon-functional" data-icon="4" id="inspector-confirm"><fmt:message key="pride.inspector.title"/></span>
        </h5>

        <c:choose>
            <c:when test="${not empty projectAccession}">
                <spring:url var="assayFileUrl" value="/projects/{projectAccession}/assays/{assayAccession}/files">
                    <spring:param name="projectAccession" value="${projectAccession}"/>
                    <spring:param name="assayAccession" value="${assaySummary.accession}"/>
                </spring:url>
                <spring:url var="assayProteinsUrl" value="/projects/{projectAccession}/assays/{assayAccession}/proteins">
                    <spring:param name="projectAccession" value="${projectAccession}"/>
                    <spring:param name="assayAccession" value="${assaySummary.accession}"/>
                </spring:url>
                <spring:url var="assayPsmsUrl" value="/projects/{projectAccession}/assays/{assayAccession}/psms">
                    <spring:param name="projectAccession" value="${projectAccession}"/>
                    <spring:param name="assayAccession" value="${assaySummary.accession}"/>
                </spring:url>
            </c:when>
            <c:otherwise>
                <spring:url var="assayFileUrl" value="/assays/{accession}/files">
                    <spring:param name="accession" value="${assaySummary.accession}"/>
                </spring:url>
                <spring:url var="assayProteinsUrl" value="/assays/{accession}/proteins">
                    <spring:param name="assayAccession" value="${assaySummary.accession}"/>
                </spring:url>
                <spring:url var="assayPsmsUrl" value="/assays/{accession}/psms">
                    <spring:param name="assayAccession" value="${assaySummary.accession}"/>
                </spring:url>
            </c:otherwise>
        </c:choose>
        <h5>
            <a href="${assayFileUrl}" class="icon icon-functional" data-icon="=">
                <fmt:message key="assay.file.download.title"/>
            </a>
        </h5>
        <c:if test="${assaySummary.indexProteinCount > 0}">
            <h5>
                <a href="${assayProteinsUrl}" class="icon icon-functional" data-icon="4">
                    <fmt:message key="assay.proteins.table"/>
                </a>
            </h5>
        </c:if>
        <c:if test="${assaySummary.indexPsmCount > 0 }">
            <h5>
                <a href="${assayPsmsUrl}" class="icon icon-functional" data-icon="4">
                    <fmt:message key="assay.psms.table"/>
                </a>
            </h5>
        </c:if>
    </div>
</div>

<div class="grid_23 clearfix statistics">
    <h4><fmt:message key="statistics"/></h4>

    <p>
    <table class="summary-table">
        <thead>
        <tr>
            <th><fmt:message key="protein.count"/></th>
            <th><fmt:message key="peptide.count"/></th>
            <th><fmt:message key="unique.peptide.count"/></th>
            <th><fmt:message key="total.spectrum.count"/></th>
            <th><fmt:message key="identified.spectrum.count"/></th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>
                <%--<c:choose>--%>
                    <%--<c:when test="${assaySummary.proteinCount > 0 and assaySummary.indexProteinCount > 0}">--%>
                        <%--<spring:url var="proteinPageUrl" value="/projects/{projectAccession}/assays/{assayAccession}/proteins">--%>
                            <%--<spring:param name="projectAccession" value="${projectAccession}"/>--%>
                            <%--<spring:param name="assayAccession" value="${assaySummary.accession}"/>--%>
                        <%--</spring:url>--%>
                        <%--<a href="${proteinPageUrl}">${assaySummary.proteinCount}</a>--%>
                    <%--</c:when>--%>
                    <%--<c:otherwise>--%>
                        ${assaySummary.proteinCount}
                    <%--</c:otherwise>--%>
                <%--</c:choose>--%>
            </td>
            <td>
                <%--<c:choose>--%>
                    <%--<c:when test="${assaySummary.peptideCount > 0 and assaySummary.indexPsmCount > 0}">--%>
                        <%--<spring:url var="psmPageUrl" value="/projects/{projectAccession}/assays/{assayAccession}/psms">--%>
                            <%--<spring:param name="projectAccession" value="${projectAccession}"/>--%>
                            <%--<spring:param name="assayAccession" value="${assaySummary.accession}"/>--%>
                        <%--</spring:url>--%>
                        <%--<a href="${psmPageUrl}">${assaySummary.peptideCount}</a>--%>
                    <%--</c:when>--%>
                    <%--<c:otherwise>--%>
                        ${assaySummary.peptideCount}
                    <%--</c:otherwise>--%>
                <%--</c:choose>--%>
            </td>
            <td>
                ${assaySummary.uniquePeptideCount}
            </td>
            <td>
                ${assaySummary.totalSpectrumCount}
            </td>
            <td>
                ${assaySummary.identifiedSpectrumCount}
            </td>
        </tr>
        </tbody>
    </table>
    </p>
</div>

<div class="grid_23 project-summary">
    <h4><fmt:message key="summary"/></h4>

    <div class="grid_16 left-column">
        <h5><fmt:message key="title"/></h5>

        <p>
            ${assaySummary.title}
        </p>

        <c:set var="shortLabel" value="${assaySummary.shortLabel}"/>
        <c:if test="${not empty shortLabel}">
            <h5><fmt:message key="assay.short.label"/></h5>

            <p>
                ${shortLabel}
            </p>
        </c:if>

        <h5><fmt:message key="experimental.factor"/></h5>

        <p>
            ${assaySummary.experimentalFactor}
        </p>

        <h5><fmt:message key="contact"/></h5>

        <p>
            <c:set var="contacts" value="${assaySummary.contacts}"/>
            <c:choose>
                <c:when test="${not empty contacts}">
                    <c:forEach var="contact" items="${contacts}">
                        <a href="mailto:${contact.email}">${contact.firstName} ${contact.lastName}</a>, ${contact.affiliation}
                        <br/>
                    </c:forEach>
                </c:when>
                <c:otherwise>

                </c:otherwise>
            </c:choose>
        </p>
    </div>

    <div class="grid_7 right-column">

        <div class="grid_24">
            <div class="grid_12 alpha">
                <c:set var="species" value="${assaySummary.species}"/>
                <h5><fmt:message key="species"/></h5>

                <p>
                    <c:choose>
                        <c:when test="${not empty species}">
                            <c:forEach var="singleSpecies" items="${species}">
                                <spring:url var="searchSpeciesUrl"
                                            value="/simpleSearch?q={species}">
                                    <spring:param name="species" value="${singleSpecies.name}"/>
                                </spring:url>

                                <a href="${searchSpeciesUrl}">${singleSpecies.name}</a>
                                <br/>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <fmt:message key="not.available"/>
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>

            <div class="grid_12 omega clearfix">
                <c:set var="tissues" value="${assaySummary.tissues}"/>
                <h5><fmt:message key="tissue"/></h5>

                <p>
                    <c:choose>
                        <c:when test="${not empty tissues}">
                            <c:forEach var="tissue" items="${tissues}">
                                <spring:url var="searchTissueUrl"
                                            value="/simpleSearch?q={tissue}">
                                    <spring:param name="tissue" value="${tissue.name}"/>
                                </spring:url>

                                <a href="${searchTissueUrl}">${tissue.name}</a>
                                <br/>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <fmt:message key="not.available"/>
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
        </div>


        <div class="grid_24">
            <c:set var="cellTypes" value="${assaySummary.cellTypes}"/>
            <div class="grid_12 alpha">
                <c:if test="${not empty cellTypes}">
                    <h5><fmt:message key="celltype"/></h5>

                    <p>
                        <c:forEach var="cellType" items="${cellTypes}">
                            <spring:url var="searchCellTypeUrl"
                                        value="/simpleSearch?q={cellType}">
                                <spring:param name="cellType" value="${cellType.name}"/>
                            </spring:url>

                            <a href="${searchCellTypeUrl}">${cellType.name}</a>
                            <br/>
                        </c:forEach>
                    </p>
                </c:if>
            </div>


            <c:set var="diseases" value="${assaySummary.diseases}"/>
            <div class="grid_12 omega clearfix">
                <c:if test="${not empty diseases}">
                    <h5><fmt:message key="disease"/></h5>

                    <p>
                        <c:forEach var="disease" items="${diseases}">
                            <spring:url var="searchDiseaseUrl"
                                        value="/simpleSearch?q={disease}">
                                <spring:param name="disease" value="${disease.name}"/>
                            </spring:url>

                            <a href="${searchDiseaseUrl}">${disease.name}</a>
                            <br/>
                        </c:forEach>
                    </p>
                </c:if>
            </div>
        </div>

        <div class="grid_24">
            <div class="grid_12">
                <c:set var="instruments" value="${assaySummary.instruments}"/>
                <h5><fmt:message key="instrument"/></h5>

                <p>
                    <c:choose>
                        <c:when test="${not empty instruments}">
                            <c:forEach var="instrument" items="${instruments}">
                                <c:choose>
                                    <c:when test="${empty instrument.model.value}">
                                        <spring:url var="searchInstrumentUrl"
                                                    value="/simpleSearch?q={instrument}">
                                            <spring:param name="instrument" value="${instrument.model.name}"/>
                                        </spring:url>

                                        <a href="${searchInstrumentUrl}">${instrument.model.name}</a>
                                        <br/>
                                    </c:when>
                                    <c:otherwise>
                                        <spring:url var="searchInstrumentUrl"
                                                    value="/simpleSearch?q={instrument}">
                                            <spring:param name="instrument" value="${instrument.model.value}"/>
                                        </spring:url>

                                        <a href="${searchInstrumentUrl}">${instrument.model.value}</a>
                                        <br/>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <fmt:message key="not.available"/>
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>

            <div class="grid_12">
                <c:set var="software" value="${assaySummary.softwares}"/>
                <h5><fmt:message key="software"/></h5>

                <p>
                    <c:choose>
                        <c:when test="${not empty software}">
                            <c:forEach var="singleSoftware" items="${software}">
                                <c:choose>
                                    <c:when test="${not fn:containsIgnoreCase(singleSoftware.name, 'unknown')}">
                                        <spring:url var="searchSoftwareUrl"
                                                    value="/simpleSearch?q={software}">
                                            <spring:param name="software" value="${singleSoftware.name}"/>
                                        </spring:url>

                                        <a href="${searchSoftwareUrl}">${singleSoftware.name} ${singleSoftware.version}</a>
                                        <br/>
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:message key="unknown"/>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <fmt:message key="not.available"/>
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
        </div>

        <div class="grid_24">
            <div class="grid_12">
                <c:set var="ptms" value="${assaySummary.ptms}"/>
                <h5><fmt:message key="modification"/></h5>

                <p>
                    <c:choose>
                        <c:when test="${not empty ptms}">
                            <c:forEach var="ptm" items="${ptms}">
                                <spring:url var="searchPtmUrl"
                                            value="/simpleSearch?q={ptm}">
                                    <spring:param name="ptm" value="${ptm.name}"/>
                                </spring:url>

                                <a href="${searchPtmUrl}">${ptm.name}</a>
                                <br/>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <fmt:message key="not.available"/>
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>

            <div class="grid_12">
                <c:set var="quantificationMethods" value="${assaySummary.quantificationMethods}"/>
                <h5><fmt:message key="quantification.method"/></h5>

                <p>
                    <c:choose>
                        <c:when test="${not empty quantificationMethods}">
                            <c:forEach var="quantificationMethod" items="${quantificationMethods}">
                                <spring:url var="searchQuantificationUrl"
                                            value="/simpleSearch?q={quantification}">
                                    <spring:param name="quantification" value="${quantificationMethod.name}"/>
                                </spring:url>

                                <a href="${quantificationMethod}">${quantificationMethod.name}</a>
                                <br/>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <fmt:message key="not.available"/>
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
        </div>
    </div>
</div>

<div class="grid_23 clearfix instrument">
    <h4><fmt:message key="instrument"/></h4>

    <p>
        <c:set var="instruments" value="${assaySummary.instruments}"/>
        <c:choose>
        <c:when test="${not empty instruments}">
    <table class="summary-table">
        <thead>
        <tr>
            <th><fmt:message key="instrument.model"/></th>
            <th><fmt:message key="instrument.source"/></th>
            <th><fmt:message key="instrument.analyzer"/></th>
            <th><fmt:message key="instrument.detector"/></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="instrument" items="${instruments}">
            <tr>
                <td>
                    <c:choose>
                        <c:when test="${empty instrument.model.value}">
                            <spring:url var="searchInstrumentUrl"
                                        value="/simpleSearch?q={instrument}">
                                <spring:param name="instrument" value="${instrument.model.name}"/>
                            </spring:url>

                            <a href="${searchInstrumentUrl}">${instrument.model.name}</a>
                        </c:when>
                        <c:otherwise>
                            <spring:url var="searchInstrumentUrl"
                                        value="/simpleSearch?q={instrument}">
                                <spring:param name="instrument" value="${instrument.model.value}"/>
                            </spring:url>
                            <a href="${searchInstrumentUrl}">${instrument.model.value}</a>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:set var="sources" value="${instrument.sources}"/>
                    <c:forEach var="source" items="${sources}">
                        <c:forEach var="sourceParam" items="${source.params}">
                            ${sourceParam.name}
                            <c:if test="${not empty sourceParam.value}">
                                : ${sourceParam.value}
                            </c:if>
                            <br/>
                        </c:forEach>
                    </c:forEach>
                </td>
                <td>
                    <c:set var="analyzers" value="${instrument.analyzers}"/>
                    <c:forEach var="analyzer" items="${analyzers}">
                        <c:forEach var="analyzerParam" items="${analyzer.params}">
                            ${analyzerParam.name}
                            <c:if test="${not empty analyzerParam.value}">
                                : ${analyzerParam.value}
                            </c:if>
                            <br/>
                        </c:forEach>
                    </c:forEach>
                </td>
                <td>
                    <c:set var="detectors" value="${instrument.detectors}"/>
                    <c:forEach var="detector" items="${detectors}">
                        <c:forEach var="detectorParam" items="${detector.params}">
                            ${detectorParam.name}
                            <c:if test="${not empty detectorParam.value}">
                                : ${detectorParam.value}
                            </c:if>
                            <br/>
                        </c:forEach>
                    </c:forEach>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    </c:when>
    <c:otherwise>
        <fmt:message key="not.available"/>
    </c:otherwise>
    </c:choose>
    </p>
</div>

<c:set var="additionals" value="${assaySummary.params}"/>
<c:if test="${not empty additionals}">
    <div class="grid_23 clearfix additional">
        <h4><fmt:message key="additional"/></h4>

        <p>
        <table class="summary-table">
            <thead>
            <tr>
                <th><fmt:message key="param.name"/></th>
                <th><fmt:message key="param.value"/></th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="additional" items="${additionals}">
                <tr>
                    <td>
                        <span style="white-space: nowrap">${additional.name}</span>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${fn:startsWith(additional.value, 'http://') || fn:startsWith(additional.value, 'https://') || fn:startsWith(additional.value, 'ftp://')}">
                                <a href="${additional.value}"><fmt:message key="go.to.link"/></a>
                            </c:when>
                            <c:otherwise>
                                ${additional.value}
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        </p>
    </div>
</c:if>

<spring:url var="prideInspectorUrl" value="/assays/{accession}/jnlp">
    <spring:param name="accession" value="${assaySummary.accession}"/>
</spring:url>

<inspector:webstartDialog prideInspectorUrl="${prideInspectorUrl}" />



