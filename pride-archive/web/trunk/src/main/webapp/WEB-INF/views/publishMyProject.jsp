<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%-- publish project --%>

<%-- breadcrumb--%>
<div class="grid_24 clearfix">
    <nav id="breadcrumb">
        <p>
            <spring:url var="prideUrl" value="http://www.ebi.ac.uk/pride"/>
            <spring:url var="priderUrl" value="/"/>
            <a href="${prideUrl}"><fmt:message key="pride"/></a> &gt; <a href="${priderUrl}"><fmt:message
                key="prider"/></a>
            &gt; <fmt:message key="my.project.publish.title"/>
        </p>
    </nav>
</div>

<div class="grid_24">
    <h2>
        <fmt:message key="my.project.publish.title"/>: ${projectAccession}
    </h2>
</div>

<div class="grid_24" style="border-top: solid #d9d9d9 1px;">

    <div style="padding-top: 20px;">

        <h5><fmt:message key="my.project.publication.details"/></h5>

        <spring:url var="publishMyProjectUrl" value=""/>

        <form:form commandName="publishProject" action="${publishMyProjectUrl}" method="POST">

            <div>
                <label class="form-label">
                    <fmt:message key="pubmed"/>
                    <fmt:message key="optional.comma.separated"/>
                </label>
            </div>
            <div>
                <form:input cssClass="input-box" path="pubmedId"/>
                <form:errors cssClass="error" path="pubmedId"/>
            </div>
            <div>
                <label class="form-label">
                    <fmt:message key="doi"/>
                    <fmt:message key="optional.comma.separated"/>
                </label>
            </div>
            <div>
                <form:input cssClass="input-box" path="doi"/>
                <form:errors cssClass="error" path="doi"/>
            </div>
            <div>
                <label class="form-label">
                    <fmt:message key="reference.line"/>
                    <fmt:message key="optional"/>
                </label>
            </div>
            <div>
                <form:textarea cssClass="input-box" path="referenceLine" rows="3" cols="20"/>
                <form:errors cssClass="error" path="referenceLine"/>
            </div>


            <button class="button" type="submit" value="Update">
                <fmt:message key="confirm"/>
            </button>

            <spring:url var="userProfileUrl" value="/users/profile"/>
            <a href="${userProfileUrl}">
                <fmt:message key="cancel"/>
            </a>
        </form:form>


    </div>
</div>
