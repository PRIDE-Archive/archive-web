package uk.ac.ebi.pride.archive.web.psm.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import uk.ac.ebi.pride.archive.repo.assay.service.AssaySummary;
import uk.ac.ebi.pride.archive.repo.project.service.ProjectSummary;
import uk.ac.ebi.pride.archive.security.assay.AssaySecureService;
import uk.ac.ebi.pride.archive.security.project.ProjectSecureService;
import uk.ac.ebi.pride.archive.security.psm.MongoPsmSecureSearchService;
import uk.ac.ebi.pride.archive.security.psm.PsmSecureSearchService;
import uk.ac.ebi.pride.archive.web.model.QualityAwarePsm;
import uk.ac.ebi.pride.archive.web.model.QualityAwarePsms;
import uk.ac.ebi.pride.archive.web.util.PageMaker;
import uk.ac.ebi.pride.archive.web.util.SearchUtils;
import uk.ac.ebi.pride.indexutils.results.PageWrapper;
import uk.ac.ebi.pride.psmindex.mongo.search.model.MongoPsm;
import uk.ac.ebi.pride.psmindex.search.model.Psm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: ntoro
 * Date: 02/05/2014
 * Time: 15:20
 */
@Controller
public class PsmsTableController {

    private static final Logger logger = LoggerFactory.getLogger(PsmsTableController.class);

    @Autowired
    private PsmSecureSearchService psmSearchService;

    @Autowired
    MongoPsmSecureSearchService mongoPsmSecureSearchService;

    @Autowired
    private AssaySecureService assayServiceImpl;

    @Autowired
    private ProjectSecureService projectServiceImpl;

    @Autowired
    private PageMaker pageMaker;


