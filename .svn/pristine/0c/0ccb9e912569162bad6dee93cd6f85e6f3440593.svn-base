<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : seminarMonthList.jsp
	 * Description : 교육일정 월간/주간 화면
	 * Modification Information
	 * 
	 * 수정일         		수정자                   수정내용
	 * -------    			--------    ---------------------------
	 * 2014.10.01		mypark		최초생성
	 *
	 * author mypark
	 * since 2014.10.01
	 *  
	 * Copyright (C) 2014 by 이용 All right reserved.
	 */  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>
<title>한국환경공단 수질오염 방제정보 시스템</title>
<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/calendar/fullcalendar.css'/>"/>
<script type='text/javascript' src="<c:url value='/js/calendar/lib/moment.min.js'/>"></script>
<script type='text/javascript' src="<c:url value='/js/calendar/fullcalendar.js'/>"></script> 
<script type='text/javascript' src="<c:url value='/js/calendar/fullcalendar.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/bbs/EgovBBSMng.js' />" ></script>
<script type="text/javascript">
//<![CDATA[
    $(document).ready(function() {
    	var searchYear = $('#searchYear').val();
    	var searchMonth = $('#searchMonth').val();
    	var maxcnt = $('#resultCnt').val();
    	var mode = $('#mode').val();
    	var cal_event = "[";    	
    	// 교육 내용
     	for(var i=0;i<maxcnt;i++){
     		var cal_title = $('#data_'+i).find('.seminarTitle').val();
			var cal_date_from = $('#data_'+i).find('.seminarDateFrom').val();
			var cal_date_to = $('#data_'+i).find('.seminarDateTo').val();
			var calDateFromTo = $('#data_'+i).find('.seminarDate').val();
			var cal_time_from = $('#data_'+i).find('.seminarTimeFrom').val();
			var cal_time_to = $('#data_'+i).find('.seminarTimeTo').val();
			var cal_place = $('#data_'+i).find('.seminarPlace').val();
			var cal_lect_name = $('#data_'+i).find('.seminarLectName').val();
			var cal_lect_tel = $('#data_'+i).find('.seminarLectTel').val();
			var cal_entry_date = $('#data_'+i).find('.seminarEntryDate').val();
			var cal_id = $('#data_'+i).find('.seminarId').val();
			var cal_host = $('#data_'+i).find('.seminarHost').val();
			var cal_gubun = $('#data_'+i).find('.seminarGubunName').val();
			var cal_closing_state = $('#data_'+i).find('.seminarClosingState').val();
			var cal_closing_name = $('#data_'+i).find('.seminarClosingStateName').val();
			if(i != 0){
				cal_event += ",";
			}
			var color = "#228fca";
			if(cal_closing_name == '신청예정') color = "#778899";
			else if(cal_closing_name == '신청마감') color = "#D3D3D3";
    		cal_event += "{";
    		cal_event += "id:'" + cal_id +"', ";
    		cal_event += "date:'" + calDateFromTo +"', ";
    		cal_event += "gubun:'" + cal_gubun +"', ";
    		cal_event += "place:'" + cal_place +"', ";
    		cal_event += "lectName:'" + cal_lect_name +"', ";
    		cal_event += "lectTel:'" + cal_lect_tel +"', ";
    		cal_event += "entryDate: '" + cal_entry_date +"', ";
    		cal_event += "host:'" + cal_host +"', ";
    		cal_event += "closing:'" + cal_closing_state +"', ";
    		cal_event += "timeFrom:'" + cal_time_from +"', ";
    		cal_event += "timeTo:'" + cal_time_to +"', ";
			cal_event += "title:'" + cal_title + "(" + cal_closing_name + ")" +"', ";
			cal_event += "start: moment('" + cal_date_from +"').format('YYYY-MM-DD'), ";
			cal_event += "end: moment('" + cal_date_to +"').add(1, 'days'), ";
			cal_event += "backgroundColor:'" + color +"'";
			cal_event += "}";
    	}
    	
		cal_event += "]";
		cal_event = eval(cal_event);

    	$('#calendar').fullCalendar({
    		lang: 'ko',
            header: {
                // title, prev, next, prevYear, nextYear, today
                left: 'prev',
                center: 'next',
                right: 'title'
            },
            // 시작요일
            firstDay:7, // 1:월요일
            // 토요일, 일요일 표시
            weekends: true,
            weekNumbers: false,
            ignoreTimezone:true,
            allDayDefault: true,
            eventLimit: false,
            // week 모드 (fixed, liquid, variable)
            weekMode: 'fixed',
            // 날짜 클릭 이벤트
            dayClick: function (date, allDay, jsEvent, view) {},
            viewDisplay: function() {},
            // 초기표시 보기
            defaultView: mode,
            columnFormat: {
            	month: "ddd",    // 월
            	week: "MM.DD ddd", // 7(월)
            	day: "dddd" // 7(월)
            },
            // 타이틀
            titleFormat: {
            	month: 'YYYY.MM',
           		week: "YYYY.MM.DD",
            	day: "YYYY.MM.DD"
        	},
            // 버튼 문자열
            buttonText: {
                prev:     '  <  ', // <
                next:     '  >  ', // >
                month:    '',
                week:     ''
            },
            editable: false,
            // 월명칭
            monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            // 요일명칭
            dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
            dayNamesShort: ['일요일(Sun)', '월요일(Mon)', '화요일(Tue)', '수요일(Wed)', '목요일(Thu)', '금요일(Fri)', '토요일(Sat)'],
            // 이벤트 소스
            //eventSources: [{ events: cal_event  }],
            //달력 내용 등록
            events: cal_event ,
            eventRender: function(event,element,calEvent) {
            	if(mode != 'month') {
            		//주간인 경우
            		var cal_btn_view = '<input type="button" id="btnView" name="btnView" class="btn btn_basic" style="float:left;" onclick="javascript:fn_view(\''+event.id+'\',\''+mode+'\');" style="float:right;" value="상세">';
            		var cal_btn_entry =  '<input type="button" id="btnEntry" name="btnEntry" class="btn btn_basic" style="float:left;" onclick="javascript:fn_egov_Entry(\''+event.id+'\',\''+mode+'\');" style="float:right;" value="신청">';
            		if(event.closing == 'N') cal_btn_entry = '';
            		var cal_title = element.find(".fc-content").html();
            		element.find(".fc-content").html("<div class='weekContent'><b>" + event.title + "</b><br/> 교육기간 : " + event.date 
            				+ "<br/> 교육시간 : " + event.timeFrom + "~" + event.timeTo
            				+ "<br/> 장소 : " + event.place + "<br/> 담당자 : " + event.lectName + " [" + event.lectTel + "]<br/> 주최 : "  + event.host + " (" + event.gubun + ")"
            				+  "<br/> 신청기간 : " + event.entryDate + "<br/><br/>" + cal_btn_view + cal_btn_entry + "</div>");
            	}
            },
            eventClick: function(calEvent, jsEvent, view) {},
            //마우스 오버시
    	    eventMouseover: function(calEvent, jsEvent, view) {
    	    	if(mode == 'month') {
            		var cal_btn_view = '<input type="button" name="btnView" class="btn btn_basic" onclick="javascript:fn_view(\''+calEvent.id+'\',\''+mode+'\');" style="float:right;" value="상세">';
    				var cal_btn_entry =  '<input type="button" id="btnEntry" name="btnEntry" class="btn btn_basic" onclick="javascript:fn_egov_Entry(\''+calEvent.id+'\',\''+mode+'\');" style="float:right;" value="신청">';
            		var cal_close = '<input type="button" id="btnTooltipXbox" name="btnTooltipXbox"  onclick="javascript:fn_tooltip_close();" value="X" class="btnTooltipXbox btn btn_white" style="width:18px" alt="닫기">'
    				//신청마감인경우, 교육신청 버튼 안보이게
            		if(calEvent.closing == 'N') cal_btn_entry = '';            		
            		var tooltip = '<div class="tooltipevent" style="display:none;"> <div class="tooltipbtn"> <div style="float:left;">'  + cal_btn_entry + cal_btn_view + '</div><div style="float:right;">' + cal_close +  '</div></div>';
            		tooltip += '<div class="tooltipTitle">' + calEvent.title +  '</div>';
            		tooltip +='<div class="tooltipBody"> 주최 : ' + calEvent.host + ' (' + calEvent.gubun + ')<br/> 교육기관 : '+ calEvent.date; 
            		tooltip +='<br/> 교육시간 : ' + calEvent.timeFrom + ' ~ ' + calEvent.timeTo + '<br/> 신청기간 : ' + calEvent.entryDate+ '<br/>' + calEvent.place + '</div>';
            		tooltip +='</div>';
            	    
            		$("body").append(tooltip);
            	    $(this).mouseover(function(e) {
            	    	$(this).css('z-index', 100);
            	        $('.tooltipevent').fadeIn('500');
            	        $('.tooltipevent').fadeTo('10', 1.9);
            	    }).mousemove(function(e) {
            	    	var xPoint = 0;
           	    	 	if(e.pageX > 1240) {
            	        	xPoint = e.pageX - 1240
            	        }
           	    	 	$('.tooltipevent').css('top', e.pageY - 175);
            	        $('.tooltipevent').css('left', e.pageX - xPoint);
            	    });
            	}
    	    },
    	    eventMouseout: function(calEvent, jsEvent, view) {
    	    	$("#calendar").on("mouseenter focusin", function(){
    	    		$('.tooltipevent').remove();
				});
    	    }
        }); //fullCalendar close

        //이전 버튼
        $('.fc-prev-button').click(function(){
        	renderEvent('prev', mode, moment);
        });
        
      	//다음 버튼
        $('.fc-next-button').click(function(){
        	renderEvent('next', mode, moment);
        });
	}); //document ready close
		
	//교육 등록 페이지 이동
	function fn_regist() {
		goMenu('/seminar/SeminarRegist.do','34200');
	}
	
	//교육 이벤트 등록
	function renderEvent(move, mode, moment) {
		var eventView = "";
		if(mode != 'month') {
    		//주간인 경우
    		var moments = $('#calendar').fullCalendar('getDate');
    		var weekYear = moments.format('YYYY');
    		var weekMonth = moments.format('MM');
    		if(weekYear == $('#searchYear').val() && weekMonth == $('#searchMonth').val()) return false;
    	}
		$.ajax({
			type: "POST",
			url: "<c:url value='/seminar/SeminarMonthWeek.do'/>",
			data: {searchYear:$('#searchYear').val() , searchMonth:$('#searchMonth').val() , mode:mode , move : move},
			dataType:"json",
			success : function(result){
				if(result != null) {
					$('#searchYear').val(result['curYear']);
					$('#searchMonth').val(result['curMon']);
					//등록되어 있던 이벤트 전부 삭제
					$('#calendar').fullCalendar( 'removeEvents');
					var list = result['resultList'];
					// 교육 내용
					for(var i=0;i<list.length;i++){
						var color = "#228fca";
						if(list[i].seminarClosingStateName == '신청예정') color = "#778899";
						else if(list[i].seminarClosingStateName == '신청마감') color = "#D3D3D3";
						
			    		$('#calendar').fullCalendar('renderEvent', {
    			    			id:list[i].seminarId,
			        			date:list[i].seminarDate,
			        		 	place:list[i].seminarPlace,
			        		 	host:list[i].seminarHost,
			        		 	closing:list[i].seminarClosingState,
			        			lectName:list[i].seminarLectName,
			        			lectTel:list[i].seminarLectTel,
			        			entryDate:list[i].seminarEntryDate,
			        			timeFrom:list[i].seminarTimeFrom,
			        			timeTo:list[i].seminarTimeTo,
			        			gubun:list[i].seminarGubunName,
			    				title: list[i].seminarTitle +'(' + list[i].seminarClosingStateName +')',
	                            start: list[i].seminarDateFrom,
	                            end: moment(list[i].seminarDateTo).add(1, 'days'),
	                            backgroundColor : color
   	                        }, true
   	                     );
			    	}
				}
			}
		});
	}

	//교육 신청 처리
	function fn_egov_Entry(seminarId , mode) {
		if(confirm("선택하신 교육을 신청하시겠습니까?")){
			var pageNo = 1;
			var url = "";
			if(mode == 'month') {
				url = "<c:url value='/seminar/SeminarSchedule.do?mode=month'/>"
			} else {
				url = "<c:url value='/seminar/SeminarSchedule.do?mode=basicWeek'/>"
			}
			if (pageNo == null) pageNo = 1;
			$.ajax({
				type: "POST",
				url: "<c:url value='/seminar/UpdateSeminarEntry.do'/>",
				data: {
						entryYn:'Y',
						seminarId:seminarId,
						pageIndex:pageNo
					},
				dataType:"json",
				success : function(result){
					if(result['resultStr'] == 'OK') {
						alert(result['msg']);
						goMenu("/common/member/MySeminarSchedule.do",61300);
					} else {
						alert(result['msg']);
					}
				}
			});
		}
	}
	
	//상세보기
	function fn_view(seminarId, mode) {
		document.frm.seminarId.value = seminarId;
		document.frm.action = "<c:url value='/seminar/SeminarApplicationView.do'/>";
		document.frm.urlStr.value = "SeminarSchedule.do?mode=" + mode;
		document.frm.submit();
	}
	
	//tooltip 닫기
	function fn_tooltip_close() {
    	$('.tooltipevent').remove();
	}
