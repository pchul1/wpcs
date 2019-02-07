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

		var sys;
		var factCode;
		var branchNo;

		function replaceAll(ostr, str1, str2)
		{
			return ostr.split(str1).join(str2);
		}

		//달력에서 선택된 일에서 "/"를 제외하고 리턴합니다.
		$.fn.val2 = function()
		{
			return replaceAll(this.val(), "/" , "");
		}
		
		$(function(){

			$.datepicker.setDefaults({
			    monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			    showMonthAfterYear:true,
			    dateFormat: 'yy/mm/dd',
			    showOn: 'both',
			    buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			    buttonImageOnly: true
			});
			
			$("#compareDate").datepicker({
			    buttonText: '비교일'

			});

			var today = new Date(); 
			var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 12);

			yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1) + "/" + addzero(yday.getDate());

			function addzero(n) {
				 return n < 10 ? "0" + n : n + "";
			}

			$("#compareDate").val(yday);

			
		 	sys = '${param.sys}';
		 	factCode = '${param.factCode}';
		 	branchNo = '${param.branchNo}';

			getItemDropDown();
			
			$('#item')
			.change(function(){
				chart();
			})		

			//$("#span_loading").css("display", "none");

			//var test = document.getElementById("chart").contentWindow.document.getElementsByTagName("td");

			getBranchName();

		});

		
		function getBranchName()
		{
			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getBranchName.do'/>", 
					{factCode:factCode,
					  branchNo:branchNo},
			   function(data, status)
			   {
					if(status == "success")
					{
						$("#branchName").text(data['data'].chukjeongso+"-"+branchNo);
					}
					else
					{
						$("#branchName").text("");
					}
			   }
			);
		}

		function chart_load()
		{
			$("#span_loading").hide();
		}
		
		function getItemDropDown(){
			
			var itemCode = "";
			
			if(sys == 'U' || sys == 'all'){
				itemCode = "22";
			}else if(sys == 'T'){
				itemCode = "23";
			}else if(sys == 'A'){
				itemCode = "37";
			}
			
			var dropDownSet = $('#item');

			dropDownSet.attr("disabled", false);
			$.getJSON("<c:url value='/cmmn/getCode.do'/>", {code_id:itemCode}, function (data, status){
			     if(status == 'success'){     
			        //item 객체에 SELECT 옵션내용 추가.
			        dropDownSet.loadSelectDepth3(data.codes, sys);

			        chart();
			        
			     } else { 
			        //alert("ERROR!");
			        return;
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
		        	  {
		            	  optionData.VALUE = optionData.VALUE + "00";
		            	  
		        	  }

		        	  var first = new Option('전체', 'all');
		        	  
		              var option = new Option(optionData.CAPTION, optionData.VALUE);
		              
		              if ($.browser.msie) {
							if(idx == 0 && sys != 'A'){selectElement.add(first);}
			                 
		                  selectElement.add(option);
		              }
		              else {
							if(idx == 0 && sys != 'A'){selectElement.add(first);}
		                  selectElement.add(option,null);
		              }
		          });

		      }
		   });
		 }
		})(jQuery);

		
		function chart(){

			$("#span_loading").show();
			
			var width = "938";
			var height = "654";

			var selectedItem = $("#item").val();

			document.chartForm.target = "chartFrame";
			document.chartForm.factCode.value = factCode;
			document.chartForm.branchNo.value = branchNo;
			document.chartForm.branchName.value = "";
			document.chartForm.sys_kind.value = sys;
			document.chartForm.width.value = width;
			document.chartForm.height.value = height;
			document.chartForm.item.value = selectedItem;

			document.chartForm.action = "<c:url value='/waterpolmnt/situationctl/getTotalMntDetailGraph.do'/>";
			
			document.chartForm.submit();
		}


		function compare()
		{
				if($("#item").val() == "all")
				{
					alert("비교하실 항목을 선택해 주세요");	
					return;
				}


				$("#span_loading").show();
				
				var width = "938";
				var height = "654";

				var selectedItem = $("#item").val();

				document.chartForm.target = "chartFrame";
				document.chartForm.factCode.value = factCode;
				document.chartForm.branchNo.value = branchNo;
				document.chartForm.branchName.value = "";
				document.chartForm.sys_kind.value = sys;
				document.chartForm.width.value = width;
				document.chartForm.height.value = height;
				document.chartForm.item.value = selectedItem;
				document.chartForm.compareDate.value = replaceAll($("#compareDate").val(), "/" , "");

				document.chartForm.action = "<c:url value='/waterpolmnt/situationctl/getTotalMntDetailGraph_compare.do'/>";
				
				document.chartForm.submit();
		}
	</script>
</head>
<body class="subPop"><!-- 추가 및 수정 -->
<form id="chartForm" name="chartForm" method="post">
		<input type="hidden" name="factCode" />
		<input type="hidden" name="branchNo" />
		<input type="hidden" name="branchName" />
		<input type="hidden" name="sys_kind" />
		<input type="hidden" name="width"/>
		<input type="hidden" name="height"/>
		<input type="hidden" name="item"/>
		<input type="hidden" name="compareDate"/>
</form>
<div class="headerWrap">
	<div class="headerBg_r">
		<div class="header">
			<h1 style='font-size:large;font-weight:bold;color:white'><span id="branchName"></span> 수질변화 추이</h1>
		</div>
	</div>
</div>
<div class="contentWrap">
	<div class="contentBg_r">
		<div class="contentBox">
			<div class="contentPad"><!-- //추가 및 수정 -->
			
<div class="totalmntPop2" style="width:938px;height:714px">
	<div class="content" style="padding-top:20px">
	<center>
	</center>
			<ul class="selectList">
				<li><span class="buArrow_tit">항목</span>
					<select id="item">
						<option value="TUR00" selected="selected">탁도</option>
						<option value="DOW00">DO</option>
						<option value="TMP00">수온</option>
						<option value="PHY00">pH</option>
						<option value="CON00">전기전도도</option>
					</select>
				</li>
				<li>&nbsp;<span class="buArrow_tit">동시간대 추이 비교</span>
					<input type="text" class="inputText" id="compareDate" readonly="readonly" size="10" onchange="compare()"></input>
				</li>
			</ul>
		<div class="graph" style="height:660px">
			<span id="span_loading" style="position:absolute">데이터를 불러오는 중 입니다...</span>
			<iframe id="chart" name="chartFrame" onload="chart_load()" src="" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="100%"></iframe>
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

