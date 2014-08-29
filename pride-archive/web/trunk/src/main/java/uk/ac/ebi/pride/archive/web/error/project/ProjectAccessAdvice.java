package uk.ac.ebi.pride.archive.web.error.project;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import uk.ac.ebi.pride.archive.web.util.PageMaker;
import uk.ac.ebi.pride.archive.repo.project.service.ProjectAccessException;

/**
 * @author Jose A. Dianes
 * @author Rui Wang
 * @version $Id$
 *
 * todo: send an email for pride support
 */
@ControllerAdvice
public class ProjectAccessAdvice {

    private static final Logger logger = LoggerFactory.getLogger(ProjectAccessAdvice.class);

    @Autowired
    private MessageSource messageSource;

    @Autowired
    private PageMaker pageMaker;


    @ExceptionHandler(ProjectAccessException.class)
    public ModelAndView handleProjectAccessException(ProjectAccessException ex) {

        logger.error(ex.getMessage(), ex);

        String errorTitle = messageSource.getMessage("error.project", null, null);
        String errorMessage = messageSource.getMessage("error.access.project", null, null);

        String projectAccession = ex.getProjectAccession();
        if (projectAccession != null) {
            errorMessage += " ( Project: " + projectAccession + ")";
        }


        return pageMaker.createErrorPage(errorTitle, errorMessage);
    }
}
