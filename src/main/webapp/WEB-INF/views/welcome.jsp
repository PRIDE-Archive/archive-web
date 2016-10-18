<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%-- welcome page--%>

<%-- bread crumb--%>
<div class="grid_24 clearfix">
    <nav id="breadcrumb">
        <p>
            <spring:url var="prideUrl" value="http://www.ebi.ac.uk/pride"/>
            <a href="${prideUrl}"><fmt:message key="pride"/></a> &gt; <fmt:message key="prider"/>
        </p>
    </nav>
</div>

<div id="top" class="grid_24 clearfix">

    <section id="introduction" class="grid_18 alpha">
        <h2>
            <fmt:message key="welcome.intro.caption"/>
        </h2>
        <p class="justify-body-text">
            <fmt:message key="welcome.intro.body"/>
        </p>

        <%--TODO Noe: If the style is moved to the css file some components stop working properly--%>
        <div class="grid_24" style="height: 500px;">
            <div id="slider_container" class="grid_14 push_2" style="position: relative; width: 800px; height: 400px; ">

                <!-- Slides Container -->
                <%--TODO Move the images captions and refs to the welcome controller--%>
                <div u="slides" style="cursor: move; position: absolute; width: 800px; height: 400px; overflow: hidden">
                    <div>
                        <img u="image" class="no-margin" src="${pageContext.request.contextPath}/resources/img/slider/px-sub-tool.png"/>
                        <div  u="thumb">
                            <fmt:message key="welcome.submit.data.caption"/>: <a style="color: blue" href="http://www.proteomexchange.org/submission" target="_blank">PX Submission Tool</a>
                            <br>MS/MS Proteomics Submission Desktop Tool
                        </div>
                    </div>
                    <div>
                        <img u="image" class="no-margin" src="${pageContext.request.contextPath}/resources/img/slider/precursor.png" />
                        <div  u="thumb">
                            <fmt:message key="welcome.prider.tools.caption"/>: <a style="color: blue" href="https://github.com/PRIDE-Toolsuite/pride-inspector" target="_blank">PRIDE Inspector</a>
                            <br>Distribution of Precursos Ion Masses
                        </div>
                    </div>
                    <div>
                        <img u="image" class="no-margin" src="${pageContext.request.contextPath}/resources/img/slider/proteome_central.png" />
                        <div  u="thumb">
                            <fmt:message key="welcome.access.caption"/>: <a style="color: blue" href="http://proteomecentral.proteomexchange.org/cgi/GetDataset" target="_blank">Proteome Central</a>
                            <br>Accessible ProteomeXchange datasets
                        </div>
                    </div>
                    <div>
                        <img u="image" class="no-margin" src="${pageContext.request.contextPath}/resources/img/slider/protein-coverage.png" />
                        <div  u="thumb">
                            <fmt:message key="welcome.prider.tools.caption"/>: <a style="color: blue"  href="https://github.com/PRIDE-Toolsuite/pride-inspector" target="_blank">PRIDE Inspector</a>
                            <br>Protein Table
                        </div>
                    </div>
                    <div>
                        <img u="image" class="no-margin" src="${pageContext.request.contextPath}/resources/img/slider/ws.jpg" />
                        <div u="thumb">
                            <fmt:message key="welcome.access.caption"/>: <a style="color: blue"  href="http://www.ebi.ac.uk/pride/ws/archive" target="_blank">PRIDE Archive Web Service</a>
                            <br>Swagger Documentation
                        </div>
                    </div>
                    <div>
                        <img u="image" class="no-margin" src="${pageContext.request.contextPath}/resources/img/slider/protein-inference-panel.png" />
                        <div  u="thumb">
                            <fmt:message key="welcome.prider.tools.caption"/>: <a style="color: blue"  href="https://github.com/PRIDE-Toolsuite/pride-inspector" target="_blank">PRIDE Inspector</a>
                            <br>Protein Inference
                        </div>
                    </div>
                    <div>
                        <img u="image" class="no-margin" src="${pageContext.request.contextPath}/resources/img/slider/quantitation.png" />
                        <div  u="thumb">
                            <fmt:message key="welcome.prider.tools.caption"/>: <a style="color: blue"  href="https://github.com/PRIDE-Toolsuite/pride-inspector" target="_blank">PRIDE Inspector</a>
                            <br>Quantitation View
                        </div>
                    </div>
                    <div>
                        <img u="image" class="no-margin" src="${pageContext.request.contextPath}/resources/img/slider/search.jpg" />
                        <div  u="thumb">
                            <fmt:message key="welcome.access.caption"/>: <a style="color: blue" href="${pageContext.request.contextPath}/simpleSearch">PRIDE Archive</a>
                            <br>Results Page
                        </div>
                    </div>
                    <div>
                        <img u="image" class="no-margin" src="${pageContext.request.contextPath}/resources/img/slider/sequence.png" />
                        <div  u="thumb">
                            <fmt:message key="welcome.prider.tools.caption"/>: <a style="color: blue"  href="https://github.com/PRIDE-Toolsuite/pride-inspector" target="_blank">PRIDE Inspector</a>
                            <br>Protein Details
                        </div>
                    </div>
                    <div>
                        <img u="image" class="no-margin" src="${pageContext.request.contextPath}/resources/img/slider/ws2.jpg" />
                        <div u="thumb">
                            <fmt:message key="welcome.access.caption"/>: <a style="color: blue" href="http://www.ebi.ac.uk/pride/ws/archive" target="_blank">PRIDE Archive Web Service</a>
                            <br>JSON Output
                        </div>
                    </div>

                </div>

                <!-- ThumbnailNavigator Skin Begin -->
                <div u="thumbnavigator" class="sliderb-T" style="position: absolute; bottom: -50px; height:45px; width:800px;">
                    <div style="filter: alpha(opacity=30); opacity:0.3; position: absolute; display: block; background-color: #000000; top: 0px; left: 0px; width: 100%; height: 100%;">
                    </div>
                    <!-- Thumbnail Item Skin Begin -->
                    <div u="slides">
                        <div u="prototype" style="POSITION: absolute; WIDTH: 795px; HEIGHT: 50px; TOP: 0px; LEFT: 0px;">
                            <div u="thumbnailtemplate" style="font-family: verdana; font-weight: normal; POSITION: absolute; WIDTH: 100%; HEIGHT: 100%; TOP: 0; LEFT: 0; color:#fff; line-height: 20px; font-size:15px; padding-top:5px; padding-left:5px;"></div>
                        </div>
                    </div>
                    <!-- Thumbnail Item Skin End -->
                </div>
                <!-- ThumbnailNavigator Skin End -->
                <!-- bullet navigator container -->
                <%--TODO move the style to the jssor.css--%>
                <div u="navigator" class="jssorb05" style="position: absolute; bottom: -34px; right: 6px; padding-right: 10px">
                    <!-- bullet navigator item prototype -->
                    <div u="prototype" style="position: absolute; width: 16px; height: 16px;"></div>
                </div>

                <!-- Arrow Left -->
                <span u="arrowleft" class="jssora13l" style="position: absolute; width: 30px; height: 46px; top: 160px; left: -30px;">
                </span>

                <!-- Arrow Right -->
                <span u="arrowright" class="jssora13r" style="position: absolute; width: 30px; height: 46px; top: 160px; right: -30px">
                </span>
                <!-- Jssor Slider End -->

            </div>
        </div>
    </section>

    <div class="grid_5 omega">
        <section id="statistics">
            <h3 class="icon icon-functional" data-icon="z">
                <fmt:message key="welcome.statistics.caption"/>
            </h3>

            <p class="justify-body-text">
            <ul>
                <li class="justify-body-text">${statistics.numProjects} projects</li>
                <li class="justify-body-text">${statistics.numAssay} assays</li>
            </ul>
            </p>
        </section>

        <section id="dataset-of-the-month">
            <h3 class="icon icon-generic" data-icon="N">
                <fmt:message key="welcome.news.caption"/>
            </h3>

            <p>
                <c:forEach items="${tweets}" var="tweet">

            <div class="row">
                <div class="date-box">
                    <span class="month"><fmt:formatDate type="date" dateStyle="medium" value="${tweet.createdAt}"
                                                        pattern="MMM"/></span>
                    <span class="day"><fmt:formatDate type="date" value="${tweet.createdAt}" pattern="dd"/></span>
                </div>
                <span class="justify-body-text"><c:out value="${tweet.text}" escapeXml="false"/></span>
            </div>
            </c:forEach>

            <spring:url var="newsUrl" value="https://twitter.com/@pride_ebi"/>
            <a class="justify-body-text icon icon-socialmedia" data-icon="T" href="${newsUrl}"><fmt:message
                    key="welcome.news.more.news.caption"/></a>
            </p>
        </section>
    </div>
