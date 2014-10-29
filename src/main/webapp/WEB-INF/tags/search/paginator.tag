<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="priderElement" tagdir="/WEB-INF/tags/elements" %>

<%@ attribute name="q" required="true" %>
<%@ attribute name="show" required="true" %>
<%@ attribute name="page" required="true" %>
<%@ attribute name="sort" required="true" %>
<%@ attribute name="order" required="true" %>
<%@ attribute name="numElements" required="true" %>
<%@ attribute name="numResults" required="true" %>
<%@ attribute name="numPages" required="true" %>
<%@ attribute name="titleFilters" required="true" type="java.util.Collection" %>
<%@ attribute name="speciesFilters" required="true" type="java.util.Collection" %>
<%@ attribute name="tissueFilters" required="true" type="java.util.Collection" %>
<%@ attribute name="diseaseFilters" required="true" type="java.util.Collection" %>
<%@ attribute name="ptmsFilters" required="true" type="java.util.Collection" %>
<%@ attribute name="instrumentFilters" required="true" type="java.util.Collection" %>
<%@ attribute name="quantificationFilters" required="true" type="java.util.Collection" %>
<%@ attribute name="experimentTypeFilters" required="true" type="java.util.Collection" %>
<%@ attribute name="projectTagFilters" required="true" type="java.util.Collection" %>
<%@ attribute name="submissionTypeFilters" required="true" type="java.util.Collection" %>

