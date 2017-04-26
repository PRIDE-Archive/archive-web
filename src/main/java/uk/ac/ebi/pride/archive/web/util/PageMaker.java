package uk.ac.ebi.pride.archive.web.util;

import org.springframework.data.domain.Page;
import org.springframework.social.twitter.api.Tweet;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import uk.ac.ebi.pride.archive.dataprovider.file.ProjectFileSource;
import uk.ac.ebi.pride.archive.dataprovider.file.ProjectFileType;
import uk.ac.ebi.pride.archive.repo.assay.service.AssaySummary;
import uk.ac.ebi.pride.archive.repo.file.service.FileSummary;
import uk.ac.ebi.pride.archive.repo.project.service.ProjectSummary;
import uk.ac.ebi.pride.archive.repo.statistics.service.StatisticsSummary;
import uk.ac.ebi.pride.archive.repo.user.service.UserSummary;
import uk.ac.ebi.pride.archive.web.assay.controller.AssaySummaryAdapter;
import uk.ac.ebi.pride.archive.web.feedback.model.Feedback;
import uk.ac.ebi.pride.archive.web.model.QualityAwarePsm;
import uk.ac.ebi.pride.archive.web.project.controller.ProjectSummaryAdapter;
import uk.ac.ebi.pride.archive.web.user.model.ChangePassword;
import uk.ac.ebi.pride.archive.web.user.model.PublishProject;
import uk.ac.ebi.pride.archive.web.user.model.UpdateUserSummary;
import uk.ac.ebi.pride.proteinidentificationindex.mongo.search.model.MongoProteinIdentification;
import uk.ac.ebi.pride.proteinidentificationindex.search.model.ProteinIdentification;
import uk.ac.ebi.pride.psmindex.mongo.search.model.MongoPsm;
import uk.ac.ebi.pride.psmindex.search.model.Psm;

import javax.validation.constraints.NotNull;
import java.util.*;

/**
 * Page maker is responsible for making all the web pages
 *
 * @author Rui Wang
 * @version $Id$
 */
@Component
public class PageMaker {

  public PageMaker() {
  }

  public ModelAndView createWelcomePage(StatisticsSummary statisticsSummary, Collection<Tweet> tweets) {
    ModelAndView modelAndView = new ModelAndView();
    modelAndView.addObject("statistics", statisticsSummary);
    modelAndView.addObject("tweets", tweets);
    modelAndView.setViewName("welcome");
    return modelAndView;
  }

  public ModelAndView createProjectSummaryPage(ProjectSummaryAdapter projectSummary, Page<AssaySummary> page) {
    ModelAndView modelAndView = new ModelAndView();
    modelAndView.addObject("projectSummary", projectSummary);
    if (page != null && page.getContent() != null) {
      modelAndView.addObject("page", page);
    }
    modelAndView.setViewName("projectSummary");
    return modelAndView;
  }

  public ModelAndView createAssaySummary(AssaySummaryAdapter assaySummary, String projectAccession) {
    ModelAndView modelAndView = new ModelAndView();
    if (projectAccession != null) {
      modelAndView.addObject("projectAccession", projectAccession);
    }
    modelAndView.addObject("assaySummary", assaySummary);
    modelAndView.setViewName("assaySummary");
    return modelAndView;
  }

  public ModelAndView createProjectFileDownloadPage(Collection<FileSummary> fileList, ProjectSummary projectSummary) {
    ModelAndView modelAndView = new ModelAndView();
    modelAndView.addObject("projectSummary", projectSummary);
    buildFileSummaries(modelAndView, fileList); // now we split the file list into types and sort them by file name
    modelAndView.setViewName("projectFileDownload");
    return modelAndView;
  }

  public ModelAndView createAssayFileDownloadPage(Collection<FileSummary> fileList, String assayAccession, ProjectSummary projectSummary) {
    ModelAndView modelAndView = new ModelAndView();
    if (projectSummary != null) {
      modelAndView.addObject("projectSummary", projectSummary);
      modelAndView.addObject("projectAccession", projectSummary.getAccession());
      modelAndView.addObject("projectPublicationDate", projectSummary.getPublicationDate());
    }
    modelAndView.addObject("assayAccession", assayAccession);
    buildFileSummaries(modelAndView, fileList); // now we split the file list into types and sort them by file name
    modelAndView.setViewName("assayFileDownload");
    return modelAndView;
  }

