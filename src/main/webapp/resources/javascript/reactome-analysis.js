var reactomeAnalysis = function(btn, acc, projection) {

    var reactomeCorsURI;

    if (projection) {
        reactomeCorsURI = 'http://www.reactome.org/AnalysisService/identifiers/url/projection?pageSize=1&page=1';
    } else {
        reactomeCorsURI = 'http://www.reactome.org/AnalysisService/identifiers/url?pageSize=1&page=1';
    }

    // ToDo: make this URI configurable to support local testing. perhaps pass in as argument
    var dataURI = "http://wwwdev.ebi.ac.uk/pride/ws/archive/protein/list/assay/"+ acc +".acc";

    var parent = $(btn).parent();
    parent.text("Loading...");
    parent.removeClass().addClass("reactome-loading");

    $.ajax({
        type: "POST",
        contentType: "text/plain",
        dataType: "json",
        url: reactomeCorsURI,
        data: dataURI,
        success: null //needs to be defined, but null is "something" xD
    })
    .done(function(data) {
            if (data.pathwaysFound > 0) {// results in Reactome
                btn.innerHTML = "View (" + data.pathwaysFound.format(0,3) + ")";
                linkBuilder(btn, data);
                $(btn).removeClass().addClass("reactome-results");
                parent.removeClass().empty().append(btn);
            } else {// no results in Reactome
                parent.removeClass().addClass("reactome-no-results");
                parent.text("No results");
            }
    })
    .fail(function(response, status) {
        parent.empty();
        switch (response.status){
            case 413: //The file size is larger than the maximum configured size (10MB)
            case 415: //Unsupported Media Type (only 'text/plain')
            case 422: //The provided URL is not processable
                parent.text(response.statusText);
                break;
            default: //Reactome service accessible?
                parent.text("Service not available in this moment");
        }
        parent.removeClass().addClass("reactome-error");
    });
};

var linkBuilder = function(btn, data){
    token = data.summary.token;

    if( data.resourceSummary.length > 2 ){
        stId = data.pathways[0].stId;
        btn.onclick = function(){
            window.open("http://www.reactome.org/PathwayBrowser/#" + stId + "&DTAB=AN&ANALYSIS=" + token, "_blank");
        };
    } else {
        resource = data.resourceSummary[1].resource;
        $.ajax({
            type: "GET",
            contentType: "text/plain",
            dataType: "json",
            url: "http://www.reactome.org/AnalysisService/token/" + token + "?pageSize=1&page=1&resource=" + resource,
            success: null //needs to be defined, but null is "something" xD
        })
        .done(function(data) {
                console.info(data);
            stId = data.pathways[0].stId;
            btn.onclick = function(){
                window.open("http://www.reactome.org/PathwayBrowser/#" + stId + "&DTAB=AN&ANALYSIS=" + token, "_blank");
            };
        })
        .fail(function(response, status) {
            //TODO
        })
    }
};

/**
 * Number.prototype.format(n, x)
 *
 * @param integer n: length of decimal
 * @param integer x: length of sections
 */
Number.prototype.format = function(n, x) {
    var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\.' : '$') + ')';
    return this.toFixed(Math.max(0, ~~n)).replace(new RegExp(re, 'g'), '$&,');
};