<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="fileList" required="true" type="java.util.Collection" %>
<%@ attribute name="projectSummary" required="true" type="uk.ac.ebi.pride.archive.repo.project.service.ProjectSummary" %>


<p>
<c:if test="${not empty projectSummary.publicationDate }">
    <fmt:formatDate value="${projectSummary.publicationDate}" pattern="yyyy" var="year" />
    <fmt:formatDate value="${projectSummary.publicationDate}" pattern="MM" var="month" />
    <c:set var="isPublic" value="true"/>
</c:if>
<table class="summary-table">
    <thead>
    <tr>
        <th><fmt:message key="file.name"/></th>
        <%--<th><fmt:message key="file.type"/></th>--%>
        <th><fmt:message key="file.size"/></th>
        <th><fmt:message key="file.download.http"/></th>
        <%-- Extra table column header if Aspera plugin is installed --%>
        <c:if test="${isPublic}">
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
            <c:choose>
                <c:when test="${isPublic}">
                    <c:choose>
                        <c:when test="${file.fileSource ne 'GENERATED'}">
                            <a href="//www.ebi.ac.uk/pride/data/archive/${year}/${month}/${projectSummary.accession}/${file.fileName}"
                               class="icon icon-functional" data-icon="="><fmt:message key="file.download"/></a>
                        </c:when>
                        <c:otherwise>
                            <a href="//www.ebi.ac.uk/pride/data/archive/${year}/${month}/${projectSummary.accession}/generated/${file.fileName}"
                               class="icon icon-functional" data-icon="="><fmt:message key="file.download"/></a>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value='/files/${file.id}'/>" class="icon icon-functional" data-icon="="><fmt:message key="file.download"/></a>
                </c:otherwise>
            </c:choose>
        </td>
            <%-- Extra table column for Aspera download links, if Aspera plugin is installed --%>
        <c:if test="${not empty projectSummary.publicationDate }">
            <td class="aspera-content aspera-content-hidden">
                <c:choose>
                    <c:when test="${file.fileSource ne 'GENERATED'}">
                        <a href="#" class="icon icon-functional" data-icon="=" onClick="asperaDownload('fasp://prd_ascp@fasp.ebi.ac.uk/pride/data/archive/${year}/${month}/${projectSummary.accession}/${file.fileName}?auth=no&bwcap=300000&targetrate=100p&policy=fair&enc=none')">
                          <fmt:message key="file.download"/></a>
                    </c:when>
                    <c:otherwise>
                        <a href="#" class="icon icon-functional" data-icon="=" onClick="asperaDownload('fasp://prd_ascp@fasp.ebi.ac.uk/pride/data/archive/${year}/${month}/${projectSummary.accession}/generated/${file.fileName}?auth=no&bwcap=300000&targetrate=100p&policy=fair&enc=none')">
                            <fmt:message key="file.download"/></a>
                    </c:otherwise>
                </c:choose>
            </td>
        </c:if>
    </tr>
    </c:forEach>
    </tbody>

</table>
</p>
