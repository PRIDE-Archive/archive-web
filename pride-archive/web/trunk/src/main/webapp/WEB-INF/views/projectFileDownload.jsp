<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="priderElement" tagdir="/WEB-INF/tags/elements" %>
<%@ taglib prefix="inspector" tagdir="/WEB-INF/tags/inspector" %>
<%@ taglib prefix="file" tagdir="/WEB-INF/tags/file" %>


<div class="grid_23 clearfix">
    <nav id="breadcrumb">
    <p>
        <spring:url var="prideUrl" value="http://www.ebi.ac.uk/pride"/>
        <spring:url var="priderUrl" value="/"/>
        <spring:url var="projectUrl" value="/projects/{accession}">
            <spring:param name="accession" value="${projectSummary.accession}"/>
        </spring:url>
        <a href="${prideUrl}"><fmt:message key="pride"/></a> &gt; <a href="${priderUrl}"><fmt:message
            key="prider"/> </a> &gt; <a href="${projectUrl}">${projectSummary.accession}</a> &gt;
        <span><fmt:message key="download.files"/> </span>
    </p>
    </nav>
</div>

<div class="grid_23 clearfix project-title">
    <div class="grid_18 alpha">
        <h2><fmt:message key="download.files"/> per <fmt:message key="project"/> ${projectSummary.accession}</h2>
        <h4>
            <span>
                <img id="inspector-confirm" class="inspector_window" src="${pageContext.request.contextPath}/resources/img/inspectorIcon.png" />
                <a id="inspector-link" href="https://github.com/PRIDE-Toolsuite/pride-inspector"><fmt:message key="pride.inspector.title"/></a>
            </span>
        </h4>
        <inspector:inspectorDialog accession="${projectSummary.accession}" />
    </div>

    <div class="grid_6 omega">

        <%-- go to ftp folder & show aspera download --%>
        <c:if test="${not empty projectSummary.publicationDate }">
            <file:download projectPublicationDate="${projectSummary.publicationDate}"
                           projectAccession="${projectSummary.accession}"
                           ftpRootAddress="ftp://ftp.pride.ebi.ac.uk/pride/data/archive"/>
        </c:if>
    </div>
</div>

<%-- Aspera application object --%>
<div class="aspera-content">
    <object id="aspera-web" type="application/x-aspera-web" width="0" height="0"></object>
</div>

<div class="grid_23 clearfix file-list">

    <h4><fmt:message key="file.list.title"/></h4>

    <c:if test="${not empty fileSummariesRESULT}">
        <h5>${fn:length(fileSummariesRESULT)} <fmt:message key="file.result.files"/></h5>
        <priderElement:fileListTable fileList="${fileSummariesRESULT}" projectSummary="${projectSummary}" />
    </c:if>

    <c:if test="${not empty fileSummariesSEARCH}">
        <h5>${fn:length(fileSummariesSEARCH)} <fmt:message key="file.search.files"/></h5>
        <priderElement:fileListTable fileList="${fileSummariesSEARCH}" projectSummary="${projectSummary}" />
    </c:if>

    <c:if test="${not empty fileSummariesPEAK}">
        <h5>${fn:length(fileSummariesPEAK)} <fmt:message key="file.peak.files"/></h5>
        <priderElement:fileListTable fileList="${fileSummariesPEAK}" projectSummary="${projectSummary}" />
    </c:if>

    <c:if test="${not empty fileSummariesRAW}">
        <h5>${fn:length(fileSummariesRAW)} <fmt:message key="file.raw.files"/></h5>
        <priderElement:fileListTable fileList="${fileSummariesRAW}" projectSummary="${projectSummary}" />
    </c:if>

    <c:if test="${not empty fileSummariesQUANT}">
        <h5>${fn:length(fileSummariesQUANT)} <fmt:message key="file.quantification.files"/></h5>
        <priderElement:fileListTable fileList="${fileSummariesQUANT}" projectSummary="${projectSummary}" />
    </c:if>

    <c:if test="${not empty fileSummariesGEL}">
        <h5>${fn:length(fileSummariesGEL)} <fmt:message key="file.gel.files"/></h5>
        <priderElement:fileListTable fileList="${fileSummariesGEL}" projectSummary="${projectSummary}" />
    </c:if>

    <c:if test="${not empty fileSummariesMS_IMAGE_DATA}">
        <h5>${fn:length(fileSummariesMS_IMAGE_DATA)} <fmt:message key="file.ms.image.files"/></h5>
        <priderElement:fileListTable fileList="${fileSummariesMS_IMAGE_DATA}" projectSummary="${projectSummary}" />
    </c:if>

    <c:if test="${not empty fileSummariesOPTICAL_IMAGE}">
        <h5>${fn:length(fileSummariesOPTICAL_IMAGE)} <fmt:message key="file.optical.image.files"/></h5>
        <priderElement:fileListTable fileList="${fileSummariesOPTICAL_IMAGE}" projectSummary="${projectSummary}" />
    </c:if>

    <c:if test="${not empty fileSummariesFASTA}">
        <h5>${fn:length(fileSummariesFASTA)} <fmt:message key="file.fasta.files"/></h5>
        <priderElement:fileListTable fileList="${fileSummariesFASTA}" projectSummary="${projectSummary}" />
    </c:if>

    <c:if test="${not empty fileSummariesSPECTRUM_LIBRARY}">
        <h5>${fn:length(fileSummariesSPECTRUM_LIBRARY)} <fmt:message key="file.spectrum.library.files"/></h5>
        <priderElement:fileListTable fileList="${fileSummariesSPECTRUM_LIBRARY}" projectSummary="${projectSummary}" />
    </c:if>

    <c:if test="${not empty fileSummariesOTHER}">
        <h5>${fn:length(fileSummariesOTHER)} <fmt:message key="file.other.files"/></h5>
        <priderElement:fileListTable fileList="${fileSummariesOTHER}" projectSummary="${projectSummary}" />
    </c:if>

