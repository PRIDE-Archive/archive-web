<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="priderElement" tagdir="/WEB-INF/tags/elements" %>

<%-- bread crumb--%>
<div class="grid_24 clearfix">
    <div class="grid_18 alpha">
    <nav id="breadcrumb">
        <p>
            <spring:url var="prideUrl" value="http://www.ebi.ac.uk/pride"/>
            <spring:url var="priderUrl" value="/"/>
            <a href="${prideUrl}"><fmt:message key="pride"/></a> &gt; <a href="${priderUrl}"><fmt:message key="prider"/></a>
            &gt; <fmt:message key="search.result.title"/>
        </p>
    </nav>
    </div>
    <c:set var="numFilters" value="${fn:length(titleFilters)+fn:length(speciesFilters)+fn:length(tissueFilters)+fn:length(diseaseFilters)+fn:length(ptmsFilters)+fn:length(instrumentFilters)+fn:length(quantificationFilters)+fn:length(experimentTypeFilters)+fn:length(projectTagFilters)+fn:length(submissionTypeFilters)}" />
    <c:if test="${q!='' && numFilters<1}">
        <aside class="grid_6 omega shortcuts expander" id="search-extras">
            <div id="ebi_search_results">
                <h3 class="slideToggle icon icon-functional" data-icon="u">Show more data from EMBL-EBI</h3>
            </div>
        </aside>
    </c:if>
</div>



