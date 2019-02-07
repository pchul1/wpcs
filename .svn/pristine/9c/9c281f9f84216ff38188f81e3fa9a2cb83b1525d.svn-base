<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : ipusn.jsp
	 * Description : IP-USN 모니터링  화면
	 * Modification Information
	 * 
	 * 수정일			수정자 		수정내용
	 * -------		--------    ---------------------------
	 * 2010.05.17	kisspa		최초 생성
	 * 2013.10.20	lkh			 리뉴얼
	 * 2014.11.14  mypark    그리드 걷어내고 테이블 처리
	 *
	 * author kisspa
	 * since 2010.07.02
	 * version 1.0
	 * see
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>
<title>한국환경공단 수질오염 방제정보 시스템</title>
<%
	String startDate = request.getParameter("startDate");
	String endDate	 = request.getParameter("endDate");
%>
<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
<style type="text/css">
.nogood { color: red }
.good{ color: green } 
.device{ color: blue } 
</style>
<script type="text/javascript">
//<![CDATA[
     var list_p_total_cnt = 0;
	$(function () {
		setDate();
		showLoading();
		reloadData();
	});
	
	function setDate() {
		var startDate = '<%=startDate%>';
		var endDate	= '<%=endDate%>';
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		
		$("#startDate").datepicker({
			buttonText: '조회일자'
		});
		
		$("#endDate").datepicker({
			buttonText: '조회일자'
		});
		
		var today = new Date();
		today = today.getFullYear()+"/"+ addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
		
		var today2 = new Date();
		today2 = today2.getFullYear()+"/"+ addzero(today2.getMonth()+1) + "/01" ;
		
		//var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 24);
		//yday = yday.getFullYear()+ addzero(yday.getMonth()+1) + addzero(yday.getDate());
		
		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}
		
		//날짜 초기값 Setting	
		if(startDate == 'null'){
			$("#startDate").val(today);
		}
		if(endDate == 'null'){
			$("#endDate").val(today);
		}
	}
	
	function commonWork(n) {
		var stdt = document.getElementById("startDate");
		var endt = document.getElementById("endDate");
		var dateCheck = /^(19[7-9][0-9]|20\d{2})\/(0[0-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])$/;
		
		if(stdt.value !=''){
			if(dateCheck.test(stdt.value)!=true){
				
				var returnValue = commonWork2(stdt.value, "startDate");
				
				//숫자만 입력 체크를 통과못하면.
				if(returnValue != 'true'){
					alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
					stdt.value = "";
					stdt.focus;
					return false;
				}
			}
		}
		if(endt.value !=''){
			if(dateCheck.test(endt.value)!=true){
				
				var returnValue = commonWork2(endt.value, "endDate");
				
				//숫자만 입력 체크를 통과못하면.
				if(returnValue != 'true'){
					alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
					endt.value = "";
					endt.focus;
					return false;
				}
			}
		}
		
		var date = new Date(stdt.value).getTime();
		var overdate =  new Date(date + (60*60*24*31)*1000);
		var strdate = overdate.getFullYear()+ "/" + addzero(overdate.getMonth()+1) + "/" + addzero(overdate.getDate());
	}

	//숫자만 입력했을때 자동완성을 위한 함수
	// 1. 8자리 체크
	// 2. 1000 년이후 체크
	// 3. 월 체크
	// 4. 일 체크
	function commonWork2(dateValue, inputId){
		var returnValue = "";
		var checkNum = "";
		
		for(var i=0 ; i<dateValue.length ; i++){
			var checkCode = dateValue.charCodeAt(i);
			
			//숫자로만 이루어져 있는지 여부 체크.
			if( checkCode >= 48 && checkCode <= 57 ){
				checkNum	= "true";
			}else{
				returnValue = "false";
				checkNum	= "false";
				break;
			}
		}
		
		//숫자로만 이루어져 있다면.
		if(checkNum == "true"){
			if( dateValue.length != 8){ //8자리가 아니면 false;
				returnValue = "false";
			}else{
				
				//년 비교
				if( !(1000 < Number(dateValue.substr(0,4)) && Number(dateValue.substr(0,4)) <= 9999 )){
					returnValue = "false";
				}else{
					var month = ["01","02","03","04","05","06","07","08","09","10","11","12"];
					var monthCheck = 'false';
					
					for(var j=0 ; j < month.length ; j++){
						if(Number(dateValue.substr(4,2)) == month[j]){
							monthCheck = 'true';
							break;
						}
					}
					
					//월 비교 통과했다면.
					if(monthCheck == 'true'){
						var day = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"];
						var dayCheck = 'false';
						
						for(var k=0 ; k < day.length ; k++){
							if(Number(dateValue.substr(6,2)) == day[k]){
								dayCheck = 'true';
								break;
							}
						}
						
						//일체크를 통과했다면.
						if(dayCheck == 'true'){
							var tempVar = dateValue.substr(0,4) + '/' + dateValue.substr(4,2) + '/' + dateValue.substr(6,2);
							document.getElementById(inputId).value = tempVar;
							returnValue = 'true';
						}else{
							returnValue = "false";
						}
						
					}else{
						returnValue = "false";
					}
				}
			}
		}
		return returnValue;
	}
	// 데이터 목록 불러오기
	function reloadData(pageNo){
		/////////////////////////////////////검색//////////////////////////////////
		showLoading();
		//수계
		var fact_code = '${param_s.fact_code}'; 
		var branch_no = '${param_s.branch_no}';

		var startDate	= $("#startDate").val().split('/').join('');
		var endDate		= $("#endDate").val().split('/').join('');
		var sugye		= $("#sugye").val();
		var searchObsCd = $("#searchObsCd").val();
		var dataType	= $("#dataType").val();
		var frTime		= $("#frTime").val();
		var toTime		= $("#toTime").val();
		
		startDate += frTime; 
		endDate += toTime; 
			
		if (pageNo == null) pageNo = 0;
		$.ajax({
			type: "POST",
			url: "<c:url value='/ipusn/getipusnbranchhistorylist.do'/>",
			data: {
					pageIndex:pageNo,
					fact_code:fact_code,
					startDate:startDate,
					endDate:endDate,
					branch_no:branch_no
			},
			dataType:"json",
			success : function(result){
// 				console.log("reload 결과 값 확인 : ",result);
				var tot = result['resultList'].length;
				var totcnt = result['totCnt'];
				var dataHtml="";
				if( tot <= 0 ){
					dataHtml="<tr><td colspan='9'>조회 결과가 없습니다.</td></tr>";
				}else{
					var backcolor = new Array(); 
					for(var i=0; i < tot; i++){
						var obj = result['resultList'][i];
						obj.no = i;
						var colorCss="";
						switch(SelectIpUsnDistance(obj.latitude1, obj.longitude1, obj.latitude2, obj.longitude2, "M", obj.gps_dist)){
							case 0 : 
								obj.nowlocation = "위치불명";
								break;
							case 1 :
								obj.nowlocation = "위치없음";
								break;
							case 2 : 
								obj.nowlocation = "위치이탈";
								colorCss =  "nogood";
								break;
							case 3 :
								obj.nowlocation = "위치정상";
								colorCss =  "good";
								break;
						}
						obj.device_st = SelectIpUsnstr(obj.device_st);
						dataHtml += "<tr>";
						dataHtml += "<td>" + obj.rn +"</td>";
						dataHtml += "<td>" + obj.river_div_name +"</td>";
						dataHtml += "<td>" + obj.branch_name +"</a></td>";
						dataHtml += "<td>" + obj.temperature +"</td>";
						dataHtml += "<td>" + obj.humidity +"</td>";
						dataHtml += "<td>" + obj.battery +"</td>";
						dataHtml += "<td>" + obj.input_time +"</td>";
						dataHtml += "<td><a href='#' onClick='OpenWindow(\"" + obj.branch_no + "\" ,\"" + obj.fact_code + "\")'><span class='" + colorCss +"'>" + obj.nowlocation +"</span></a></td>";
						dataHtml += "<td>" + obj.device_st +"</td>";
						dataHtml += "</tr>";
					}
				}
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				$("#dataList tr:odd").attr("class","even");
				// 총건수 표시
				$("#p_total_cnt").html("[총 " + totcnt + "건]");
				list_p_total_cnt = totcnt;
				var pageStr = makePaginationInfo(result['PaginationInfo']);
				$("#pagination").empty();
				$("#pagination").append(pageStr);
				$("#pagination").show();
				closeLoading();
			},
			error:function(result){
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null ) {
					var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				dataView.getItemMetadata = function () {
					return {"columns":{0:{"colspan":"*"}}};
				}
				var dataHtml="<tr colspan='9'><td>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "</td></tr>";
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				
				closeLoading();
			}
		});
	}

	function excelDown(){

		var startDate	= $("#startDate").val().split('/').join('');
		var endDate		= $("#endDate").val().split('/').join('');
		var sugye		= $("#sugye").val();
		var searchObsCd = $("#searchObsCd").val();
		var dataType	= $("#dataType").val();
		var frTime		= $("#frTime").val();
		var toTime		= $("#toTime").val();
		
		startDate += frTime; 
		endDate += toTime; 
		var param = "";
		if(Number(list_p_total_cnt) == 0){
			alert('조회 결과가 없습니다.');
		} else if(Number(list_p_total_cnt) > 60000){
			alert('6만건 이상 다운로드 되지 않습니다.');
		} else{
			param = "branch_no=${param_s.branch_no}";
			param += "&fact_code=${param_s.fact_code}";
			param += "&startDate="+startDate;
			param += "&endDate="+endDate;
			location.href = "/ipusn/getExcelipusnbranchhistorylist.do?" + param;
		}
	}
	
	function SelectIpUsnDistance(latitude1, longitude1, latitude2, longitude2, mode, desc_dist){
		if(!latitude2){
			return 0;
		}else{
		    var gps_dist = Number(desc_dist);
			var Lat1 = Number(latitude1);
			var Long1 = Number(longitude1);
			var Lat2 = Number(latitude2);
			var Long2 = Number(longitude2);
			 
	        var dLat1InRad = Lat1 * (3.14159265358979323846/ 180.0);
	        var dLong1InRad = Long1 * (3.14159265358979323846/ 180.0);
	        var dLat2InRad = Lat2 * (3.14159265358979323846/ 180.0);
	        var dLong2InRad = Long2 * (3.14159265358979323846/ 180.0);
	
	        var dLongitude = dLong2InRad - dLong1InRad;
	        var dLatitude = dLat2InRad - dLat1InRad;
	
	        // Intermediate result a.
	        var a = Math.pow(Math.sin(dLatitude / 2.0), 2.0) + 
	            Math.cos(dLat1InRad) * Math.cos(dLat2InRad) * 
	            Math.pow(Math.sin(dLongitude / 2.0), 2.0);
	
	        // Intermediate result c (great circle distance in Radians).
	        var c = 2.0 * Math.atan2(Math.sqrt(a), Math.sqrt(1.0 - a));
	
	        // Distance.
	        // const Double kEarthRadiusMiles = 3956.0;
	        var kEarthRadiusKms = 6376.5;
	        dDistance = kEarthRadiusKms * c;
	        
	        if(mode == "M"){	//미터
	        	dDistance = dDistance*1000;
	        }else if(mode == "K"){	//킬로미터
	        	dDistance = dDistance;
	        }
	        	
			if(dDistance > gps_dist) {
				if(latitude2 == "0" ) {
					return 1;
				} else {
					return 2;
				}
			} else {
				return 3;
			}
		}
    }		
	
	function linkPage(n){
		reloadData(n);
	}
	function SelectIpUsnstr(device_st){
		switch(device_st){
			case "OK" : return "정상"; break; 
			case "A0" : return "전원이상 - 메인전원"; break;
			case "B0" : return "점검/보수중 - 측정기기 보수"; break; 
			case "B1" : return "점검/보수중 - 측정기기 부품 교환(센서, 기타)"; break;
			case "B2" : return "점검/보수중 - 측정기기 부품 교환"; break;
			case "B3" : return "점검/보수중 - 측정기기 Overhaul cleaning"; break;
			case "B4" : return "점검/보수중 - 측정기기 점검(정기, 수시)"; break;
			case "B5" : return "점검/보수중 - 전송장비 점검/보수"; break;
			case "C0" : return "장비이상 - 측정기기 이상"; break;
			case "E1" : return "교정중 - 수동 교정"; break;
			case "E2" : return "교정중 - 정도 관리"; break;
			case "F0" : return "시운전 - 시운전"; break;
			case "G0" : return "가동중지 - 가동중지(측정기)"; break;
			case "Z9" : return "영구중단"; break;
		}
	}

	function OpenWindow(branch_no, fact_code) {
		var param = "branch_no="+ branch_no + "&fact_code=" + fact_code;
		url = "/ipusn/getipusnmap.do?" + param;
		var qResult = window.open( url, "getipusnmap", "width=600, height=600,left=200,top=200,toolbar=no,status=yes,scrollbars=no,resizable=no");
		//return qResult;
	}
