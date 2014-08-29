package uk.ac.ebi.pride.archive.web.error.file;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import uk.ac.ebi.pride.archive.web.util.PageMaker;
import uk.ac.ebi.pride.archive.repo.file.service.FileAccessException;

/**
 * @author Rui Wang
 * @version $Id$
 */
@ControllerAdvice
public class ProjectFileAccessAdvice {

    private static final Logger logger = LoggerFactory.getLogger(ProjectFileAccessAdvice.class);

    @Autowired
    private MessageSource messageSource;

    @Autowired
    private PageMaker pageMaker;

    @ExceptionHandler(FileAccessException.class)
    public ModelAndView handleProjectFileAccessException(FileAccessException ex) {

        logger.error(ex.getMessage(), ex);

        String errorTitle = messageSource.getMessage("error.file", null, null);
        String errorMessage = messageSource.getMessage("error.access.file", null, null);

        String projectAccession = ex.getProjectAccession();
        String assayAccession = ex.getAssayAccession();

        if (projectAccession != null) {
            errorMessage += " ( Project: " + projectAccession + ")";
        }

        if (assayAccession != null) {
            errorMessage += " ( Assay: " + assayAccession + ")";
        }

        return pageMaker.createErrorPage(errorTitle, errorMessage);
    }
}
