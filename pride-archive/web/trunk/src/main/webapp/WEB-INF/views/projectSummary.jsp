<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="inspector" tagdir="/WEB-INF/tags/inspector" %>

<%-- Breadcrumb for navigation --%>
<%-- PRIDE > PRIDE Archive > Accession--%>
<div class="grid_24 clearfix">
    <nav id="breadcrumb">
        <p>
            <spring:url var="prideUrl" value="http://www.ebi.ac.uk/pride"/>
            <spring:url var="priderUrl" value="/"/>
            <a href="${prideUrl}"><fmt:message key="pride"/></a> &gt; <a href="${priderUrl}"><fmt:message
                key="prider"/></a>
            &gt; ${projectSummary.accession}
        </p>
    </nav>
</div>

<%-- Project header including accession and download options--%>
<div class="grid_23 clearfix project-title">
    <div class="grid_18 alpha">
        <h3><fmt:message key="project"/> : ${projectSummary.accession}</h3>

        <%-- pride internal tags--%>
        <c:if test="${not empty projectSummary.internalTags or projectSummary.highlighted == true}">
            <div style="display: block">
                <h6 style="display: inline"><fmt:message key="project.pride.tag"/>:</h6>
                <c:if test="${not empty projectSummary.internalTags}">
                    <c:forEach var="internalTag" items="${projectSummary.internalTags}">
                        <spring:url var="searchTagUrl"
                                    value="/simpleSearch?q=&projectTagFilters={projectTagFilter}">
                            <spring:param name="tag" value="${internalTag.tag}"/>
                            <spring:param name="projectTagFilter" value="${internalTag.tag}"/>
                        </spring:url>

                    <a class="${fn:toLowerCase(internalTag.tag)}"
                             href="${searchTagUrl}">${internalTag.tag} <fmt:message key="project.dataset"/></a>
                    </c:forEach>
                </c:if>

                <c:if test="${projectSummary.highlighted == true}">
                    <spring:url var="searchTagUrl"
                                value="/simpleSearch?q=&projectTagFilters={projectTagFilter}">
                        <spring:param name="tag" value="Highlighted"/>
                        <spring:param name="projectTagFilter" value="Highlighted"/>
                    </spring:url>

                    <a class="highlighted" href="${searchTagUrl}"><fmt:message key="project.highlighted"/></a>
                </c:if>
            </div>
        </c:if>

        <%--parent project tags--%>
        <c:if test="${not empty projectSummary.parentProjectTags}">
            <div style="display: block">
                <h6 style="display: inline"><fmt:message key="project.parent.tag"/>:</h6>
                <c:forEach var="parentProjectTag" items="${projectSummary.parentProjectTags}">
                    <spring:url var="searchTagUrl"
                                value="/simpleSearch?q=&projectTagFilters={projectTagFilter}">
                        <spring:param name="tag" value="${parentProjectTag.tag}"/>
                        <spring:param name="projectTagFilter" value="${parentProjectTag.tag}"/>
                    </spring:url>

                    <a class="other" href="${searchTagUrl}">${parentProjectTag.tag}</a>
                </c:forEach>
            </div>
        </c:if>
    </div>

    <div class="grid_6 omega right-justify">
        <c:if test="${fn:toLowerCase(projectSummary.submissionType) != 'partial'}">
            <%-- launch pride inspector --%>
            <h5>
                <span class="icon icon-functional" data-icon="4" id="inspector-confirm">
                    <fmt:message key="pride.inspector.title"/>
                </span>
            </h5>
        </c:if>

        <%-- download project files--%>
        <spring:url var="projectFileUrl" value="/projects/{accession}/files">
            <spring:param name="accession" value="${projectSummary.accession}"/>
        </spring:url>
        <h5>
            <a href="${projectFileUrl}" class="icon icon-functional" data-icon="=">
                <fmt:message key="project.file.download.title"/>
            </a>
        </h5>
        <c:if test="${fn:toLowerCase(projectSummary.submissionType) != 'partial' and projectSummary.indexProteinCount > 0}">
            <spring:url var="projectProteinsUrl" value="/projects/{accession}/proteins">
                <spring:param name="accession" value="${projectSummary.accession}"/>
            </spring:url>
            <h5>
                <a href="${projectProteinsUrl}" class="icon icon-functional" data-icon="4">
                    <fmt:message key="project.proteins.table"/>
                </a>
            </h5>
        </c:if>

        <c:if test="${fn:toLowerCase(projectSummary.submissionType) != 'partial' and projectSummary.indexPsmCount gt 0 }">
            <spring:url var="projectPsmsUrl" value="/projects/{accession}/psms">
                <spring:param name="accession" value="${projectSummary.accession}"/>
            </spring:url>
            <h5>
                <a href="${projectPsmsUrl}" class="icon icon-functional" data-icon="4">
                    <fmt:message key="project.psms.table"/>
                </a>
            </h5>
        </c:if>
    </div>
