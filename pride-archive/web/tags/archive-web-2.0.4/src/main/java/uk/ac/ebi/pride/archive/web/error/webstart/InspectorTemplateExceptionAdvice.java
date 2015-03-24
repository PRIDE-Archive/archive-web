package uk.ac.ebi.pride.archive.web.error.webstart;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import uk.ac.ebi.pride.archive.web.util.PageMaker;

/**
 * @author Rui Wang
 * @version $Id$
 */
@ControllerAdvice
public class InspectorTemplateExceptionAdvice {
    private static final Logger logger = LoggerFactory.getLogger(InspectorTemplateExceptionAdvice.class);

    @Autowired
    private MessageSource messageSource;

    @Autowired
    private PageMaker pageMaker;

    @ExceptionHandler(InspectorTemplateException.class)
    public ModelAndView handleInspectorTemplateException(InspectorTemplateException ex) {

        logger.error(ex.getMessage(), ex);

        // NOTE: a redirection is necessary due to front-tier template filter

        String errorTitle = messageSource.getMessage("error.file", null, null);
        String errorMessage = ex.getMessage();

        return pageMaker.createRedirectedErrorPage(errorTitle, errorMessage);
    }
}