  private void buildFileSummaries(ModelAndView modelAndView, Collection<FileSummary> fileList){
    // now we split the file list into types and sort them by file name
    HashMap<String, List<FileSummary>> fileSummariesByType = new HashMap<>();
    HashMap<String, List<FileSummary>> fileSummariesBySource = new HashMap<>();
    for (ProjectFileType theType: ProjectFileType.values()) {
      fileSummariesByType.put(theType.name(), new LinkedList<>());
    }
    for (ProjectFileType theType: ProjectFileType.values()) {
      fileSummariesBySource.put(theType.name(), new LinkedList<>());
    }
    for (FileSummary theFileSummary: fileList){
      if(!theFileSummary.getFileSource().equals(ProjectFileSource.GENERATED)){
        fileSummariesByType.get(theFileSummary.getFileType().name()).add(theFileSummary);
      } else {
        fileSummariesBySource.get(theFileSummary.getFileType().name()).add(theFileSummary);
      }
    }
    for (ProjectFileType theType: ProjectFileType.values()) {
      Collections.sort(fileSummariesByType.get(theType.name()),
          new Comparator() {
            public int compare(Object o1, Object o2) {
              return ((Comparable) ((FileSummary) (o1)).getFileName())
                  .compareTo(((FileSummary) (o2)).getFileName());
            }
          }
      );
      modelAndView.addObject("fileSummaries" + theType.name(), fileSummariesByType.get(theType.name()));
    }
    for (ProjectFileType theType : ProjectFileType.values()) {
      Collections.sort(fileSummariesBySource.get(theType.name()),
          new Comparator() {
            public int compare(Object o1, Object o2) {
              return ((Comparable) ((FileSummary) (o1)).getFileName())
                  .compareTo(((FileSummary) (o2)).getFileName());
            }
          }
      );
      modelAndView.addObject("fileGeneratedSummaries" + theType.name(), fileSummariesBySource.get(theType.name()));
    }
  }

  public ModelAndView createErrorPage(String errorTitle, String errorMessage) {
    return createErrorPage(errorTitle, errorMessage, null);
  }

  public ModelAndView createErrorPage(String errorTitle, String errorMessage, String errorAdvice) {
    ModelAndView modelAndView = new ModelAndView();
    modelAndView.addObject("errorTitle", errorTitle);
    if (errorMessage != null) {
      modelAndView.addObject("errorMessage", errorMessage);
    }
    if (errorAdvice != null) {
      modelAndView.addObject("errorAdvice", errorAdvice);
    }
    modelAndView.setViewName("error");
    return modelAndView;
  }

  public ModelAndView createRedirectedErrorPage(String errorTitle, String errorMessage) {
    return createRedirectedErrorPage(errorTitle, errorMessage, null);
  }

  public ModelAndView createRedirectedErrorPage(String errorTitle, String errorMessage, String errorAdvice) {
    ModelAndView modelAndView = new ModelAndView(new RedirectView("/error", true));
    modelAndView.addObject("errorTitle", errorTitle);
    if (errorMessage != null) {
      modelAndView.addObject("errorMessage", errorMessage);
    }
    if (errorAdvice != null) {
      modelAndView.addObject("errorAdvice", errorAdvice);
    }
    return modelAndView;
  }

  public ModelAndView createUserLoginPage(String errorMessage) {
    ModelAndView modelAndView = new ModelAndView();
    if (errorMessage != null) {
      modelAndView.addObject("loginErrorMessage", errorMessage);
    }
    modelAndView.setViewName("login");
    return modelAndView;
  }

  public ModelAndView createUserProfilePage(UserSummary user, Collection<ProjectSummary> projectSummaries) {
    ModelAndView modelAndView = new ModelAndView();
    modelAndView.addObject("user", user);
    modelAndView.addObject("projects", projectSummaries);
    modelAndView.setViewName("userProfile");
    return modelAndView;
  }

  public ModelAndView createEditUserProfilePage(UpdateUserSummary user,
                                                ChangePassword changePassword,
                                                boolean onUpdateContactError,
                                                boolean onUpdatePasswordError) {
    ModelAndView modelAndView = new ModelAndView();
    if (onUpdateContactError) {
      modelAndView.addObject("updateContactError", "true");
    }
    if (onUpdatePasswordError) {
      modelAndView.addObject("updatePasswordError", "true");
    }
    modelAndView.addObject("updateContact", user);
    modelAndView.addObject("updatePassword", changePassword);
    modelAndView.addObject("titles", TitleUtils.getValidTitles());
    modelAndView.setViewName("editUserProfile");
    return modelAndView;
  }

  public ModelAndView createForgotPasswordPage(UserSummary user, boolean onError) {
    ModelAndView modelAndView = new ModelAndView();
    if (onError) {
      modelAndView.addObject("error", "true");
    }
    modelAndView.addObject("user", user);
    modelAndView.setViewName("forgotPassword");
    return modelAndView;
  }

