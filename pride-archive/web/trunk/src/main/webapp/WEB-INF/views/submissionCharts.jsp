<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: Maximilian Koch
  Date: 24.07.13
  Time: 13:50
  To change this template use File | Settings | File Templates.
--%>
<div id="chartContainer">
    <table id="thumbTable">
        <tr>
            <td>
                <div class='thumbnails' id='1'>
                    <img id="thumb1" src='https://docs.google.com/spreadsheet/oimg?key=0AiPwkIg-BdVzdF9ZNlRvQzgxcmtQaVZHMzUtTzVjWmc&oid=3&zx=5kcn9redx76c' title='Geochart' alt='Geochart'>
                </div>
            </td>
            <td>
                <div class='thumbnails' id='2'>
                    <img id="thumb2" src="https://docs.google.com/spreadsheet/oimg?key=0AiPwkIg-BdVzdEdYMUQycDdYbjJ5WUFZeWF6X21hbFE&oid=7&zx=yidef9y42mkb" title='Legacy Data' alt='Legacy Data'>
                </div>
            <td>
                <div class='thumbnails' id='3'>
                    <img id="thumb3" src="https://docs.google.com/spreadsheet/oimg?key=0AiPwkIg-BdVzdG51R2VwbVdjUy16bUhZbG54THRWSEE&oid=4&zx=xu2n0z1zzxiu" title='Species Distribution' alt='Species Distribution'>
                </div>
            </td>
            <td>
                <div class='thumbnails' id='4'>
                    <img id="thumb4" src='https://docs.google.com/spreadsheet/oimg?key=0AiPwkIg-BdVzdGZFN252cGwtNUY5b3hhcm9Wbmp0dkE&oid=22&zx=whgxnxktb1sr' title='Total Dataset Size' alt='Total Dataset Size'>
                </div>
            </td>
            <td>
                <div class='thumbnails' id='5'>
                    <img id="thumb5" src='https://docs.google.com/spreadsheet/oimg?key=0AiPwkIg-BdVzdGZFN252cGwtNUY5b3hhcm9Wbmp0dkE&oid=21&zx=sfy06cxkq5mo' title='Dataset Size Per File Type' alt='Dataset Size Per File Type'>
                </div>
            </td>
        </tr>
    </table>
    <table id="chartTable">
        <tr>
            <td>
                <img class='zoom' id='in' src='./resources/img/in.png' alt="zoom in" title="zoom in">
                <img class='zoom' id='out' src='./resources/img/out.png' alt="zoom out" title="zoom out">
                <img id='loader' src='./resources/img/loader.gif'>
            </td>
        </tr>
        <tr>
            <td class='chartCell'>
                <div id="chart"></div>
            </td>
            <td>
                    <div class="heading"  id="heading1" style='display:none;'>
                        <fmt:message key="priderrStats.GeoChart"></fmt:message>
                    </div>
                    <div class="heading"  id="heading2" style='display:none;'>
                        <fmt:message key="priderrStats.LegacyData"></fmt:message>
                    </div>
                    <div class="heading"  id="heading3" style='display:none;'>
                        <fmt:message key="priderrStats.SpeciesDistribution"></fmt:message>
                    </div>
                    <div class="heading"  id="heading4" style='display:none;'>
                        <fmt:message key="priderrStats.TotalDatasetSize"></fmt:message>
                    </div>
                    <div class="heading"  id="heading5" style='display:none;'>
                        <fmt:message key="priderrStats.DatasetSizePerFileType"></fmt:message>
                    </div>
                <div class='descriptionCell'>
                    <div id='description1' style='display:none;'>Geographical distribution of ProteomeXchange submissions. The color gradient highlights the number of datasets submitted by particular countries.<br><br><br><div id='totalSum'></div></div>
                    <div id='description2' style='display:none;'>Data growth based on data stored in legacy PRIDE XML files. the 3 core data type is shown: number of mass spectra, reported peptide assignments and protein identifications.</div>
                    <div id='description3' style='display:none;'>Sample species analysed by 2 or more ProteomeXchange data submissions. The other category consists of species used only by 1 PX submission.</div>
                    <div id='description4' style='display:none;'>Total size of uploaded ProteomeXchange datasets per month.</div>
                    <div id='description5' style='display:none;'>Size of the different incoming ProteomeXchange file types per month.</div>
                </div>
            </td>
        </tr>
    </table>
</div>
<canvas id="canvas" hidden="true"></canvas>
