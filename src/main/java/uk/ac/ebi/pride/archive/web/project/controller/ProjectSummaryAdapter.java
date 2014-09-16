package uk.ac.ebi.pride.archive.web.project.controller;

import uk.ac.ebi.pride.archive.dataprovider.identification.PeptideSequenceProvider;
import uk.ac.ebi.pride.archive.dataprovider.identification.ProteinIdentificationProvider;
import uk.ac.ebi.pride.archive.dataprovider.param.CvParamProvider;
import uk.ac.ebi.pride.archive.dataprovider.param.ParamProvider;
import uk.ac.ebi.pride.archive.dataprovider.person.ContactProvider;
import uk.ac.ebi.pride.archive.dataprovider.person.UserProvider;
import uk.ac.ebi.pride.archive.dataprovider.project.ProjectTagProvider;
import uk.ac.ebi.pride.archive.dataprovider.project.SubmissionType;
import uk.ac.ebi.pride.archive.dataprovider.reference.ReferenceProvider;
import uk.ac.ebi.pride.archive.repo.param.service.CvParamSummary;
import uk.ac.ebi.pride.archive.repo.project.service.ProjectSummary;
import uk.ac.ebi.pride.archive.repo.project.service.ProjectTagSummary;
import uk.ac.ebi.pride.archive.repo.user.service.UserSummary;

import java.util.Collection;
import java.util.Date;
import java.util.Map;

/**
 * This adapter allows to include the counts for the index in the web
 *
 * @author ntoro
 * @since 12/09/2014 10:05
 */
public class ProjectSummaryAdapter implements ProjectSummaryDetails {

    private final ProjectSummary projectSummary;
    private final Long indexProteinCount;
    private final Long indexPsmCount;


    public ProjectSummaryAdapter(ProjectSummary projectSummary, Long indexProteinCount, Long indexPsmCount) {
        this.projectSummary = projectSummary;
        this.indexProteinCount = indexProteinCount;
        this.indexPsmCount = indexPsmCount;
    }

    @Override
    public String getAccession() {
        return projectSummary.getAccession();
    }

    @Override
    public String getDoi() {
        return projectSummary.getDoi();
    }

    @Override
    public String getTitle() {
        return projectSummary.getTitle();
    }

    @Override
    public String getProjectDescription() {
        return projectSummary.getProjectDescription();
    }

    @Override
    public String getSampleProcessingProtocol() {
        return projectSummary.getSampleProcessingProtocol();
    }

    @Override
    public String getDataProcessingProtocol() {
        return projectSummary.getDataProcessingProtocol();
    }

    @Override
    public String getOtherOmicsLink() {
        return projectSummary.getOtherOmicsLink();
    }

    @Override
    public UserSummary getSubmitter() {
        return projectSummary.getSubmitter();
    }

    @Override
    public Collection<? extends UserProvider> getUsers() {
        return projectSummary.getUsers();
    }

    @Override
    public String getKeywords() {
        return projectSummary.getKeywords();
    }

    @Override
    public int getNumAssays() {
        return projectSummary.getNumAssays();
    }

    @Override
    public String getReanalysis() {
        return projectSummary.getReanalysis();
    }

    @Override
    public Collection<? extends CvParamProvider> getExperimentTypes() {
        return projectSummary.getExperimentTypes();
    }

    @Override
    public SubmissionType getSubmissionType() {
        return projectSummary.getSubmissionType();
    }

    @Override
    public Date getSubmissionDate() {
        return projectSummary.getSubmissionDate();
    }

    @Override
    public Date getPublicationDate() {
        return projectSummary.getPublicationDate();
    }

    @Override
    public Date getUpdateDate() {
        return projectSummary.getUpdateDate();
    }

    @Override
    public Collection<? extends ReferenceProvider> getReferences() {
        return projectSummary.getReferences();
    }

    @Override
    public Collection<? extends ProjectTagProvider> getProjectTags() {
        return projectSummary.getProjectTags();
    }

    @Override
    public Collection<? extends ContactProvider> getLabHeads() {
        return projectSummary.getLabHeads();
    }

    @Override
    public Collection<? extends CvParamProvider> getPtms() {
        return projectSummary.getPtms();
    }

    @Override
    public Collection<? extends CvParamProvider> getSamples() {
        return projectSummary.getSamples();
    }

    @Override
    public Collection<? extends CvParamProvider> getInstruments() {
        return projectSummary.getInstruments();
    }

    @Override
    public Collection<? extends CvParamProvider> getSoftware() {
        return projectSummary.getSoftware();
    }

    @Override
    public Collection<? extends CvParamProvider> getQuantificationMethods() {
        return projectSummary.getQuantificationMethods();
    }

    @Override
    public boolean isPublicProject() {
        return false;
    }

    @Override
    public Long getId() {
        return projectSummary.getId();
    }

    @Override
    public Collection<? extends ParamProvider> getParams() {
        return projectSummary.getParams();
    }

    @Override
    public Map<String, Collection<ProteinIdentificationProvider>> getProteinIdentifications() {
        return projectSummary.getProteinIdentifications();
    }

    @Override
    public Collection<? extends PeptideSequenceProvider> getPeptideSequences() {
        return projectSummary.getPeptideSequences();
    }

    @Override
    public Collection<CvParamSummary> getSpecies() {
        return projectSummary.getSpecies();
    }

    @Override
    public Collection<CvParamSummary> getTissues() {
        return projectSummary.getTissues();
    }

    @Override
    public Collection<CvParamSummary> getCellTypes() {
        return projectSummary.getCellTypes();
    }

    @Override
    public Collection<CvParamSummary> getDiseases() {
        return projectSummary.getDiseases();
    }

    @Override
    public Collection<CvParamSummary> getGoTerms() {
        return projectSummary.getGoTerms();
    }

    @Override
    public Collection<ProjectTagSummary> getParentProjectTags() {
        return projectSummary.getParentProjectTags();
    }

    @Override
    public Collection<ProjectTagSummary> getInternalTags() {
        return projectSummary.getInternalTags();
    }

    @Override
    public Boolean getHighlighted() {
        return projectSummary.getHighlighted();
    }

    @Override
    public Long getIndexProteinCount() {
        return indexProteinCount;
    }

    @Override
    public Long getIndexPsmCount() {
        return indexPsmCount ;
    }

}