<!-- paging buttons -->
<div class="grid_24">
    <%-- Pagination Bar--%>
    <div class="col_pager">
        <div class="pr-pager">
            <c:if test="${numResults gt 0}">
                <c:if test="${numPages gt 1}">
                    <fmt:message key="search.page"/>
                    <c:choose>
                        <c:when test="${0 eq page}">
                            <span>1</span>
                        </c:when>
                        <c:otherwise>
                            <priderElement:hrefSearch
                                    label="1"
                                    q="${q}"
                                    show="${show}"
                                    page="0"
                                    sort="${sort}"
                                    order="${order}"
                                    titleFilters="${titleFilters}"
                                    speciesFilters="${speciesFilters}"
                                    tissueFilters="${tissueFilters}"
                                    diseaseFilters="${diseaseFilters}"
                                    ptmsFilters="${ptmsFilters}"
                                    instrumentFilters="${instrumentFilters}"
                                    quantificationFilters="${quantificationFilters}"
                                    experimentTypeFilters="${experimentTypeFilters}"
                                    projectTagFilters="${projectTagFilters}"
                                    submissionTypeFilters="${submissionTypeFilters}"/>
                        </c:otherwise>
                    </c:choose>
                </c:if>
                <c:if test="${page gt 3}">...</c:if>
                <%-- In between pages --%>
                <%--<c:forEach var="nPage" begin="${(page<5) ? 2 : (page-2)}" end="${(page>(numPages-4)) ? numPages-1 : (page+2)}">--%>
                <c:forEach var="nPage" begin="${(page lt 4) ? 2 : (page-1)}" end="${(page gt (numPages-3)) ? numPages-1 : (page+3)}">
                    <c:if test="${numPages gt 1}">
                        <c:choose>
                            <c:when test="${nPage-1 eq page}">
                                <span>${nPage}</span>
                            </c:when>
                            <c:otherwise>
                                <priderElement:hrefSearch
                                        label="${nPage}"
                                        q="${q}"
                                        show="${show}"
                                        page="${nPage-1}"
                                        sort="${sort}"
                                        order="${order}"
                                        titleFilters="${titleFilters}"
                                        speciesFilters="${speciesFilters}"
                                        tissueFilters="${tissueFilters}"
                                        diseaseFilters="${diseaseFilters}"
                                        ptmsFilters="${ptmsFilters}"
                                        instrumentFilters="${instrumentFilters}"
                                        quantificationFilters="${quantificationFilters}"
                                        experimentTypeFilters="${experimentTypeFilters}"
                                        projectTagFilters="${projectTagFilters}"
                                        submissionTypeFilters="${submissionTypeFilters}"/>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </c:forEach>
                <%-- Last --%>
                <c:if test="${page lt (numPages-3)}">...</c:if>
                <c:if test="${numPages gt 1}">
                    <c:choose>
                        <c:when test="${numPages-1 eq page}">
                            <span>${numPages}</span>
                        </c:when>
                        <c:otherwise>
                            <priderElement:hrefSearch
                            label="${numPages}"
                            q="${q}"
                            show="${show}"
                            page="${numPages-1}"
                            sort="${sort}"
                            order="${order}"
                            titleFilters="${titleFilters}"
                            speciesFilters="${speciesFilters}"
                            tissueFilters="${tissueFilters}"
                            diseaseFilters="${diseaseFilters}"
                            ptmsFilters="${ptmsFilters}"
                            instrumentFilters="${instrumentFilters}"
                            quantificationFilters="${quantificationFilters}"
                            experimentTypeFilters="${experimentTypeFilters}"
                            projectTagFilters="${projectTagFilters}"
                            submissionTypeFilters="${submissionTypeFilters}"/>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </c:if>
        </div>
        <div class="pr-page-size">
            <c:if test="${numResults gt 10}">
                <fmt:message key="search.show.entries"/>
                <c:choose>
                    <c:when test="${show eq  10}">
                        <span>10</span>
                    </c:when>
                    <c:otherwise>
                        <priderElement:hrefSearch
                                label="10"
                                q="${q}"
                                show="10"
                                page="${page}"
                                sort="${sort}"
                                order="${order}"
                                titleFilters="${titleFilters}"
                                speciesFilters="${speciesFilters}"
                                tissueFilters="${tissueFilters}"
                                diseaseFilters="${diseaseFilters}"
                                ptmsFilters="${ptmsFilters}"
                                instrumentFilters="${instrumentFilters}"
                                quantificationFilters="${quantificationFilters}"
                                experimentTypeFilters="${experimentTypeFilters}"
                                projectTagFilters="${projectTagFilters}"
                                submissionTypeFilters="${submissionTypeFilters}"/>
                    </c:otherwise>
                </c:choose>
            </c:if>
            <c:if test="${numResults ge 20}">
                <c:choose>
                    <c:when test="${show eq  20}">
                        <span>20</span>
                    </c:when>
                    <c:otherwise>
                        <priderElement:hrefSearch
                            label="20"
                            q="${q}"
                            show="20"
                            page="${page}"
                            sort="${sort}"
                            order="${order}"
                            titleFilters="${titleFilters}"
                            speciesFilters="${speciesFilters}"
                            tissueFilters="${tissueFilters}"
                            diseaseFilters="${diseaseFilters}"
                            ptmsFilters="${ptmsFilters}"
                            instrumentFilters="${instrumentFilters}"
                            quantificationFilters="${quantificationFilters}"
                            experimentTypeFilters="${experimentTypeFilters}"
                            projectTagFilters="${projectTagFilters}"
                            submissionTypeFilters="${submissionTypeFilters}"/>
                    </c:otherwise>
                </c:choose>
            </c:if>
            <c:if test="${numResults ge 50}">
                <c:choose>
                    <c:when test="${show eq 50}">
                        <span>50</span>
                    </c:when>
                    <c:otherwise>
                        <priderElement:hrefSearch
                                label="50"
                                q="${q}"
                                show="50"
                                page="${page}"
                                sort="${sort}"
                                order="${order}"
                                titleFilters="${titleFilters}"
                                speciesFilters="${speciesFilters}"
                                tissueFilters="${tissueFilters}"
                                diseaseFilters="${diseaseFilters}"
                                ptmsFilters="${ptmsFilters}"
                                instrumentFilters="${instrumentFilters}"
                                quantificationFilters="${quantificationFilters}"
                                experimentTypeFilters="${experimentTypeFilters}"
                                projectTagFilters="${projectTagFilters}"
                                submissionTypeFilters="${submissionTypeFilters}"/>
                    </c:otherwise>
                </c:choose>
            </c:if>
            <c:if test="${numResults ge 100}">
                <c:choose>
                    <c:when test="${show eq 100}">
                        <span>100</span>
                    </c:when>
                    <c:otherwise>
                        <priderElement:hrefSearch
                                label="100"
                                q="${q}"
                                show="100"
                                page="${page}"
                                sort="${sort}"
                                order="${order}"
                                titleFilters="${titleFilters}"
                                speciesFilters="${speciesFilters}"
                                tissueFilters="${tissueFilters}"
                                diseaseFilters="${diseaseFilters}"
                                ptmsFilters="${ptmsFilters}"
                                instrumentFilters="${instrumentFilters}"
                                quantificationFilters="${quantificationFilters}"
                                experimentTypeFilters="${experimentTypeFilters}"
                                projectTagFilters="${projectTagFilters}"
                                submissionTypeFilters="${submissionTypeFilters}"/>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </div>
        <div class="pr-stats">
            Showing <span>${show * page + 1} - ${show * page + numElements}</span> of <span>${numResults}</span> results
        </div>
    </div>
</div> <!-- paging buttons -->