//]]>
</script>
<style type='text/css'>
	#calendar {
		max-width: 990px;
		margin: 0 auto;
	}
	table th {
		background-color : #FFFFFF;
	}
</style>
</head>
<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="wrap">
		
		<!-- Head Start-->
		<div id="header">
			<c:import url="/common/menu/header.do" />
		</div>
		<!-- Head End-->
		
		<!-- Body Start-->
		<div id="container">
			<div id="content_wrapper">
				
				<!--left menu Start-->
				<c:import url="/common/menu/left.do" />
				<!--left menu End-->
				
				<!-- Content Start-->
				<div id="content">
				
					<!-- navi, tab menu Start-->
					<c:import url="/common/menu/navi.do" />
					<!-- navi, tab menu End-->
					
					<!--tab Contnet Start-->
					<div class="tab_container">
						<!-- 달력 표시 -->
						<div id='calendar' ></div>
						<div id="cal_data" style="display:none;">
							<c:forEach var="list" items="${resultList}" varStatus="seq">
								<div id="data_${seq.index}">
									<input type="hidden" class="seminarTitle" value="<c:out value='${list.seminarTitle}'/>">
									<input type="hidden" class="seminarDateFrom" value="<c:out value='${list.seminarDateFrom}'/>">
									<input type="hidden" class="seminarDateTo" value="<c:out value='${list.seminarDateTo}'/>">
									<input type="hidden" class="seminarLectName" value="<c:out value='${list.seminarLectName}'/>">
									<input type="hidden" class="seminarLectTel" value="<c:out value='${list.seminarLectTel}'/>">
									<input type="hidden" class="seminarDate" value="<c:out value='${list.seminarDate}'/>">
									<input type="hidden" class="seminarEntryDate" value="<c:out value='${list.seminarEntryDate}'/>">
									<input type="hidden" class="seminarTimeFrom" value="<c:out value='${list.seminarTimeFrom}'/>">
									<input type="hidden" class="seminarTimeTo" value="<c:out value='${list.seminarTimeTo}'/>">
									<input type="hidden" class="seminarPlace" value="<c:out value='${list.seminarPlace}'/>">
									<input type="hidden" class="seminarGubunName" value="<c:out value='${list.seminarGubunName}'/>">
									<input type="hidden" class="seminarHost" value="<c:out value='${list.seminarHost}'/>">
									<input type="hidden" class="seminarId" value="<c:out value='${list.seminarId}'/>">
									<input type="hidden" class="seminarClosingState" value="<c:out value='${list.seminarClosingState}'/>">
									<input type="hidden" class="seminarClosingStateName" value="<c:out value='${list.seminarClosingStateName}'/>">
								</div>
							</c:forEach>
							<form name="frm" action ="" method="post">
								<input type="hidden" name="seminarId" value="" />
								<input type="hidden" name="checkSeminarId" value="" />
								<input type="hidden" name="entryYn" value="Y" />
								<input type="hidden" class="searchYear" name="searchYear" id="searchYear" value="<c:out value='${searchVO.searchYear}'/>">
								<input type="hidden" class="searchMonth" name="searchMonth" id="searchMonth" value="<c:out value='${searchVO.searchMonth}'/>">
								<input type="hidden" class="resultCnt" name="resultCnt" id="resultCnt" value="<c:out value='${resultCnt}'/>">
								<input type="hidden" class="urlStr" name="urlStr" id="urlStr" value="<c:out value='${searchVO.urlStr}'/>">
								<input type="hidden" class="mode" name="mode" id="mode" value="<c:out value='${searchVO.mode}'/>">
							</form>
						</div>
						<!-- 버튼 메뉴 -->
						<div style="padding-top:20px;">
						<span id="menuAuth1">
							<input type="button" id="btnRegist" name="btnRegist" class="btn btn_basic" onclick="javascript:fn_regist();" style="float:right;" value="교육등록">
						</span>
						</div>
						<!-- //버튼 메뉴 -->
					</div>
					<!--tab Contnet End-->
				</div>
				<!-- Content End-->
			</div>
		</div>
		<!-- Body End-->
		
		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
	</div>
	<script language="javascript">
	function menuAuth(auth){
		var iauthC ="";
		var iauthU ="";
		var iauthD ="";
		if(auth == "C"){
			iauthC ="Y";
		}
		if(auth == "U"){
			iauthU ="Y";
		}
		if(auth == "D"){
			iauthD ="Y";
		}
		var menuAuth = ""	;
		$.ajax({	
			type:"post",
			url: "<c:url value='/admin/member/getUserAuthorCnt.do'/>",
			dataType:"json",
			async: false,
			data:{
				userId:$("#userId").val(),
				menuId:$("#naviMenuNo").val(),
				authC:iauthC,
				authU:iauthU,
				authD:iauthD
			},
			success : function(result){
				var tot = 0;
				 tot = result['getUserMenuAuthorCount'];
				 menuAuth = tot;
			}
		});
		return menuAuth;
	}
	if("1" == menuAuth("C")){
		$("#menuAuth1").show();
	}else{
		$("#menuAuth1").hide();
	}
	</script>
</body>
</html>