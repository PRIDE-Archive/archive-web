package uk.ac.ebi.pride.archive.web.project.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import uk.ac.ebi.pride.archive.security.assay.AssaySecureService;
import uk.ac.ebi.pride.archive.security.project.ProjectSecureService;
import uk.ac.ebi.pride.archive.web.util.PageMaker;
import uk.ac.ebi.pride.archive.web.util.filter.EntityFilter;
import uk.ac.ebi.pride.archive.repo.assay.service.AssaySummary;
import uk.ac.ebi.pride.archive.repo.file.service.FileService;
import uk.ac.ebi.pride.archive.repo.file.service.FileSummary;
import uk.ac.ebi.pride.archive.repo.project.service.ProjectSummary;

import javax.servlet.http.HttpServletRequest;
import java.util.Arrays;
import java.util.Collection;
import java.util.Map;

/**
 * @author Rui Wang
 * @author Jose A. Dianes
 * @version $Id$
 */
@Controller
public class ProjectSummaryController {

    private static final Logger logger = LoggerFactory.getLogger(ProjectSummaryController.class);

    @Autowired
    private ProjectSecureService projectSecureService;

    @Autowired
    private AssaySecureService assaySecureService;

    @Autowired
    private FileService fileServiceImpl;

    @Autowired
    private EntityFilter<ProjectSummary> removeProjectDuplicateCvParamFilter;

    @Autowired
    private PageMaker pageMaker;

    @RequestMapping(value = "projects/{accession}", method = RequestMethod.GET)
    public ModelAndView getProjectSummary(@PathVariable String accession) {

//        try {
            // get the project metadata
            ProjectSummary summary = projectSecureService.findByAccession(accession);

            // filter project cv params
            Collection<ProjectSummary> filteredProjectSummaries = removeProjectDuplicateCvParamFilter.filter(Arrays.asList(summary));
            summary = filteredProjectSummaries.iterator().next();

            // get the assay list
            Collection<AssaySummary> assaySummaries = assaySecureService.findAllByProjectAccession(accession);

            return pageMaker.createProjectSummaryPage(summary, assaySummaries);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return null;
    }

    @RequestMapping(value = "projects/{accession}/files", method = RequestMethod.GET)
    public ModelAndView getProjectFiles(@PathVariable String accession) {

        // get the file list
        Collection<FileSummary> fileList = fileServiceImpl.findAllByProjectAccession(accession);

        // get the project metadata
        ProjectSummary summary = projectSecureService.findByAccession(accession);

        return pageMaker.createProjectFileDownloadPage(fileList, summary);
    }


    @RequestMapping( value = "projects/{accession}/viewer/protein/{proteinID}", method = RequestMethod.GET )
    public ModelAndView viewer(@PathVariable String accession, @PathVariable String proteinID) {
        // perform a security check on the project accession before allowing the redirection to the viewer webapp
        ProjectSummary summary = projectSecureService.findByAccession(accession);
        // if yes, we redirect to the viewer page
        return new ModelAndView("redirect:" + "/viewer#protein=" + proteinID);
    }


}
