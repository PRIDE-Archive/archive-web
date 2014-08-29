package uk.ac.ebi.pride.archive.web.error.file;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import uk.ac.ebi.pride.archive.web.util.PageMaker;

import java.io.File;

/**
 * @author Jose A. Dianes
 * @author Rui Wang
 * @version $Id$
 *
 */
@ControllerAdvice
public class ProjectFileNotFoundAdvice {

    private static final Logger logger = LoggerFactory.getLogger(ProjectFileNotFoundAdvice.class);

    @Autowired
    private MessageSource messageSource;

    @Autowired
    private PageMaker pageMaker;

    @ExceptionHandler(ProjectFileNotFoundException.class)
    public ModelAndView handleProjectFileNotFoundException(ProjectFileNotFoundException ex) {

        logger.error(ex.getMessage(), ex);

        // NOTE: a redirection is necessary due to front-tier template filter

        String errorTitle = messageSource.getMessage("error.file", null, null);
        String errorMessage = messageSource.getMessage("error.access.file", null, null);

        File file = ex.getFile();
        if (file != null) {
            errorMessage += " " + file.getName();
        }

        return pageMaker.createRedirectedErrorPage(errorTitle, errorMessage);
    }
}
