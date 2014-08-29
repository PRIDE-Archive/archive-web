package uk.ac.ebi.pride.archive.web.protein.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.solr.core.query.result.HighlightEntry;
import org.springframework.data.solr.core.query.result.HighlightPage;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import uk.ac.ebi.pride.archive.repo.assay.service.AssaySummary;
import uk.ac.ebi.pride.archive.repo.project.service.ProjectSummary;
import uk.ac.ebi.pride.archive.security.assay.AssaySecureService;
import uk.ac.ebi.pride.archive.security.project.ProjectSecureService;
import uk.ac.ebi.pride.archive.security.protein.ProteinIdentificationSecureSearchService;
import uk.ac.ebi.pride.archive.web.util.PageMaker;
import uk.ac.ebi.pride.indexutils.results.PageWrapper;
import uk.ac.ebi.pride.proteinidentificationindex.search.model.ProteinIdentification;
import uk.ac.ebi.pride.proteinindex.search.model.ProteinIdentified;
import uk.ac.ebi.pride.psmindex.search.model.Psm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: ntoro
 * Date: 02/05/2014
 * Time: 16:03
 */
@Controller
public class ProteinsTableController {

    private static final Logger logger = LoggerFactory.getLogger(ProteinsTableController.class);

    @Autowired
    private ProteinIdentificationSecureSearchService proteinIdentificationSearchService;

    @Autowired
    private AssaySecureService assayServiceImpl;

    @Autowired
    private ProjectSecureService projectServiceImpl;

    @Autowired
    private PageMaker pageMaker;

    @RequestMapping(value = "/projects/{projectAccession}/assays/{assayAccession}/proteins", method = RequestMethod.GET)
    public ModelAndView getProjectAssayProteins(@PathVariable String assayAccession,
                                                @PathVariable String projectAccession,
                                                @PageableDefault(page = 0, value = 50) Pageable page,
                                                @RequestParam(value = "q", required = false) String query,
                                                @RequestParam(value = "newPtmsFilter", required = false) String newPtmsFilter,
                                                @RequestParam(value = "ptmsFilters", required = false) List<String> ptmsFilters) {
        // get the project proteins
        logger.debug("Retrieve psm entries with project: " + projectAccession +
                    " assay: " + assayAccession +
                    " page: " + page +
                    " and query: " + query +
                    " and newPtmsFilter: " + newPtmsFilter +
                    " and ptmsFilters: " + ptmsFilters);

        if (newPtmsFilter != null && !newPtmsFilter.isEmpty()) {
            if (ptmsFilters == null || ptmsFilters.isEmpty()) {
                ptmsFilters = new ArrayList<String>();
            }
            //We need the double quotes to have an exact match in the filter
            ptmsFilters.add("\"" + newPtmsFilter + "\"");
        }

        PageWrapper<ProteinIdentification> proteinPage = proteinIdentificationSearchService.findByAssayAccessionHighlightsOnModificationNames(assayAccession, query, ptmsFilters, page);
        Map<String, Long> availablePtms = proteinIdentificationSearchService.findByAssayAccessionFacetOnModificationNames(assayAccession, query, ptmsFilters);

        return pageMaker.createProteinsTablePage(projectAccession, assayAccession, proteinPage.getPage(), proteinPage.getHighlights(), query, availablePtms, ptmsFilters);
    }

    @RequestMapping(value = "/assays/{assayAccession}/proteins", method = RequestMethod.GET)
    public ModelAndView getAssayProteins(@PathVariable String assayAccession,
                                         @PageableDefault(page = 0, value = 50) Pageable page,
                                         @RequestParam(value = "q", required = false) String query,
                                         @RequestParam(value = "newPtmsFilter", defaultValue = "") String newPtmsFilter,
                                         @RequestParam(value = "ptmsFilters", defaultValue = "") List<String> ptmsFilters) {

        String projectAccession = getProjectAccession(assayAccession);
        return getProjectAssayProteins(assayAccession, projectAccession, page, query, newPtmsFilter, ptmsFilters);
    }

    @RequestMapping(value = "/projects/{projectAccession}/proteins", method = RequestMethod.GET)
    public ModelAndView getProjectProteins(@PathVariable String projectAccession,
                                           @PageableDefault(page = 0, value = 50) Pageable page,
                                           @RequestParam(value = "q", required = false) String query,
                                           @RequestParam(value = "newPtmsFilter", required = false) String newPtmsFilter,
                                           @RequestParam(value = "ptmsFilters", required = false) List<String> ptmsFilters) {
        // get the project proteins
        logger.debug("Retrieve protein entries with project: " + projectAccession +
                " page: " + page +
                " and query: " + query +
                " and newPtmsFilter: " + newPtmsFilter +
                " and ptmsFilters: " + ptmsFilters);


        if (newPtmsFilter != null && !newPtmsFilter.isEmpty()) {
            if (ptmsFilters == null || ptmsFilters.isEmpty()) {
                ptmsFilters = new ArrayList<String>();
            }
            //We need the double quotes to have an exact match in the filter
            ptmsFilters.add("\"" + newPtmsFilter + "\"");
        }

        PageWrapper<ProteinIdentification> proteinPage =  proteinIdentificationSearchService.findByProjectAccessionHighlightsOnModificationNames(projectAccession, query, ptmsFilters, page);
        Map<String, Long>  availablePtms = proteinIdentificationSearchService.findByProjectAccessionFacetOnModificationNames(projectAccession, query, ptmsFilters);

        return pageMaker.createProteinsTablePage(projectAccession, null, proteinPage.getPage(), proteinPage.getHighlights(), query, availablePtms, ptmsFilters);
    }

    private String getProjectAccession(String assayAccession) {
        // find the assay record to retrieve the project ID
        AssaySummary assaySummary = assayServiceImpl.findByAccession(assayAccession);

        // find the project record to retrieve the project accession
        ProjectSummary projectSummary = projectServiceImpl.findById(assaySummary.getProjectId());
        return projectSummary.getAccession();
    }

}
