package uk.ac.ebi.pride.archive.web.search.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import uk.ac.ebi.pride.archive.search.service.ProjectSearchService;
import uk.ac.ebi.pride.archive.search.service.ProjectSearchSummary;
import uk.ac.ebi.pride.archive.security.protein.ProteinIdentificationSecureSearchService;
import uk.ac.ebi.pride.archive.web.search.SolrQueryBuilder;
import uk.ac.ebi.pride.archive.web.util.SearchUtils;
import uk.ac.ebi.pride.proteinidentificationindex.search.model.ProteinIdentification;
import uk.ac.ebi.pride.psmindex.search.model.Psm;
import uk.ac.ebi.pride.psmindex.search.service.PsmSearchService;

import java.util.*;

import static uk.ac.ebi.pride.archive.search.service.dao.solr.ProjectSearchDaoSolr.HIGHLIGHT_POST_FRAGMENT;
import static uk.ac.ebi.pride.archive.search.service.dao.solr.ProjectSearchDaoSolr.HIGHLIGHT_PRE_FRAGMENT;
import static uk.ac.ebi.pride.archive.web.search.SearchFields.PEPTIDE_SEQUENCES;
import static uk.ac.ebi.pride.archive.web.search.SearchFields.PROTEIN_IDENTIFICATIONS;

/**
 * @author Jose A. Dianes
 * @version $Id$
 */
@Controller
public class SearchController {
    private static final int MAX_PEPTIDE_SEQUENCE_HIGHLIGHTS = 5;

//  The amino acids characters come from PRIDE Inspector
//  The star and the question mark have been added for solr purposes
    private static final String PEPTIDE_REGEX = "[ABCDEFGHIJKLMNPQRSTUVWXYZ*?]{4,100}";

    private static final String DATE_SORTING_CRITERIA = "publication_date";
    private static final String SCORE_SORTING_CRITERIA = "score";
    private static final String DESCENDING_ORDER = "desc";
    private static final String MORE_TEXT = " (More)";
    private static final String MORE_WITH_NUMBER_TEXT = " (%s more)";

    @Autowired
    private ProjectSearchService projectSearchService;

    @Autowired
    private ProteinIdentificationSecureSearchService proteinIdentificationSearchService;

    @Autowired
    private PsmSearchService psmSearchService;