</div>

<div class="grid_23 project-summary">
<%-- Summary title--%>
<h4><fmt:message key="summary"/></h4>

<div class="grid_16 left-column">
    <%-- project title--%>
    <h5><fmt:message key="title"/></h5>

    <p>
        ${projectSummary.title}
    </p>

    <%-- project description --%>
    <h5><fmt:message key="project.description"/></h5>

    <p class="longtext">
        ${projectSummary.projectDescription}
    </p>

    <%-- sample processing protocol --%>
    <h5><fmt:message key="project.sample.processing.protocol"/></h5>
    <c:set var="sampleProcessingProtocol" value="${projectSummary.sampleProcessingProtocol}"/>
    <c:choose>
        <c:when test="${not fn:containsIgnoreCase(sampleProcessingProtocol, 'not available')}">
            <p class="longtext">
                    ${sampleProcessingProtocol}
            </p>
        </c:when>
        <c:otherwise>
            <c:set var="publications" value="${projectSummary.references}"/>
            <c:choose>
                <c:when test="${not empty publications}">
                    <p>
                        <fmt:message key="view.reference.detail"/> :
                        <c:forEach var="publication" items="${publications}">
                            <%-- pubmed url--%>
                            <spring:url var="pubmedIdUrl" value="http://www.ncbi.nlm.nih.gov/pubmed/{pubmedId}">
                                <spring:param name="pubmedId" value="${publication.pubmedId}"/>
                            </spring:url>

                            <a href="${pubmedIdUrl}" target="_blank">${publication.pubmedId}</a>
                        </c:forEach>
                    </p>
                </c:when>
                <c:otherwise>
                    <p><fmt:message key="not.available"/></p>
                </c:otherwise>
            </c:choose>
        </c:otherwise>
    </c:choose>

    <%-- data processing protocol --%>
    <h5><fmt:message key="project.data.processing.protocol"/></h5>
    <c:set var="dataProcessingProtocol" value="${projectSummary.dataProcessingProtocol}"/>
    <c:choose>
        <c:when test="${not fn:containsIgnoreCase(dataProcessingProtocol, 'not available')}">
            <p class="longtext">
                    ${dataProcessingProtocol}
            </p>
        </c:when>
        <c:otherwise>
            <c:set var="publications" value="${projectSummary.references}"/>
            <c:choose>
                <c:when test="${not empty publications}">
                    <p>
                        <fmt:message key="view.reference.detail"/> :
                        <c:forEach var="publication" items="${publications}">
                            <%-- pubmed url--%>
                            <spring:url var="pubmedIdUrl" value="http://www.ncbi.nlm.nih.gov/pubmed/{pubmedId}">
                                <spring:param name="pubmedId" value="${publication.pubmedId}"/>
                            </spring:url>

                            <a href="${pubmedIdUrl}" target="_blank">${publication.pubmedId}</a>
                        </c:forEach>
                    </p>
                </c:when>
                <c:otherwise>
                    <p><fmt:message key="not.available"/></p>
                </c:otherwise>
            </c:choose>
        </c:otherwise>
    </c:choose>

    <%-- submitter contact and lab heads --%>
    <h5><fmt:message key="contact"/></h5>

    <p>
        <%-- submitter --%>
        <a href="mailto:${projectSummary.submitter.email}">${projectSummary.submitter.firstName} ${projectSummary.submitter.lastName}</a>, ${projectSummary.submitter.affiliation}

        <%-- lab heads --%>
        <c:if test="${not empty projectSummary.labHeads}">
            <c:forEach var="labHead" items="${projectSummary.labHeads}">
                <br/>
                <a href="mailto:${labHead.email}">${labHead.firstName} ${labHead.lastName}</a>, ${labHead.affiliation} (
                <fmt:message key="project.labhead"/> )
            </c:forEach>
        </c:if>
    </p>

    <%-- submission date --%>
    <h5><fmt:message key="submission.date"/></h5>

    <p>
        <fmt:formatDate value="${projectSummary.submissionDate}" pattern="dd/MM/yyyy"/>
    </p>

</div>

<div class="grid_7 right-column">

<div class="grid_24">
    <div class="grid_12 alpha">
        <c:set var="species" value="${projectSummary.species}"/>
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
        <c:set var="tissues" value="${projectSummary.tissues}"/>
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
    <c:set var="cellTypes" value="${projectSummary.cellTypes}"/>
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


    <c:set var="diseases" value="${projectSummary.diseases}"/>
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

