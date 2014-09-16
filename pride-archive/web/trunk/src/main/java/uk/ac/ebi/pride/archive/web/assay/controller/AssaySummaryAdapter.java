package uk.ac.ebi.pride.archive.web.assay.controller;

import uk.ac.ebi.pride.archive.dataprovider.assay.instrument.InstrumentProvider;
import uk.ac.ebi.pride.archive.dataprovider.assay.software.SoftwareProvider;
import uk.ac.ebi.pride.archive.dataprovider.param.CvParamProvider;
import uk.ac.ebi.pride.archive.dataprovider.param.ParamProvider;
import uk.ac.ebi.pride.archive.dataprovider.person.ContactProvider;
import uk.ac.ebi.pride.archive.repo.assay.service.AssaySummary;
import uk.ac.ebi.pride.archive.repo.param.service.CvParamSummary;

import java.util.Collection;

/**
 * This adapter allows to include the counts for the index in the web
 * @author ntoro
 * @since 12/09/2014 10:05
 */
public class AssaySummaryAdapter implements AssaySummaryDetails {

    private final AssaySummary assaySummary;
    private final Long indexProteinCount;
    private final Long indexPsmCount;

    public AssaySummaryAdapter(AssaySummary assaySummary, Long indexProteinCount, Long indexPsmCount) {
        this.assaySummary = assaySummary;
        this.indexProteinCount = indexProteinCount;
        this.indexPsmCount = indexPsmCount;
    }

    @Override
    public Long getProjectId() {
        return assaySummary.getProjectId();
    }

    @Override
    public String getAccession() {
        return assaySummary.getAccession();
    }

    @Override
    public String getTitle() {
        return assaySummary.getTitle();
    }

    @Override
    public String getShortLabel() {
        return assaySummary.getShortLabel();
    }

    @Override
    public String getExperimentalFactor() {
        return assaySummary.getExperimentalFactor();
    }

    @Override
    public int getProteinCount() {
        return assaySummary.getProteinCount();
    }

    @Override
    public int getPeptideCount() {
        return assaySummary.getPeptideCount();
    }

    @Override
    public int getUniquePeptideCount() {
        return assaySummary.getUniquePeptideCount();
    }

    @Override
    public int getIdentifiedSpectrumCount() {
        return assaySummary.getIdentifiedSpectrumCount();
    }

    @Override
    public int getTotalSpectrumCount() {
        return assaySummary.getTotalSpectrumCount();
    }

    @Override
    public boolean hasMs2Annotation() {
        return assaySummary.hasMs2Annotation();
    }

    @Override
    public boolean hasChromatogram() {
        return assaySummary.hasChromatogram();
    }

    @Override
    public Collection<? extends CvParamProvider> getSamples() {
        return assaySummary.getSamples();
    }

    @Override
    public Collection<? extends InstrumentProvider> getInstruments() {
        return assaySummary.getInstruments();
    }

    @Override
    public Collection<? extends SoftwareProvider> getSoftwares() {
        return assaySummary.getSoftwares();
    }

    @Override
    public Collection<? extends CvParamProvider> getPtms() {
        return assaySummary.getPtms();
    }

    @Override
    public Collection<? extends CvParamProvider> getQuantificationMethods() {
        return assaySummary.getQuantificationMethods();
    }

    @Override
    public Collection<? extends ContactProvider> getContacts() {
        return assaySummary.getContacts();
    }

    @Override
    public Long getId() {
        return assaySummary.getId();
    }

    @Override
    public Collection<? extends ParamProvider> getParams() {
        return assaySummary.getParams();
    }

    @Override
    public Collection<CvParamSummary> getSpecies() {
      return assaySummary.getSpecies();
    }

    @Override
    public Collection<CvParamSummary> getTissues() {
        return assaySummary.getTissues();
    }

    @Override
    public Collection<CvParamSummary> getCellTypes() {
        return assaySummary.getCellTypes();
    }

    @Override
    public Collection<CvParamSummary> getDiseases() {
        return assaySummary.getDiseases();
    }

    @Override
    public Collection<CvParamSummary> getGoTerms() {
        return assaySummary.getGoTerms();
    }

    @Override
    public long getIndexProteinCount() {
        return indexProteinCount;
    }

    @Override
    public long getIndexPsmCount() {
        return indexPsmCount;
    }
}