</div>




<%--<div id="top" class="grid_24 clearfix">--%>
    <%--<br/><br/><br/>--%>
<%--</div>--%>

<div id="bottom" class="grid_24">

    <section id="submit-data" class="grid_8 alpha">
        <h3 class="icon icon-functional" data-icon="_">
            <fmt:message key="welcome.submit.data.caption"/>
        </h3>

        <p class="justify-body-text">
            <spring:url var="submissionUrl" value="http://www.ebi.ac.uk/pride/help/archive/submission"/>
            <a href="${submissionUrl}"><fmt:message key="welcome.submit.data.caption"/></a>: <fmt:message
                key="welcome.submit.data.summary"/>
        </p>

        <p class="justify-body-text">
            <spring:url var="proteomeXchangeUrl" value="http://www.proteomexchange.org/"/>
            <a href="${proteomeXchangeUrl}"><fmt:message key="welcome.submit.data.proteomexchange.caption"/></a>:
            <fmt:message key="welcome.submit.data.proteomexchange.summary"/>
        </p>
    </section>

    <section id="access-and-download" class="grid_8">
        <h3 class="icon icon-functional" data-icon="4">
            <fmt:message key="welcome.access.caption"/>
        </h3>

        <p class="justify-body-text">
            <spring:url var="browseUrl" value="/simpleSearch"/>
            <a href="${browseUrl}"><fmt:message key="welcome.access.browse.caption"/></a>:
            <fmt:message key="welcome.access.browse.summary"/>
        </p>

        <p class="justify-body-text">
            <spring:url var="webserviceUrl" value="http://www.ebi.ac.uk/pride/ws/archive"/>
            <a href="${webserviceUrl}"><fmt:message key="welcome.access.webservice.caption"/></a>:
            <fmt:message key="welcome.access.webservice.summary"/>
        </p>

        <p class="justify-body-text">
            <spring:url var="browseUrl" value="ftp://ftp.pride.ebi.ac.uk/pride/data/archive"/>
            <a href="${browseUrl}"><fmt:message key="welcome.access.ftp.caption"/></a>:
            <fmt:message key="welcome.access.ftp.summary"/>
        </p>

    </section>

    <section id="tools-and-tips" class="grid_8">
        <h3 class="icon icon-functional" data-icon="t">
            <fmt:message key="welcome.prider.tools.caption"/>
        </h3>

        <p class="justify-body-text">
            <spring:url var="prideInspectorUrl" value="https://github.com/PRIDE-Toolsuite/pride-inspector"/>
            <a href="${prideInspectorUrl}"><fmt:message key="welcome.pride.inspector.caption"/></a>:
            <fmt:message key="welcome.pride.inspector.summary"/>
        </p>

        <p class="justify-body-text">
            <spring:url var="prideConverterUrl" value="http://code.google.com/p/pride-converter-2/"/>
            <a href="${prideConverterUrl}"><fmt:message key="welcome.pride.converter.caption"/></a>:
            <fmt:message key="welcome.pride.converter.summary"/>
        </p>
    </section>


