<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="fileList" required="true" type="java.util.Collection" %>
<%@ attribute name="projectSummary" required="true" type="uk.ac.ebi.pride.archive.repo.project.service.ProjectSummary" %>


<p>
<table class="summary-table">
    <thead>
    <tr>
        <th><fmt:message key="file.name"/></th>
        <%--<th><fmt:message key="file.type"/></th>--%>
        <th><fmt:message key="file.size"/></th>
        <th><fmt:message key="file.download.http"/></th>
        <%-- Extra table column header if Aspera plugin is installed --%>
        <c:if test="${not empty projectSummary.publicationDate }">
            <fmt:formatDate value="${projectSummary.publicationDate}" pattern="yyyy" var="projectPublicationYear" />
            <fmt:formatDate value="${projectSummary.publicationDate}" pattern="MM" var="projectPublicationMonth" />
            <th class="aspera-content aspera-content-hidden"><fmt:message key="file.download.fast"/> (<a href="http://asperasoft.com/">Aspera</a>)</th>
        </c:if>
    </tr>
    </thead>

    <tbody>
    <c:forEach var="file" items="${fileList}">
    <tr>
        <td>
                ${file.fileName}
        </td>
        <%--<td>--%>
                <%--${file.fileType}--%>
        <%--</td>--%>
        <td>
            <fmt:formatNumber type="number" maxFractionDigits="3" value="${file.fileSize / 1048576}"/>
            <fmt:message key="file.units.mb"/>
        </td>
        <td width="10%">
            <a href="<c:url value='/files/${file.id}'/>" class="icon icon-functional" data-icon="="><fmt:message
                    key="file.download"></fmt:message></a>
        </td>
            <%-- Extra table column for Aspera download links, if Aspera plugin is installed --%>
        <c:if test="${not empty projectSummary.publicationDate }">
            <td class="aspera-content aspera-content-hidden">
                <c:set var="newExtension" value=""/>
                <c:if test="${(file.fileType=='RESULT') && not fn:endsWith(file.fileName, '.gz')}">
                    <c:set var="newExtension" value=".gz"/>
                </c:if>
                <a href="#" class="icon icon-functional" data-icon="=" onClick="asperaDownload('fasp://prd_ascp@fasp.ebi.ac.uk/pride/data/archive/${projectPublicationYear}/${projectPublicationMonth}/${projectSummary.accession}/${file.fileName}${newExtension}?auth=no&bwcap=300000&targetrate=100p&policy=fair&enc=none')">
                    <fmt:message key="file.download"></fmt:message>
                </a>
            </td>
        </c:if>
    </tr>
    </c:forEach>
    </tbody>

</table>
</p>