    @RequestMapping(value = "simpleSearch", method = RequestMethod.GET)
    public String simpleSearchProjects(@RequestParam(value="q", defaultValue = "", required = false) String term,
                                       @RequestParam(value = "show", defaultValue = "10", required = false) int showResults,
                                       @RequestParam(value = "page", defaultValue = "0", required = false) int page,
                                       @RequestParam(value = "sort", defaultValue = "", required = false) String sortBy,
                                       @RequestParam(value = "order", defaultValue = DESCENDING_ORDER,required = false) String order,

                                       @RequestParam(value = "newPtmsFilter", defaultValue = "", required = false) String newPtmsFilter,
                                       @RequestParam(value = "ptmsFilters", defaultValue = "", required = false) String[] ptmsFilters,

                                       @RequestParam(value = "newSpeciesFilter", defaultValue = "", required = false) String newSpeciesFilter,
                                       @RequestParam(value = "speciesFilters", defaultValue = "", required = false) String[] speciesFilters,

                                       @RequestParam(value = "newTissueFilter", defaultValue = "", required = false) String newTissueFilter,
                                       @RequestParam(value = "tissueFilters", defaultValue = "", required = false) String[] tissueFilters,

                                       @RequestParam(value = "newDiseaseFilter", defaultValue = "", required = false) String newDiseaseFilter,
                                       @RequestParam(value = "diseaseFilters", defaultValue = "", required = false) String[] diseaseFilters,

                                       @RequestParam(value = "newTitleFilter", defaultValue = "", required = false) String newTitleFilter,
                                       @RequestParam(value = "titleFilters", defaultValue = "", required = false) String[] titleFilters,

                                       @RequestParam(value = "newInstrumentFilter", defaultValue = "", required = false) String newInstrumentFilter,
                                       @RequestParam(value = "instrumentFilters", defaultValue = "", required = false) String[] instrumentFilters,

                                       @RequestParam(value = "newQuantificationFilter", defaultValue = "", required = false) String newQuantificationFilter,
                                       @RequestParam(value = "quantificationFilters", defaultValue = "", required = false) String[] quantificationFilters,

                                       @RequestParam(value = "newExperimentTypeFilter", defaultValue = "", required = false) String newExperimentTypeFilter,
                                       @RequestParam(value = "experimentTypeFilters", defaultValue = "", required = false) String[] experimentTypeFilters,

                                       @RequestParam(value = "newProjectTagFilter", defaultValue = "", required = false) String newProjectTagFilter,
                                       @RequestParam(value = "projectTagFilters", defaultValue = "", required = false) String[] projectTagFilters,

                                       @RequestParam(value = "newSubmissionTypeFilter", defaultValue = "", required = false) String newSubmissionTypeFilter,
                                       @RequestParam(value = "submissionTypeFilters", defaultValue = "", required = false) String[] submissionTypeFilters,
                                       Model model) throws org.apache.solr.common.SolrException {

        // foall: if no search term is provided, and therefore score is not very relevant, date has to be the sorting
        // criteria
        if ("".equals(term) && "".equals(sortBy)) {
            sortBy = DATE_SORTING_CRITERIA; // this is the default sorting criteria when no one is specified and there is no search term
        } else if (!"".equals(term) && "".equals(sortBy)) {
            sortBy = SCORE_SORTING_CRITERIA; // this is the default sorting criteria when no one specified and there is a search term
        }

        // add instrument filter to list
        HashSet<String> instrumentFilterList = new HashSet<>();
        if (instrumentFilters != null && instrumentFilters.length > 0)
            instrumentFilterList.addAll(Arrays.asList(instrumentFilters));
        if (!"".equals(newInstrumentFilter))
            instrumentFilterList.add(newInstrumentFilter);

        // add ptm filter to list
        HashSet<String> ptmsFilterList = new HashSet<>();
        if (ptmsFilters != null && ptmsFilters.length > 0)
            ptmsFilterList.addAll(Arrays.asList(ptmsFilters));
        if (!"".equals(newPtmsFilter))
            ptmsFilterList.add(newPtmsFilter);

        // add species filter to list
        HashSet<String> speciesFilterList = new HashSet<>();
        if (speciesFilters != null && speciesFilters.length > 0)
            speciesFilterList.addAll(Arrays.asList(speciesFilters));
        if (!"".equals(newSpeciesFilter))
            speciesFilterList.add(newSpeciesFilter);

        // add tissue filter to list
        HashSet<String> tissueFilterList = new HashSet<>();
        if (tissueFilters != null && tissueFilters.length > 0)
            tissueFilterList.addAll(Arrays.asList(tissueFilters));
        if (!"".equals(newTissueFilter))
            tissueFilterList.add(newTissueFilter);

        // add disease filter to list
        HashSet<String> diseaseFilterList = new HashSet<>();
        if (diseaseFilters != null && diseaseFilters.length > 0)
            diseaseFilterList.addAll(Arrays.asList(diseaseFilters));
        if (!"".equals(newDiseaseFilter))
            diseaseFilterList.add(newDiseaseFilter);

        // add title filter to list
        HashSet<String> titleFilterList = new HashSet<>();
        if (titleFilters != null && titleFilters.length > 0)
            titleFilterList.addAll(Arrays.asList(titleFilters));
        if (!"".equals(newTitleFilter))
            titleFilterList.add(newTitleFilter);

        // add quantification filter to list
        HashSet<String> quantificationFilterList = new HashSet<>();
        if (quantificationFilters != null && quantificationFilters.length > 0)
            quantificationFilterList.addAll(Arrays.asList(quantificationFilters));
        if (!"".equals(newQuantificationFilter))
            quantificationFilterList.add(newQuantificationFilter);

        // add experiment type filter to list
        HashSet<String> experimentTypeFilterList = new HashSet<>();
        if (experimentTypeFilters != null && experimentTypeFilters.length > 0)
            experimentTypeFilterList.addAll(Arrays.asList(experimentTypeFilters));
        if (!"".equals(newExperimentTypeFilter))
            experimentTypeFilterList.add(newExperimentTypeFilter);


        // add project tags filter to list
        HashSet<String> projectTagFilterList = new HashSet<>();
        if (projectTagFilters != null && projectTagFilters.length > 0)
            projectTagFilterList.addAll(Arrays.asList(projectTagFilters));
        if (!"".equals(newProjectTagFilter))
            projectTagFilterList.add(newProjectTagFilter);

        // add project tags filter to list
        HashSet<String> submissionTypeFilterList = new HashSet<>();
        if (submissionTypeFilters != null && submissionTypeFilters.length > 0)
            submissionTypeFilterList.addAll(Arrays.asList(submissionTypeFilters));
        if (!"".equals(newSubmissionTypeFilter))
            submissionTypeFilterList.add(newSubmissionTypeFilter);

        // search for projects
        searchForProjects(model, term, showResults, page, sortBy, order,
                ptmsFilterList, speciesFilterList, tissueFilterList, diseaseFilterList, titleFilterList,
                instrumentFilterList, quantificationFilterList, experimentTypeFilterList, projectTagFilterList, submissionTypeFilterList);

        return "searchResult";
    }