</div>

<%-- ToDo: we don't list any generated files until we are sure about their availability --%>
<c:set var="numFiles" value="0"/>
<%--<c:set var="numFiles"--%>
       <%--value="${fn:length(fileGeneratedSummariesRESULT) +--%>
                <%--fn:length(fileGeneratedSummariesRAW) +--%>
                <%--fn:length(fileGeneratedSummariesPEAK) +--%>
                <%--fn:length(fileGeneratedSummariesSEARCH) +--%>
                <%--fn:length(fileGeneratedSummariesQUANT) +--%>
                <%--fn:length(fileGeneratedSummariesGEL) +--%>
                <%--fn:length(fileGeneratedSummariesMS_IMAGE_DATA) +--%>
                <%--fn:length(fileGeneratedSummariesOPTICAL_IMAGE) +--%>
                <%--fn:length(fileGeneratedSummariesOTHER)--%>
                <%--}"/>--%>

<c:if test="${numFiles gt 0}">
    <div class="grid_23 clearfix file-list">
        <h4><fmt:message key="file.generated.files"/></h4>

        <c:if test="${not empty fileGeneratedSummariesRESULT}">
            <h5>${fn:length(fileGeneratedSummariesRESULT)} <fmt:message key="file.result.files"/></h5>
            <priderElement:fileListTable fileList="${fileGeneratedSummariesRESULT}" projectSummary="${projectSummary}" />
        </c:if>

        <c:if test="${not empty fileGeneratedSummariesRAW}">
            <h5>${fn:length(fileGeneratedSummariesRAW)} <fmt:message key="file.raw.files"/></h5>
            <priderElement:fileListTable fileList="${fileGeneratedSummariesRAW}" projectSummary="${projectSummary}" />
        </c:if>

        <c:if test="${not empty fileGeneratedSummariesPEAK}">
            <h5>${fn:length(fileGeneratedSummariesPEAK)} <fmt:message key="file.peak.files"/></h5>
            <priderElement:fileListTable fileList="${fileGeneratedSummariesPEAK}" projectSummary="${projectSummary}" />
        </c:if>

        <c:if test="${not empty fileGeneratedSummariesSEARCH}">
            <h5>${fn:length(fileGeneratedSummariesSEARCH)} <fmt:message key="file.search.files"/></h5>
            <priderElement:fileListTable fileList="${fileGeneratedSummariesSEARCH}" projectSummary="${projectSummary}" />
        </c:if>

        <c:if test="${not empty fileGeneratedSummariesQUANT}">
            <h5>${fn:length(fileGeneratedSummariesQUANT)} <fmt:message key="file.quantification.files"/></h5>
            <priderElement:fileListTable fileList="${fileGeneratedSummariesQUANT}" projectSummary="${projectSummary}" />
        </c:if>

        <c:if test="${not empty fileGeneratedSummariesGEL}">
            <h5>${fn:length(fileGeneratedSummariesGEL)} <fmt:message key="file.gel.files"/></h5>
            <priderElement:fileListTable fileList="${fileGeneratedSummariesGEL}" projectSummary="${projectSummary}" />
        </c:if>

        <c:if test="${not empty fileGeneratedSummariesMS_IMAGE_DATA}">
            <h5>${fn:length(fileGeneratedSummariesMS_IMAGE_DATA)} <fmt:message key="file.ms.image.files"/></h5>
            <priderElement:fileListTable fileList="${fileGeneratedSummariesMS_IMAGE_DATA}" projectSummary="${projectSummary}" />
        </c:if>

        <c:if test="${not empty fileGeneratedSummariesOPTICAL_IMAGE}">
            <h5>${fn:length(fileGeneratedSummariesOPTICAL_IMAGE)} <fmt:message key="file.optical.image.files"/></h5>
            <priderElement:fileListTable fileList="${fileGeneratedSummariesOPTICAL_IMAGE}" projectSummary="${projectSummary}" />
        </c:if>

        <c:if test="${not empty fileSummariesFASTA}">
            <h5>${fn:length(fileSummariesFASTA)} <fmt:message key="file.fasta.files"/></h5>
            <priderElement:fileListTable fileList="${fileSummariesFASTA}" projectSummary="${projectSummary}" />
        </c:if>

        <c:if test="${not empty fileSummariesSPECTRUM_LIBRARY}">
            <h5>${fn:length(fileSummariesSPECTRUM_LIBRARY)} <fmt:message key="file.spectrum.library.files"/></h5>
            <priderElement:fileListTable fileList="${fileSummariesSPECTRUM_LIBRARY}" projectSummary="${projectSummary}" />
        </c:if>


        <c:if test="${not empty fileGeneratedSummariesOTHER}">
            <h5>${fn:length(fileGeneratedSummariesOTHER)} <fmt:message key="file.other.files"/></h5>
            <priderElement:fileListTable fileList="${fileGeneratedSummariesOTHER}" projectSummary="${projectSummary}" />
        </c:if>
    </div>
</c:if>
