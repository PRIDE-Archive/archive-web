package uk.ac.ebi.pride.archive.web.user.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import uk.ac.ebi.pride.archive.web.user.model.PublishProject;
import uk.ac.ebi.pride.archive.web.user.validator.PublishProjectValidator;
import uk.ac.ebi.pride.archive.web.util.PrideSupportEmailSender;

import javax.validation.Valid;

/**
 * Controller to make project public
 *
 * @author Rui Wang
 * @version $Id$
 */
@Controller
@RequestMapping("/users/projects/{projectAccession}/publish")
public class UserPublishProjectController extends AbstractUserProfileController{
    private static final Logger logger = LoggerFactory.getLogger(UserPublishProjectController.class);

    @Autowired
    private PublishProjectValidator publishProjectValidator;

    @Autowired
    private PrideSupportEmailSender mailSender;

    @Autowired
    private String publishProjectEmailTemplate;

    @InitBinder(value = "publishProject")
    protected void initPublishProjectBinder(WebDataBinder binder) {
        binder.setValidator(publishProjectValidator);
    }

    @RequestMapping(method = RequestMethod.GET)
    @PreAuthorize("hasPermission(#projectAccession, 'isAccessibleProjectAccession') and hasRole('ADMINISTRATOR', 'SUBMITTER')")
    public ModelAndView beforePublishProject(@PathVariable("projectAccession") String projectAccession) {

        return pageMaker.createBeforePublishProjectPage(new PublishProject(), projectAccession);
    }

    @RequestMapping(method = RequestMethod.POST)
    @PreAuthorize("hasPermission(#projectAccession, 'isAccessibleProjectAccession') and hasRole('ADMINISTRATOR', 'SUBMITTER')")
    public ModelAndView publishProject(@ModelAttribute("publishProject") @Valid PublishProject publishProject, BindingResult errors, @PathVariable("projectAccession") String projectAccession) {

        if (!errors.hasErrors()) {
            mailSender.sendPublishProjectEmail(publishProject, projectAccession, publishProjectEmailTemplate);
            return pageMaker.createAfterPublishProject(projectAccession);
        } else {
            return pageMaker.createBeforePublishProjectPage(publishProject, projectAccession);
        }
    }
}
