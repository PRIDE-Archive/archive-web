package uk.ac.ebi.pride.archive.web.util.filter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import uk.ac.ebi.pride.archive.repo.param.service.CvParamSummary;
import uk.ac.ebi.pride.archive.repo.project.service.ProjectSummary;

import java.util.ArrayList;
import java.util.Collection;

/**
 * Filter and remove duplicated cv params from project
 *
 * @author Rui Wang
 * @version $Id$
 */
@Component
public class RemoveProjectDuplicateCvParamFilter implements EntityFilter<ProjectSummary>{

    private EntityFilter<CvParamSummary> removeDuplicateNameCvParamFilter;

    @Autowired
    public RemoveProjectDuplicateCvParamFilter(EntityFilter<CvParamSummary> removeDuplicateNameCvParamFilter) {
        this.removeDuplicateNameCvParamFilter = removeDuplicateNameCvParamFilter;
    }

    @Override
    public Collection<ProjectSummary> filter(Collection<ProjectSummary> entities) {
        Collection<ProjectSummary> projectSummaries = new ArrayList<ProjectSummary>();

        for (ProjectSummary entity : entities) {
            ProjectSummary filteredEntity = filterIndividualProjectSummary(entity);
            projectSummaries.add(filteredEntity);
        }

        return projectSummaries;
    }

    private ProjectSummary filterIndividualProjectSummary(ProjectSummary projectSummary) {
        // instruments
        Collection<CvParamSummary> filteredInstruments = removeDuplicateNameCvParamFilter.filter(projectSummary.getInstruments());
        projectSummary.setInstruments(filteredInstruments);

        // modification
        Collection<CvParamSummary> filteredModifications = removeDuplicateNameCvParamFilter.filter(projectSummary.getPtms());
        projectSummary.setPtms(filteredModifications);

        // samples
        Collection<CvParamSummary> filteredSamples = removeDuplicateNameCvParamFilter.filter(projectSummary.getSamples());
        projectSummary.setSamples(filteredSamples);

        // quatification
        Collection<CvParamSummary> filteredQuantifications = removeDuplicateNameCvParamFilter.filter(projectSummary.getQuantificationMethods());
        projectSummary.setQuantificationMethods(filteredQuantifications);

        return projectSummary;
    }
}
