package uk.ac.ebi.pride.archive.web.project.controller;

import uk.ac.ebi.pride.archive.dataprovider.project.ProjectProvider;
import uk.ac.ebi.pride.archive.repo.param.service.CvParamSummary;
import uk.ac.ebi.pride.archive.repo.project.service.ProjectTagSummary;

import java.util.Collection;

/**
 * @author ntoro
 * @since 12/09/2014 10:00
 */
public interface ProjectSummaryDetails extends ProjectProvider {

    public Collection<CvParamSummary> getSpecies();
    public Collection<CvParamSummary> getTissues();
    public Collection<CvParamSummary> getCellTypes();
    public Collection<CvParamSummary> getDiseases();
    public Collection<CvParamSummary> getGoTerms();

    public Collection<ProjectTagSummary> getParentProjectTags() ;
    public Collection<ProjectTagSummary> getInternalTags();
    public Boolean getHighlighted() ;

    public Long getIndexProteinCount();
    public Long getIndexPsmCount();

}
