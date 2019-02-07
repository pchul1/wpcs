<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page import="daewooInfo.common.security.util.TmsUserDetailsHelper" %>
<%@ page import="daewooInfo.common.login.bean.LoginVO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title></title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
	
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>
	
	<script type='text/javascript'>

		var item;
		
		$(function(){

			$("#branchName").html($("#branchNo",opener.document).find("option:selected").html() + " ");
			
			getItemDropDown();
			chart();
			$('#item').change(function(){
				chart();
			})	
			$('#day').change(function(){
				chart();
			})	
			

			//$("#span_loading").css("display", "none");

			//var test = document.getElementById("chart").contentWindow.document.getElementsByTagName("td");

		});

		function chart_load()
		{
			$("#span_loading").css("display", "none");
		}
		function getItemDropDown(){

			var itemCode = "22";
			
			var dropDownSet = $('#item');
			sys = "U";
			dropDownSet.attr("disabled", false);
			
			$.getJSON("<c:url value='/cmmn/getCode.do'/>", {code_id:itemCode}, function (data, status){
				 if(status == 'success'){	 
					//item 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelectDepth3(data.codes, sys);
					
				 } 
			});	
		}

		//동적 SELECTBOX 구현을 위한 사용자 함수
		(function($) {

		//SELECT OPTION 삭제
		$.fn.emptySelect = function() {
			return this.each(function(){
			  if (this.tagName=='SELECT') this.options.length = 0;
			});
		 }

		//SELECT OPTION 등록
		$.fn.loadSelectDepth3 = function(optionsDataArray, sys) {
			return this.emptySelect().each(function(){
			  if (this.tagName=='SELECT') {
				  var selectElement = this;
				  $.each(optionsDataArray,function(idx, optionData){

					  if(sys != "A")
						  optionData.VALUE = optionData.VALUE + "00";

					  var option = new Option(optionData.CAPTION, optionData.VALUE);
					  
					  if ($.browser.msie) {
							if(idx == 0 && sys != "A"){}
							 
						  selectElement.add(option);
					  }
					  else {
							if(idx == 0 && sys != "A"){}
						  selectElement.add(option,null);
					  }
				  });

			  }
		   });
		 }
		})(jQuery);

		
		function chart(){
			$("#span_loading").show();

			var item = $("#item").val();
			
			var param = "fact_code=<c:out value='${param_s.fact_code }'/>";
			param += "&branch_no=<c:out value='${param_s.branch_no }'/>";
			param += "&item_code=" + item;
			param += "&min_time=<c:out value='${param_s.min_time }'/>" + $("#day").val();
			var src = "<c:url value='/waterpolmnt/waterinfo/getDefiniteDataChart.do?'/>";
			$('#chart').attr("src", src + param);
		}
	</script>
</head>

<body class="subPop"><!-- 추가 및 수정 -->
<div class="headerWrap">
	<div class="headerBg_r">
		<div class="header">
			<h1 style='font-size:large;font-weight:bold;color:white'><span id='branchName'></span>데이터 비교</h1>
		</div>
	</div>
</div>
<div class="contentWrap">
	<div class="contentBg_r">
		<div class="contentBox">
			<div class="contentPad"><!-- //추가 및 수정 -->
				<div class="totalmntPop2" style="width:740px;height:509px">
					<div class="content" style="padding-top:10px">
					<center>
					</center>
						<ul class="selectList">
							<li>
							${fn:substring(param_s.min_time,0,4)}년 ${fn:substring(param_s.min_time,4,6)}월
								<select id="day" style="width:40px" >
									<c:forEach begin="1" end="31" step="1" var="i">
										<c:set value="${i}" var="min"/>
										<c:if test="${i<10}">
											<c:set value="0${i}" var="min"/>
										</c:if>
										<option value="<c:out value="${min}"/>"><c:out value="${min}"/></option>
									</c:forEach>
								</select>일
							</li>
							&nbsp;&nbsp;
							<li>항목
								<select id="item" style="width:200px">
									<option value="TUR00" selected="selected">전체</option>
								</select>
							</li>
						</ul>
						<div class="graph" style="height:455px">
							<span id="span_loading" style="position:absolute">데이터를 불러오는 중 입니다...</span>
							<iframe id="chart" name="chartFrame" onload="chart_load()" src="" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="455"></iframe>
						</div>
					</div>
				</div>
			</div><!-- 추가 및 수정 -->
		</div>
	</div>
</div>
<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 -->
</body>
</html>

