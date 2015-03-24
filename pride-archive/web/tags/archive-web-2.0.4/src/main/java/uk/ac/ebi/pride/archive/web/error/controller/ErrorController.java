package uk.ac.ebi.pride.archive.web.error.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import uk.ac.ebi.pride.archive.web.util.PageMaker;

/**
 * @author Jose A. Dianes
 * @author Rui Wang
 * @version $Id$
 */
@Controller
public class ErrorController {
    @Autowired
    private PageMaker pageMaker;

    @RequestMapping(value="error400")
    public ModelAndView handleSolrException() {

        String errorTitle = "Resource error";
        String errorMessage = "Something went wrong. The page you are trying is not available.";

        return pageMaker.createErrorPage(errorTitle, errorMessage);
    }
}
