package uk.ac.ebi.pride.archive.web.project.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import uk.ac.ebi.pride.archive.repo.assay.service.AssaySummary;
import uk.ac.ebi.pride.archive.repo.file.service.FileService;
import uk.ac.ebi.pride.archive.repo.file.service.FileSummary;
import uk.ac.ebi.pride.archive.repo.project.service.ProjectService;
import uk.ac.ebi.pride.archive.repo.project.service.ProjectSummary;
import uk.ac.ebi.pride.archive.security.assay.AssaySecureService;
import uk.ac.ebi.pride.archive.security.project.ProjectSecureService;
import uk.ac.ebi.pride.archive.security.protein.ProteinIdentificationSecureSearchService;
import uk.ac.ebi.pride.archive.security.psm.PsmSecureSearchService;
import uk.ac.ebi.pride.archive.web.assay.controller.AssaySummaryAdapter;
import uk.ac.ebi.pride.archive.web.user.model.PublishProject;
import uk.ac.ebi.pride.archive.web.user.validator.PublishProjectValidator;
import uk.ac.ebi.pride.archive.web.util.PageMaker;
import uk.ac.ebi.pride.archive.web.util.PrideSupportEmailSender;
import uk.ac.ebi.pride.archive.web.util.filter.EntityFilter;

import javax.validation.Valid;
import java.util.Arrays;
import java.util.Collection;
import java.util.LinkedList;

/**
 * @author Rui Wang
 * @author Jose A. Dianes
 * @version $Id$
 */
@Controller
public class ProjectSummaryController {

    private static final Logger logger = LoggerFactory.getLogger(ProjectSummaryController.class);

    @Autowired
    private PublishProjectValidator publishProjectValidator;

    @Autowired
    private PrideSupportEmailSender mailSender;

    @Autowired
    @Qualifier("projectServiceImpl")
    private ProjectService projectService;

    @Autowired
    @Qualifier("projectSecureServiceImpl")
    private ProjectSecureService projectSecureService;

    @Autowired
    private AssaySecureService assaySecureService;

    @Autowired
    private FileService fileServiceImpl;

    @Autowired
    private EntityFilter<ProjectSummary> removeProjectDuplicateCvParamFilter;

    @Autowired
    private PageMaker pageMaker;

    @Autowired
    private ProteinIdentificationSecureSearchService proteinIdentificationSearchService;

    @Autowired
    private PsmSecureSearchService psmSecureSearchService;

    @RequestMapping(value = "projects", method = RequestMethod.GET)
    public ModelAndView getProjects() {
        return new ModelAndView("redirect:/simpleSearch?q=&submit=Search");
    }

    @RequestMapping(value = "projects/{accession}", method = RequestMethod.GET)
    public ModelAndView getProjectSummary(@PathVariable String accession,
                                          @PageableDefault(page = 0, value = 10) Pageable page
                                          ) {

//        try {
        // get the project metadata
        ProjectSummary summary = projectSecureService.findByAccession(accession);

        // filter project cv params
        Collection<ProjectSummary> filteredProjectSummaries = removeProjectDuplicateCvParamFilter.filter(Arrays.asList(summary));
        summary = filteredProjectSummaries.iterator().next();

        // get the assay list
        Page<AssaySummary> assaySummaries = assaySecureService.findAllByProjectAccession(accession, page);


        Long indexProteinCount = proteinIdentificationSearchService.countByProjectAccession(accession);
        Long indexPsmCount = psmSecureSearchService.countByProjectAccession(accession);

        return pageMaker.createProjectSummaryPage(new ProjectSummaryAdapter(summary, indexProteinCount, indexPsmCount), assaySummaries);
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

    @InitBinder(value = "publishProject")
    protected void initPublishProjectBinder(WebDataBinder binder) {
        binder.setValidator(publishProjectValidator);
    }

    @RequestMapping(value = "projects/{accession}/publish", method = RequestMethod.GET)
    public ModelAndView beforePublishProject(@PathVariable("accession") String accession) {
        logger.info("Publish request for project " + accession);

        String contactPride = "please contact pride-support [at] ebi.ac.uk.";
        // check if a project exists with the provided accession and if it is still private
        boolean projectIsPublic;
        ProjectSummary project = projectService.findByAccession(accession);
        if (project == null || project.getAccession() == null) {
            // project does not exist in PRIDE, we show an error and provide a link to ProteomeCentral
            String advice;
            // if it's a PX accession we advise to check with ProteomeCentral
            if (accession.contains("PXD")) {
                advice = "You can check the identifier in <a href=\"http://proteomecentral.proteomexchange.org/cgi/GetDataset?ID="
                        + accession +"\">ProteomeCentral</a>, the ProteomeXchange accession authority or " + contactPride;
            } else {
                advice = "If you think this record should exist " + contactPride;
            }
            return pageMaker.createErrorPage("Project not found",
                    "The project accession - " + accession + " - is not recognised by the PRIDE Archive database.",
                    advice);
        } else if (project.isPublicProject()) {
            // project already public, so we show an error page
            return pageMaker.createErrorPage("Already public record",
                    "The project accession - " + accession + " - is already flagged public in the PRIDE Archive database.",
                    "If you cannot get access to this public record " + contactPride);
        } else {
            PublishProject publishProjectRequest = new PublishProject();
            Authentication a = SecurityContextHolder.getContext().getAuthentication();
            if (a.getPrincipal() instanceof  String) {
                publishProjectRequest.setUserName( (String) a.getPrincipal() );
            } else if (a.getPrincipal() instanceof UserDetails) {
                UserDetails currentUser = (UserDetails) a.getPrincipal();
                publishProjectRequest.setUserName( currentUser.getUsername() );
                // add the authorisation status of the user
                try {
                    ProjectSummary aux = projectSecureService.findByAccession(accession);
                    if (aux != null) {
                        publishProjectRequest.setAuthorized(true);
                    }
                } catch (Exception e) {
                    publishProjectRequest.setAuthorized(false);
                }
            } else {
                throw new IllegalStateException("Unrecognised authentidation details!");
            }

            // proceed in the publication request process
            return pageMaker.createBeforePublishProjectPage(publishProjectRequest, accession);
        }
    }

    @RequestMapping(value = "projects/{accession}/publish", method = RequestMethod.POST)
    public ModelAndView publishProject(@ModelAttribute("publishProject")
                                       @Valid PublishProject publishProject,
                                       BindingResult errors,
                                       @PathVariable("accession") String accession) {

        if (!errors.hasErrors()) {
            String userName = publishProject.getUserName() + (publishProject.isAuthorized() ? " (authorized)" : " (NOT authorized)");
            logger.debug("Publish request for project " + accession + " by user: " + userName);

            mailSender.sendPublishProjectEmail(publishProject, accession);
            return pageMaker.createAfterPublishProject(accession);
        } else {
            return pageMaker.createBeforePublishProjectPage(publishProject, accession);
        }
    }


}
