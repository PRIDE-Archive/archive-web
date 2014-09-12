package uk.ac.ebi.pride.archive.web.user.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import uk.ac.ebi.pride.archive.web.user.model.PublishProject;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Validator for PublishProject objects
 *
 * @author Rui Wang
 * @version $Id$
 */
@Component
public class PublishProjectValidator implements Validator {

    public static final String PUBMED_FORMAT_ERROR_MESSAGE = "Invalid PubMed ID(s)";
    public static final String DOI_FORMAT_ERROR_MESSAGE = "Invalid DOI ID(s)";
    private static final String AUTHORISATION_REQUIREMENT_MESSAGE = "At least one value has to be provided as justification for the publish request.";

    public static final Pattern PUBMED_PATTERN = Pattern.compile("^\\d+$");

    public static final Pattern DOI_PATTERN = Pattern.compile("^10\\.\\d+/.*$");


    public PublishProjectValidator() {
    }

    @Override
    public boolean supports(Class<?> clazz) {
        return PublishProject.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        PublishProject publishProject = (PublishProject)target;

        String pubmedIds = publishProject.getPubmedId();
        String dois = publishProject.getDoi();
        String refLine = publishProject.getReferenceLine();
        String justification = publishProject.getPublishJustification();

        boolean doisEmpty = (dois == null || dois.trim().isEmpty());
        boolean pubmedIdsEmpty = (pubmedIds == null || pubmedIds.trim().isEmpty());
        boolean refLineEmpty = (refLine == null || refLine.trim().isEmpty());
        boolean justificationEmpty = (justification == null || justification.trim().isEmpty());

        // check pubmed id format
        if (!pubmedIdsEmpty) {
            String[] parts = pubmedIds.trim().split(",");
            for (String part : parts) {
                Matcher matcher = PUBMED_PATTERN.matcher(part.trim());
                if (!matcher.matches()) {
                    errors.rejectValue("pubmedId", "required", null, PUBMED_FORMAT_ERROR_MESSAGE);
                    break;
                }
            }
        }

        // check doi format
        if (!doisEmpty) {
            String[] parts = dois.trim().split(",");
            for (String part : parts) {
                Matcher matcher = DOI_PATTERN.matcher(part.trim());
                if (!matcher.matches()) {
                    errors.rejectValue("doi", "required", null, DOI_FORMAT_ERROR_MESSAGE);
                    break;
                }
            }
        }

        // check authorisation requirements
        if (!publishProject.isAuthorized()) {
            // if the request does not come from an authorized user,
            // we require at least one evidence that the project should be make public
            if (doisEmpty && pubmedIdsEmpty && refLineEmpty && justificationEmpty) {
                errors.rejectValue("authorized", "required", null, AUTHORISATION_REQUIREMENT_MESSAGE);
            }
        }

    }
}
