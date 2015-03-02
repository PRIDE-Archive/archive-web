package uk.ac.ebi.pride.archive.web.error.file;

import java.io.File;

/**
 * @author Jose A. Dianes
 * @author Rui Wang
 * @version $Id$
 */
public class ProjectFileNotFoundException extends Exception {

    private File file;

    public ProjectFileNotFoundException(String s) {
        super(s);
    }

    public ProjectFileNotFoundException(String s, File file) {
        super(s);
        this.file = file;
    }

    public File getFile() {
        return file;
    }
}
