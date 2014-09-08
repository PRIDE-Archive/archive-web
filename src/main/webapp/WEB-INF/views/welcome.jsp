<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%-- welcome page--%>

<%-- bread crumb--%>
<div class="grid_24 clearfix">
    <nav id="breadcrumb">
        <p>
            <spring:url var="prideUrl" value="http://www.ebi.ac.uk/pride"/>
            <a href="${prideUrl}"><fmt:message key="pride"/></a> &gt; <fmt:message key="prider"/>
        </p>
    </nav>
</div>

<div id="top" class="grid_24 clearfix">

    <section id="introduction" class="grid_18 alpha">
        <h2>
            <fmt:message key="welcome.intro.caption"/>
        </h2>

        <p class="justify-body-text">
            <fmt:message key="welcome.intro.body"/>
        </p>
    </section>

    <section id="statistics" class="grid_6 omega">
        <h3 class="icon icon-functional" data-icon="z">
            <fmt:message key="welcome.statistics.caption"/>
        </h3>

        <p class="justify-body-text">
        <ul>
            <li class="justify-body-text">${statistics.numProjects} projects</li>
            <li class="justify-body-text">${statistics.numAssay} assays</li>
        </ul>
        </p>
    </section>
</div>

<div id="top" class="grid_24 clearfix">
    <br/><br/><br/>
</div>

<div id="bottom" class="grid_24">

    <section id="submit-data" class="grid_6 alpha">
        <h3 class="icon icon-functional" data-icon="_">
            <fmt:message key="welcome.submit.data.caption"/>
        </h3>

        <p class="justify-body-text">
            <spring:url var="submissionUrl" value="http://www.ebi.ac.uk/pride/help/archive/submission"/>
            <a href="${submissionUrl}"><fmt:message key="welcome.submit.data.caption"/></a>: <fmt:message
                key="welcome.submit.data.summary"/>
        </p>

        <p class="justify-body-text">
            <spring:url var="proteomeXchangeUrl" value="http://www.proteomexchange.org/"/>
            <a href="${proteomeXchangeUrl}"><fmt:message key="welcome.submit.data.proteomexchange.caption"/></a>:
            <fmt:message key="welcome.submit.data.proteomexchange.summary"/>
        </p>
    </section>

    <section id="access-and-download" class="grid_6">
        <h3 class="icon icon-functional" data-icon="4">
            <fmt:message key="welcome.access.caption"/>
        </h3>

        <p class="justify-body-text">
            <spring:url var="browseUrl" value="/simpleSearch?q=&submit=Search"/>
            <a href="${browseUrl}"><fmt:message key="welcome.access.browse.caption"/></a>:
            <fmt:message key="welcome.access.browse.summary"/>
        </p>

        <p class="justify-body-text">
            <spring:url var="webserviceUrl" value="http://www.ebi.ac.uk/pride/ws/archive"/>
            <a href="${webserviceUrl}"><fmt:message key="welcome.access.webservice.caption"/></a>:
            <fmt:message key="welcome.access.webservice.summary"/>
        </p>

        <p class="justify-body-text">
            <spring:url var="browseUrl" value="ftp://ftp.pride.ebi.ac.uk/pride/data/archive"/>
            <a href="${browseUrl}"><fmt:message key="welcome.access.ftp.caption"/></a>:
            <fmt:message key="welcome.access.ftp.summary"/>
        </p>

    </section>

    <section id="tools-and-tips" class="grid_6">
        <h3 class="icon icon-functional" data-icon="t">
            <fmt:message key="welcome.prider.tools.caption"/>
        </h3>

        <p class="justify-body-text">
            <spring:url var="prideInspectorUrl" value="http://code.google.com/p/pride-toolsuite/wiki/PRIDEInspector"/>
            <a href="${prideInspectorUrl}"><fmt:message key="welcome.pride.inspector.caption"/></a>:
            <fmt:message key="welcome.pride.inspector.summary"/>
        </p>

        <p class="justify-body-text">
            <spring:url var="prideConverterUrl" value="http://code.google.com/p/pride-converter-2/"/>
            <a href="${prideConverterUrl}"><fmt:message key="welcome.pride.converter.caption"/></a>:
            <fmt:message key="welcome.pride.converter.summary"/>
        </p>
    </section>


    <section id="dataset-of-the-month" class="grid_6">
        <h3 class="icon icon-generic" data-icon="N">
            <fmt:message key="welcome.news.caption"/>
        </h3>

        <p>
            <c:forEach items="${tweets}" var="tweet">

            <div class="row">
                <div class="date-box">
                    <span class="month"><fmt:formatDate type="date" dateStyle="medium" value="${tweet.createdAt}"
                                                        pattern="MMM"/></span>
                    <span class="day"><fmt:formatDate type="date" value="${tweet.createdAt}" pattern="dd"/></span>
                </div>
                <span class="justify-body-text"><c:out value="${tweet.text}" escapeXml="false"/></span>
            </div>
            </c:forEach>

            <spring:url var="newsUrl" value="https://twitter.com/@pride_ebi"/>
            <a class="justify-body-text icon icon-socialmedia" data-icon="T"href="${newsUrl}"><fmt:message key="welcome.news.more.news.caption"/></a>
        </p>
    </section>

</div>

