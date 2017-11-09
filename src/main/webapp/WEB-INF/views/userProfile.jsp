<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%-- user profile page--%>

<div class="grid_24 clearfix">
    <nav id="breadcrumb">
        <p>
            <spring:url var="prideUrl" value="//www.ebi.ac.uk/pride"/>
            <spring:url var="priderUrl" value="/"/>
            <a href="${prideUrl}"><fmt:message key="pride"/></a> &gt; <a href="${priderUrl}"><fmt:message key="prider"/></a>
            &gt; <fmt:message key="user.profile"/>
        </p>
    </nav>
</div>

<div class="grid_23 clearfix">

    <div class="grid_10">
        <h4 style="font-weight:bold">
            <sec:authorize access="hasRole('SUBMITTER')">${user.title} </sec:authorize>${user.firstName}<sec:authorize access="hasRole('SUBMITTER')"> ${user.lastName}</sec:authorize>
        </h4>

        <sec:authorize access="hasRole('SUBMITTER')">
            <h5><fmt:message key="email"/>: ${user.email} </h5>
            <h5><fmt:message key="affiliation"/>: ${user.affiliation} </h5>
            <c:if test="${not empty user.country}">
                <h5><fmt:message key="country"/>: ${user.country} </h5>
            </c:if>
            <c:if test="${not empty user.orcid}">
                <h5><a href="https://orcid.org/${user.orcid}" title="Link: https://orcid.org/${user.orcid}" target="_blank">
                    <img src="https://orcid.org/sites/default/files/images/orcid_24x24.png" title="Image: ORCID" border="0"> orcid.org/${user.orcid}</a>
                </h5>
            </c:if>
        </sec:authorize>

    </div>

    <div class="grid_4 clearfix">
        <spring:url var="editProfileUrl" value="/users/profile/edit"/>

        <sec:authorize access="hasRole('SUBMITTER')">
            <form action="${editProfileUrl}" method="GET">
                <button class="button" type="submit">
                    <fmt:message key="user.profile.edit"/>
                </button>
            </form>
        </sec:authorize>
    </div>
</div>

<div class="grid_23 clearfix" style="border-top: solid #d9d9d9 1px;">
    <div class="grid_23 clearfix" style="padding-top: 20px;">
        <h3>
            <fmt:message key="my.project.list.title"/>
        </h3>
    </div>

    <%-- project table --%>
    <div class="grid_23">
        <p>
            <c:choose>
            <c:when test="${not empty projects}">
        <table class="summary-table ">
            <thead>
            <tr>
                <th style="text-align:center;">
                    <fmt:message key="project.accession"/>
                </th>
                <th style="text-align:center;">
                    <fmt:message key="title"/>
                </th>
                <th style="text-align:center;">
                    <fmt:message key="species"/>
                </th>
                <th style="text-align:center;">
                    <fmt:message key="experiment.type"/>
                </th>
                <th style="text-align:center;">
                    <fmt:message key="submission.type"/>
                </th>
                <th style="text-align:center;">
                    <fmt:message key="submission.date"/>
                </th>
                <th style="text-align:center;">
                    <fmt:message key="publication.date"/>
                </th>
                <th style="text-align:center;">
                    <fmt:message key="claim.to.orcid"/>
                </th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="myProject" items="${projects}">
                <tr>
                    <td style="text-align:center;">
                        <spring:url var="showUrl" value="/projects/{projectAccession}">
                            <spring:param name="projectAccession" value="${myProject.accession}"/>
                        </spring:url>
                        <a href="${showUrl}" class="icon icon-functional"
                           data-icon="4">${myProject.accession}</a>
                    </td style="text-align:center;">
                    <td style="text-align:center;">
                            ${myProject.title}
                    </td>
                    <td style="text-align:center;">
                        <c:set var="species" value="${myProject.species}"/>

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
                    </td>
                    <td style="text-align:center;">
                        <c:set var="experimentTypes" value="${myProject.experimentTypes}"/>

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
                    </td>
                    <td style="text-align:center;">
                            ${myProject.submissionType}
                    </td>
                    <td style="text-align:center;">
                        <fmt:formatDate value="${myProject.submissionDate}" pattern="dd/MM/yyyy"/>
                    </td>
                    <td style="text-align:center;">
                        <c:choose>
                            <c:when test="${not empty myProject.publicationDate}">
                                <fmt:formatDate value="${myProject.publicationDate}" pattern="dd/MM/yyyy"/>
                            </c:when>
                            <c:otherwise>
                                <sec:authorize access="hasRole('SUBMITTER')">
                                    <spring:url var="publishProjectUrl" value="/projects/{projectAccession}/publish">
                                        <spring:param name="projectAccession" value="${myProject.accession}"/>
                                    </spring:url>
                                    <form action="${publishProjectUrl}" method="GET">
                                        <button class="button-no-margin" type="submit" value="Public">
                                            <fmt:message key="make.project.public"/>
                                        </button>
                                    </form>
                                </sec:authorize>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td style="text-align:center;">
                        <c:if test="${not empty myProject.publicationDate}">
                        <spring:url var="claimProjectToOrcid" value="https://www.ebi.ac.uk/ebisearch/search.ebi?db=pride&query=${myProject.accession}"/>
                        <div style="margin: 0 auto; width: 24px">
                            <a href="${claimProjectToOrcid}" title="Claim project to ORCID" target="_blank">
                                <img src="https://orcid.org/sites/default/files/images/orcid_24x24.png" title="Claim ${myProject.accession} to ORCID" border="0" style="width: 24px"></a>
                            </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <c:if test="${not empty user.orcid}">
            <spring:url var="claimToOrcid" value="https://www.ebi.ac.uk/ebisearch/search.ebi?db=pride&query=${user.orcid}"/>
            <sec:authorize access="hasRole('SUBMITTER')">
                <form action="${claimToOrcid}" method="post" target="_blank">
                    <button class="button" type="submit">
                        <fmt:message key="user.profile.orcid.claim"/>
                    </button>
                </form>
            </sec:authorize>
        </c:if>
        <form action="http://www.ebi.ac.uk/pride/help/archive/claim-to-orcid" method="post" target="_blank">
            <button class="button" type="submit">
                <fmt:message key="user.profile.orcid.claim.help"/>
            </button>
        </form><b>*Please note: if your project has recently been made public, it may not be ready yet to be claimed to your ORCID ID.</b>
    </c:when>
        <c:otherwise>
            <h4><fmt:message key="my.project.list.empty"/></h4>
        </c:otherwise>
        </c:choose>
    </div>
</div>
