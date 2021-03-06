<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<title>한국환경공단 수질오염 방제정보 시스템</title>
<link rel="stylesheet" type="text/css" href="/css/newFrontCommon.css"/>
<script type="text/javascript" src="<c:url value='/js/JQuery/jquery-1.3.2.min.js'/>"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/tab.js"></script>
<script type="text/javascript" src="<c:url value='/js/bbs/EgovBBSMng.js' />" ></script>
<script type="text/javascript">
//<![CDATA[
	function fnAccountStep(){
		var radio_policy = $('input[name="radio_policy"]:checked').val();
		
		if(radio_policy=='N'){
			alert("개인정보 동의하지 않는 경우 계정신청을 진행 하실 수 없습니다.");
			return;
		}else{
			document.frm.action = "<c:url value='/acc/accountAppInfo.do'/>";
			document.frm.submit();
		}
	}
//]]>
</script>
</head>
<body>
<!-- wrap -->

<div id="wrap"> 
  
	<!--header -->
	<div class="header_wrap">
		<c:import url="/WEB-INF/jsp/pub/include/client_header.jsp"/>
	</div>
	<!--header --> 
  
	<!--container -->
	<div class="container_wrap">
		<div id="container"> 
		    
			<!--content wrap -->
			<div class="content_wrap">
				<div id="snb">
					<c:import url="/WEB-INF/jsp/pub/include/leftMenu6.jsp"/>
				</div>
				<div class="content">
					<!-- Navi -->
					<p class="spot">홈 &gt; 계정신청 &gt; <span class="point">계정신청</span></p>
					<h3>계정신청</h3>
					<!-- Navi -->
					<div class="list_type01">
						<img src="/images/new/account_info.png"alt="계정신청"/>
					</div>
					<div class="list_type01">
						<form:form commandName="frm" name="frm" method="post" >	

						<!-- width_div_1 -->
						<div class="width_div_1 mgt40">
							<h4>회원 이용약관 안내</h4>
							
							<div class="jon_scroll_box">
								<h4 class="join_title">제 1장 총 칙</h4>
								
								<h5 class="join_title_s mgt20">제 1 조 (목적)</h5>
			
								<p class="black mgt10">이 약관은 한국환경공단(이하'공단'이라 한다)에서 제공하는 수질오염방제정보시스템(www.waterkorea.or.kr)에서 제공하는 모든 서비스(이하 '서비스'라 한다)의 이용조건 및 절차, 이용자와 당 홈페이지의 권리, 의무, 책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.</p>
			
								<h5 class="join_title_s mgt20">제 2 조 (약관의 효력과 변경)</h5>
			
								<ul class="jon_scroll_box.join_list mgt10">
								<li><span class="join_number">1) </span>당 홈페이지는 이용자가 본 약관 내용에 동의하는 것을 조건으로 이용자에게 서비스를 제공할 것이며, 이용자가 본 약관의 내용에 동의하는 경우, 당 홈페이지의 서비스 제공 행위 및 이용자의 서비스 이용 행위는 본 약관이 우선적으로 적용 될 것입니다.</li>
								<li><span class="join_number">2) </span>공단이 필요하다고 인정하는 경우에는 약관의 규제에 관한 법률 및 기타 관련 법령에 위배되지 않는 범위 내에서 본 약관을 변경할 수 있으며, 약관이 변경된 경우에는 지체 없이 당 홈페이지 내에 공지함과 동시에 회원가입시 기입한 이메일을 통해 공지함으로써 이용자가 직접 확인하도록 할 것입니다.</li>
								<li><span class="join_number">3) </span>변경된 약관은 공지와 동시에 그 효력이 발생되며, 이용자가 변경된 약관에 동의하지 아니하는 경우, 이용자는 본인의 회원등록을 취소(회원탈퇴)할 수 있습니다. 단, 공지된 이후 이메일 회신 등 별도의 거부의사를 표시하지 아니하고 서비스를 7일이상 계속 사용할 경우에는 약관 변경에 동의한 것으로 간주됩니다. 변경된 약관에 대한 정보를 알지 못해 발생하는 이용자의 피해는 공단에서 책임지지 않습니다.</li>
								</ul>
								
								<h5 class="join_title_s mgt20">제 3 조 (약관 외 준칙)</h5>
			
								<p class="black mgt10">본 약관에 명시되지 않은 사항은 전기통신기본법, 전기통신사업법, 방송통신심의위원회 정보통신에 관한 심의규정, 저작권법 및 기타 관계 법령의 규정에 의합니다.</p>
			
								<h5 class="join_title_s mgt20">제 4 조 (용어의 정의)</h5>
			
								<p class="black mgt10">본 약관에서 사용하는 용어의 정의는 다음과 같습니다.</p>
								<ul class="jon_scroll_box.join_list mgt10">
								<li>
									<ul class="jon_scroll_box.join_list_s">
									<li><span class="join_number_s">1) </span>이용자 : 당 홈페이지에 접속하여 당 홈페이지에서 제공하는 서비스를 받는 회원 및 비회원을 말합니다.</li>
									<li><span class="join_number_s">2) </span>회원 : 당 홈페이지에 접속하여 이 약관에 동의하고, ID(고유번호)와 비밀번호를 발급받은 자로 당 홈페이지의 정보 및 서비스를 이용할 수 있는 자를 말합니다.</li>
									<li><span class="join_number_s">3) </span>비회원 : 회원가입을 하지 않고 당 홈페이지에서 제공하는 서비스를 이용하는 자를 말합니다.</li>
									<li><span class="join_number_s">4) </span>ID(고유번호) : 회원 식별과 회원의 서비스 이용을 위하여 이용자가 선정하고 당 홈페이지에서 승인하는 영문자와 숫자의 조합(하나의 ID만 발급, 이용가능)을 말합니다.</li>
									<li><span class="join_number_s">5) </span>비밀번호 : 회원 아이디와 일치된 회원임을 확인하는 번호로써, 회원의 비밀보호를 위해 회원자신이 선정한 문자와 숫자의 조합을 말합니다.</li>
									<li><span class="join_number_s">6) </span>회원가입 : 회원이 당 홈페이지에서 제공하는 신청서 양식에 해당 정보를 기입하고, 본 약관에 동의하여 서비스 이용계약을 완료시키는 행위를 말합니다.</li>
									<li><span class="join_number_s">7) </span>회원탈퇴 : 회원이 이용계약을 종료시키는 의사표시입니다.</li>
									</ul>
								</li>
								</ul>
			
								<h4 class="join_title mgt20">제 2 장 서비스 제공 및 이용</h4>
			
								<h5 class="join_title_s mgt20">제 5 조 (이용계약의 성립)</h5>
			
								<ul class="jon_scroll_box.join_list mgt10">
								<li><span class="join_number">1) </span>회원이 되고자하는 이용자는 온라인을 통하여 인증서 등록신청 및 인증서 변경등록 페이지의 ‘개인식별정보 수집동의 안내에 동의합니다’ 체크함으로써 당 홈페이지의 본 약관 내용에 대한 동의표시를 합니다.</li>
								<li><span class="join_number">2) </span>본 약관에 동의한 이용자는 공단이 요구하는 방법에 의해 본인확인 절차를 거치며, 만14세 미만의 경우는 법정대리인의 동의가 수반되어야 합니다.</li>
								<li><span class="join_number">3) </span>공단과 이용자 간의 서비스 이용계약은 본인확인 절차를 거친 이용자가 당 홈페이지에서 제공하는 양식에 따라 요구하는 사항을 기록함으로써 회원가입을 완료하는 것으로 성립됩니다.</li>
								<li><span class="join_number">4) </span>당 홈페이지는 다음 각 항에 해당하는 경우 그 사유가 해소될 때까지 이용계약 성립을 유보할 수 있습니다.</li>
								<div style="border:1px solid #333333;padding-left:20px"><b><i><u>① 서비스 관련 제반 용량이 부족한 경우</u></i></b>
								<br/><b><i><u>② 기술상 장애 사유가 있는 경우</u></i></b></div>
								<li><span class="join_number">5) </span>당 홈페이지의 서비스는 변경될 수 있으며, 변경 사항은 홈페이지 내 공지사항을 통해 이용자에게 알리고 별도의 동의가 필요한 경우, 회원가입시 기입한 이메일을 통해 별도의 동의를 받을 수 있습니다.</li>
								</ul>
			
								<h5 class="join_title_s mgt20">제 6 조 (회원가입 및 탈퇴)</h5>
			
								<ul class="jon_scroll_box.join_list mgt10">
								<li><span class="join_number">1) </span>회원가입은 이용자가 인터넷을 통해 약관의 동의절차와 회원가입절차를 완료하는 것으로 성립됩니다. 회원가입은 반드시 실명으로만 가입할 수 있으며 당 홈페이지는 실명확인 조치를 할 수 있습니다.</li>
								<li><span class="join_number">2) </span>당 홈페이지는 다음 각 호에 해당하는 회원가입 신청에 대하여는 가입을 승낙하지 아니할 수 있습니다. </li>
								<div style="border:1px solid #999999;padding-left:20px"><b><i><u>① 실명인증이 되지 않거나 주민번호 등 중요 사항이 타인의 정보와 중복되는 경우</u></i></b>
								<br/><b><i><u>② 만14세 미만의 경우, 법정대리인의 동의가 없는 경우</u></i></b>
								<br/><b><i><u>③ 기타 당 홈페이지가 정한 회원가입 요건을 충족하지 못하였을 경우</u></i></b></div>
								<li><span class="join_number">3) </span>당 홈페이지는 다음 각 호에 해당하는 경우 회원가입을 취소할 수 있습니다. </li>
								<div style="border:1px solid #333333;padding-left:20px"><b><i><u>① 다른 사람의 명의를 사용하여 신청하였을 경우</u></i></b>
								<br/><b><i><u>② 만14세 미만의 경우, 명의도용에 의해 법정대리인의 동의를 득한 것이 발견된 경우</u></i></b>
								<br/><b><i><u>③ 이용 계약 신청서의 내용을 허위로 기재한 사실이 발견된 경우</u></i></b>
								<br/><b><i><u>④ 다른 사람의 당 홈페이지 서비스 이용을 방해하거나 다른 사람의 정보를 도용하는 등의 행위를 하였을 경우</u></i></b>
								<br/><b><i><u>⑤ 당 홈페이지를 이용하여 법령과 본 약관이 금지하는 행위를 하는 경우⑥ 영리를 추구할 목적으로 본 서비스를 이용하고자 하는 경우</u></i></b></div>
								<li><span class="join_number">4) </span>회원은 회원가입 이후 당 홈페이지에서 제공하는 서비스를 제공받을 의사를 철회하고자 하는 경우에는 언제든지 "회원탈퇴"를 요구할 수 있으며, 당 홈페이지는 즉시 회원탈퇴 처리를 합니다.</li>
								</ul>
			
			 
								<h5 class="join_title_s mgt20">제 7 조 (회원ID부여 및 변경, 회원ID 및 비밀번호 찾기)</h5>
			
								<ul class="jon_scroll_box.join_list mgt10">
								<li><span class="join_number">1) </span>당 홈페이지는 본 약관에 정하는 바에 따라 회원ID를 부여합니다.</li>
								<li><span class="join_number">2) </span>회원ID는 원칙적으로 변경이 불가하며 부득이한 사유로 인하여 변경하고자 하는 경우에는 해당 회원등록을 탈퇴(해지)하고 재가입해야 합니다. 단, 탈퇴(해지)한 회원은 기존 회원ID로 서비스를 이용할 수 없습니다.</li>
								<li><span class="join_number">3) </span>회원은 등록된 본인의 회원정보가 변경된 경우, 즉시 변경된 내용으로 회원정보를 수정하여야 하며, 공단은 회원이 변경사항을 수정하지 아니하여 발생하는 불이익에 대하여 책임지지 않습니다.</li>
								<li><span class="join_number">4) </span>회원ID 분실시 본인 확인을 거친 후 회원ID를 당 홈페이지를 통해 확인할 수 있도록 제공합니다.</li>
								</ul>
								
								<h5 class="join_title_s mgt20">제 8 조 (회원정보 사용에 대한 동의)</h5>
			
								<p class="black mgt10">당 홈페이지는 “개인정보보호법”등 관계 법령 및 공단의 개인정보처리방침이 정하는 바에 따라 회원의 개인정보를 보호하기 위해 노력합니다.</p>
								
								<h5 class="join_title_s mgt20">제 9 조 (회원의 정보 보안)</h5>
			
								<ul class="jon_scroll_box.join_list mgt10">
								<li><span class="join_number">1) </span>회원가입 신청자는 당 홈페이지 서비스 가입 절차를 완료하는 순간부터 회원으로서 입력한 정보의 비밀을 유지할 책임이 있으며, 회원의 ID와 비밀번호에 관한 관리와 회원의 ID와 비밀번호를 사용하여 발생하는 모든 결과에 대한 책임은 회원 본인에게 있습니다.</li>
								<li><span class="join_number">2) </span>회원은 회원의 ID나 비밀번호가 부정하게 사용되었다는 사실을 발견한 경우에는 즉시 당 홈페이지에 신고하여야 합니다. 신고를 하지 않음으로 인한 모든 책임은 회원 본인에게 있습니다.</li>
								<li><span class="join_number">3) </span>회원은 당 홈페이지 서비스의 사용 종료 시마다 정확히 접속을 종료(Log-out)하도록 해야 하며, 공공장소에서는 웹 브라우저를 종료하고 ID, 비밀번호 등의 회원정보가 타인에게 노출되지 않도록 이용기록 삭제 등의 조치를 하여야 합니다.</li>
								<li><span class="join_number">4) </span>공단은 회원이 홈페이지 사용을 정확히 종료하지 아니함으로써 제3자가 회원에 관한 정보를 도용하게 되는 등의 결과로 인해 발생하는 손해 및 손실에 대하여 책임을 부담하지 아니합니다.</li>
								</ul>
								
								<h5 class="join_title_s mgt20">제 10 조 (서비스 이용시간)</h5>
			
								<ul class="jon_scroll_box.join_list mgt10">
								<li><span class="join_number">1) </span>서비스 이용시간은 공단의 업무상 또는 기술상 특별한 지장이 없는 한 연중무휴, 1일 24시간을 원칙으로 합니다. 다만, 정기점검 등의 필요로 인하여 공단이 정한 날 또는 시간은 예외로 하며, 사전에 공지합니다.</li>
								<li><span class="join_number">2) </span>공단은 정전 등 서비스를 제공하지 못할 만한 합리적인 이유가 있는 경우에는 서비스의 제공을 중단할 수 있습니다.</li>
								</ul>
								
								<h5 class="join_title_s mgt20">제 11 조 (서비스의 중지 및 중지에 대한 공지)</h5>
			
								<ul class="jon_scroll_box.join_list mgt10">
								<li><span class="join_number">1) </span>회원은 당 홈페이지 서비스에 보관되거나 전송된 메시지 및 기타 통신 메시지 등의 내용이 국가 비상사태, 정전, 당 홈페이지의 관리 범위 외의 서비스 설비 장애 및 기타 불가항력에 의하여 삭제되었거나 보관되지 못한 경우, 전송되지 못하거나 통신 데이터의 손실이 있을 경우에 공단에 관련 책임을 부담하지 아니합니다.</li>
								<li><span class="join_number">2) </span>국가의 비상사태, 정전, 당 홈페이지의 관리범위 외 서비스 설비장애 및 기타 불가항력의 경우 위 사전 고지기간은 감축되거나 생략될 수 있습니다. 또한 위 서비스 중지에 의하여 본 서비스에 보관되거나 전송된 메시지 및 기타 통신 메시지 등의 내용이 보관되지 못하였거나 삭제된 경우, 전송되지 못한 경우 및 기타 통신 데이터의 손실이 있을 경우에 대하여도 공단은 책임을 부담하지 아니합니다.</li>
								<li><span class="join_number">3) </span>당 홈페이지가 정상적인 서비스 제공이 어려움으로 인하여 일시적으로 서비스를 중지하여야 할 경우에는 서비스 중지 전에 당 홈페이지에 서비스 중지사유 및 일시를 공지한 후 서비스를 중지할 수 있으며, 이 기간 동안 이용자가 공지내용을 인지하지 못한 데 대하여 공단은 책임을 부담하지 아니합니다.</li>
								<li><span class="join_number">4) </span>당 홈페이지의 사정으로 서비스를 영구적으로 중단하여야 할 경우에는 서비스 중단 1개월 전에 당 홈페이지에 서비스 중단사유 및 일시를 공지한 후 서비스를 중단할 수 있으며, 이 기간 동안 이용자가 공지내용을 인지하지 못한 데 대하여 공단은 책임을 부담하지 아니합니다.</li>
								<li><span class="join_number">5) </span>당 홈페이지는 사전 공지 후 서비스를 일시적으로 수정, 변경 및 중단할 수 있으며, 공단은 이에 대하여 이용자 또는 제3자에게 어떠한 책임도 부담하지 아니합니다.</li>
								<li><span class="join_number">6) </span>당 홈페이지는 이용자가 본 약관의 내용에 위배되는 행동을 한 경우, 사전고지 없이 서비스 사용을 제한 및 중지할 수 있습니다.</li>
								</ul>
								
								<h5 class="join_title_s mgt20">제 12 조 (정보 제공 및 홍보물 게재)</h5>
			
								<ul class="jon_scroll_box.join_list mgt10">
								<li><span class="join_number">1) </span>당 홈페이지는 서비스를 운영함에 있어서 각종 정보를 홈페이지에 게재하는 방법, 이메일이나 서신우편 발송 등으로 이용자에게 제공할 수 있습니다.</li>
								<li><span class="join_number">2) </span>회원은 제1항의 정보 제공을 원치 않을 경우 가입신청메뉴와 회원정보수정 메뉴에서 정보 수신거부를 설정할 수 있습니다.</li>
								</ul>
								
								<h5 class="join_title_s mgt20">제 13 조 (사용자의 행동규범 및 서비스 이용제한)</h5>
			
								<ul class="jon_scroll_box.join_list mgt10">
								<li><span class="join_number">1) </span>회원이 제공하는 정보의 내용이 허위인 것으로 판명되거나, 허위가 있다고 의심할 만한 합리적인 사유가 발생할 경우 공단은 회원의 서비스 이용의 일부 또는 전부를 중지할 수 있으며 이로 인해 발생하는 불이익에 대해서는 책임을 부담하지 아니합니다.</li>
								<li><span class="join_number">2) </span>당 홈페이지는 이용자가 본 약관 제16조(회원의 의무)등 본 약관의 내용에 위배되는 행동을 한 경우, 임의로 서비스 사용을 제한 및 중지할 수 있습니다.</li>
								</ul>
								
								<h4 class="join_title mgt20">제 3 장 의무 및 책임</h4>
			
								<h5 class="join_title_s mgt20">제 14 조 (당 홈페이지의 의무)</h5>
								<ul class="jon_scroll_box.join_list mgt10">
								<li><span class="join_number">1) </span>당 홈페이지는 법령과 본 약관이 금지하거나 미풍양속에 반하는 행위를 하지 않으며, 안정적으로 서비스를 제공하기 위해 노력할 의무가 있습니다.</li>
								<li><span class="join_number">2) </span>당 홈페이지는 서비스 제공과 관련해서 알고 있는 회원의 개인정보를 본인의 승낙 없이 제3자에게 누설, 제공하지 않습니다.</li>
								<li><span class="join_number">3) </span>다만, 정보주체 또는 제3자의 이익을 부당하게 침해할 우려가 있을 때를 제외하고는 다음 각 호의 어느 하나에 해당하는 경우에는 개인정보를 목적 외의 용도로 이용하거나 이를 제3자에게 제공할 수 있습니다. </li>
								<div style="border:1px solid #333333;padding-left:20px"><b><i><u>① 정보주체로부터 별도의 동의를 받은 경우</u></i></b>
								<br/><b><i><u>② 다른 법률에 특별한 규정이 있는 경우</u></i></b>
								<br/><b><i><u>③ 정보주체 또는 그 법정대리인이 의사표시를 할 수 없는 상태에 있거나 주소불명 등으로 사전 동의를 받을 수 없는 경우로서 명백히 정보주체 또는 제3자의 급박한 생명, 신체, 재산의 이익을 위하여 필요하다고 인정되는 경우</u></i></b>
								<br/><b><i><u>④ 통계작성 및 학술연구 등의 목적을 위하여 필요한 경우로서 특정 개인을 알아볼 수 없는 형태로 개인정보를 제공하는 경우</u></i></b>
								<br/><b><i><u>⑤ 개인정보를 목적 외의 용도로 이용하거나 이를 제3자에게 제공하지 아니하면 다른 법률에서 정하는 소관 업무를 수행할 수 없는 경우로서 보호위원회의 심의·의결을 거친 경우</u></i></b>
								<br/><b><i><u>⑥ 조약, 그 밖의 국제협정의 이행을 위하여 외국정부 또는 국제기구에 제공하기 위하여 필요한 경우</u></i></b>
								<br/><b><i><u>⑦ 범죄의 수사와 공소의 제기 및 유지를 위하여 필요한 경우</u></i></b>
								<br/><b><i><u>⑧ 법원의 재판업무 수행을 위하여 필요한 경우</u></i></b>
								<br/><b><i><u>⑨ 형(刑) 및 감호, 보호처분의 집행을 위하여 필요한 경우</u></i></b></div>
								<li><span class="join_number">4) </span>공단은 회원으로부터 제출되는 의견 및 불만사항이 정당하다고 판단하는 경우 신속히 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 회원에게 그 사유와 처리일정을 통지합니다.</li>
								<li><span class="join_number">5) </span>당 홈페이지는 이용자가 안전하게 당 홈페이지 서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함) 보호를 위한 보안시스템을 갖추어야 합니다.</li>
								</ul>
			
			 
								<h5 class="join_title_s mgt20">제 15 조 (회원의 의무)</h5>
			
								<ul class="jon_scroll_box.join_list mgt10">
								<li><span class="join_number">1) </span>회원 가입 시에 요구되는 정보는 정확하게 기입하여야 하며, 이미 제공된 회원에 대한 정보가 정확한 정보가 되도록 유지, 갱신하여야 합니다. 또한, 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.</li>
								<li><span class="join_number">2) </span>회원은 당 홈페이지의 사전 승낙 없이 서비스를 이용하여 어떠한 영리행위도 할 수 없습니다.</li>
								<li><span class="join_number">3) </span>회원은 당 홈페이지 서비스를 이용하여 얻은 정보를 당 홈페이지의 사전승낙 없이 복사, 복제, 변경, 번역, 출판·방송 기타의 방법으로 사용하거나 이를 타인에게 제공할 수 없습니다.</li>
								<li><span class="join_number">4) </span>회원은 본 서비스를 통하여 다음과 같은 행위를 금지합니다. </li>
								<li><span class="join_number">4) </span>회원은 본 서비스를 통하여 다음과 같은 행위를 금지합니다. </li>
								<div style="border:1px solid #333333;padding-left:20px"><b><i><u>① 타인의 아이디(ID)와 비밀번호를 도용하는 행위</u></i></b>
								<br/><b><i><u>② 저속, 음란, 모욕적, 위협적이거나 타인의 프라이버시를 침해할 수 있는 내용을 전송, 게시, 게재, 전자메일 또는 기타의 방법으로 전송하는 행위</u></i></b>
								<br/><b><i><u>③ 서비스를 통하여 전송된 내용의 출처를 위장하는 행위</u></i></b>
								<br/><b><i><u>④ 법률, 계약에 의하여 이용할 수 없는 내용을 게시, 게재, 전자메일 또는 기타의 방법으로 전송하는 행위</u></i></b></div>
								<li><span class="join_number">5) </span>당 홈페이지는 회원이 본 약관을 위배했다고 판단되면 당 홈페이지와 관련한 모든 이용정보를 이용자의 동의없이 삭제할 수 있습니다.</li>
								</ul>
			
								<h4 class="join_title mgt20">제 4 장 기타</h4>
								<h5 class="join_title_s mgt20">제 16 조 (당 홈페이지의 소유권)</h5>
								
								<ul class="jon_scroll_box.join_list mgt10">
								<li><span class="join_number">1) </span>당 홈페이지가 제공하는 서비스, 그에 필요한 소프트웨어, 이미지, 마크, 로고, 디자인, 서비스명칭, 정보 및 상표 등과 관련된 지적재산권 및 기타 권리는 공단에 소유권이 있습니다.</li>
								<li><span class="join_number">2) </span>회원은 당 홈페이지가 명시적으로 승인한 경우를 제외하고는 제17조제1항에 규정된 사항에 대한 소유권의 전부 또는 일부의 수정, 대여, 대출, 판매, 배포, 제작, 양도, 저작권 기한연장, 담보권 설정 행위, 상업적 이용 행위를 할 수 없으며, 제3자로 하여금 이와 같은 행위를 하도록 허락할 수 없습니다.</li>
								</ul>
								
								<h5 class="join_title_s mgt20">제 17 조 (양도금지)</h5>
								<p class="black mgt10">회원이 서비스의 이용권한, 기타 이용계약 상 지위를 타인에게 양도, 증여할 수 없으며, 이를 담보로 제공할 수 없습니다.</p>
								
								<h5 class="join_title_s mgt20">제 18 조 (손해배상)</h5>
								<p class="black mgt10">당 홈페이지는 무료로 제공되는 서비스와 관련하여 회원에게 어떠한 손해가 발생하더라도 아래 각항의 경우를 제외하고는 이에 대한 어떠한 책임도 부담하지 않습니다. </p>
			
								<ul class="jon_scroll_box.join_list mgt10">
								<li><span class="join_number">1) </span>당 홈페이지에서 고의로 행한 범죄행위</li>
								<li><span class="join_number">2) </span>당 홈페이지에서 제공하는 무료 서비스를 원천제공자의 동의 없이 유료서비스로 전환한 경우</li>
								<li><span class="join_number">3) </span>당 홈페이지에서 부당이득을 취할 목적으로 제14조(당 홈페이지의 의무)조항을 고의적으로 위반한 경우</li>
								</ul>
								
								<h5 class="join_title_s mgt20">제 19 조 (면책조항)</h5>
								
								<ul class="jon_scroll_box.join_list mgt10">
								<li><span class="join_number">1) </span>천재지변 또는 이에 준하는 불가항력으로 인하여 당 홈페이지의 서비스를 제공할 수 없는 경우 공단은 서비스 미제공에 대한 책임이 면제됩니다.</li>
								<li><span class="join_number">2) </span>서비스용 설비의 보수, 교체, 정기점검, 공사 등 부득이한 사유로 발생한 손해에 대해서는 공단의 책임이 면제됩니다.</li>
								<li><span class="join_number">3) </span>공단은 회원의 귀책사유로 인한 손해에 대해서는 책임을 지지 않습니다.</li>
								<li><span class="join_number">4) </span>공단은 당 홈페이지의 서비스에 표출된 회원의 의견이나 정보에 대해 대표할 의무가 없습니다.</li>
								<li><span class="join_number">5) </span>공단은 회원 상호간 또는 회원과 제3자간에 서비스를 매개로 하여 이루어진 물품거래 혹은 금전적 거래 등과 관련하여 어떠한 책임도 부담하지 아니하며 회원이 서비스의 이용과 관련하여 기대하는 이익에 관하여 책임을 부담하지 않습니다.</li>
								<li><span class="join_number">6) </span>공단은 어떠한 경우에도 회원이 당 홈페이지에서 제공하는 서비스에 담긴 정보에 의존해 얻은 이득이나 입은 손해에 대해 책임이 없습니다.</li>
								<li><span class="join_number">7) </span>공단은 당 홈페이지에서 무료로 제공하는 서비스 이용과 관련하여 관련법에 특별한 규정이 없는 한 책임을 지지 않습니다.</li>
								</ul>
								
								<h5 class="join_title_s mgt20">제 20조 (관할법원)</h5>
								<p class="black mgt10">본 서비스 이용과 관련하여 발생한 분쟁에 대하여는 대한민국 법을 적용하며, 본 분쟁으로 인한 소는 대한민국의 법원에 제기합니다.</p>
								<p class="mgt20">(시행일) 본 약관은 2016년 11월 1일부터 적용됩니다.</p>
							</div>
							<br />
							<h4>개인정보 수집, 이용 및 동의에 대한 안내</h4>
							<div class="jon_scroll_box2">
								<p class="black mgt10">한국환경공단(이하 ‘공단’)은 수질오염방제정보시스템(www.waterkorea.or.kr)에서 수집하게 될 개인정보는 『개인정보보호법』 제15조에 따라 개인정보의 수집 이용 시 본인의 동의를 얻어야 하는 정보입니다. 이에 공단은 아래 내용과 같이 개인정보를 수집 이용하고자 합니다. 홈페이지 이용자는 동의를 거부할 수 있습니다. 다만, 이 경우 회원가입 및 제공 서비스에 제한이 있을 수 있습니다.</p>
			
								<ul class="jon_scroll_box2.join_list mgt10"><br/>
								<li><span class="join_number" style="font-size:12pt;font-face:굴릶;font-weight:bold;color:blue">1. 개인정보의 처리 목적 </span><br/>&lt;수질오염방제정보시스템&gt;은 개인정보를 다음의 목적을 위해 처리합니다. 처리한 개인정보는 다음의 목적이외의 용도로는 사용되지 않으며 이용 목적이 변경될 시에는 개인정보보호법 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.</li>
								<div style="border:1px solid #333333;padding-left:20px"><b><i><u>가. 홈페이지 회원가입 및 관리, 서비스 제공
								<br/>회원 가입의사 확인, 회원제 서비스 제공에 따른 본인 식별·인증, 회원자격 유지·관리, 서비스 부정 이용 방지, 각종 고지·통지 및 서비스 제공 등을 목적으로 개인정보를 처리합니다.</u></i></b>
								<br/><b><i><u>나. 기타</u></i></b></div><br/>
								<li><span class="join_number" style="font-size:12pt;font-face:굴릶;font-weight:bold;color:blue">2. 개인정보 수집 및 이용 내역 </span><br/>&lt;수질오염방제정보시스템&gt;은 재난 발생시 알림에 필요한 최소한의 개인정보를 아래와 같이 수집, 이용하고자 합니다.<br/>내용을 자세히 읽으신 후 동의 여부를 결정하여 주십시요.</li>
								<!-- <div style="border:1px solid #333333;padding-left:20px">개인정보 파일에 기록되는 개인정보의 항목</div>
								<div style="border:1px solid #333333;padding-left:20px">ID, 이름, 주소, 직장, 소속기관, 근무부서, E-Mail, 직장연락처, 핸드폰(연락처), 서비스 이용 기록, 접속 로그</div>
								<li><span class="join_number">3. (개인정보의 보유 및 이용 기간) </span>홈페이지 이용자의 개인정보는 원칙적으로 개인정보의 처리목적이 달성되거나 해당 서비스가 폐지되면 지체없이 파기합니다.</li>
								<div style="border:1px solid #333333;padding-left:20px">보유기간</div>
								<div style="border:1px solid #333333;padding-left:20px">회원정보 회원탈퇴 요청 시 또는 서비스 폐지 시 까지</div> -->
								<div>
									<table style="font-size:11pt;font-face:굴림;">
										<caption>개인정보 이용, 수집내역</caption>
										<colgroup>
											<col width="*"/>
											<col width="33%"/>
											<col width="33%"/>
										</colgroup>
										<thead>
										<tr>
											<th scope="col" style="background:#f5f5f5;border:1px solid #333333;">항목</th>
											<th scope="col" style="background:#f5f5f5;border:1px solid #333333;">수집목적</th>
											<th scope="col" style="background:#f5f5f5;border:1px solid #333333;">보유기간</th>
										</tr>
										</thead>
										<tbody>
										<tr align="center">
											<td scope="col" style="border:1px solid #333333;"><u>ID, 이름, 주소, 직장, 소속기관, 근무부서,<br/>E-Mail, 직장연락처, 핸드폰(연락처),<br/>서비스 이용 기록, 접속 로그</u></td>
											<td scope="col" style="border:1px solid #333333;">재난 발생 알림</td>
											<td scope="col" style="border:1px solid #333333;"><u>회원탈퇴 요청 또는 서비스 폐지 시 까지</u></td>
										</tr>
										</tbody>
									</table>
									<br/>
									<span>
										※ 위의 개인정보 수집, 이용에 대한 동의를 거부할 권리가 있습니다.<br/>
										&nbsp;&nbsp;&nbsp;&nbsp;그러나 동의를 거부할 경우 원할한 서비스 제공에 제한을 받을 수 있습니다.
									</span>
								</div>
								</ul>
							</div>
							<br />
							<div style="text-align:right;">
								<span>
									<strong>위와 같이 개인정보를 수집, 이용하는데 동의하십니까? 동의 하지 않는 경우 계정신청을 진행 하실 수 없습니다.</strong>
								</span>
								<span style="padding-left:200px;">
									<input type="radio" name="radio_policy" checked="checked" value="Y"/>동의&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" name="radio_policy"  value="N"/>미동의
								</span>
							</div>
					</div>
				</form:form>
					</div>
					<div class="list_type01">
						<div style="padding-top:20px;text-align:right;cursor:pointer;">
							<a href="<c:url value='/acc/accountApp.do?page=pub/acc/accountApp&menu=6'/>"><img src="/images/new/btn_pre.gif"alt="이전단계"/></a>
							<a href="javascript:fnAccountStep();"><img src="/images/new/btn_next2.gif"alt="다음단계"/></a>
						</div>
					</div>
				</div>
			</div>
			<!--content wrap --> 
		    
		</div>
	</div>
	<!--container --> 
  
	<!--footer -->
	<div class="footer_wrap">
		<div id="footer">
			<c:import url="/WEB-INF/jsp/pub/include/client_footer.jsp" />
		</div>
	</div>
	<!--footer --> 
  
</div>
<!-- wrap -->

</body>
</html>