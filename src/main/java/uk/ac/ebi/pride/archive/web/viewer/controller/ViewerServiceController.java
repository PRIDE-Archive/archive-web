package uk.ac.ebi.pride.archive.web.viewer.controller;

import javassist.NotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import uk.ac.ebi.pride.archive.security.assay.AssaySecureService;
import uk.ac.ebi.pride.archive.web.service.controller.viewer.InvalidDataException;
import uk.ac.ebi.pride.archive.web.service.controller.viewer.ViewerControllerImpl;
import uk.ac.ebi.pride.archive.web.service.model.viewer.PeptideList;
import uk.ac.ebi.pride.archive.web.service.model.viewer.Protein;
import uk.ac.ebi.pride.archive.web.service.model.viewer.Spectrum;
import uk.ac.ebi.pride.web.util.exception.RestError;

import java.security.Principal;

/**
 * @author Florian Reisinger
 * @since 2.0.2
 */
@Controller
@RequestMapping(value = "/viewer/service")
public class ViewerServiceController {



    @Autowired
    private AssaySecureService assaySecureService;
    @Autowired
    ViewerControllerImpl viewerControllerImpl;



    @RequestMapping(value = "/protein/{proteinID:.+}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseStatus(HttpStatus.OK) // 200
    public
    @ResponseBody
    Protein getProteinData(@PathVariable("proteinID") String proteinID) throws InvalidDataException, NotFoundException {
        System.out.println("Protein request for ID: " + proteinID);

        // extract the assay accession from the requested ID in order to perform a security check
        String assayAccession = ViewerControllerImpl.getAssayAccessionFromProteinID(proteinID);
        // do the security check on the assay accession (since there is no check on protein level)
        assaySecureService.findByAccession(assayAccession);

        // if we did not run into a security issue we can continue retrieving the results
        Protein result = viewerControllerImpl.getProteinData(proteinID);
        if (result == null) {
            throw new NotFoundException("No protein record found for id: " + proteinID);
        }
        return result;
    }


    @RequestMapping(value = "/peptide/{peptideID}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseStatus(HttpStatus.OK) // 200
    public
    @ResponseBody
    PeptideList getPSMData(@PathVariable("peptideID") String peptideID) throws InvalidDataException, NotFoundException {
        System.out.println("Peptide request for ID: " + peptideID);
        // retrieve the assay accession in order to perform a security check
        String assayAccession = ViewerControllerImpl.getAssayAccessionFromPsmID(peptideID);
        // do the security check on the assay accession
        assaySecureService.findByAccession(assayAccession);

        // if we did not run into a security issue we can continue retrieving the results
        PeptideList result = viewerControllerImpl.getPSMData(peptideID);
        if (result == null) {
            throw new NotFoundException ("No PSM records found for peptide with id: " + peptideID);
        }
        return result;
    }

    @RequestMapping(value = "/spectrum/{variationID}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseStatus(HttpStatus.OK) // 200
    public
    @ResponseBody
    Spectrum getSpectrumData(@PathVariable("variationID") String variationID) throws InvalidDataException, NotFoundException {
        System.out.println("Spectrum request for variation with ID: " + variationID);
        // retrieve the assay accession in order to perform a security check
        String assayAccession = ViewerControllerImpl.getAssayAccessionFromVariationID(variationID);
        // do the security check on the assay accession
        assaySecureService.findByAccession(assayAccession);

        // if we did not run into a security issue we can continue retrieving the results
        // (an exception should have been thrown at this point instead)
        Spectrum result = viewerControllerImpl.getSpectrumData(variationID);
        if (result == null) {
            throw new NotFoundException ("No Spectrum record found for variation with id: " + variationID);
        }
        System.out.println("Returning spectrum with Id= " + result.getId());
        return result;

    }

    // Controller local exception handling to overwrite the default behaviour of the archive web
    // (return a RestError with appropriate error code instead of redirecting to the login page)
    @ResponseStatus(value = HttpStatus.UNAUTHORIZED)
    @ExceptionHandler(AccessDeniedException.class)
    private
    @ResponseBody
    RestError handleAccessDeniedException(AccessDeniedException ex, Principal principal) {
        // distinguish two cases:
        //      request for private data, but no user credentials present
        //      user credentials present, but access forbidden for user
        if (principal == null) {
            return new RestError(HttpStatus.UNAUTHORIZED,
                    HttpStatus.UNAUTHORIZED.value(),
                    "Private data! Please log in.",
                    "Authorisation required.",
                    "http://www.ebi.ac.uk/pride/archive/login",
                    null);
        } else {
            return new RestError(HttpStatus.FORBIDDEN,
                    HttpStatus.FORBIDDEN.value(),
                    "Access denied for user " + principal.getName(),
                    null);
        }
    }

    @ResponseStatus(value = HttpStatus.UNPROCESSABLE_ENTITY)
    @ExceptionHandler(InvalidDataException.class)
    private
    @ResponseBody
    RestError handleIllegalArgumentException(InvalidDataException ex) {
        return new RestError(HttpStatus.UNPROCESSABLE_ENTITY,
                HttpStatus.UNPROCESSABLE_ENTITY.value(),
                "Invalid data." + ex.getMessage(),
                null);
    }

    @ResponseStatus(value = HttpStatus.NOT_FOUND)
    @ExceptionHandler(NotFoundException.class)
    private
    @ResponseBody
    RestError handleNotFoundException(NotFoundException ex) {
        return new RestError(HttpStatus.NOT_FOUND,
                HttpStatus.NOT_FOUND.value(),
                "Not found: " + ex.getMessage(),
                "Repository search returned no result.",
                "If this record should exist, please contact pride-support@ebi.ac.uk",
                null);
    }

    @ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
    @ExceptionHandler(Exception.class)
    private
    @ResponseBody
    RestError handleAnyOtherException(Exception ex) {
        return new RestError(HttpStatus.INTERNAL_SERVER_ERROR,
                HttpStatus.INTERNAL_SERVER_ERROR.value(),
                "Internal Server Error: " + ex.getMessage(),
                "Please report to pride-support@ebi.ac.uk",
                null,
                null);
    }

}