//]]>
</script>
</head>

<body style="margin: 0 10px 0px 10px; overflow:hidden;" >
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="/images/common/ajax-loader2.gif" alt="로딩중.." />
	</div>
	<div>
		<!-- Body Start-->
		<div id="container">
			<div style="padding-bottom:0px;padding-top:20px;">
				<!-- Content Start-->
				<div style="width:990px;">
					<div class="searchBox">
							<ul>
								<li>
									<span class="fieldName">조회기간</span>
									<input type="text" size="13" id="startDate" name="startDate" onchange="commonWork(this)"/>
									<select id="frTime" name="frTime" onchange="commonWork(this)">
										<option value="00">00</option>
										<option value="01">01</option>
										<option value="02">02</option>
										<option value="03">03</option>
										<option value="04">04</option>
										<option value="05">05</option>
										<option value="06">06</option>
										<option value="07">07</option>
										<option value="08">08</option>
										<option value="09">09</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
										<option value="13">13</option>
										<option value="14">14</option>
										<option value="15">15</option>
										<option value="16">16</option>
										<option value="17">17</option>
										<option value="18">18</option>
										<option value="19">19</option>
										<option value="20">20</option>
										<option value="21">21</option>
										<option value="22">22</option>
										<option value="23">23</option>
									</select>
									<span>~</span>
									<input type="text" size="13" id="endDate" name="endDate" onchange="commonWork(this)"/>
									<select id="toTime" name="toTime" onchange="commonWork(this)">
										<option value="00">00</option>
										<option value="01">01</option>
										<option value="02">02</option>
										<option value="03">03</option>
										<option value="04">04</option>
										<option value="05">05</option>
										<option value="06">06</option>
										<option value="07">07</option>
										<option value="08">08</option>
										<option value="09">09</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
										<option value="13">13</option>
										<option value="14">14</option>
										<option value="15">15</option>
										<option value="16">16</option>
										<option value="17">17</option>
										<option value="18">18</option>
										<option value="19">19</option>
										<option value="20">20</option>
										<option value="21">21</option>
										<option value="22">22</option>
										<option value="23" selected="selected">23</option>
									</select>
								</li>
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData(1);" alt="조회하기" style="float:right;"/>
						</div>
					<div id="btArea">
						<span id="p_total_cnt">▶ 검색결과 [총 ${totCnt}건]</span>
						<input type="button" id="excel" name="excel" class="btn btn_excel" onclick="javascript:excelDown();" alt="엑셀"/>
					</div>
					<div class="table_wrapper">
						<table summary="게시판 목록. 번호, 수계, 지점명, 온도, 습도, 배터리, 접속시간, 위치, 장비상태가 담김">
							<colgroup>
								<col width="60" />
								<col width="100" />
								<col width="120" />
								<col width="60" />
								<col width="60" />
								<col width="70" />
								<col width="150" />
								<col width="120" />
								<col width="250" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">No.</th>
									<th scope="col">수계</th>
									<th scope="col">지점명</th>
									<th scope="col">온도</th>
									<th scope="col">습도</th>
									<th scope="col">배터리</th>
									<th scope="col">접속시간</th>
									<th scope="col">위치</th>
									<th scope="col">장비상태</th>
								</tr>
							</thead>
							<tbody id="dataList">
							</tbody>
						</table>
						<div class="paging">
							<div id="page_number">
								<ul class="paginate" id="pagination"></ul>
							</div>
						</div>
					</div>
				</div>
				<!-- Content End-->
			</div>
		</div>
		<!-- Body End-->
	</div>
</body>
</html>