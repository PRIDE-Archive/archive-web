package uk.ac.ebi.pride.archive.web.viewer.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import uk.ac.ebi.pride.archive.repo.project.service.ProjectSummary;
import uk.ac.ebi.pride.archive.security.project.ProjectSecureService;
import uk.ac.ebi.pride.archive.web.util.PageMaker;


/**
 * @author Florian Reisinger
 * @since 2.0.0
 */
@Controller
public class ViewerController {

    @Autowired
    private PageMaker pageMaker;

    @RequestMapping( value = "/viewer", method = RequestMethod.GET )
    public ModelAndView viewer() {
        return pageMaker.createViewerPage();
    }

}
