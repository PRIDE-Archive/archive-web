package uk.ac.ebi.pride.archive.web.error.search;

import org.apache.solr.common.SolrException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import uk.ac.ebi.pride.archive.web.util.PageMaker;

/**
 * @author Jose A. Dianes
 * @version $Id$
 *
 * todo: move error message to external file
 */
@ControllerAdvice
public class SolrExceptionAdvice {

    private static final Logger logger = LoggerFactory.getLogger(SolrExceptionAdvice.class);

    @Autowired
    private PageMaker pageMaker;

    @ExceptionHandler(SolrException.class)
    public ModelAndView handleSolrException(SolrException ex) {

        logger.error(ex.getMessage(), ex);

        String errorTitle = "Search error";
        String errorMessage = "Cause: " + ex.getMessage() + ".";
        String errorAdvice = "Try again with a different search criteria";
        return pageMaker.createErrorPage(errorTitle, errorMessage, errorAdvice);
    }
}
