<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ attribute name="projectList" required="true" type="java.util.Collection" %>
<%@ attribute name="speciesFilters" required="true" type="java.util.Collection" %>
<%@ attribute name="tissueFilters" required="true" type="java.util.Collection" %>
<%@ attribute name="diseaseFilters" required="true" type="java.util.Collection" %>
<%@ attribute name="ptmsFilters" required="true" type="java.util.Collection" %>
<%@ attribute name="instrumentFilters" required="true" type="java.util.Collection" %>
<%@ attribute name="quantificationFilters" required="true" type="java.util.Collection" %>
<%@ attribute name="experimentTypeFilters" required="true" type="java.util.Collection" %>
<%@ attribute name="submissionTypeFilters" required="true" type="java.util.Collection" %>
<%@ attribute name="projectTagFilters" required="true" type="java.util.Collection" %>
<%@ attribute name="q" required="true" %>

<c:forEach var="project" items="${projectList}">
    <div class="project-widget">

        <%--Project accession and project tags (linked to project summary page)--%>
        <div class="project-widget-accession">

            <%-- Project accession --%>
            <spring:url var="showUrl" value="/projects/{projectAccession}">
                <spring:param name="projectAccession" value="${project.projectAccession}"/>
            </spring:url>
            <a href="${showUrl}">${project.projectAccession}</a>

        </div>
            <%--Project title--%>
        <div class="project-widget-title">
            <c:set var="titleHighlighted" value="${fn:contains(project.highlights, 'project_title')}"/>
            <c:choose>
                <c:when test="${titleHighlighted}">
                    ${project.highlights['project_title'][0]}
                </c:when>
                <c:otherwise>
                    ${project.title}
                </c:otherwise>
            </c:choose>
            <br>
        </div>

        <%--Protein identifications--%>
        <div class="project-widget-paragraph">
            <c:set var="proteinIdentifiationsHighlighted" value="${fn:contains(project.highlights, 'protein_identifications')}"/>
            <%--highlight protein identifications--%>
            <c:if test="${proteinIdentifiationsHighlighted}">
                Protein identifications:
                <c:forEach var="theProteinIdentificationHighlight" items="${project.highlights['protein_identifications']}">
                    <spring:url var="projectProteinsUrl" value="/projects/{accession}/proteins?q={term}">
                        <spring:param name="accession" value="${project.projectAccession}"/>
                        <spring:param name="term" value="${q}"/>
                    </spring:url>
                    ${theProteinIdentificationHighlight}
                </c:forEach>
                <a href="${projectProteinsUrl}">(More)</a>
                <br>
            </c:if>
        </div>

        <div class="project-widget-paragraph">
            <c:set var="peptideSequencesHighlighted" value="${fn:contains(project.highlights, 'peptide_sequences')}"/>
                <%--highlight peptide sequences--%>
            <c:if test="${peptideSequencesHighlighted}">
                Peptide sequences:
                <c:forEach var="thePeptideSequenceHighlight" items="${project.highlights['peptide_sequences']}">
                    <spring:url var="projectPsmUrl" value="/projects/{accession}/psms?q={term}">
                        <spring:param name="accession" value="${project.projectAccession}"/>
                        <spring:param name="term" value="${q}"/>
                    </spring:url>

                    <a href="${projectPsmUrl}">${thePeptideSequenceHighlight}</a>
                </c:forEach>
                <br>
            </c:if>
        </div>

            <%--Project species--%>
        <div class="project-widget-paragraph">

            <c:set var="speciesHighlighted" value="${fn:contains(project.highlights, 'species_as_text')}"/>
            <c:set var="speciesDescendantsHighlighted"
                   value="${fn:contains(project.highlights, 'species_descendants_as_text')}"/>
            Species:
            <c:choose>
                <%--highlight species--%>
                <c:when test="${speciesHighlighted}">
                    <c:forEach var="theSpeciesHighlight" items="${project.highlights['species_as_text']}">
                        ${theSpeciesHighlight}
                    </c:forEach>
                    <%--${project.highlights['species_as_text'][0]}--%>
                </c:when>
                <%--highlight species descendants--%>
                <c:when test="${speciesDescendantsHighlighted}">
                    <c:forEach var="theSpeciesDescendantHighlight" items="${project.highlights['species_descendants_as_text']}">
                        ${theSpeciesDescendantHighlight}
                    </c:forEach>
                    <%--${project.highlights['species_descendants_as_text'][0]}--%>
                </c:when>
            </c:choose>
            <%--Highlight filters--%>
            <c:if test="${not empty speciesFilters}">
                <c:forEach var="theSpeciesFilter" items="${speciesFilters}">
                    <c:set var="filterContainsTerm" value="false"/>
                    <c:forTokens var="theSearchTerm" items="${q}" delims=" ">
                        <c:if test="${fn:containsIgnoreCase(theSpeciesFilter, theSearchTerm)}">
                            <c:set var="filterContainsTerm" value="true"/>
                        </c:if>
                    </c:forTokens>
                    <c:if test="${not filterContainsTerm}">
                        <span class='search-hit'>${theSpeciesFilter}</span>&NonBreakingSpace;
                    </c:if>
                </c:forEach>
            </c:if>
            <%--if not highlighted terms or filters applied, we show all species by default--%>
            <c:if test="${not (speciesHighlighted or speciesDescendantsHighlighted or not empty speciesFilters)}">
                <c:forEach var="projectSpecies" items="${project.speciesNames}">
                    ${projectSpecies}
                </c:forEach>
            </c:if>
            <br>
        </div>

            <%--Assay accessions--%>
        <div class="project-widget-paragraph">
            <c:if test="${not empty project.assayAccessions}">
                Matching assay:
                <c:forEach var="assayAccession" items="${project.assayAccessions}">
                    <spring:url var="showUrlAssay"
                                value="/projects/${project.projectAccession}/assays/{assayAccessionId}">
                        <spring:param name="assayAccessionId" value="${assayAccession}"/>
                    </spring:url>
                    <a href="${showUrlAssay}">${assayAccession}</a>
                </c:forEach>
                <br>
            </c:if>
        </div>


            <%-- project description highlight --%>
        <div class="project-widget-paragraph">
            <c:set var="descriptionHighlighted" value="${fn:contains(project.highlights, 'project_description')}"/>
            <c:choose>
                <c:when test="${descriptionHighlighted}">
                    Project description:
                    ${project.highlights['project_description'][0]}
                    <spring:url var="showUrl" value="/projects/{projectAccession}">
                        <spring:param name="projectAccession" value="${project.projectAccession}"/>
                    </spring:url>
                    <a href="${showUrl}">(More)</a>
                    <br>
                </c:when>
                <c:otherwise>
                    Project description:
                    <c:choose>
                        <c:when test="${not empty project.projectDescription}">
                        ${project.projectDescription}
                        <spring:url var="showUrl" value="/projects/{projectAccession}">
                            <spring:param name="projectAccession" value="${project.projectAccession}"/>
                        </spring:url>
                        <a href="${showUrl}">(More)</a>
                        </c:when>
                        <c:otherwise>
                            Not available
                        </c:otherwise>
                    </c:choose>
                    <br>
                </c:otherwise>
            </c:choose>
        </div>

            <%--disease highlight--%>
        <div class="project-widget-paragraph">
            <c:set var="diseaseHighlighted" value="${fn:contains(project.highlights, 'disease_as_text')}"/>
            <c:set var="diseaseDescendantsHighlighted"
                   value="${fn:contains(project.highlights, 'disease_descendants_as_text')}"/>

            <c:if test="${diseaseHighlighted or diseaseDescendantsHighlighted or not empty diseaseFilters}">
                Diseases:
                <c:if test="${diseaseHighlighted or diseaseDescendantsHighlighted}">
                    <c:choose>
                        <c:when test="${diseaseHighlighted}">
                            ${project.highlights['disease_as_text'][0]}
                        </c:when>
                        <c:when test="${diseaseDescendantsHighlighted}">
                            ${project.highlights['disease_descendants_as_text'][0]}
                        </c:when>
                    </c:choose>
                </c:if>
                <%--Highlight filters--%>
                <c:if test="${not empty diseaseFilters}">
                    Diseases:
                    <c:forEach var="theDiseaseFilter" items="${diseaseFilters}">
                        <c:set var="filterContainsTerm" value="false"/>
                        <c:forTokens var="theSearchTerm" items="${q}" delims=" ">
                            <c:if test="${fn:containsIgnoreCase(theDiseaseFilter, theSearchTerm)}">
                                <c:set var="filterContainsTerm" value="true"/>
                            </c:if>
                        </c:forTokens>
                        <c:if test="${not filterContainsTerm}">
                            <span class='search-hit'>${theDiseaseFilter}</span>&NonBreakingSpace;
                        </c:if>
                    </c:forEach>
                </c:if>
                <br>
            </c:if>
        </div>

            <%--tissue highlight--%>
        <div class="project-widget-paragraph">
            <c:set var="tissueHighlighted" value="${fn:contains(project.highlights, 'tissue_as_text')}"/>
            <c:set var="tissueDescendantsHighlighted"
                   value="${fn:contains(project.highlights, 'tissue_descendants_as_text')}"/>
            <c:if test="${tissueHighlighted or tissueDescendantsHighlighted or not empty tissueFilters}">
                Tissues:
                <c:if test="${tissueHighlighted or tissueDescendantsHighlighted}">
                    <c:choose>
                        <c:when test="${tissueHighlighted}">
                            ${project.highlights['tissue_as_text'][0]}
                        </c:when>
                        <c:when test="${tissueDescendantsHighlighted}">
                            ${project.highlights['tissue_descendants_as_text'][0]}
                        </c:when>
                    </c:choose>
                </c:if>
                <%--Highlight filters--%>
                <c:if test="${not empty tissueFilters}">
                    <c:forEach var="theTissueFilter" items="${tissueFilters}">
                        <c:set var="filterContainsTerm" value="false"/>
                        <c:forTokens var="theSearchTerm" items="${q}" delims=" ">
                            <c:if test="${fn:containsIgnoreCase(theTissueFilter, theSearchTerm)}">
                                <c:set var="filterContainsTerm" value="true"/>
                            </c:if>
                        </c:forTokens>
                        <c:if test="${not filterContainsTerm}">
                            <span class='search-hit'>${theTissueFilter}</span>&NonBreakingSpace;
                        </c:if>
                    </c:forEach>
                </c:if>
                <br>
            </c:if>
        </div>

            <%--cell type highlight        --%>
        <div class="project-widget-paragraph">
            <c:set var="cellTypeHighlighted" value="${fn:contains(project.highlights, 'cell_type_as_text')}"/>
            <c:set var="cellTypeDescendantsHighlighted"
                   value="${fn:contains(project.highlights, 'cell_type_descendants_as_text')}"/>
            <c:if test="${cellTypeHighlighted or cellTypeDescendantsHighlighted}">
                Cell types:
                <c:choose>
                    <c:when test="${cellTypeHighlighted}">
                        ${project.highlights['cell_type_as_text'][0]}
                    </c:when>
                    <c:when test="${cellTypeDescendantsHighlighted}">
                        ${project.highlights['cell_type_descendants_as_text'][0]}
                    </c:when>
                </c:choose>
                <br>
            </c:if>
        </div>

            <%--Instrument model--%>
        <div class="project-widget-paragraph">
            <c:if test="${fn:contains(project.highlights, 'instrument_models_as_text') or not empty instrumentFilters}">
                Instrument:
                <c:if test="${fn:contains(project.highlights, 'instrument_models_as_text')}">
                    ${project.highlights['instrument_models_as_text'][0]}
                </c:if>
                    <%--Highlight filters--%>
                <c:if test="${not empty instrumentFilters}">
                    <c:forEach var="theInstrumentFilter" items="${instrumentFilters}">
                        <c:set var="filterContainsTerm" value="false"/>
                        <c:forTokens var="theSearchTerm" items="${q}" delims=" ">
                            <c:if test="${fn:containsIgnoreCase(theInstrumentFilter, theSearchTerm)}">
                                <c:set var="filterContainsTerm" value="true"/>
                            </c:if>
                        </c:forTokens>
                        <c:if test="${not filterContainsTerm}">
                            <span class='search-hit'>${theInstrumentFilter}</span>&NonBreakingSpace;
                        </c:if>
                    </c:forEach>
                </c:if>
                <br>
            </c:if>
        </div>

            <%--Quantification method--%>
        <div class="project-widget-paragraph">
            <c:if test="${fn:contains(project.highlights, 'quantification_methods_as_text') or not empty quantificationFilters}">
            Quantification method:
                <c:if test="${fn:contains(project.highlights, 'quantification_methods_as_text')}">
                    ${project.highlights['quantification_methods_as_text'][0]}
                </c:if>
                    <%--Highlight filters--%>
                <c:if test="${not empty quantificationFilters}">
                    <c:forEach var="theQuantificationFilter" items="${quantificationFilters}">
                        <c:set var="filterContainsTerm" value="false"/>
                        <c:forTokens var="theSearchTerm" items="${q}" delims=" ">
                            <c:if test="${fn:containsIgnoreCase(theQuantificationFilter, theSearchTerm)}">
                                <c:set var="filterContainsTerm" value="true"/>
                            </c:if>
                        </c:forTokens>
                        <c:if test="${not filterContainsTerm}">
                            <span class='search-hit'>${theQuantificationFilter}</span>&NonBreakingSpace;
                        </c:if>
                    </c:forEach>
                </c:if>
                <br>
            </c:if>
        </div>

            <%--Experiment type--%>
        <div class="project-widget-paragraph">
            <c:if test="${fn:contains(project.highlights, 'experiment_types_as_text') or not empty experimentTypeFilters}">
                Experiment type:
                <c:if test="${fn:contains(project.highlights, 'experiment_types_as_text')}">
                    ${project.highlights['experiment_types_as_text'][0]}
                </c:if>
                    <%--Highlight filters--%>
                <c:if test="${not empty experimentTypeFilters}">
                    <c:forEach var="theExperimentTypeFilter" items="${experimentTypeFilters}">
                        <c:set var="filterContainsTerm" value="false"/>
                        <c:forTokens var="theSearchTerm" items="${q}" delims=" ">
                            <c:if test="${fn:containsIgnoreCase(theExperimentTypeFilter, theSearchTerm)}">
                                <c:set var="filterContainsTerm" value="true"/>
                            </c:if>
                        </c:forTokens>
                        <c:if test="${not filterContainsTerm}">
                            <span class='search-hit'>${theExperimentTypeFilter}</span>&NonBreakingSpace;
                        </c:if>
                    </c:forEach>
                </c:if>
                <br>
            </c:if>
        </div>

            <%--PTMs--%>
        <div class="project-widget-paragraph">
            <c:if test="${fn:contains(project.highlights, 'ptm_as_text')
                or fn:contains(project.highlights, 'ptm_names')
                or fn:contains(project.highlights, 'ptm_accessions')
                or not empty ptmsFilters}">
                Modifications:
                <c:if test="${fn:contains(project.highlights, 'ptm_as_text')}">
                    ${project.highlights['ptm_as_text'][0]}
                </c:if>
                <c:if test="${fn:contains(project.highlights, 'ptm_names')}">
                    ${project.highlights['ptm_names'][0]}
                </c:if>
                <c:if test="${fn:contains(project.highlights, 'ptm_accessions')}">
                    ${project.highlights['ptm_accessions'][0]}
                </c:if>

                    <%--Highlight filters--%>
                <c:if test="${not empty ptmsFilters}">
                    <c:forEach var="thePtmFilter" items="${ptmsFilters}">
                        <c:set var="filterContainsTerm" value="false"/>
                        <c:forTokens var="theSearchTerm" items="${q}" delims=" ">
                            <c:if test="${fn:containsIgnoreCase(thePtmFilter, theSearchTerm)}">
                                <c:set var="filterContainsTerm" value="true"/>
                            </c:if>
                        </c:forTokens>
                        <c:if test="${not filterContainsTerm}">
                            <span class='search-hit'>${thePtmFilter}</span>&NonBreakingSpace;
                        </c:if>
                    </c:forEach>
                </c:if>
                <br>
            </c:if>
        </div>

            <%--Samples--%>
        <div class="project-widget-paragraph">
            <c:if test="${fn:contains(project.highlights, 'sample_as_text')}">
                Samples:
                ${project.highlights['sample_as_text'][0]}<br>
            </c:if>
        </div>

            <%--Publication date--%>
        <div class="project-widget-paragraph">
            Made public:
            <fmt:formatDate pattern="yyyy-MM-dd"
                            value="${project.publicationDate}"/>
        </div>

            <%--Submission Type --%>
        <div class="project-widget-paragraph">
            <c:if test="${fn:contains(project.highlights, 'submission_type') or not empty submissionTypeFilters}">
                Submission type:
                <c:if test="${fn:contains(project.highlights, 'submission_type')}">
                    ${project.highlights['submission_type'][0]}
                </c:if>
                <c:if test="${not empty submissionTypeFilters}">
                    <c:forEach var="theSubmissionTypeFilter" items="${submissionTypeFilters}">
                        <c:set var="filterContainsTerm" value="false"/>
                        <c:forTokens var="theSearchTerm" items="${q}" delims=" ">
                            <c:if test="${fn:containsIgnoreCase(theSubmissionTypeFilter, theSearchTerm)}">
                                <c:set var="filterContainsTerm" value="true"/>
                            </c:if>
                        </c:forTokens>
                        <c:if test="${not filterContainsTerm}">
                            <span class='search-hit'>${theSubmissionTypeFilter}</span>&NonBreakingSpace;
                        </c:if>
                    </c:forEach>
                </c:if>
                <br>
            </c:if>
        </div>

            <%-- Project tags --%>
        <div class="project-widget-tag">
            <c:if test="${not empty project.projectTagNames == true}">
                <c:forEach var="tag" items="${project.projectTagNames}">
                    <c:choose>
                        <c:when test="${fn:toLowerCase(tag) eq 'biomedical' or
                                        fn:toLowerCase(tag) eq 'biological' or
                                        fn:toLowerCase(tag) eq 'technical' or
                                        fn:toLowerCase(tag) eq 'cardiovascular' or
                                        fn:toLowerCase(tag) eq 'metaproteomics'}">
                            <c:set var="tagType" value='${fn:toLowerCase(tag)}'/>
                            <c:set var="tagName">${tag} <fmt:message key="project.dataset"/></c:set>
                        </c:when>
                        <c:when test="${fn:toLowerCase(tag) eq 'highlighted'}">
                            <c:set var="tagType" value='highlighted'/>
                            <c:set var="tagName"><fmt:message key="project.highlighted"/></c:set>
                        </c:when>
                        <c:otherwise>
                            <c:set var="tagType" value='other'/>
                            <c:set var="tagName" value="${tag}"/>
                        </c:otherwise>
                    </c:choose>

                    <spring:url var="searchTagUrl"
                                value="/simpleSearch?q=&projectTagFilters={projectTagFilter}">
                        <spring:param name="tag" value="${tag}"/>
                        <spring:param name="projectTagFilter" value="${tag}"/>
                    </spring:url>

                    <a title="${tagName}" class="${tagType}" href="${searchTagUrl}">${tagName}</a>
                </c:forEach>
            </c:if>
        </div>
    </div>
</c:forEach>
