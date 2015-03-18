<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="accession" required="true" %>


<div id="inspector-dialog" title="Open in PRIDE Inspector">
    Follow the next steps to open your selected project or assay in PRIDE Inspector:
    <br/>
    <br/>
    <ol>
        <li>
            <a class="icon icon-functional" data-icon="="
               href="http://www.ebi.ac.uk/pride/resources/tools/inspector/latest/desktop/pride-inspector.zip">Download PRIDE Inspector </a> and uncompressed the folder
        </li>
        <li>
            Copy to clipboard the project or assay accession that you would like to open in PRIDE Inspector.
            <label>
                In this case: <input size="10" style="text-align: center" title="Select the text and copy it (e.g. Ctr+C or Cmd+C)" type="text" value="${accession}" autofocus="true" onfocus="this.setSelectionRange(0, this.value.length)" />
            </label>
        </li>
        <li>
            Open PRIDE Inspector <img id="inspector-img" style="width: 45px;" src="${pageContext.request.contextPath}/resources/img/inspectorIcon.png" />

        </li>
        <li>
           Click in the little magnifier <img style="height: 20px" src="${pageContext.request.contextPath}/resources/img/search.png"> on the left top corner
        </li>
        <li>
            Paste the project or assay accession in the box and hit search
        </li>
        <li>
            Click in the corresponding "Download" button to download the files and visualize them
        </li>
    </ol>

    <div style="text-align: right" >
        <span>PRIDE Inspector in  <a href="https://github.com/PRIDE-Toolsuite/pride-inspector">GitHub <img style="height: 20px" src="${pageContext.request.contextPath}/resources/img/octocat.jpg"> </a></span>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $("#inspector-dialog").dialog({
            autoOpen: false,
            height: 390,
            width: 630,
            modal: true,
            buttons: {
                "Cancel": function () {
                    $(this).dialog("close");
                }
            }
        });

        $("#inspector-confirm").click(function () {
            $("#inspector-dialog").dialog("open");
        });
    });
</script>