    private void searchForProjects(Model model, String term, int showResults, int page, String sortBy, String order,
                                   Iterable<String> ptmsFilterList,
                                   Iterable<String> speciesFilterList,
                                   Iterable<String> tissueFilterList,
                                   Iterable<String> diseaseFilterList,
                                   Iterable<String> titleFilterList,
                                   Iterable<String> instrumentFilterList,
                                   Iterable<String> quantificationFilterList,
                                   Iterable<String> experimentTypeFilterList,
                                   Iterable<String> projectTagFilterList,
                                   Iterable<String> submissionTypeFilterList) {
        Collection<ProjectSearchSummary> projects = null;
        //We remove the reserved words in solr first and later we remove more than one double spaces,
        // they can create syntax errors in the query.
        term = cleanTerm(term);
        String queryTerm = SolrQueryBuilder.buildQueryTerm(term);
        String queryFields = SolrQueryBuilder.buildQueryFields();
        String queryFilters[] = SolrQueryBuilder.buildQueryFilters(
                ptmsFilterList,
                speciesFilterList,
                tissueFilterList,
                diseaseFilterList,
                titleFilterList,
                instrumentFilterList,
                quantificationFilterList,
                experimentTypeFilterList,
                projectTagFilterList,
                submissionTypeFilterList
        );
        // facet on the whole data set
        Map<String, Long> availableSpecies = sortByValueDesc(projectSearchService.getSpeciesCount(queryTerm, queryFields, queryFilters));
        Map<String, Long> availableTissue = sortByValueDesc(projectSearchService.getTissueCount(queryTerm, queryFields, queryFilters));
        Map<String, Long> availableDisease = sortByValueDesc(projectSearchService.getDiseaseCount(queryTerm, queryFields, queryFilters));
        Map<String, Long> availableInstruments = sortByValueDesc(projectSearchService.getInstrumentModelCount(queryTerm, queryFields, queryFilters));
        Map<String, Long> availableQMethods = sortByValueDesc(projectSearchService.getQuantificationMethodsCount(queryTerm, queryFields, queryFilters));
        Map<String, Long> availableExperimentTypes = sortByValueDesc(projectSearchService.getExperimentTypesCount(queryTerm, queryFields, queryFilters));
        Map<String, Long> availablePtms = sortByValueDesc(projectSearchService.getPtmCount(queryTerm, queryFields, queryFilters));
        Map<String, Long> availableProjectTags = sortByValueDesc(projectSearchService.getProjectTagCount(queryTerm, queryFields, queryFilters));
        Map<String, Long> availableSubmissionTypes = sortByValueDesc(projectSearchService.getSubmissionTypeCount(queryTerm, queryFields, queryFilters));

        int numPages = 0;
        long numResults = projectSearchService.numSearchResults(queryTerm, queryFields, queryFilters);
        if (numResults > 0) {
            numPages = roundUp(numResults, showResults);
            page = (page > numPages) ? numPages-1 : page;
            int start = showResults * (page);
            projects = projectSearchService.searchProjects(queryTerm, queryFields, queryFilters, start, showResults, sortBy, order);
        }
        filterAssayAccessions(projects, term);
        highlightProteinAccessions(projects, term);
        highlightPeptideSequences(projects, term);

        model.addAttribute("projectList", projects);
        model.addAttribute("q", term);
        model.addAttribute("show", showResults);
        model.addAttribute("page", page);
        model.addAttribute("numPages", numPages);
        model.addAttribute("numResults", numResults);
        model.addAttribute("sort", sortBy);
        model.addAttribute("order", order);

        // return title filters
        model.addAttribute("titleFilters", titleFilterList);

        // return ptm filters
        model.addAttribute("ptmsFilters", ptmsFilterList);
        model.addAttribute("availablePtmList", availablePtms);

        // return species filters
        model.addAttribute("speciesFilters", speciesFilterList);
        model.addAttribute("availableSpeciesList", availableSpecies);

        // return tissue filters
        model.addAttribute("tissueFilters", tissueFilterList);
        model.addAttribute("availableTissueList", availableTissue);

        // return disease filters
        model.addAttribute("diseaseFilters", diseaseFilterList);
        model.addAttribute("availableDiseaseList", availableDisease);

        // return instrument filters
        model.addAttribute("instrumentFilters", instrumentFilterList);
        model.addAttribute("availableInstrumentList", availableInstruments);

        // return quantification filters
        model.addAttribute("quantificationFilters", quantificationFilterList);
        model.addAttribute("availableQuantificationMethodsList", availableQMethods);

        // return experiment type filters
        model.addAttribute("experimentTypeFilters", experimentTypeFilterList);
        model.addAttribute("availableExperimentTypesList", availableExperimentTypes);

        // return project tag filters
        model.addAttribute("projectTagFilters", projectTagFilterList);
        model.addAttribute("availableProjectTagsList", availableProjectTags);

        // return project tag filters
        model.addAttribute("submissionTypeFilters", submissionTypeFilterList);
        model.addAttribute("availableSubmissionTypesList", availableSubmissionTypes);
    }

