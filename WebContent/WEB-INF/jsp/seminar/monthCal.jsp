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
<script type='text/javascript' src="<c:url value='/js/calendar/lib/jquery.min.js'/>"></script>
<script type='text/javascript' src="<c:url value='/js/calendar/lib/jquery-ui.custom.min.js'/>"></script>
<script type='text/javascript' src="<c:url value='/js/calendar/lib/moment.min.js'/>"></script>
<script type='text/javascript' src="<c:url value='/js/calendar/fullcalendar.js'/>"></script> 
<script type='text/javascript' src="<c:url value='/js/calendar/fullcalendar.min.js'/>"></script>
</head>
<script type="text/javascript">
//<![CDATA[
    $(document).ready(function() {
    	var searchYear = $('#searchYear').val();
    	var searchMonth = $('#searchMonth').val();
    	var maxcnt = $('#resultCnt').val();
    	var mode = 'month';
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
            defaultView: 'month',
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
            eventRender: function(event,element,calEvent) {},
            eventClick: function(calEvent, jsEvent, view) {},
            //마우스 오버시
    	    eventMouseover: function(calEvent, jsEvent, view) {},
    	    eventMouseout: function(calEvent, jsEvent, view) {}
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
			        		 	closingName:list[i].seminarClosingStateName,
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
//]]>
</script>
<style type='text/css'>
	#calendar {
		max-width: 900px;
		margin: 0 auto;
	}
	table th {
		background-color : #FFFFFF;
	}
</style>
<body style="overflow: hidden;">
	<div class="contentWrap">
		<div class="contentBg_r">
			<div class="contentBox">
				<div id='calendar' style='margin-top:15px;'></div>
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
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 -->
</body>
</html>