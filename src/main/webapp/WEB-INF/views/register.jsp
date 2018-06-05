<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%-- registration form--%>
<div class="grid_24 clearfix">
    <nav id="breadcrumb">
        <p>
            <spring:url var="prideUrl" value="//www.ebi.ac.uk/pride"/>
            <spring:url var="priderUrl" value="/"/>
            <a href="${prideUrl}"><fmt:message key="pride"/></a> &gt; <a href="${priderUrl}"><fmt:message key="prider"/></a>
            &gt; <fmt:message key="register.title"/>
        </p>
    </nav>
</div>

<div class="grid_23 clearfix">
    <div class="grid_24">
        <h2>
            <fmt:message key="register.title"/>
        </h2>
    </div>

    <div class="grid_24" style="border-top: solid #d9d9d9 1px;">
        <div class="grid_16" style="border-right: solid #d9d9d9 1px;">

            <div style="padding-top: 20px;">

                <c:if test="${not empty error}">
                    <div class="error">
                        <p><fmt:message key="register.unsuccessful"/></p>
                    </div>
                </c:if>

                <spring:url var="registerNewUserUrl" value="/register"/>
                <form:form commandName="user" method="POST" action="${registerNewUserUrl}">

                    <%-- email as user name--%>
                    <div>
                        <label class="block-label">
                            <fmt:message key="email"/>
                        </label>

                        <form:input cssClass="input-box" path="email"/>
                        <form:errors cssClass="error" path="email"/>
                    </div>

                    <%-- password --%>
                    <%--<div>--%>
                        <%--<label class="block-label">--%>
                            <%--<fmt:message key="password"/>--%>
                        <%--</label>--%>

                        <%--<form:password cssClass="input-box" path="password"/>--%>
                        <%--<form:errors cssClass="error" path="password"/>--%>
                    <%--</div>--%>


                    <%-- title --%>
                    <div>
                        <label class="block-label">
                            <fmt:message key="title"/>
                        </label>

                        <form:select cssClass="register-title-list" path="title" items="${titles}"/>
                        <form:errors cssClass="error" path="title"/>
                    </div>


                    <%-- First name --%>
                    <div>
                        <label class="block-label">
                            <fmt:message key="first.name"/>
                        </label>

                        <form:input cssClass="input-box" path="firstName"/>
                        <form:errors cssClass="error" path="firstName"/>
                    </div>

                    <%-- Last name--%>
                    <div>
                        <label class="block-label">
                            <fmt:message key="last.name"/>
                        </label>

                        <form:input cssClass="input-box" path="lastName"/>
                        <form:errors cssClass="error" path="lastName"/>
                    </div>

                    <%-- affiliation --%>
                    <div>
                        <label class="block-label">
                            <fmt:message key="affiliation"/>
                        </label>

                        <form:textarea cssClass="input-box" path="affiliation" rows="3" cols="20"/>
                        <form:errors cssClass="error" path="affiliation"/>
                    </div>

                    <%-- country --%>
                    <div>
                        <label class="block-label">
                            <fmt:message key="country"/>
                        </label>

                        <form:select cssClass="register-country-list" path="country" items="${countries}"/>
                        <form:errors cssClass="error" path="country"/>
                    </div>

                    <%-- orcid --%>
                    <div>
                        <label class="block-label">
                            <fmt:message key="orcid"/>
                        </label>

                        <a href="https://orcid.org/" title="Link: https://orcid.org/" target="_blank"><img src="https://orcid.org/sites/default/files/images/orcid_24x24.png" title="Image: ORCID" border="0"> orcid.org/ </a><form:textarea cssClass="input-box" path="orcid" rows="3" cols="20"/>
                        <form:errors cssClass="error" path="orcid"/>
                    </div>

                    <%-- Terms of usage --%>
                    <div>
                        <label class="block-label">
                            <fmt:message key="terms"/> - <a href="https://www.ebi.ac.uk/data-protection/privacy-notice/pride-new" title="Link: https://www.ebi.ac.uk/data-protection/privacy-notice/pride-new" target="_blank">Privacy notice</a>
                        </label>
                        Accept
                        <form:checkbox cssClass="check-box" path="acceptedTermsOfUse"/>
                        <form:errors cssClass="error" path="acceptedTermsOfUse"/>
                    </div>

                    <div>
                        <button class="button" type="submit" value="Register">
                            <fmt:message key="register.submit"/>
                        </button>
                    </div>
                </form:form>
            </div>
        </div>

        <div class="grid_7">
            <div style="padding-top: 20px">
                <h3>
                    <fmt:message key="register.login"/>
                </h3>

                <p>
                    <fmt:message key="register.login.message"/> <a href="<c:url value='/login'/>">Login</a>.
                </p>
            </div>
        </div>
    </div>
</div>