    private void highlightProteinAccessions(Collection<ProjectSearchSummary> projects, String term) {
        if (projects != null) {
            if (!term.isEmpty()) {
                String[] termTokens = term.split(" "); // build regex, later to be checked against protein accessions
                if (termTokens.length > 0) { // if we get any patterns from the search terms...
                    for (ProjectSearchSummary projectSearchSummary : projects) { // go through projects to find highlights
                        for (String termToken : termTokens) {
                            termToken = cleanTerm(termToken); //We remove the solr reserved words
                            if(termToken!= null && !termToken.isEmpty()) {
                                //We need escape every token to avoid syntax problems
                                termToken = SearchUtils.escapeQueryCharsExceptStartQuestionMarkWhitespace(termToken);
                                // get protein identifications for this project and possibly the search term
                                List<ProteinIdentification> proteinIdentifications =
                                        proteinIdentificationSearchService.findByProjectAccessionAndAccession(
                                                projectSearchSummary.getProjectAccession(), termToken);
                                if (proteinIdentifications != null && proteinIdentifications.size() > 0) {
                                    int count = proteinIdentifications.size();
                                    projectSearchSummary.getHighlights().computeIfAbsent(PROTEIN_IDENTIFICATIONS.getIndexName(), k -> new LinkedList<>());
                                    projectSearchSummary.getHighlights().get(PROTEIN_IDENTIFICATIONS.getIndexName()).add(
                                            HIGHLIGHT_PRE_FRAGMENT + termToken + " (" + count + ")" + HIGHLIGHT_POST_FRAGMENT
                                    );
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    private void highlightPeptideSequences(Collection<ProjectSearchSummary> projects, String term) {
        if (projects != null) {
            if (!term.isEmpty()) {
                // build regex, later to be checked against protein accessions
                String[] termTokens = term.split(" ");
                if (termTokens.length > 0) { // if we get any patterns from the search terms...
                    // go through projects to find highlights
                    for (ProjectSearchSummary projectSearchSummary : projects) {
                        for (String termToken : termTokens) {
                            //We remove the solr reserved words
                            termToken = cleanTerm(termToken);
                            if(termToken!= null && !termToken.isEmpty()) {
                                //We need escape every token to avoid syntax problems
                                termToken = SearchUtils.escapeQueryCharsExceptStartQuestionMarkWhitespace(termToken);
                                // We avoid queries with less than 4 amino acids and more that 100 and with letters that
                                // don't represent amino acids except the star.
                                if (termToken.matches(PEPTIDE_REGEX)) {
                                    // get protein identifications for this project and possibly the search term
                                    List<Psm> psms =
                                            psmSearchService.findByPeptideSequenceAndProjectAccession(
                                                    termToken, projectSearchSummary.getProjectAccession(),
                                                new PageRequest(0, 5, Sort.Direction.ASC, "peptide_sequence", "id")).getContent()
                                            ;
                                    if (psms != null) {
                                        Set<String> peptideSequences = new TreeSet<>();
                                        //We group only the sequences to count properly the results (we have several psm with the same sequence),
                                        //maybe un the future we will need the modifications too
                                        for (Psm psm : psms) {
                                            peptideSequences.add(psm.getPeptideSequence());
                                        }
                                        int numHighlightsAdded = 0;
                                        Iterator<String> it = peptideSequences.iterator();
                                        while (it.hasNext() && numHighlightsAdded < MAX_PEPTIDE_SEQUENCE_HIGHLIGHTS) {
                                            String sequence = it.next();
                                            // initialize the highlights for the field if needed (most likely)
                                            projectSearchSummary.getHighlights().computeIfAbsent(PEPTIDE_SEQUENCES.getIndexName(), k -> new LinkedList<>());
                                            String pepHighlight = HIGHLIGHT_PRE_FRAGMENT + sequence + HIGHLIGHT_POST_FRAGMENT;
                                            //the peptide sequences is not added before becasue we remove the repetitions before
                                            projectSearchSummary.getHighlights().get(PEPTIDE_SEQUENCES.getIndexName()).add(pepHighlight);
                                            numHighlightsAdded++;
                                        }
                                        if (numHighlightsAdded > 0 && numHighlightsAdded < peptideSequences.size()) {
                                            // add the (More) bit
                                            projectSearchSummary.getHighlights().get(PEPTIDE_SEQUENCES.getIndexName()).add(
                                                    String.format(MORE_WITH_NUMBER_TEXT, peptideSequences.size() - MAX_PEPTIDE_SEQUENCE_HIGHLIGHTS)
                                            );
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    private void filterAssayAccessions(Collection<ProjectSearchSummary> projects, String term) {
        if (projects != null) {
            Set<String> terms = new HashSet<>();
            terms.addAll(Arrays.asList(term.split(" ")));
            for (ProjectSearchSummary project : projects) {
                if (project.getAssayAccessions() != null) {
                    int i = 0;
                    while (i < project.getAssayAccessions().size()) {
                        if (!terms.contains(project.getAssayAccessions().get(i))) {
                            project.getAssayAccessions().remove(i);
                        } else {
                            i++;
                        }
                    }
                }
            }
        }
    }

    private String cleanTerm(String term) {
        if (term != null && !term.equals("")) {
            //Solr reserved words
            term = term.replaceAll("^AND$", "").replaceAll("^OR$", "").replaceAll("^NOT$", "");
            term = term.trim().replaceAll(" {2,}", " ");
            if(term.equals(" ") || term.equals("*")){
                term="";
            }
        }
        return term;
    }

    private static int roundUp(long num, long divisor) {
        if (divisor == 0) return 0;
        else return (int) ((num + divisor - 1) / divisor);
    }

    private static <K,V extends Comparable<V>> Map<K,V>  sortByValueDesc(Map<K,V> map) {
        if (map != null) {
            List<Map.Entry<K,V>> list = new LinkedList<>(map.entrySet());
            list.sort(Comparator.comparing(o -> (o.getValue())));
            Collections.reverse(list);
            Map<K,V> result = new LinkedHashMap<>();
            for (Map.Entry<K, V> entry : list) {
                result.put(entry.getKey(), entry.getValue());
            }
            return result;
        } else {
            return null;
        }
    }
}
