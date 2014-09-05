package uk.ac.ebi.pride.archive.web.search;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

/**
 * @author Jose A. Dianes
 * @version $Id$
 */
public class SolrQueryBuilder {

    private static final int PX_RELEVANCE = 4;

    public static String buildQueryFields() {
        return ""
                + SearchFields.TITLE.getIndexName() + "^" + SearchFields.TITLE.getFieldRelevance() + " "
                + SearchFields.DESCRIPTION.getIndexName() + "^" + SearchFields.DESCRIPTION.getFieldRelevance() + " "
                + SearchFields.ACCESSION.getIndexName() + "^" + SearchFields.ACCESSION.getFieldRelevance() + " "
                + SearchFields.PUBMED.getIndexName() + "^" + SearchFields.PUBMED.getFieldRelevance() + " "
                + SearchFields.SPECIES_NAMES.getIndexName() + "^" + SearchFields.SPECIES_NAMES.getFieldRelevance() + " "
                + SearchFields.SPECIES_ACCESSIONS.getIndexName() + "^" + SearchFields.SPECIES_ACCESSIONS.getFieldRelevance() + " "
                + SearchFields.SPECIES_ASCENDANTS_AS_TEXT.getIndexName() + "^" + SearchFields.SPECIES_ASCENDANTS_AS_TEXT.getFieldRelevance() + " "
                + SearchFields.TISSUE_NAMES.getIndexName() + "^" + SearchFields.TISSUE_NAMES.getFieldRelevance() + " "
                + SearchFields.TISSUE_ACCESSIONS.getIndexName() + "^" + SearchFields.TISSUE_ACCESSIONS.getFieldRelevance() + " "
                + SearchFields.TISSUE_ASCENDANTS_AS_TEXT.getIndexName() + "^" + SearchFields.TISSUE_ASCENDANTS_AS_TEXT.getFieldRelevance() + " "
                + SearchFields.DISEASE_NAMES.getIndexName() + "^" + SearchFields.DISEASE_NAMES.getFieldRelevance() + " "
                + SearchFields.DISEASE_ACCESSIONS.getIndexName() + "^" + SearchFields.DISEASE_ACCESSIONS.getFieldRelevance() + " "
                + SearchFields.DISEASE_ASCENDANTS_AS_TEXT.getIndexName() + "^" + SearchFields.DISEASE_ASCENDANTS_AS_TEXT.getFieldRelevance() + " "
                + SearchFields.CELLTYPE_NAMES.getIndexName() + "^" + SearchFields.CELLTYPE_NAMES.getFieldRelevance() + " "
                + SearchFields.CELLTYPE_ACCESSIONS.getIndexName() + "^" + SearchFields.CELLTYPE_ACCESSIONS.getFieldRelevance() + " "
                + SearchFields.CELLTYPE_ASCENDANTS.getIndexName() + "^" + SearchFields.CELLTYPE_ASCENDANTS.getFieldRelevance() + " "
                + SearchFields.SAMPLE_NAMES.getIndexName() + "^" + SearchFields.SAMPLE_NAMES.getFieldRelevance() + " "
                + SearchFields.PTM_NAMES.getIndexName() + "^" + SearchFields.PTM_NAMES.getFieldRelevance() + " "
                + SearchFields.PTM_ACCESSIONS.getIndexName() + "^" + SearchFields.PTM_ACCESSIONS.getFieldRelevance() + " "
                + SearchFields.PTM_FACET_NAMES.getIndexName() + "^" + SearchFields.PTM_FACET_NAMES.getFieldRelevance() + " "
                + SearchFields.INSTRUMENT_MODELS.getIndexName() + "^" + SearchFields.INSTRUMENT_MODELS.getFieldRelevance() + " "
                + SearchFields.INSTRUMENT_FACETS_NAMES.getIndexName() + "^" + SearchFields.INSTRUMENT_FACETS_NAMES.getFieldRelevance() + " "
                + SearchFields.QUANTIFICATION_METHODS_NAMES.getIndexName() + "^" + SearchFields.QUANTIFICATION_METHODS_NAMES.getFieldRelevance() + " "
                + SearchFields.QUANTIFICATION_METHODS_ACCESSIONS.getIndexName() + "^" + SearchFields.QUANTIFICATION_METHODS_ACCESSIONS.getFieldRelevance() + " "
                + SearchFields.EXPERIMENT_TYPES_NAMES.getIndexName() + "^" + SearchFields.EXPERIMENT_TYPES_NAMES.getFieldRelevance() + " "
                + SearchFields.EXPERIMENT_TYPES_ACCESSIONS.getIndexName() + "^" + SearchFields.EXPERIMENT_TYPES_ACCESSIONS.getFieldRelevance() + " "
                + SearchFields.ASSAY_ACCESSIONS.getIndexName() + "^" + SearchFields.ASSAY_ACCESSIONS.getFieldRelevance() + " "
                + SearchFields.PROJECT_TAGS.getIndexName() + "^" + SearchFields.PROJECT_TAGS.getFieldRelevance() + " "
                + SearchFields.PROJECT_TAGS_AS_TEXT.getIndexName() + "^" + SearchFields.PROJECT_TAGS_AS_TEXT.getFieldRelevance() + " "
                + SearchFields.PROTEIN_IDENTIFICATIONS.getIndexName() + "^" + SearchFields.PROTEIN_IDENTIFICATIONS.getFieldRelevance() + " "
                + SearchFields.PEPTIDE_SEQUENCES.getIndexName() + "^" + SearchFields.PEPTIDE_SEQUENCES.getFieldRelevance() + " "
                + SearchFields.SUBMISSION_TYPE.getIndexName() + "^" + SearchFields.SUBMISSION_TYPE.getFieldRelevance()
        ;
    }

