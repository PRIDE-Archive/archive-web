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
            <%--one base page number same as screen--%>
            <c:set var="myPage" value="${page + 1}"/>
            <c:if test="${numResults gt 0}">
                <c:if test="${numPages gt 1}">
                    <fmt:message key="search.page"/>
                    <c:choose>
                        <c:when test="${page eq 0}">
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
                <c:if test="${myPage gt 4 and numPages gt 5 }">...</c:if>

                <%-- In between pages --%>
                <c:if test="${myPage le 5 and numPages le 5}">
                    <c:set var="start" value="2" />
                    <c:set var="stop" value="${numPages-1}" />
                </c:if>

                <c:if test="${myPage le 4 and numPages gt 5}">
                    <c:set var="start" value="2" />
                    <c:set var="stop" value="5" />
                </c:if>

                <c:if test="${myPage gt 4 and numPages gt 5}">
                    <c:set var="start" value="${myPage+2 gt numPages-2 ? numPages-4 : myPage-2}" />
                    <c:set var="stop" value="${myPage+2 gt numPages-2 ? numPages-1 : myPage+2}" />
                </c:if>

                <c:if test="${numPages gt 2}">
                    <c:forEach var="nPage"
                               begin="${start}"
                               end="${stop}">
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
                </c:if>

                <%-- Last --%>
                <c:if test="${numPages gt 5 and myPage le numPages-4 }">...</c:if>
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
