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
            ${user.firstName} <sec:authorize access="hasRole('SUBMITTER')">${user.lastName}</sec:authorize>
        </h4>

        <sec:authorize access="hasRole('SUBMITTER')">
            <h5><fmt:message key="email"/>: ${user.email} </h5>
            <h5><fmt:message key="affiliation"/>: ${user.affiliation} </h5>
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
                        <th>
                            <fmt:message key="project.accession"/>
                        </th>
                        <th>
                            <fmt:message key="title"/>
                        </th>
                        <th>
                            <fmt:message key="species"/>
                        </th>
                        <th>
                            <fmt:message key="experiment.type"/>
                        </th>
                        <th>
                            <fmt:message key="submission.type"/>
                        </th>
                        <th>
                            <fmt:message key="submission.date"/>
                        </th>
                        <th>
                            <fmt:message key="publication.date"/>
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="myProject" items="${projects}">
                        <tr>
                            <td>
                                <spring:url var="showUrl" value="/projects/{projectAccession}">
                                    <spring:param name="projectAccession" value="${myProject.accession}"/>
                                </spring:url>
                                <a href="${showUrl}" class="icon icon-functional"
                                   data-icon="4">${myProject.accession}</a>
                            </td>
                            <td>
                                    ${myProject.title}
                            </td>
                            <td>
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
                            <td>
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
                            <td>
                                    ${myProject.submissionType}
                            </td>
                            <td>
                                <fmt:formatDate value="${myProject.submissionDate}" pattern="dd/MM/yyyy"/>
                            </td>
                            <td>
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
                                                <button class="button" type="submit" value="Public">
                                                    <fmt:message key="make.project.public"/>
                                                </button>
                                            </form>
                                        </sec:authorize>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <h4><fmt:message key="my.project.list.empty"/></h4>
            </c:otherwise>
        </c:choose>
    </div>

</div>