<div id="search-result">


    <%--Title and count--%>
    <div id="result-count" class="grid_24 clearfix">

        <h2>
            <strong>${numResults}</strong> <fmt:message key="search.result.title"/>
            <c:if test="${q!=''}">
                <fmt:message key="search.result.forterm"/> <span class="searchterm" id="query">${q}</span>
            </c:if>
            <c:if test="${numFilters>0}">+ ${numFilters} filters</c:if>

        </h2>
    </div>


    <div class="grid_24">
        <%--Filters--%>
        <div class="grid_6 left-column search-filters">
            <h4>Filter your results</h4>
            <spring:url var="searchUrl" value="/simpleSearch"/>
            <%-- ADD filter form--%>
            <form action="${searchUrl}" method="get">
                <fieldset>
                    <input type='hidden' id='q' name='q' value='${q}'/>
                    <input type='hidden' id='show' name='show' value='${show}'/>
                    <input type='hidden' id='page' name='page' value='${page}'/>
                    <input type='hidden' id='sort' name='sort' value='${sort}'/>
                    <input type='hidden' id='order' name='order' value='${order}'/>

                    <%--active filters: used to keep a list of active filters and give it back to the server--%>
                    <priderElement:inputHiddenList items="${speciesFilters}" name="speciesFilters"/>
                    <priderElement:inputHiddenList items="${instrumentFilters}" name="instrumentFilters"/>
                    <priderElement:inputHiddenList items="${tissueFilters}" name="tissueFilters"/>
                    <priderElement:inputHiddenList items="${diseaseFilters}" name="diseaseFilters"/>
                    <priderElement:inputHiddenList items="${ptmsFilters}" name="ptmsFilters"/>
                    <priderElement:inputHiddenList items="${quantificationFilters}" name="quantificationFilters"/>
                    <priderElement:inputHiddenList items="${experimentTypeFilters}" name="experimentTypeFilters"/>
                    <priderElement:inputHiddenList items="${titleFilters}" name="titleFilters"/>
                    <priderElement:inputHiddenList items="${projectTagFilters}" name="projectTagFilters"/>
                    <priderElement:inputHiddenList items="${submissionTypeFilters}" name="submissionTypeFilters"/>


                    <ul id="filter-options">
                        <!-- filter field -->
                        <li>Field</li>
                        <select id="filter-field" name="filterField" style="overflow:hidden; max-width:100px">
                            <option value="species-filter">Species</option>
                            <option value="tissue-filter">Tissue</option>
                            <option value="disease-filter">Disease</option>
                            <option value="ptm-filter">Modification</option>
                            <option value="instrument-filter">Instrument</option>
                            <%--<option value="quantification-filter" ${(filterField == 'quantification')?'selected':''}>Quantification method</option>--%>
                            <option value="exptype-filter">Experiment type</option>
                            <%--<option value="title-filter" ${(filterField == 'title')?'selected':''}>Title</option>--%>
                            <option value="tag-filter">Project tags</option>
                            <option value="submtype-filter">Submission type</option>
                        </select>

                        <li>Contains</li>

                        <!-- select filters -->
                        <priderElement:selectFilter id="species-filter" items="${availableSpeciesList}" name="newSpeciesFilter"/>
                        <priderElement:selectFilter id="tissue-filter" items="${availableTissueList}" name="newTissueFilter"/>
                        <priderElement:selectFilter id="disease-filter" items="${availableDiseaseList}" name="newDiseaseFilter"/>
                        <priderElement:selectFilter id="ptm-filter" items="${availablePtmList}" name="newPtmsFilter"/>
                        <priderElement:selectFilter id="instrument-filter" items="${availableInstrumentList}" name="newInstrumentFilter"/>
                        <priderElement:selectFilter id="quantification-filter" items="${availableQuantificationMethodsList}" name="newQuantificationFilter"/>
                        <priderElement:selectFilter id="exptype-filter" items="${availableExperimentTypesList}" name="newExperimentTypeFilter"/>
                        <priderElement:selectFilter id="tag-filter" items="${availableProjectTagsList}" name="newProjectTagFilter"/>
                        <priderElement:selectFilter id="submtype-filter" items="${availableSubmissionTypesList}" name="newSubmissionTypeFilter"/>

                        <li>
                            <input id='title-filter'
                                   type='text'
                                   size="24"
                                   value="${title}"
                                   name='newTitleFilter'
                                   style="display:none;"
                                    />
                        </li>

                        <li>
                            </br>
                            <button type="submit">
                                Add filter
                            </button>
                        </li>
                    </ul>

                </fieldset>
            </form>

            <%--active filters & REMOVE filters forms--%>
            <c:if test="${numFilters>0}">
                <h4>Current active filters</h4>

                <%--Remove all--%>
                <form action="${searchUrl}" method="get">
                    <fieldset>
                        <input type='hidden' id='q' name='q' value='${q}'/>
                        <input type='hidden' id='show' name='show' value='${show}'/>
                        <input type='hidden' id='page' name='page' value='${page}'/>
                        <input type='hidden' id='sort' name='sort' value='${sort}'/>
                        <input type='hidden' id='order' name='order' value='${order}'/>
                        <button type="submit">
                            Remove all
                        </button>
                    </fieldset>
                </form>

                <%--Species filters--%>
                <c:if test="${not empty speciesFilters}">
                    Species: </br>
                    <c:forEach var="theSpeciesFilter" items="${speciesFilters}">
                        <form action="${searchUrl}" method="get">
                        <fieldset>
                            <input type='hidden' id='q' name='q' value='${q}'/>
                            <input type='hidden' id='show' name='show' value='${show}'/>
                            <input type='hidden' id='page' name='page' value='${page}'/>
                            <input type='hidden' id='sort' name='sort' value='${sort}'/>
                            <input type='hidden' id='order' name='order' value='${order}'/>
                            <priderElement:inputHiddenList items="${instrumentFilters}" name="instrumentFilters"/>
                            <priderElement:inputHiddenList items="${ptmsFilters}" name="ptmsFilters"/>
                            <priderElement:inputHiddenList items="${titleFilters}" name="titleFilters"/>
                            <priderElement:inputHiddenList items="${quantificationFilters}" name="quantificationFilters"/>
                            <priderElement:inputHiddenList items="${experimentTypeFilters}" name="experimentTypeFilters"/>
                            <priderElement:inputHiddenList items="${tissueFilters}" name="tissueFilters"/>
                            <priderElement:inputHiddenList items="${diseaseFilters}" name="diseaseFilters"/>
                            <priderElement:inputHiddenList items="${projectTagFilters}" name="projectTagFilters"/>
                            <priderElement:inputHiddenList items="${submissionTypeFilters}" name="submissionTypeFilters"/>
                            <priderElement:inputHiddenListExcluding items="${speciesFilters}" name="speciesFilters" excludeItem="${theSpeciesFilter}"/>
                            ${theSpeciesFilter}
                            <button type="submit" class="remove-filter-button">
                                x
                            </button>
                            </br>
                        </fieldset>
                        </form>
                    </c:forEach>
                    </br>
                </c:if>

                <%--Tissue filters--%>
                <c:if test="${not empty tissueFilters}">
                    Tissues: </br>
                    <c:forEach var="theTissueFilter" items="${tissueFilters}">
                        <form action="${searchUrl}" method="get">
                            <fieldset>
                                <input type='hidden' id='q' name='q' value='${q}'/>
                                <input type='hidden' id='show' name='show' value='${show}'/>
                                <input type='hidden' id='page' name='page' value='${page}'/>
                                <input type='hidden' id='sort' name='sort' value='${sort}'/>
                                <input type='hidden' id='order' name='order' value='${order}'/>
                                <priderElement:inputHiddenList items="${instrumentFilters}" name="instrumentFilters"/>
                                <priderElement:inputHiddenList items="${ptmsFilters}" name="ptmsFilters"/>
                                <priderElement:inputHiddenList items="${titleFilters}" name="titleFilters"/>
                                <priderElement:inputHiddenList items="${quantificationFilters}" name="quantificationFilters"/>
                                <priderElement:inputHiddenList items="${experimentTypeFilters}" name="experimentTypeFilters"/>
                                <priderElement:inputHiddenList items="${speciesFilters}" name="speciesFilters"/>
                                <priderElement:inputHiddenList items="${diseaseFilters}" name="diseaseFilters"/>
                                <priderElement:inputHiddenList items="${projectTagFilters}" name="projectTagFilters"/>
                                <priderElement:inputHiddenList items="${submissionTypeFilters}" name="submissionTypeFilters"/>
                                <priderElement:inputHiddenListExcluding items="${tissueFilters}" name="tissueFilters" excludeItem="${theTissueFilter}"/>
                                ${theTissueFilter}
                                <button type="submit" class="remove-filter-button">
                                    x
                                </button>
                                </br>
                            </fieldset>
                        </form>
                    </c:forEach>
                    </br>
                </c:if>

                <%--Disease filters--%>
                <c:if test="${not empty diseaseFilters}">
                    Diseases: </br>
                    <c:forEach var="theDiseaseFilter" items="${diseaseFilters}">
                        <form action="${searchUrl}" method="get">
                            <fieldset>
                                <input type='hidden' id='q' name='q' value='${q}'/>
                                <input type='hidden' id='show' name='show' value='${show}'/>
                                <input type='hidden' id='page' name='page' value='${page}'/>
                                <input type='hidden' id='sort' name='sort' value='${sort}'/>
                                <input type='hidden' id='order' name='order' value='${order}'/>
                                <priderElement:inputHiddenList items="${instrumentFilters}" name="instrumentFilters"/>
                                <priderElement:inputHiddenList items="${ptmsFilters}" name="ptmsFilters"/>
                                <priderElement:inputHiddenList items="${titleFilters}" name="titleFilters"/>
                                <priderElement:inputHiddenList items="${quantificationFilters}" name="quantificationFilters"/>
                                <priderElement:inputHiddenList items="${experimentTypeFilters}" name="experimentTypeFilters"/>
                                <priderElement:inputHiddenList items="${speciesFilters}" name="speciesFilters"/>
                                <priderElement:inputHiddenList items="${tissueFilters}" name="tissueFilters"/>
                                <priderElement:inputHiddenList items="${projectTagFilters}" name="projectTagFilters"/>
                                <priderElement:inputHiddenList items="${submissionTypeFilters}" name="submissionTypeFilters"/>
                                <priderElement:inputHiddenListExcluding items="${diseaseFilters}" name="diseaseFilters" excludeItem="${theDiseaseFilter}"/>
                                ${theDiseaseFilter}
                                <button type="submit" class="remove-filter-button">
                                    x
                                </button>
                                </br>
                            </fieldset>
                        </form>
                    </c:forEach>
                    </br>
                </c:if>

                <%--PTMs filters--%>
                <c:if test="${not empty ptmsFilters}">
                    Modifications: </br>
                    <c:forEach var="thePtmsFilter" items="${ptmsFilters}">
                        <form action="${searchUrl}" method="get">
                            <fieldset>
                                <input type='hidden' id='q' name='q' value='${q}'/>
                                <input type='hidden' id='show' name='show' value='${show}'/>
                                <input type='hidden' id='page' name='page' value='${page}'/>
                                <input type='hidden' id='sort' name='sort' value='${sort}'/>
                                <input type='hidden' id='order' name='order' value='${order}'/>
                                <priderElement:inputHiddenList items="${instrumentFilters}" name="instrumentFilters"/>
                                <priderElement:inputHiddenList items="${speciesFilters}" name="speciesFilters"/>
                                <priderElement:inputHiddenList items="${titleFilters}" name="titleFilters"/>
                                <priderElement:inputHiddenList items="${quantificationFilters}" name="quantificationFilters"/>
                                <priderElement:inputHiddenList items="${experimentTypeFilters}" name="experimentTypeFilters"/>
                                <priderElement:inputHiddenList items="${tissueFilters}" name="tissueFilters"/>
                                <priderElement:inputHiddenList items="${diseaseFilters}" name="diseaseFilters"/>
                                <priderElement:inputHiddenList items="${projectTagFilters}" name="projectTagFilters"/>
                                <priderElement:inputHiddenList items="${submissionTypeFilters}" name="submissionTypeFilters"/>
                                <priderElement:inputHiddenListExcluding items="${ptmsFilters}" name="ptmsFilters" excludeItem="${thePtmsFilter}"/>
                                ${thePtmsFilter}
                                <button type="submit" class="remove-filter-button">
                                    x
                                </button>
                                </br>
                            </fieldset>
                        </form>
                    </c:forEach>
                    </br>
                </c:if>

                <%--Instrument filters--%>
                <c:if test="${not empty instrumentFilters}">
                Instruments: </br>
                <c:forEach var="theInstrumentFilter" items="${instrumentFilters}">
                    <form action="${searchUrl}" method="get">
                        <fieldset>
                            <input type='hidden' id='q' name='q' value='${q}'/>
                            <input type='hidden' id='show' name='show' value='${show}'/>
                            <input type='hidden' id='page' name='page' value='${page}'/>
                            <input type='hidden' id='sort' name='sort' value='${sort}'/>
                            <input type='hidden' id='order' name='order' value='${order}'/>
                            <priderElement:inputHiddenList items="${ptmsFilters}" name="ptmsFilters"/>
                            <priderElement:inputHiddenList items="${speciesFilters}" name="speciesFilters"/>
                            <priderElement:inputHiddenList items="${titleFilters}" name="titleFilters"/>
                            <priderElement:inputHiddenList items="${quantificationFilters}" name="quantificationFilters"/>
                            <priderElement:inputHiddenList items="${experimentTypeFilters}" name="experimentTypeFilters"/>
                            <priderElement:inputHiddenList items="${tissueFilters}" name="tissueFilters"/>
                            <priderElement:inputHiddenList items="${diseaseFilters}" name="diseaseFilters"/>
                            <priderElement:inputHiddenList items="${projectTagFilters}" name="projectTagFilters"/>
                            <priderElement:inputHiddenList items="${submissionTypeFilters}" name="submissionTypeFilters"/>
                            <priderElement:inputHiddenListExcluding items="${instrumentFilters}" name="instrumentFilters" excludeItem="${theInstrumentFilter}"/>
                            ${theInstrumentFilter}
                            <button type="submit" class="remove-filter-button">
                                x
                            </button>
                            </br>
                        </fieldset>
                    </form>
                </c:forEach>
                </br>
                </c:if>

                <%--Quantification method filters--%>
                <c:if test="${not empty quantificationFilters}">
                Quantification methods: </br>
                <c:forEach var="theQuantificationFilter" items="${quantificationFilters}">
                    <form action="${searchUrl}" method="get">
                        <fieldset>
                            <input type='hidden' id='q' name='q' value='${q}'/>
                            <input type='hidden' id='show' name='show' value='${show}'/>
                            <input type='hidden' id='page' name='page' value='${page}'/>
                            <input type='hidden' id='sort' name='sort' value='${sort}'/>
                            <input type='hidden' id='order' name='order' value='${order}'/>
                            <priderElement:inputHiddenList items="${ptmsFilters}" name="ptmsFilters"/>
                            <priderElement:inputHiddenList items="${speciesFilters}" name="speciesFilters"/>
                            <priderElement:inputHiddenList items="${titleFilters}" name="titleFilters"/>
                            <priderElement:inputHiddenList items="${instrumentFilters}" name="instrumentFilters"/>
                            <priderElement:inputHiddenList items="${experimentTypeFilters}" name="experimentTypeFilters"/>
                            <priderElement:inputHiddenList items="${tissueFilters}" name="tissueFilters"/>
                            <priderElement:inputHiddenList items="${diseaseFilters}" name="diseaseFilters"/>
                            <priderElement:inputHiddenList items="${projectTagFilters}" name="projectTagFilters"/>
                            <priderElement:inputHiddenList items="${submissionTypeFilters}" name="submissionTypeFilters"/>
                            <priderElement:inputHiddenListExcluding items="${quantificationFilters}" name="quantificationFilters" excludeItem="${theQuantificationFilter}"/>
                            ${theQuantificationFilter}
                            <button type="submit" class="remove-filter-button">
                                x
                            </button>
                            </br>
                        </fieldset>
                    </form>
                </c:forEach>
                </br>
                </c:if>

                <%--Experiment type filters--%>
                <c:if test="${not empty experimentTypeFilters}">
                Experiment types: </br>
                <c:forEach var="theExpTypeFilter" items="${experimentTypeFilters}">
                    <form action="${searchUrl}" method="get">
                        <fieldset>
                            <input type='hidden' id='q' name='q' value='${q}'/>
                            <input type='hidden' id='show' name='show' value='${show}'/>
                            <input type='hidden' id='page' name='page' value='${page}'/>
                            <input type='hidden' id='sort' name='sort' value='${sort}'/>
                            <input type='hidden' id='order' name='order' value='${order}'/>
                            <priderElement:inputHiddenList items="${ptmsFilters}" name="ptmsFilters"/>
                            <priderElement:inputHiddenList items="${speciesFilters}" name="speciesFilters"/>
                            <priderElement:inputHiddenList items="${titleFilters}" name="titleFilters"/>
                            <priderElement:inputHiddenList items="${instrumentFilters}" name="instrumentFilters"/>
                            <priderElement:inputHiddenList items="${quantificationFilters}" name="quantificationFilters"/>
                            <priderElement:inputHiddenList items="${tissueFilters}" name="tissueFilters"/>
                            <priderElement:inputHiddenList items="${diseaseFilters}" name="diseaseFilters"/>
                            <priderElement:inputHiddenList items="${projectTagFilters}" name="projectTagFilters"/>
                            <priderElement:inputHiddenList items="${submissionTypeFilters}" name="submissionTypeFilters"/>
                            <priderElement:inputHiddenListExcluding items="${experimentTypeFilters}" name="experimentTypeFilters" excludeItem="${theExpTypeFilter}"/>
                            ${theExpTypeFilter}
                            <button type="submit" class="remove-filter-button">
                                x
                            </button>
                            </br>
                        </fieldset>
                    </form>
                </c:forEach>
                </br>
                </c:if>

                <%--Title filters--%>
                <c:if test="${not empty titleFilters}">
                    Title contains: </br>
                    <c:forEach var="theTitleFilter" items="${titleFilters}">
                        <form action="${searchUrl}" method="get">
                            <fieldset>
                                <input type='hidden' id='q' name='q' value='${q}'/>
                                <input type='hidden' id='show' name='show' value='${show}'/>
                                <input type='hidden' id='page' name='page' value='${page}'/>
                                <input type='hidden' id='sort' name='sort' value='${sort}'/>
                                <input type='hidden' id='order' name='order' value='${order}'/>
                                <priderElement:inputHiddenList items="${instrumentFilters}" name="instrumentFilters"/>
                                <priderElement:inputHiddenList items="${ptmsFilters}" name="ptmsFilters"/>
                                <priderElement:inputHiddenList items="${speciesFilters}" name="speciesFilters"/>
                                <priderElement:inputHiddenList items="${diseaseFilters}" name="diseaseFilters"/>
                                <priderElement:inputHiddenList items="${tissueFilters}" name="tissueFilters"/>
                                <priderElement:inputHiddenList items="${quantificationFilters}" name="quantificationFilters"/>
                                <priderElement:inputHiddenList items="${experimentTypeFilters}" name="experimentTypeFilters"/>
                                <priderElement:inputHiddenList items="${projectTagFilters}" name="projectTagFilters"/>
                                <priderElement:inputHiddenList items="${submissionTypeFilters}" name="submissionTypeFilters"/>
                                <priderElement:inputHiddenListExcluding items="${titleFilters}" name="titleFilters" excludeItem="${theTitleFilter}"/>
                                ${theTitleFilter}
                                <button type="submit" class="remove-filter-button">
                                    x
                                </button>
                                </br>
                            </fieldset>
                        </form>
                    </c:forEach>
                    </br>
                </c:if>

                <%--Project tag filters--%>
                <c:if test="${not empty projectTagFilters}">
                    Project Tags contains: </br>
                    <c:forEach var="theProjectTagFilter" items="${projectTagFilters}">
                        <form action="${searchUrl}" method="get">
                            <fieldset>
                                <input type='hidden' id='q' name='q' value='${q}'/>
                                <input type='hidden' id='show' name='show' value='${show}'/>
                                <input type='hidden' id='page' name='page' value='${page}'/>
                                <input type='hidden' id='sort' name='sort' value='${sort}'/>
                                <input type='hidden' id='order' name='order' value='${order}'/>
                                <priderElement:inputHiddenList items="${instrumentFilters}" name="instrumentFilters"/>
                                <priderElement:inputHiddenList items="${ptmsFilters}" name="ptmsFilters"/>
                                <priderElement:inputHiddenList items="${speciesFilters}" name="speciesFilters"/>
                                <priderElement:inputHiddenList items="${diseaseFilters}" name="diseaseFilters"/>
                                <priderElement:inputHiddenList items="${tissueFilters}" name="tissueFilters"/>
                                <priderElement:inputHiddenList items="${quantificationFilters}" name="quantificationFilters"/>
                                <priderElement:inputHiddenList items="${experimentTypeFilters}" name="experimentTypeFilters"/>
                                <priderElement:inputHiddenList items="${titleFilters}" name="titleFilters"/>
                                <priderElement:inputHiddenList items="${submissionTypeFilters}" name="submissionTypeFilters"/>
                                <priderElement:inputHiddenListExcluding items="${projectTagFilters}" name="projectTagFilters" excludeItem="${theProjectTagFilter}"/>
                                ${theProjectTagFilter}
                                <button type="submit" class="remove-filter-button">
                                    x
                                </button>
                                </br>
                            </fieldset>
                        </form>
                    </c:forEach>
                    </br>
                </c:if>

                <%--Submission Type filter--%>
                <c:if test="${not empty submissionTypeFilters}">
                    Submission Type contains: </br>
                    <c:forEach var="theSubmissionTypeFilter" items="${submissionTypeFilters}">
                        <form action="${searchUrl}" method="get">
                            <fieldset>
                                <input type='hidden' id='q' name='q' value='${q}'/>
                                <input type='hidden' id='show' name='show' value='${show}'/>
                                <input type='hidden' id='page' name='page' value='${page}'/>
                                <input type='hidden' id='sort' name='sort' value='${sort}'/>
                                <input type='hidden' id='order' name='order' value='${order}'/>
                                <priderElement:inputHiddenList items="${instrumentFilters}" name="instrumentFilters"/>
                                <priderElement:inputHiddenList items="${ptmsFilters}" name="ptmsFilters"/>
                                <priderElement:inputHiddenList items="${speciesFilters}" name="speciesFilters"/>
                                <priderElement:inputHiddenList items="${diseaseFilters}" name="diseaseFilters"/>
                                <priderElement:inputHiddenList items="${tissueFilters}" name="tissueFilters"/>
                                <priderElement:inputHiddenList items="${quantificationFilters}" name="quantificationFilters"/>
                                <priderElement:inputHiddenList items="${experimentTypeFilters}" name="experimentTypeFilters"/>
                                <priderElement:inputHiddenList items="${titleFilters}" name="titleFilters"/>
                                <priderElement:inputHiddenList items="${projectTagFilters}" name="projectTagFilters"/>
                                <priderElement:inputHiddenListExcluding items="${submissionTypeFilters}" name="submissionTypeFilters" excludeItem="${theSubmissionTypeFilter}"/>
                                    ${theSubmissionTypeFilter}
                                <button type="submit" class="remove-filter-button">
                                    x
                                </button>
                                </br>
                            </fieldset>
                        </form>
                    </c:forEach>
                    </br>
                </c:if>

            </c:if> <!--end of any filters check-->
        </div> <!-- end of filters -->


        <!-- Result table and controls -->
        <%--No projects to show--%>
        <c:if test="${empty projectList}">
            <%-- ToDo: this could be nicer --%>
            <div id="search-results" class="grid_18 right-column">
                <p>
                    <fmt:message key="search.result.empty"/>
                    <fmt:message key="search.result.forterm"/>
                    <span class="searchterm">${q}</span>
                    <fmt:message key="search.result.current.active.filters"/>.
                    <fmt:message key="search.result.try.different"/>.
                </p>
                <p>
                    <c:if test="${fn:startsWith(q, 'PXD') or fn:startsWith(q, 'PRD')}">
                        <fmt:message key="search.result.request.project.publication"/>
                        <spring:url var="projectPublishUrl" value="/projects/${q}/publish"/>
                        <a href="${projectPublishUrl}">here.</a>
                    </c:if>
                </p>
            </div>
        </c:if>

        <%--There are projects to show--%>
        <c:if test="${not empty projectList}">
            <div id="search-results" class="grid_18 right-column">

                <!-- paging buttons -->
                <div class="grid_24">
                    <c:if test="${numPages>1}">
                        <div id="paging-buttons" class="grid_12 alpha">
                            <ul class="search-menu">
                                <%-- First --%>
                                <li><priderElement:hrefSearch
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
                                        submissionTypeFilters="${submissionTypeFilters}"
                                        hrefClass="${0==page?'selected':''}"
                                        />
                                </li>
                                <c:if test="${page>3}"><li>...</li></c:if>

                                <%-- In between pages --%>
                                <%--<c:forEach var="nPage" begin="${(page<5) ? 2 : (page-2)}" end="${(page>(numPages-4)) ? numPages-1 : (page+2)}">--%>
                                <c:forEach var="nPage" begin="${(page<4) ? 2 : (page-1)}" end="${(page>(numPages-3)) ? numPages-1 : (page+3)}">
                                    <li><priderElement:hrefSearch
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
                                            submissionTypeFilters="${submissionTypeFilters}"
                                            hrefClass="${nPage-1==page?'selected':''}"
                                            />
                                    </li>
                                </c:forEach>
                                <%-- Last --%>
                                <c:if test="${page<(numPages-3)}"><li>...</li></c:if>
                                <li><priderElement:hrefSearch
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
                                        submissionTypeFilters="${submissionTypeFilters}"
                                        hrefClass="${numPages-1==page?'selected':''}"
                                        />
                                </li>

                            </ul>
                        </div>
                    </c:if>

                    <!-- Show entries controls -->
                    <c:choose>
                        <c:when test="${numPages>1}">
                            <c:set var="show_entries_style" value="grid_12 omega"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="show_entries_style" value="grid_23 omega"/>
                        </c:otherwise>
                    </c:choose>
                    <div id="show-entries" class="${show_entries_style}">
                        <ul class="search-menu-right-align">
                            <c:if test="${numResults>10}">
                                <li><fmt:message key="search.show.entries"/></li>
                                <li><priderElement:hrefSearch
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
                                        submissionTypeFilters="${submissionTypeFilters}"
                                        hrefClass="${show==10?'selected':''}"
                                        /></li>

                                <li><priderElement:hrefSearch
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
                                        submissionTypeFilters="${submissionTypeFilters}"
                                        hrefClass="${show==20?'selected':''}"
                                        /></li>

                                <c:if test="${numResults>20}">
                                    <li><priderElement:hrefSearch
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
                                            submissionTypeFilters="${submissionTypeFilters}"
                                            hrefClass="${show==50?'selected':''}"
                                            /></li>

                                    <c:if test="${numResults>50}">
                                        <li><priderElement:hrefSearch
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
                                                submissionTypeFilters="${submissionTypeFilters}"
                                                hrefClass="${show==100?'selected':''}"
                                                /></li>
                                    </c:if> <!--50-->
                                </c:if> <!--20-->
                            </c:if> <!--10-->
                        </ul>
                    </div>
                </div>

                <%--Sort by controls--%>
                <div class="grid_24">
                    <div id="sort-by" class="clearfix">
                            <%--Headers--%>
                        <ul id="sort-by-menu" class="search-header">
                            <li>Sort by: </li>
                                <%-- Sort by Accession--%>
                            <li><priderElement:hrefSearch
                                    label="Accession"
                                    q="${q}"
                                    show="${show}"
                                    page="${page}"
                                    sort="id"
                                    order="${(sort == 'id') ? ((order=='asc')?'desc':'asc') : order}"
                                    titleFilters="${titleFilters}"
                                    speciesFilters="${speciesFilters}"
                                    tissueFilters="${tissueFilters}"
                                    diseaseFilters="${diseaseFilters}"
                                    ptmsFilters="${ptmsFilters}"
                                    instrumentFilters="${instrumentFilters}"
                                    quantificationFilters="${quantificationFilters}"
                                    experimentTypeFilters="${experimentTypeFilters}"
                                    projectTagFilters="${projectTagFilters}"
                                    submissionTypeFilters="${submissionTypeFilters}"
                                    hrefClass="${sort=='id'?'selected':''}"
                                    /></li>
                                <%--Sort by Title--%>
                            <li><priderElement:hrefSearch
                                    label="Title"
                                    q="${q}"
                                    show="${show}"
                                    page="${page}"
                                    sort="project_title"
                                    order="${(sort == 'project_title') ? ((order=='asc')?'desc':'asc') : order}"
                                    titleFilters="${titleFilters}"
                                    speciesFilters="${speciesFilters}"
                                    tissueFilters="${tissueFilters}"
                                    diseaseFilters="${diseaseFilters}"
                                    ptmsFilters="${ptmsFilters}"
                                    instrumentFilters="${instrumentFilters}"
                                    quantificationFilters="${quantificationFilters}"
                                    experimentTypeFilters="${experimentTypeFilters}"
                                    projectTagFilters="${projectTagFilters}"
                                    submissionTypeFilters="${submissionTypeFilters}"
                                    hrefClass="${sort=='project_title'?'selected':''}"
                                    /></li>
                                <%--Sort by Relevance--%>
                            <li><priderElement:hrefSearch
                                    label="Relevance"
                                    q="${q}"
                                    show="${show}"
                                    page="${page}"
                                    sort="score"
                                    order="${(sort == 'score') ? ((order=='asc')?'desc':'asc') : order}"
                                    titleFilters="${titleFilters}"
                                    speciesFilters="${speciesFilters}"
                                    tissueFilters="${tissueFilters}"
                                    diseaseFilters="${diseaseFilters}"
                                    ptmsFilters="${ptmsFilters}"
                                    instrumentFilters="${instrumentFilters}"
                                    quantificationFilters="${quantificationFilters}"
                                    experimentTypeFilters="${experimentTypeFilters}"
                                    projectTagFilters="${projectTagFilters}"
                                    submissionTypeFilters="${submissionTypeFilters}"
                                    hrefClass="${sort=='score'?'selected':''}"
                                    /></li>
                                <%--Sort by Publication Date--%>
                            <li><priderElement:hrefSearch
                                    label="Publication date"
                                    q="${q}"
                                    show="${show}"
                                    page="${page}"
                                    sort="publication_date"
                                    order="${(sort == 'publication_date') ? ((order=='asc')?'desc':'asc') : order}"
                                    titleFilters="${titleFilters}"
                                    speciesFilters="${speciesFilters}"
                                    tissueFilters="${tissueFilters}"
                                    diseaseFilters="${diseaseFilters}"
                                    ptmsFilters="${ptmsFilters}"
                                    instrumentFilters="${instrumentFilters}"
                                    quantificationFilters="${quantificationFilters}"
                                    experimentTypeFilters="${experimentTypeFilters}"
                                    projectTagFilters="${projectTagFilters}"
                                    submissionTypeFilters="${submissionTypeFilters}"
                                    hrefClass="${sort=='publication_date'?'selected':''}"
                                    /></li>
                                <%--display order--%>
                            <c:if test="${order=='asc'}">
                                <li>(Ascending)</li>
                            </c:if>
                            <c:if test="${order=='desc'}">
                                <li>(Descending)</li>
                            </c:if>

                        </ul>
                    </div>
                </div>

                <%--List of projects--%>
                <div>
                    <%--Projects--%>
                    <div id="search-results-items" class="grid_24">
                        <priderElement:projecList projectList="${projectList}"
                                                  speciesFilters="${speciesFilters}"
                                                  tissueFilters="${tissueFilters}"
                                                  diseaseFilters="${diseaseFilters}"
                                                  ptmsFilters="${ptmsFilters}"
                                                  instrumentFilters="${instrumentFilters}"
                                                  quantificationFilters="${quantificationFilters}"
                                                  experimentTypeFilters="${experimentTypeFilters}"
                                                  projectTagFilters="${projectTagFilters}"
                                                  submissionTypeFilters="${submissionTypeFilters}"
                                                  q="${q}"/>
                        <br>
                    </div>
                </div>

                <!-- paging buttons -->
                <div class="grid_24">
                    <!-- paging buttons -->
                    <c:if test="${numPages>1}">
                        <div id="paging-buttons" class="grid_12 alpha">
                            <ul class="search-menu">
                                    <%-- First --%>
                                <li><priderElement:hrefSearch
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
                                        submissionTypeFilters="${submissionTypeFilters}"
                                        hrefClass="${0==page?'selected':''}"
                                        />
                                </li>
                                <c:if test="${page>3}"><li>...</li></c:if>

                                    <%-- In between pages --%>
                                    <%--<c:forEach var="nPage" begin="${(page<5) ? 2 : (page-2)}" end="${(page>(numPages-4)) ? numPages-1 : (page+2)}">--%>
                                <c:forEach var="nPage" begin="${(page<4) ? 2 : (page-1)}" end="${(page>(numPages-3)) ? numPages-1 : (page+3)}">
                                    <li><priderElement:hrefSearch
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
                                            submissionTypeFilters="${submissionTypeFilters}"
                                            hrefClass="${nPage-1==page?'selected':''}"
                                            />
                                    </li>
                                </c:forEach>
                                    <%-- Last --%>
                                <c:if test="${page<(numPages-3)}"><li>...</li></c:if>
                                <li><priderElement:hrefSearch
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
                                        submissionTypeFilters="${submissionTypeFilters}"
                                        hrefClass="${numPages-1==page?'selected':''}"
                                        />
                                </li>

                            </ul>
                        </div>
                    </c:if>

                    <!-- Show entries controls -->
                    <c:choose>
                        <c:when test="${numPages>1}">
                            <c:set var="show_entries_style" value="grid_12 omega"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="show_entries_style" value="grid_23 omega"/>
                        </c:otherwise>
                    </c:choose>
                    <div id="show-entries" class="${show_entries_style}">
                        <ul class="search-menu-right-align">
                            <c:if test="${numResults>10}">
                                <li><fmt:message key="search.show.entries"/></li>
                                <li><priderElement:hrefSearch
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
                                        submissionTypeFilters="${submissionTypeFilters}"
                                        hrefClass="${show==10?'selected':''}"
                                        /></li>

                                <li><priderElement:hrefSearch
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
                                        submissionTypeFilters="${submissionTypeFilters}"
                                        hrefClass="${show==20?'selected':''}"
                                        /></li>

                                <c:if test="${numResults>20}">
                                    <li><priderElement:hrefSearch
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
                                            submissionTypeFilters="${submissionTypeFilters}"
                                            hrefClass="${show==50?'selected':''}"
                                            /></li>

                                    <c:if test="${numResults>50}">
                                        <li><priderElement:hrefSearch
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
                                                submissionTypeFilters="${submissionTypeFilters}"
                                                hrefClass="${show==100?'selected':''}"
                                                /></li>
                                    </c:if> <!--50-->
                                </c:if> <!--20-->
                            </c:if> <!--10-->
                        </ul>
                    </div>
                </div> <!-- paging buttons -->
            </div> <!-- search results-->
        </c:if> <!-- no empty search -->
     </div>
</div>

