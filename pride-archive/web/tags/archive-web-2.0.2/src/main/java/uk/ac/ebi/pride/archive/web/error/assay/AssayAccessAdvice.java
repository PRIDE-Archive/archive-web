package uk.ac.ebi.pride.archive.web.error.assay;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import uk.ac.ebi.pride.archive.web.util.PageMaker;
import uk.ac.ebi.pride.archive.repo.assay.service.AssayAccessException;

/**
 * @author Rui Wang
 * @version $Id$
 */
@ControllerAdvice
public class AssayAccessAdvice {

    private static final Logger logger = LoggerFactory.getLogger(AssayAccessAdvice.class);

    @Autowired
    private MessageSource messageSource;

    @Autowired
    private PageMaker pageMaker;


    @ExceptionHandler(AssayAccessException.class)
    public ModelAndView handleAssayAccessException(AssayAccessException ex) {

        logger.error(ex.getMessage(), ex);

        String errorTitle = messageSource.getMessage("error.assay", null, null);
        String errorMessage = messageSource.getMessage("error.access.assay", null, null);

        String projectAccession = ex.getProjectAccession();
        if (projectAccession != null) {
            errorMessage += " ( Project: " + projectAccession + ")";
        }

        String assayAccession = ex.getAssayAccession();
        if (assayAccession != null) {
            errorMessage += " ( Assay: " + assayAccession + ")";
        }

        return pageMaker.createErrorPage(errorTitle, errorMessage);
    }
}
