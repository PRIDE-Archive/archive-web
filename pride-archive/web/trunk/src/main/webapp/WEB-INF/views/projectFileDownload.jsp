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


<div class="grid_24 clearfix">
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
        <h3><fmt:message key="project"/> : ${projectSummary.accession}</h3>
    </div>
    <div class="grid_6 omega">
        <c:if test="${fn:toLowerCase(projectSummary.submissionType) != 'partial'}">
            <h5>
                <span class="icon icon-functional" data-icon="4" id="inspector-confirm"><fmt:message key="pride.inspector.title"/></span>
            </h5>
        </c:if>

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

    <c:if test="${not empty fileSummariesQUANTIFICATION}">
        <h5>${fn:length(fileSummariesQUANTIFICATION)} <fmt:message key="file.quantification.files"/></h5>
        <priderElement:fileListTable fileList="${fileSummariesQUANTIFICATION}" projectSummary="${projectSummary}" />
    </c:if>

    <c:if test="${not empty fileSummariesGEL}">
        <h5>${fn:length(fileSummariesGEL)} <fmt:message key="file.gel.files"/></h5>
        <priderElement:fileListTable fileList="${fileSummariesGEL}" projectSummary="${projectSummary}" />
    </c:if>

    <c:if test="${not empty fileSummariesOTHER}">
        <h5>${fn:length(fileSummariesOTHER)} <fmt:message key="file.other.files"/></h5>
        <priderElement:fileListTable fileList="${fileSummariesOTHER}" projectSummary="${projectSummary}" />
    </c:if>

</div>

<spring:url var="prideInspectorUrl" value="/projects/{accession}/jnlp">
    <spring:param name="accession" value="${projectSummary.accession}"/>
</spring:url>

<inspector:webstartDialog prideInspectorUrl="${prideInspectorUrl}" />




