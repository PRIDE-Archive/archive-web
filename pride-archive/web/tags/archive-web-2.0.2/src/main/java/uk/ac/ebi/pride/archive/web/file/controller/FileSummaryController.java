package uk.ac.ebi.pride.archive.web.file.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;
import uk.ac.ebi.pride.archive.repo.file.service.FileAccessException;
import uk.ac.ebi.pride.archive.repo.file.service.FileSummary;
import uk.ac.ebi.pride.archive.repo.project.service.ProjectSummary;
import uk.ac.ebi.pride.archive.security.file.FileSecureService;
import uk.ac.ebi.pride.archive.security.project.ProjectSecureService;
import uk.ac.ebi.pride.archive.utils.config.FilePathBuilder;
import uk.ac.ebi.pride.archive.utils.streaming.FileUtils;
import uk.ac.ebi.pride.archive.web.error.file.ProjectFileNotFoundException;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

/**
 * @author Rui Wang
 * @author Jose A. Dianes
 * @version $Id$
 */
@Controller
public class FileSummaryController {

    private static final Logger logger = LoggerFactory.getLogger(FileSummaryController.class);

    @Autowired
    private FileSecureService fileSecureService;

    @Autowired
    private ProjectSecureService projectSecureService;

    @Autowired
    private FileUtils fileUtils;

    @Autowired
    private FilePathBuilder filePathBuilder;

    @Value("#{fileConfig['file.location.prefix']}")
    private String fileLocationPrefix;


    @RequestMapping(value = "/files/{fileId}", method = RequestMethod.GET)
    @ResponseStatus(HttpStatus.OK)
    public void file(@PathVariable Long fileId,
                     HttpServletResponse response) throws ProjectFileNotFoundException {

        FileSummary fileSummary = fileSecureService.findById(fileId);

        try {
            streamFile(response, fileSummary);
        } catch (FileNotFoundException ex) {
            logger.error(ex.getMessage(), ex);
            throw new ProjectFileNotFoundException(ex.getMessage(), new File(fileSummary.getFileName()));
        } catch (IOException e) {
            String msg = "Failed to read the file from PRIDE";
            logger.error(msg, e);
            throw new FileAccessException(msg, e);
        }
    }

    private void streamFile(HttpServletResponse response, FileSummary fileSummary) throws IOException {
        // streaming the file to client
        ProjectSummary projectSummary = projectSecureService.findById(fileSummary.getProjectId());

        String filePath = filePathBuilder.buildPublicationFilePath(fileLocationPrefix, projectSummary, fileSummary);

        File fileToStream = fileUtils.findFileToStream(filePath);
        try {
            fileUtils.streamFile(response, fileToStream);
        } catch (Exception e) {
            logger.error("Exception streaming file: " + filePath);
            logger.trace("File streaming exception: ", e);
        }
    }
}
