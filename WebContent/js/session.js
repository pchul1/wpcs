var globalTimer;
var globalStayTime;
var minute;
var second;
var isSession = true;

/* 시간 설정 & 세션 연장[전달인자 : 세션 유지 시간(초)] */
function setTime()
{
	var min = 0;
	var sec = arguments[0];
	if(60 < sec)
	{
		min = Math.floor(sec/60);
		sec = sec - min * 60;
	}
	minute = min;
	second = sec;
	isSession = true;
}

/* 시간 타이머 */
function timeclock()
{
	if (00 == second)
	{
		minute = minute - 1;
		second = 59;
	} else {
		second = second - 1;
	}
	if ((0 > minute) && (true == isSession))
	{
		clearTimeout(globalTimer);
		//$("#spanSession").html('세션이 만료되었습니다.');
		alert('세션이 만료되었습니다.');
		isSession = false;
		window.location.replace = "/common/login/actionLogout.do";
		return;
	}
	var m;
	var s;
	m = minute;
	if (10 > second)
	{
		s = 0 + second.toString();
	}
	else
	{
		s = second;
	}
	topSessionView(m,s);
}

function topSessionView(m,s){
	var text = "세션 만료 시간 "+m+":"+s;
	$("#spanSession").html(text);
}