</div>

<script>
    jQuery(document).ready(function ($) {

        var _SlideshowTransitions = [
            //Fade in R
            {$Duration: 1200, x: -0.3, $During: { $Left: [0.3, 0.7] }, $Easing: { $Left: $JssorEasing$.$EaseInCubic, $Opacity: $JssorEasing$.$EaseLinear }, $Opacity: 2 }
            //Fade out L
            , { $Duration: 1200, x: 0.3, $SlideOut: true, $Easing: { $Left: $JssorEasing$.$EaseInCubic, $Opacity: $JssorEasing$.$EaseLinear }, $Opacity: 2 }
        ];

        var options = {
            $AutoPlay: true,                                    //[Optional] Whether to auto play, to enable slideshow, this option must be set to true, default value is false
            $AutoPlaySteps: 1,                                  //[Optional] Steps to go for each navigation request (this options applys only when slideshow disabled), the default value is 1
            $AutoPlayInterval: 4000,                            //[Optional] Interval (in milliseconds) to go for next slide since the previous stopped if the slider is auto playing, default value is 3000
            $PauseOnHover: 1,                                   //[Optional] Whether to pause when mouse over if a slider is auto playing, 0 no pause, 1 pause for desktop, 2 pause for touch device, 3 pause for desktop and touch device, 4 freeze for desktop, 8 freeze for touch device, 12 freeze for desktop and touch device, default value is 1
            $FillMode: 1,                                       //[Optional] The way to fill image in slide, 0 stretch, 1 contain (keep aspect ratio and put all inside slide), 2 cover (keep aspect ratio and cover whole slide), 4 actual size, 5 contain for large image, actual size for small image, default value is 0

            $ArrowKeyNavigation: true,                          //[Optional] Allows keyboard (arrow key) navigation or not, default value is false
            $SlideDuration: 500,                                //[Optional] Specifies default duration (swipe) for slide in milliseconds, default value is 500
            $MinDragOffsetToSlide: 20,                          //[Optional] Minimum drag offset to trigger slide , default value is 20
            //$SlideWidth: 600,                                 //[Optional] Width of every slide in pixels, default value is width of 'slides' container
            //$SlideHeight: 300,                                //[Optional] Height of every slide in pixels, default value is height of 'slides' container
            $SlideSpacing: 0,                                   //[Optional] Space between each slide in pixels, default value is 0
            $DisplayPieces: 1,                                  //[Optional] Number of pieces to display (the slideshow would be disabled if the value is set to greater than 1), the default value is 1
            $ParkingPosition: 0,                                //[Optional] The offset position to park slide (this options applys only when slideshow disabled), default value is 0.
            $UISearchMode: 1,                                   //[Optional] The way (0 parellel, 1 recursive, default value is 1) to search UI components (slides container, loading screen, navigator container, arrow navigator container, thumbnail navigator container etc).
            $PlayOrientation: 1,                                //[Optional] Orientation to play slide (for auto play, navigation), 1 horizental, 2 vertical, 5 horizental reverse, 6 vertical reverse, default value is 1
            $DragOrientation: 3,                                //[Optional] Orientation to drag slide, 0 no drag, 1 horizental, 2 vertical, 3 either, default value is 1 (Note that the $DragOrientation should be the same as $PlayOrientation when $DisplayPieces is greater than 1, or parking position is not 0)

            $SlideshowOptions: {                                //[Optional] Options to specify and enable slideshow or not
                $Class: $JssorSlideshowRunner$,                 //[Required] Class to create instance of slideshow
                $Transitions: _SlideshowTransitions,            //[Required] An array of slideshow transitions to play slideshow
                $TransitionsOrder: 1,                           //[Optional] The way to choose transition to play slide, 1 Sequence, 0 Random
                $ShowLink: true                                 //[Optional] Whether to bring slide link on top of the slider when slideshow is running, default value is false
            },

            $BulletNavigatorOptions: {                          //[Optional] Options to specify and enable navigator or not
                $Class: $JssorBulletNavigator$,                 //[Required] Class to create navigator instance
                $ChanceToShow: 2,                               //[Required] 0 Never, 1 Mouse Over, 2 Always
                $Lanes: 1,                                      //[Optional] Specify lanes to arrange items, default value is 1
                $SpacingX: 10,                                  //[Optional] Horizontal space between each item in pixel, default value is 0
                $SpacingY: 10                                   //[Optional] Vertical space between each item in pixel, default value is 0
            },

            $ArrowNavigatorOptions: {
                $Class: $JssorArrowNavigator$,                  //[Requried] Class to create arrow navigator instance
                $ChanceToShow: 2,                               //[Required] 0 Never, 1 Mouse Over, 2 Always
                $AutoCenter: 2                                  //[Optional] Auto center navigator in parent container, 0 None, 1 Horizontal, 2 Vertical, 3 Both, default value is 0
            },

            $ThumbnailNavigatorOptions: {
                $Class: $JssorThumbnailNavigator$,              //[Required] Class to create thumbnail navigator instance
                $ChanceToShow: 2,                               //[Required] 0 Never, 1 Mouse Over, 2 Always
                $ActionMode: 0,                                 //[Optional] 0 None, 1 act by click, 2 act by mouse hover, 3 both, default value is 1
                $DisableDrag: true                              //[Optional] Disable drag or not, default value is false
            }
        };

        var jssor_sliderb = new $JssorSlider$("slider_container", options);

    });
</script>
