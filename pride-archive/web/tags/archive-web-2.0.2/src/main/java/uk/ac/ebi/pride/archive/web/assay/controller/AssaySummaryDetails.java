package uk.ac.ebi.pride.archive.web.assay.controller;

import uk.ac.ebi.pride.archive.dataprovider.assay.AssayProvider;
import uk.ac.ebi.pride.archive.repo.param.service.CvParamSummary;

import java.util.Collection;

/**
 * @author ntoro
 * @since 12/09/2014 10:00
 */
public interface AssaySummaryDetails extends AssayProvider {

    public Collection<CvParamSummary> getSpecies();
    public Collection<CvParamSummary> getTissues();
    public Collection<CvParamSummary> getCellTypes();
    public Collection<CvParamSummary> getDiseases();
    public Collection<CvParamSummary> getGoTerms();

    public long getIndexProteinCount();
    public long getIndexPsmCount();
}