    //This trims automatically the request parameters
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(String.class, new StringTrimmerEditor("\b\t\r\n\f", true));
    }

    @RequestMapping(value = "/projects/{projectAccession}/assays/{assayAccession}/psms", method = RequestMethod.GET)
    public ModelAndView getProjectAssayPsms(@PathVariable String assayAccession,
                                            @PathVariable String projectAccession,
                                            @PageableDefault(page = 0, value = 10) Pageable page,
                                            @RequestParam(value = "q", required = false) String query,
                                            @RequestParam(value = "newPtmsFilter", required = false) String newPtmsFilter,
                                            @RequestParam(value = "ptmsFilters", required = false) List<String> ptmsFilters) {
        logger.debug("Retrieve psm entries with project: " + projectAccession +
                    " assay: " + assayAccession +
                    " page: " + page +
                    " and query: " + query +
                    " and newPtmsFilter: " + newPtmsFilter +
                    " and ptmsFilters: " + ptmsFilters);
        if (newPtmsFilter != null && !newPtmsFilter.isEmpty()) {
            if (ptmsFilters == null || ptmsFilters.isEmpty()) {
                ptmsFilters = new ArrayList<>();
            }
            ptmsFilters.add("\"" + newPtmsFilter + "\""); //We need the double quotes to have an exact match in the filter
        }
        String filteredQuery = query; //The query is escaped
        if(filteredQuery  != null && !filteredQuery.isEmpty()){
            filteredQuery = SearchUtils.escapeQueryCharsExceptStartQuestionMarkWhitespace(query);
        }
        PageWrapper<Psm> psmPage = psmSearchService.findByAssayAccessionHighlightsOnModificationNames(assayAccession, filteredQuery, ptmsFilters, page);
        Map<String, Long> availablePtms = psmSearchService.findByAssayAccessionFacetOnModificationNames(assayAccession, filteredQuery, ptmsFilters);
        Map<String, QualityAwarePsm> psmsWithClusters = getClustersForPsm(psmPage.getPage().getContent());
        ArrayList<String> psmIds = new ArrayList<>();
        for (Psm psm: psmPage.getPage().getContent()) {
            psmIds.add(psm.getId());
        }
        List<MongoPsm> mongoPsms = mongoPsmSecureSearchService.findByIdIn(psmIds,
            new Sort(Sort.Direction.ASC, "peptideSequence"));
        return pageMaker.createPsmsTablePage(projectAccession, assayAccession, psmPage.getPage(),
            psmPage.getHighlights(), query, availablePtms, ptmsFilters, psmsWithClusters, mongoPsms);
    }

    @RequestMapping(value = "/assays/{assayAccession}/psms", method = RequestMethod.GET)
    public ModelAndView getAssayPsms(@PathVariable String assayAccession,
                                     @PageableDefault(page = 0, value = 10) Pageable page,
                                     @RequestParam(value = "q", required = false) String query,
                                     @RequestParam(value = "newPtmsFilter", defaultValue = "") String newPtmsFilter,
                                     @RequestParam(value = "ptmsFilters", defaultValue = "") List<String> ptmsFilters) {

        String projectAccession = getProjectAccession(assayAccession);
        return getProjectAssayPsms(assayAccession, projectAccession, page, query, newPtmsFilter, ptmsFilters);
    }

    @RequestMapping(value = "/projects/{projectAccession}/psms", method = RequestMethod.GET)
    public ModelAndView getProjectPsms(@PathVariable String projectAccession,
                                       @PageableDefault(page = 0, value = 10) Pageable page,
                                       @RequestParam(value = "q", required = false) String query,
                                       @RequestParam(value = "newPtmsFilter", required = false) String newPtmsFilter,
                                       @RequestParam(value = "ptmsFilters", required = false) List<String> ptmsFilters) {
        // get the project psms
        logger.debug("Retrieve psm entries with project: " + projectAccession +
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

        //The query is escaped
        String filteredQuery = query;
        if(filteredQuery  != null && !filteredQuery.isEmpty()){
            filteredQuery = SearchUtils.escapeQueryCharsExceptStartQuestionMarkWhitespace(query);
        }

        PageWrapper<Psm> psmPage = psmSearchService.findByProjectAccessionHighlightsOnModificationNames(projectAccession, filteredQuery, ptmsFilters, page);
        Map<String, Long> availablePtms = psmSearchService.findByProjectAccessionFacetOnModificationNames(projectAccession, filteredQuery, ptmsFilters);
        Map<String, QualityAwarePsm> psmsWithClusters = getClustersForPsm(psmPage.getPage().getContent());
        ArrayList<String> psmIds = new ArrayList<>();
        for (Psm psm: psmPage.getPage().getContent()) {
            psmIds.add(psm.getId());
        }
        List<MongoPsm> mongoPsms = mongoPsmSecureSearchService.findByIdIn(psmIds,
            new Sort(Sort.Direction.ASC, "peptideSequence"));
        return pageMaker.createPsmsTablePage(projectAccession, null, psmPage.getPage(),
            psmPage.getHighlights(), query, availablePtms, ptmsFilters, psmsWithClusters, mongoPsms);
    }

    private String getProjectAccession(String assayAccession) {
        // find the assay record to retrieve the project ID
        AssaySummary assaySummary = assayServiceImpl.findByAccession(assayAccession);

        // find the project record to retrieve the project accession
        ProjectSummary projectSummary = projectServiceImpl.findById(assaySummary.getProjectId());
        return projectSummary.getAccession();
    }

    private Map<String, QualityAwarePsm> getClustersForPsm(List<Psm> psms) {
        Map<String, QualityAwarePsm> result = new HashMap<>(psms.size());
        RestTemplate restTemplate = new RestTemplate();
        QualityAwarePsms qualityAwarePsms;
        QualityAwarePsm qualityAwarePsm;
        for (Psm psm : psms) {
            qualityAwarePsms = restTemplate.getForObject("http://www.ebi.ac.uk/pride/ws/cluster/psm/archive/" + psm.getId(), QualityAwarePsms.class);
            if (qualityAwarePsms!=null && !qualityAwarePsms.getQualityAwarePsms().isEmpty()){
                qualityAwarePsm = qualityAwarePsms.getQualityAwarePsms().first();
            } else {
                qualityAwarePsm = new QualityAwarePsm();
            }
            result.put(psm.getId(), qualityAwarePsm);
        }
        return result;
    }
}
