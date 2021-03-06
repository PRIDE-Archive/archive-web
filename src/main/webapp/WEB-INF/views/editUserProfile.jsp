<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="grid_24 clearfix">
    <nav id="breadcrumb">
        <p>
            <spring:url var="prideUrl" value="//www.ebi.ac.uk/pride"/>
            <spring:url var="priderUrl" value="/"/>
            <spring:url var="userProfileUrl" value="/users/profile"/>

            <a href="${prideUrl}"><fmt:message key="pride"/></a> &gt; <a href="${priderUrl}"><fmt:message key="prider"/></a>
            &gt; <a href="${userProfileUrl}"><fmt:message key="user.profile"/></a>
            &gt; <fmt:message key="user.profile.edit"/>
        </p>
    </nav>
</div>

<div class="grid_23 clearfix">

    <div class="grid_24">
        <h2>
            <fmt:message key="user.profile.edit"/>
        </h2>
    </div>

    <div class="grid_24" style="border-top: solid #d9d9d9 1px;">
        <div class="grid_12" style="border-right: solid #d9d9d9 1px;">
            <%-- change contact details --%>
            <div style="padding-top: 20px;">

                <c:if test="${not empty updateContactError}">
                    <div class="error">
                        <p><fmt:message key="user.profile.update.profile.unsuccessful"/></p>
                    </div>
                </c:if>

                <spring:url var="updateContactUrl" value="/users/profile/editcontact"/>
                <form:form commandName="updateContact" method="POST" action="${updateContactUrl}">

                    <%-- existing email hidden--%>
                    <form:hidden path="existingEmail"/>

                    <%-- email as user name--%>
                    <div>
                        <label class="block-label">
                            <fmt:message key="email"/>
                        </label>

                        <form:input cssClass="input-box" path="email"/>
                        <form:errors cssClass="error" path="email"/>
                    </div>

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

                        <form:select cssClass="register-countries-list" path="country" items="${countries}"/>
                        <form:errors cssClass="error" path="country"/>
                    </div>

                    <%-- orcid --%>
                    <div>
                        <label class="block-label">
                            <fmt:message key="orcid"/> - <a href="https://orcid.org/" title="Link: https://orcid.org/" target="_blank">What is ORCID?</a>
                        </label>

                        <a href="https://orcid.org/" title="Link: https://orcid.org/" target="_blank"><img src="https://orcid.org/sites/default/files/images/orcid_24x24.png" title="Image: ORCID" border="0"> orcid.org/ </a><form:input cssClass="input-box" path="orcid"/>
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
                        <button class="button" type="submit">
                            <fmt:message key="update.contact"/>
                        </button>
                    </div>
                </form:form>
            </div>
        </div>

        <div class="grid_11">
            <%-- change contact details --%>
            <div style="padding-top: 20px;">

                <c:if test="${not empty updatePasswordError}">
                    <div class="error">
                        <p><fmt:message key="user.profile.change.password.unsuccessful"/></p>
                    </div>
                </c:if>

                <spring:url var="updatePasswordUrl" value="/users/profile/changepassword"/>
                <form:form commandName="updatePassword" method="POST" action="${updatePasswordUrl}">

                    <%-- email hidden--%>
                    <form:hidden path="email"/>

                    <%-- old password --%>
                    <div>
                        <label class="block-label">
                            <fmt:message key="old.password"/>
                        </label>

                        <form:password cssClass="input-box" path="oldPassword"/>
                        <form:errors cssClass="error" path="oldPassword"/>
                    </div>

                    <%-- new password --%>
                    <div>
                        <label class="block-label">
                            <fmt:message key="new.password"/>
                        </label>

                        <form:password cssClass="input-box" path="newPassword"/>
                        <form:errors cssClass="error" path="newPassword"/>
                    </div>

                    <%-- confirm password --%>
                    <div>
                        <label class="block-label">
                            <fmt:message key="confirm.new.password"/>
                        </label>

                        <form:password cssClass="input-box" path="confirmedNewPassword"/>
                        <form:errors cssClass="error" path="confirmedNewPassword"/>
                    </div>

                    <div>
                        <button class="button" type="submit">
                            <fmt:message key="change.password"/>
                        </button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>