  public ModelAndView createEnterOldPasswordPage(UpdateUserSummary updateContact) {
    ModelAndView modelAndView = new ModelAndView();
    modelAndView.addObject("updateContact", updateContact);
    modelAndView.addObject("titles", TitleUtils.getValidTitles());
    modelAndView.setViewName("reenterPassword");
    return modelAndView;
  }

  public ModelAndView createAfterPublishProject(String projectAccession) {
    ModelAndView modelAndView = new ModelAndView();
    modelAndView.addObject("projectAccession", projectAccession);
    modelAndView.setViewName("finishPublishMyProject");
    return modelAndView;
  }

  public ModelAndView createBeforePublishProjectPage(PublishProject publishProject, String projectAccession) {
    ModelAndView modelAndView = new ModelAndView();
    modelAndView.addObject("projectAccession", projectAccession);
    modelAndView.addObject("publishProject", publishProject);
    modelAndView.setViewName("publishMyProject");
    return modelAndView;
  }

  public ModelAndView createRegistrationPage(UserSummary user, boolean onError) {
    ModelAndView modelAndView = new ModelAndView();
    if (onError) {
      modelAndView.addObject("error", "true");
    }
    modelAndView.addObject("user", user);
    modelAndView.addObject("titles", TitleUtils.getValidTitles());
    modelAndView.setViewName("register");
    return modelAndView;
  }

  public ModelAndView createRegistrationSuccessfulPage(UserSummary user) {
    ModelAndView modelAndView = new ModelAndView();
    modelAndView.addObject("user", user);
    modelAndView.setViewName("registrationSuccessful");
    return modelAndView;
  }

  public ModelAndView createFeedbackPage(Feedback feedback) {
    ModelAndView modelAndView = new ModelAndView();
    modelAndView.addObject("feedback", feedback);
    modelAndView.setViewName("feedback");
    return modelAndView;
  }

  public ModelAndView createFeedbackAcknowledgementPage() {
    ModelAndView modelAndView = new ModelAndView();
    modelAndView.setViewName("feedbackAcknowledgement");
    return modelAndView;
  }

  public ModelAndView createWebCheckPage(boolean checkOK, String report) {
    ModelAndView modelAndView = new ModelAndView();
    modelAndView.addObject("checkSuccess", checkOK);
    modelAndView.addObject("report", report);
    modelAndView.setViewName("webCheck");
    return modelAndView;
  }

  public ModelAndView createViewerPage() {
    ModelAndView modelAndView = new ModelAndView();
    modelAndView.setViewName("proteinView");
    return modelAndView;
  }

  public ModelAndView createProteinsTablePage(@NotNull String projectAccession,
                                              String assayAccession,
                                              Page<ProteinIdentification> proteinPage,
                                              Map<ProteinIdentification, Map<String, List<String>>> highlights,
                                              String query,
                                              Map<String, Long> availablePtms,
                                              List<String> ptmsFilterList,
                                              List<MongoProteinIdentification> mongoProteinIdentifications) {
    ModelAndView modelAndView = new ModelAndView();
    modelAndView.addObject("page", proteinPage);
    modelAndView.addObject("mongoProteinIdentifications", mongoProteinIdentifications);
    modelAndView.addObject("highlights", highlights);
    modelAndView.addObject("q", query);
    modelAndView.addObject("projectAccession", projectAccession);
    if (assayAccession != null) {
      modelAndView.addObject("assayAccession", assayAccession);
    }

    modelAndView.addObject("ptmsFilters", ptmsFilterList);
    modelAndView.addObject("availablePtmList", availablePtms);
    modelAndView.setViewName("proteinsTable");
    return modelAndView;
  }

  public ModelAndView createPsmsTablePage(@NotNull String projectAccession,
                                          String assayAccession,
                                          Page<Psm> psmPage,
                                          Map<Psm, Map<String, List<String>>> highlights,
                                          String query,
                                          Map<String, Long> availablePtms,
                                          List<String> ptmsFilterList,
                                          Map<String, QualityAwarePsm> psmsWithClusters,
                                          List<MongoPsm> mongoPsms) {
    ModelAndView modelAndView = new ModelAndView();
    modelAndView.addObject("page", psmPage);
    modelAndView.addObject("mongoPsms", mongoPsms);
    modelAndView.addObject("highlights", highlights);
    modelAndView.addObject("q", query);
    modelAndView.addObject("projectAccession", projectAccession);
    if (assayAccession != null) {
      modelAndView.addObject("assayAccession", assayAccession);
    }
    modelAndView.addObject("ptmsFilters", ptmsFilterList);
    modelAndView.addObject("availablePtmList", availablePtms);
    modelAndView.addObject("psmsWithClusters", psmsWithClusters);
    modelAndView.setViewName("psmsTable");
    return modelAndView;
  }
}
