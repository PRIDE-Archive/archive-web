<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="projectPublicationDate" required="true" type="java.util.Date" %>
<%@ attribute name="projectAccession" required="true" %>
<%@ attribute name="ftpRootAddress" required="true" %>

<fmt:formatDate value="${projectPublicationDate}" pattern="yyyy" var="projectPublicationYear" />
<fmt:formatDate value="${projectPublicationDate}" pattern="MM" var="projectPublicationMonth" />

<spring:url var="ftpFolderUrl" value="${ftpRootAddress}/{projectPublicationYear}/{projectPublicationMonth}/{projectAccession}">
    <spring:param name="projectPublicationYear" value="${projectPublicationYear}"/>
    <spring:param name="projectPublicationMonth" value="${projectPublicationMonth}"/>
    <spring:param name="projectAccession" value="${projectAccession}"/>
</spring:url>

<h4><a href="${ftpFolderUrl}" class="icon icon-functional" data-icon="="><fmt:message
        key="file.download.ftp"/> </a></h4>

<%-- Notice if the Aspera browser plugin is not installed --%>
<h4 class="aspera-plugin-link aspera-content-hidden">
    <a href="http://www.asperasoft.com/connect/" class="icon icon-functional" data-icon="=">
        <fmt:message key="fast.download.support"/> (<a href="http://asperasoft.com/">Aspera</a>)
    </a>
</h4>
