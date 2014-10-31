/**
 * Created with IntelliJ IDEA.
 * User: Maximilian Koch
 * Date: 24.07.13
 * Time: 13:45
 * To change this template use File | Settings | File Templates.
 */

google.load('visualization', '1', {packages: ['geochart', 'corechart']});

var currentChart = 1;
var zoom = new Boolean();
var isZoomable = new Boolean();
var width = 900;
var heigth = 500;

function setGeoChart() {
    var query = new google.visualization.Query('//docs.google.com/spreadsheet/tq?key=0AiPwkIg-BdVzdF9ZNlRvQzgxcmtQaVZHMzUtTzVjWmc&transpose=0&headers=1&range=A1%3AB134&gid=1&pub=1');
    query.send(drawGeoChart);
}

function setPepProSpecChart() {
    var query = new google.visualization.Query('//docs.google.com/spreadsheet/tq?key=0AiPwkIg-BdVzdEdYMUQycDdYbjJ5WUFZeWF6X21hbFE&transpose=0&headers=1&range=A1%3AD1000&gid=2&pub=1');
    query.send(drawAreaChart);
}

function setSpeciesChart() {
    var query = new google.visualization.Query('//docs.google.com/spreadsheet/tq?key=0AiPwkIg-BdVzdG51R2VwbVdjUy16bUhZbG54THRWSEE&transpose=0&headers=1&range=A1%3AB90&gid=4&pub=1');
    query.send(drawPieChart);
}

function setFileSizesTOTALChart() {
    var query = new google.visualization.Query('//docs.google.com/spreadsheet/tq?key=0AiPwkIg-BdVzdGZFN252cGwtNUY5b3hhcm9Wbmp0dkE&transpose=0&headers=1&range=A1%3AB14&gid=51&pub=1');
    query.send(drawAreaChart);
}

function setFileSizesCompareChart() {
    var query = new google.visualization.Query('//docs.google.com/spreadsheet/tq?key=0AiPwkIg-BdVzdGZFN252cGwtNUY5b3hhcm9Wbmp0dkE&transpose=0&headers=1&range=A1%3AF14&gid=51&pub=1');
    query.send(drawAreaChart);
}

function drawGeoChart(response) {
    var data = response.getDataTable();
    getSum(data, 1);
    var options = getGeoChartOptions();
    var chart = new google.visualization.GeoChart(document.getElementById('chart'));
    google.visualization.events.addListener(chart, 'ready', isReady);
    chart.draw(data, options);
    google.visualization.events.addListener(chart, 'select', selectHandler);

    function isReady(){
        isZoomable = false;
        showLoader(false);
        createCanvasObj();
    }

    function selectHandler() {
        // event listener
    }
}

function drawAreaChart(response) {
    var data = response.getDataTable();

    var options = getAreaChartOptions();
    var chart = new google.visualization.AreaChart(document.getElementById('chart'));
    google.visualization.events.addListener(chart, 'ready', isReady);
    chart.draw(data, options);
    google.visualization.events.addListener(chart, 'select', selectHandler);

    function isReady(){
        isZoomable = true;
        showLoader(false);
        createCanvasObj();
    }

    function selectHandler() {
        // event listener
    }
}

function drawPieChart(response) {
    var data = response.getDataTable();

    var options = getPieChartOptions();
    var chart = new google.visualization.PieChart(document.getElementById('chart'));
    google.visualization.events.addListener(chart, 'ready', isReady);
    chart.draw(data, options);
    google.visualization.events.addListener(chart, 'select', selectHandler);

    function isReady(){
        isZoomable = true;
        showLoader(false);
        createCanvasObj();
    }

    function selectHandler() {
        // event listener
    }
}

function getSum(data, column) {
    var total = 0;
    for (i = 0; i < data.getNumberOfRows(); i++)
        total = total + data.getValue(i, column);
    $('#totalSum').html('Total submissions: ' + total);
}



$(document).ready(function () {
    showLoader(true);
    setGeoChart();
    $('#'+currentChart+'.thumbnails').fadeTo(0, 0.5);
    $('#description1').show();
    $('#description'+currentChart).show();
    $('#heading'+currentChart).show();

    $('.thumbnails').click(function () {
        showLoader(true);
        zoom = false;
        $('#chart').hide();
        chartRedraw(this.id);
        $('#chart').show();
        var oldChart = currentChart;
        currentChart = this.id;

        $('#'+oldChart+'.thumbnails').fadeTo(0, 1.0);
        $('#description'+oldChart).hide();
        $('#heading'+oldChart).hide();
        $('#'+currentChart+'.thumbnails').fadeTo(0, 0.5);
        $('#description'+currentChart+'').show();
        $('#heading'+currentChart).show();
    });
    $('#downloadChart').click(function() {
        saveAsImg(chart);
    });
    $('#in').click(function(){
        zoom = true;
        showLoader(true);
        chartRedraw(currentChart);
    });
    $('#out').click(function(){
        zoom = false;
        showLoader(true);
        chartRedraw(currentChart);
    });
});

function chartRedraw(chartID){
    switch (chartID) {
        case ('1'):
            setGeoChart();
            break;
        case ('2'):
            setPepProSpecChart();
            break;
        case ('3'):
            setSpeciesChart();
            break;
        case ('4'):
            setFileSizesTOTALChart();
            break;
        case ('5'):
            setFileSizesCompareChart();
            break;
    }
}

function showLoader(loading){
    switch(loading){
        case true:
            $('#loader').show()
            break;
        case false:
            $('#loader').hide()
            break;
    }
}

function createCanvasObj(){
    svg = $('svg').parent().html();
    canvg('canvas', svg);
    canvas = $('canvas');
}

function getPieChartOptions(){

    var optionsZoomIn = {
        'width': width,
        'height': heigth,
        'chartArea':
        {width: '100%', height: '100%'},
        'legend':
        {position: 'labeled'},
        'titlePosition': 'in',
        'axisTitlesPosition': 'in',
        'hAxis':
        {textPosition: 'in'},
        'vAxis':
        {textPosition: 'in'},
        'sliceVisibilityThreshold': 0.01,
        'pieSliceText': 'value'
    };

    var optionsZoomOut = {
        'width': width,
        'height': heigth,
        'legend':
        {position: 'labeled'},
        'sliceVisibilityThreshold': 0.01,
        'pieSliceText': 'value'
    }

    if(zoom){
        return optionsZoomIn;
    } else{
        return optionsZoomOut;
    }
}

function getAreaChartOptions(){

    var optionsZoomIn = {
        'width': width,
        'height': heigth,
        'chartArea':
        {width: '100%', height: '100%'},
        'legend':
        {position: 'in'},
        'titlePosition': 'in',
        'axisTitlesPosition': 'in',
        'hAxis':
        {textPosition: 'in'},
        'vAxis':
        {textPosition: 'in'}
    };

    var optionsZoomOut = {
        'width': width,
        'height': heigth,
        'legend':
        {position: 'in'}
    }

    if(zoom){
        return optionsZoomIn;
    } else{
        return optionsZoomOut;
    }
}

function getGeoChartOptions(){

    var options = {
        'width': width,
        'height': heigth
    }

    return options;
}