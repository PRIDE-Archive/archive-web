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
            <%-- hidden fileds to preserve the values passed into the page via the model --%>
            <form:hidden path="userName"/>
            <form:hidden path="authorized"/>

            <%-- location for general error messages not directly concerning one of the input fields --%>
            <form:errors cssClass="error" path="authorized"/>

            <%-- field to provide a pubmed ID if known --%>
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

            <%-- field to provide a DOI if available --%>
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

            <%-- field to provide a refLine in case no pubmed ID or DOI are available yet --%>
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

            <%-- Add a field for the user to provide a reason for the publication request,
                 in case it is not related to a publication (pubmed/DOI/refLine) --%>
            <div>
                <label class="form-label">
                    <fmt:message key="publishJustification.line"/>
                    <fmt:message key="optional"/>
                </label>
            </div>
            <div>
                <form:textarea cssClass="input-box" path="publishJustification" rows="3" cols="20"/>
                <form:errors cssClass="error" path="publishJustification"/>
            </div>


            <button class="button" type="submit" value="Update">
                <fmt:message key="confirm"/>
            </button>

            <%-- on canellation: when the user is authorized, e.g. it's the owner of the dataset,
                 we redirect him to his profile page, otherwise to the Archive homepage --%>
            <c:choose>
                <c:when test="${publishProject.authorized}">
                    <spring:url var="cancelUrl" value="/users/profile"/>
                    <a href="${cancelUrl}">
                        <fmt:message key="cancel"/>
                    </a>
                </c:when>
                <c:otherwise>
                    <spring:url var="cancelUrl" value="/"/>
                    <a href="${cancelUrl}">
                        <fmt:message key="cancel"/>
                    </a>
                </c:otherwise>
            </c:choose>
        </form:form>


    </div>
</div>
