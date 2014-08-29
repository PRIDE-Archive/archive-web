<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div class="grid_23 clearfix">
    <div class="grid_24">
        <h2>
            <fmt:message key="feedback.title"/>
        </h2>
    </div>

    <div class="grid_24" style="border-top: solid #d9d9d9 1px;">

        <div style="padding-top: 20px;">

            <spring:url var="feedbackUrl" value="/feedback"/>
            <form:form commandName="feedback" method="POST" action="${feedbackUrl}">
                <div class="grid_24">
                    <label class="block-label">
                        <fmt:message key="feedback.comment.message"/>
                    </label>
                    <form:textarea cssClass="input-area" path="comment" rows="10" cols="50"/>
                    <form:errors cssClass="error" path="comment"/>
                </div>

                <div class="grid_24">
                    <label class="block-label">
                        <fmt:message key="feedback.email.message"/>
                    </label>
                    <form:input cssClass="input-box" path="email"/>
                </div>

                <div>
                    <button class="button" type="send">
                        <fmt:message key="feedback.send"/>
                    </button>
                </div>
            </form:form>
        </div>
    </div>
</div>
