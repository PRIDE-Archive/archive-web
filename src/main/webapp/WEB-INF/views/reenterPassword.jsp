<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
            <a href="${prideUrl}"><fmt:message key="pride"/></a> &gt; <a href="${priderUrl}"><fmt:message
                key="prider"/></a>
            &gt; <fmt:message key="user.profile"/>
        </p>
    </nav>
</div>

<div class="grid_23 clearfix">

    <%-- page title--%>
    <div class="grid_24">
        <h2>
            <fmt:message key="user.profile.update.title"/>
        </h2>
    </div>

    <div class="grid_24" style="border-top: solid #d9d9d9 1px;">

        <div style="padding-top: 20px;">
            <spring:url var="updateProfileUrl" value="/users/profile/editcontact/update"/>
            <form:form commandName="updateContact" method="POST" action="${updateProfileUrl}">
                <div class="grid_24">
                    <%-- pass hidden values --%>
                    <form:hidden path="email"/>
                    <form:hidden path="existingEmail"/>
                    <form:hidden path="password"/>
                    <form:hidden path="title"/>
                    <form:hidden path="firstName"/>
                    <form:hidden path="lastName"/>
                    <form:hidden path="affiliation"/>

                    <%-- existing password--%>
                    <div>
                        <form:password cssClass="input-box" path="existingPassword"/>
                        <form:errors cssClass="error" path="existingPassword"/>
                    </div>

                    <%-- confirm button--%>
                    <div>
                        <button class="button" type="submit" value="Update">
                            <fmt:message key="confirm"/>
                        </button>

                        <%-- cancel button --%>
                        <spring:url var="myProfileUrl" value="/users/profile"/>
                        <a href="${myProfileUrl}">
                            <fmt:message key="cancel"/>
                        </a>
                    </div>
                </div>
            </form:form>
        </div>
    </div>

</div>
