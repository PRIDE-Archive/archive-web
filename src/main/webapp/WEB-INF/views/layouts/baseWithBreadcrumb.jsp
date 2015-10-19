<%@ page language="java" pageEncoding="utf8" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<!-- Default breadcrumb -->
<div class="grid_24 clearfix">
    <nav id="breadcrumb">
        <p>
            <spring:url var="prideUrl" value="//www.ebi.ac.uk/pride"/>
            <spring:url var="prideRUrl" value="/"/>
            <a href="${prideUrl}"><fmt:message key="pride"/></a> &gt; <a href="${prideRUrl}"><fmt:message key="prider"/></a>
        </p>
    </nav>
</div>

<!-- Main Content -->
<div id="main">
    <tiles:insertAttribute name="main" />
</div>