<%-- Instruments --%>
<div class="grid_24">
    <div class="grid_12">
        <c:set var="instruments" value="${projectSummary.instruments}"/>
        <h5><fmt:message key="instrument"/></h5>

        <p>
            <c:choose>
                <c:when test="${not empty instruments}">
                    <c:forEach var="instrument" items="${instruments}">
                        <c:choose>
                            <c:when test="${empty instrument.value}">
                                <spring:url var="searchInstrumentUrl"
                                            value="/simpleSearch?q={instrument}">
                                    <spring:param name="instrument" value="${instrument.name}"/>
                                </spring:url>

                                <a href="${searchInstrumentUrl}">${instrument.name}</a>
                                <br/>
                            </c:when>
                            <c:otherwise>
                                <spring:url var="searchInstrumentUrl"
                                            value="/simpleSearch?q={instrument}">
                                    <spring:param name="instrument" value="${instrument.value}"/>
                                </spring:url>

                                <a href="${searchInstrumentUrl}">${instrument.value}</a>
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

    <%-- software --%>
    <div class="grid_12">
        <c:set var="software" value="${projectSummary.software}"/>
        <h5><fmt:message key="software"/></h5>

        <p>
            <c:choose>
                <c:when test="${not empty software}">
                    <c:forEach var="singleSoftware" items="${software}">
                        <c:choose>
                            <c:when test="${not fn:containsIgnoreCase(singleSoftware.value, 'unknown')}">
                                <spring:url var="searchSoftwareUrl"
                                            value="/simpleSearch?q={software}">
                                    <spring:param name="software" value="${singleSoftware.value}"/>
                                </spring:url>

                                <a href="${searchSoftwareUrl}">${singleSoftware.value}</a>
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

<%-- Modifications --%>
<div class="grid_24">
    <div class="grid_12">
        <c:set var="ptms" value="${projectSummary.ptms}"/>
        <h5><fmt:message key="modification"/></h5>

        <p>
            <c:choose>
                <c:when test="${not empty ptms}">
                    <c:forEach var="ptm" items="${ptms}">
                        <spring:url var="searchPTMUrl"
                                    value="/simpleSearch?q={ptm}">
                            <spring:param name="ptm" value="${ptm.name}"/>
                        </spring:url>

                        <a href="${searchPTMUrl}">${ptm.name}</a>
                        <br/>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <fmt:message key="not.available"/>
                </c:otherwise>
            </c:choose>
        </p>
    </div>

    <%-- quantification --%>
    <div class="grid_12">
        <c:set var="quantificationMethods" value="${projectSummary.quantificationMethods}"/>
        <h5><fmt:message key="quantification.method"/></h5>

        <p>
            <c:choose>
                <c:when test="${not empty quantificationMethods}">
                    <c:forEach var="quantificationMethod" items="${quantificationMethods}">
                        <spring:url var="searchQuantificationUrl"
                                    value="/simpleSearch?q={quantification}">
                            <spring:param name="quantification" value="${quantificationMethod.name}"/>
                        </spring:url>

                        <a href="${searchQuantificationUrl}">${quantificationMethod.name}</a>
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
    <div class="grid_12">
        <c:set var="experimentTypes" value="${projectSummary.experimentTypes}"/>
        <h5><fmt:message key="experiment.type"/></h5>

        <p>
            <c:choose>
                <c:when test="${not empty experimentTypes}">
                    <c:forEach var="experimentType" items="${experimentTypes}">
                        <spring:url var="searchExperimentTypeUrl"
                                    value="/simpleSearch?q={experimentType}">
                            <spring:param name="experimentType" value="${experimentType.name}"/>
                        </spring:url>

                        <a href="${searchExperimentTypeUrl}">${experimentType.name}</a>
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
        <c:if test="${not empty assaySummaries}">
            <h5><fmt:message key="assay.number"/></h5>

            <p>
                <a href="#assays">${fn:length(assaySummaries)}</a>
            </p>
        </c:if>
    </div>
</div>
</div>
</div>

<%-- publications --%>
<div class="grid_23 clearfix publication">
    <h4><fmt:message key="publication"/></h4>
    <c:set var="publications" value="${projectSummary.references}"/>
    <c:choose>
        <c:when test="${not empty publications}">
            <ul>
                <c:forEach var="publication" items="${publications}">
                    <%-- pubmed url--%>
                    <spring:url var="pubmedIdUrl" value="http://www.ncbi.nlm.nih.gov/pubmed/{pubmedId}">
                        <spring:param name="pubmedId" value="${publication.pubmedId}"/>
                    </spring:url>

                    <p>
                            ${publication.referenceLine}
                        <fmt:message key="pubmed"/> : <a href="${pubmedIdUrl}"
                                                         target="_blank">${publication.pubmedId}</a>
                    </p>
                </c:forEach>
            </ul>
        </c:when>
        <c:otherwise>
            <fmt:message key="publication.pending"/>
        </c:otherwise>
    </c:choose>
