package uk.ac.ebi.pride.archive.web.search;

/**
 * @author Jose A. Dianes
 * @version $Id$
 */
public enum SearchFields {
    ACCESSION("id", 3),
    TITLE("project_title", 1),
    DESCRIPTION("project_description", 1),
    PUBMED("pubmed_ids", 3),
    PTM_NAMES("ptm_as_text", 2),
    PTM_ACCESSIONS("ptm_accessions", 3),
    PTM_FACET_NAMES("ptm_facet_names", 4),
    INSTRUMENT_MODELS("instrument_models_as_text", 2),
    INSTRUMENT_FACETS_NAMES("instruments_facet_names", 4),
    QUANTIFICATION_METHODS_NAMES("quantification_methods_as_text", 2),
    QUANTIFICATION_METHODS_ACCESSIONS("quantification_methods_accessions", 3),
    EXPERIMENT_TYPES_NAMES("experiment_types_as_text", 2),
    EXPERIMENT_TYPES_ACCESSIONS("experiment_types_accession", 3),
    SPECIES_ACCESSIONS("species_accessions", 3),
    SPECIES_NAMES("species_as_text", 2),
    SPECIES_ASCENDANTS_AS_TEXT("species_descendants_as_text", 1),
    SPECIES_ASCENDANTS_NAMES("species_descendants_names", 1),
    TISSUE_ACCESSIONS("tissue_accessions", 3),
    TISSUE_NAMES("tissue_as_text", 2),
    TISSUE_ASCENDANTS_AS_TEXT("tissue_descendants_as_text", 1),
    TISSUE_ASCENDANTS_NAMES("tissue_descendants_names", 1),
    DISEASE_ACCESSIONS("disease_accessions", 3),
    DISEASE_NAMES("disease_as_text", 2),
    DISEASE_ASCENDANTS_AS_TEXT("disease_descendants_as_text", 1),
    DISEASE_ASCENDANTS_NAMES("disease_descendants_names", 1),
    CELLTYPE_ACCESSIONS("cell_type_accessions", 3),
    CELLTYPE_NAMES("cell_type_as_text", 2),
    CELLTYPE_ASCENDANTS("cell_type_descendants_as_text", 1),
    SAMPLE_NAMES("sample_as_text", 2),
    SAMPLE_ACCESSIONS("sample_accessions", 3),
    ASSAY_ACCESSIONS("assays_accession", 5),
    PROJECT_TAGS("project_tags", 5),
    PROJECT_TAGS_AS_TEXT("project_tags_as_text", 4),
    PROTEIN_IDENTIFICATIONS("protein_identifications", 25),
    PEPTIDE_SEQUENCES("peptide_sequences", 25),
    SUBMISSION_TYPE("submission_type",5);

    private String indexName;
    private int fieldRelevance;

    private SearchFields(String indexName, int fieldRelevance) {
        this.indexName = indexName;
        this.fieldRelevance = fieldRelevance;
    }

    public String getIndexName() {
        return indexName;
    }

    public int getFieldRelevance() {
        return fieldRelevance;
    }

    public static String buildIndexOrQueryString(String term) {
        String res = "(";

        for (SearchFields searchField: SearchFields.values()) {
            res = res + searchField.getIndexName() + ":*"+term+" OR ";
        }

        // remove last OR
        res = res.substring(0, res.length()-3);
        res = res + ")";

        return res;
    }
}