    public static String buildQueryTerm(String term) {
//        if ("".equals(term))
//            return "*";
//        else
//            return term;
        if ("".equals(term))
            return "id:PR* id:PX*^"+PX_RELEVANCE; // PX submissions are more relevant
        else
//            return term;
            return "(id:PR* id:PX*^"+PX_RELEVANCE + ") AND (" + term +")"; // PX submissions are more relevant
    }

    public static String[] buildQueryFilters(List<String> ptmsFilterList,
                                             List<String> speciesFilterList,
                                             List<String> tissueFilterList,
                                             List<String> diseaseFilterList,
                                             List<String> titleFilterList,
                                             List<String> instrumentFilterList,
                                             List<String> quantificationFilterList,
                                             List<String> experimentTypeFilterList,
                                             List<String> projectTagFilterList,
                                             List<String> submissionTypeFilterList) {

        LinkedList<String> queryFilterList = new LinkedList<String>();

        if (ptmsFilterList!=null) {
            Iterator<String> filterIterator = ptmsFilterList.iterator();
            while (filterIterator.hasNext()) {
                String filter = filterIterator.next();
                queryFilterList.add(SearchFields.PTM_FACET_NAMES.getIndexName()+":\""+filter
//                        +"\" + OR "+ SearchFields.PTM_ACCESSIONS.getIndexName()+":\""+filter
//                        +"\" + OR "+ SearchFields.PTM_NAMES.getIndexName()+":\""+filter
                        +"\"");
            }

        }

        if (speciesFilterList!=null) {
            Iterator<String> filterIterator = speciesFilterList.iterator();
            while (filterIterator.hasNext()) {
                String filter = filterIterator.next();
                queryFilterList.add(
                        SearchFields.SPECIES_NAMES.getIndexName()+":\""+filter+"\" OR "
                                + SearchFields.SPECIES_ACCESSIONS.getIndexName()+":\""+filter+"\" OR "
                                + SearchFields.SPECIES_ASCENDANTS_NAMES.getIndexName()+":\""+filter+"\""
                );
            }

        }

        if (tissueFilterList!=null) {
            Iterator<String> filterIterator = tissueFilterList.iterator();
            while (filterIterator.hasNext()) {
                String filter = filterIterator.next();
                queryFilterList.add(
                        SearchFields.TISSUE_NAMES.getIndexName()+":\""+filter+"\" OR "
                        + SearchFields.TISSUE_ACCESSIONS.getIndexName()+":\""+filter+"\" OR "
                        + SearchFields.TISSUE_ASCENDANTS_NAMES.getIndexName()+":\""+filter+"\""
                );
            }

        }

        if (diseaseFilterList!=null) {
            Iterator<String> filterIterator = diseaseFilterList.iterator();
            while (filterIterator.hasNext()) {
                String filter = filterIterator.next();
                queryFilterList.add(
                        SearchFields.DISEASE_NAMES.getIndexName()+":\""+filter+"\" OR "
                                + SearchFields.DISEASE_ACCESSIONS.getIndexName()+":\""+filter+"\" OR "
                                + SearchFields.DISEASE_ASCENDANTS_NAMES.getIndexName()+":\""+filter+"\""
                );
            }

        }

        if (titleFilterList!=null) {
            Iterator<String> filterIterator = titleFilterList.iterator();
            while (filterIterator.hasNext()) {
                String filter = filterIterator.next();
                queryFilterList.add(SearchFields.TITLE.getIndexName() +":\""+filter+"\"");
            }

        }

        if (instrumentFilterList!=null) {
            Iterator<String> filterIterator = instrumentFilterList.iterator();
            while (filterIterator.hasNext()) {
                String filter = filterIterator.next();
                queryFilterList.add(SearchFields.INSTRUMENT_FACETS_NAMES.getIndexName() +":\""+filter
//                        +"\" + OR "+ SearchFields.INSTRUMENT_MODELS.getIndexName()+":\""+filter
                        +"\"");
            }

        }

        if (quantificationFilterList!=null) {
            Iterator<String> filterIterator = quantificationFilterList.iterator();
            while (filterIterator.hasNext()) {
                String filter = filterIterator.next();
                queryFilterList.add(SearchFields.QUANTIFICATION_METHODS_NAMES.getIndexName()+":\""+filter+"\" OR "+ SearchFields.QUANTIFICATION_METHODS_ACCESSIONS.getIndexName()+":\""+filter+"\"");
            }

        }

        if (experimentTypeFilterList!=null) {
            Iterator<String> filterIterator = experimentTypeFilterList.iterator();
            while (filterIterator.hasNext()) {
                String filter = filterIterator.next();
                queryFilterList.add(SearchFields.EXPERIMENT_TYPES_NAMES.getIndexName()+":\""+filter+"\" OR "+ SearchFields.EXPERIMENT_TYPES_ACCESSIONS.getIndexName()+":\""+filter+"\"");
            }

        }

        if (projectTagFilterList!=null) {
            Iterator<String> filterIterator = projectTagFilterList.iterator();
            while (filterIterator.hasNext()) {
                String filter = filterIterator.next();
                queryFilterList.add(SearchFields.PROJECT_TAGS.getIndexName()+":\""+filter+"\"");
            }
        }

        if (submissionTypeFilterList!=null) {
            Iterator<String> filterIterator = submissionTypeFilterList.iterator();
            while (filterIterator.hasNext()) {
                String filter = filterIterator.next();
                queryFilterList.add(SearchFields.SUBMISSION_TYPE.getIndexName()+":\""+filter+"\"");
            }
        }

        return queryFilterList.toArray(new String[queryFilterList.size()]);
    }
}
