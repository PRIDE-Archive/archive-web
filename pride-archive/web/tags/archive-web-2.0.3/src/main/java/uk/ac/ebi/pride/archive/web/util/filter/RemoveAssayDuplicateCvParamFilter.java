package uk.ac.ebi.pride.archive.web.util.filter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import uk.ac.ebi.pride.archive.repo.assay.service.AssaySummary;
import uk.ac.ebi.pride.archive.repo.param.service.CvParamSummary;

import java.util.ArrayList;
import java.util.Collection;

/**
 * Filter and remove duplicated cv params from assay
 *
 * @author Rui Wang
 * @version $Id$
 */
@Component
public class RemoveAssayDuplicateCvParamFilter implements EntityFilter<AssaySummary>{

    private RemoveDuplicateNameCvParamFilter removeDuplicateNameCvParamFilter;

    @Autowired
    public RemoveAssayDuplicateCvParamFilter(RemoveDuplicateNameCvParamFilter removeDuplicateNameCvParamFilter) {
        this.removeDuplicateNameCvParamFilter = removeDuplicateNameCvParamFilter;
    }

    @Override
    public Collection<AssaySummary> filter(Collection<AssaySummary> entities) {
        Collection<AssaySummary> assaySummaries = new ArrayList<AssaySummary>();

        for (AssaySummary entity : entities) {
            AssaySummary filteredEntity = filterIndividualAssay(entity);
            assaySummaries.add(filteredEntity);
        }

        return assaySummaries;
    }

    private AssaySummary filterIndividualAssay(AssaySummary assaySummary) {

        // samples
        Collection<CvParamSummary> filteredSamples = removeDuplicateNameCvParamFilter.filter(assaySummary.getSamples());
        assaySummary.setSamples(filteredSamples);

        // quantifications
        Collection<CvParamSummary> filteredQuantifications = removeDuplicateNameCvParamFilter.filter(assaySummary.getQuantificationMethods());
        assaySummary.setQuantificationMethods(filteredQuantifications);

        // modifications
        Collection<CvParamSummary> filteredModifications = removeDuplicateNameCvParamFilter.filter(assaySummary.getPtms());
        assaySummary.setPtms(filteredModifications);

        return assaySummary;
    }


}