</div>

<%-- assay summaries --%>
<c:if test="${not empty assaySummaries}">
    <div id="assays" class="grid_23 clearfix assay">
        <h4><fmt:message key="assay.list.title"/></h4>

        <p>
        <table class="summary-table" width="1080px">
            <thead class="fixedHeader">
            <tr>
                <th width="80px">
                    <fmt:message key="assay.accession"/>
                </th>
                <th width="500px">
                    <fmt:message key="assay.title"/>
                </th>
                <th width="80px">
                    <fmt:message key="assay.protein.count"/>
                </th>
                <th width="80px">
                    <fmt:message key="assay.peptide.count"/>
                </th>
                <th width="100px">
                    <fmt:message key="assay.unique.peptide.count"/>
                </th>
                <th width="80px">
                    <fmt:message key="assay.spectrum.count"/>
                </th>
                <th width="120px">
                    <fmt:message key="assay.identified.spectrum.count"/>
                </th>
                <th width="100px">
                    <fmt:message key="assay.reactome.link"/>
                </th>
            </tr>
            </thead>
            <tbody class="scrollContent">
            <c:forEach var="assay" items="${assaySummaries}">
                <tr>
                    <td width="80px">
                        <spring:url var="showUrl" value="/projects/{projectAccession}/assays/{assayAccession}">
                            <spring:param name="projectAccession" value="${projectSummary.accession}"/>
                            <spring:param name="assayAccession" value="${assay.accession}"/>
                        </spring:url>
                        <a href="${showUrl}" class="icon icon-functional" data-icon="4">${assay.accession}</a>
                    </td>
                    <td width="500px">
                            ${assay.title}
                    </td>
                    <td width="80px">
                        <c:choose>
                            <c:when test="${assay.proteinCount > 0  and assay.indexProteinCount gt 0}">
                                <spring:url var="proteinPageUrl" value="/projects/{projectAccession}/assays/{assayAccession}/proteins">
                                    <spring:param name="projectAccession" value="${projectSummary.accession}"/>
                                    <spring:param name="assayAccession" value="${assay.accession}"/>
                                </spring:url>
                                <a href="${proteinPageUrl}">${assay.proteinCount}</a>
                            </c:when>
                            <c:otherwise>
                                ${assay.proteinCount}
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td width="80px">
                        <c:choose>
                            <c:when test="${assay.peptideCount > 0 and assay.indexPsmCount gt 0}">
                                <spring:url var="psmPageUrl" value="/projects/{projectAccession}/assays/{assayAccession}/psms">
                                    <spring:param name="projectAccession" value="${projectSummary.accession}"/>
                                    <spring:param name="assayAccession" value="${assay.accession}"/>
                                </spring:url>
                                <a href="${psmPageUrl}">${assay.peptideCount}</a>
                            </c:when>
                            <c:otherwise>
                                ${assay.peptideCount}
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td width="100px">
                            ${assay.uniquePeptideCount}
                    </td>
                    <td width="80px">
                            ${assay.totalSpectrumCount}
                    </td>
                    <td width="120px">
                            ${assay.identifiedSpectrumCount}
                    </td>
                    <td width="100px" style="text-align: center">
                        <button onclick="reactomeAnalysis(this, ${assay.accession}, false)" class="reactome-analyse">
                            Analyse
                        </button>
                        <%--<reactome-analysis-url value="http://wwwdev.ebi.ac.uk/pride/ws/archive/protein/list/assay/${assay.accession}.acc" project="false" size="12"></reactome-analysis-url>--%>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</c:if>
<spring:url var="prideInspectorUrl" value="/projects/{accession}/jnlp">
    <spring:param name="accession" value="${projectSummary.accession}"/>
</spring:url>

<inspector:webstartDialog prideInspectorUrl="${prideInspectorUrl}" />

<spring:url var="readMoreJavascriptUrl" value="/resources/javascript/readmore.min.js"/>
<script src="${readMoreJavascriptUrl}"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $(".longtext").readmore({
            maxHeight: 100,
            moreLink: '<p> <a href="#">Read more</a></p>',
            lessLink: '<p> <a href="#">Close</a> </p>'
        });
    });
</script>
