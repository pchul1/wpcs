<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<title>한국환경공단 수질오염 방제정보 시스템</title>
<link rel="stylesheet" type="text/css" href="/css/init/pass.css" />
<link rel="stylesheet" type="text/css" href="/css/init/agree.css" />
<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css" rel="stylesheet'/>" />

<sec:authorize ifAnyGranted="ROLE_USER">
	<c:set var="user_dept_no">
		<sec:authentication property="principal.userVO.deptNo"/>	
	</c:set>
	<script>
		var user_dept_no = '<sec:authentication property="principal.userVO.deptNo"/>';
	</script>
</sec:authorize>


<script type="text/javascript" >
//<![CDATA[
	$(document).ready(function(){

		$('#notImg').click(function(e){
			if(confirm("<spring:message code="fail.privacy.login" />")){
				$('#memberFrm').attr("action","/common/login/actionLogout.do");
				$('#memberFrm').submit();
			}
			
		});
		$('#agreeImg').click(function(e){
			if(!($('#agree_1').is(":checked")) || !($('#agree_2').is(":checked")) || !($('#agree_3').is(":checked")) || !($('#agree_4').is(":checked"))){
				alert("계정신청 약관 및 개인정보정책 4가지 모두 동의하셔야 계정신청 하실 수 있습니다.");
			}else{
				$('#memberFrm').attr("action","/common/updatePrivacy.do");
				$('#memberFrm').submit();
			}
		});
		
		
		$("#agree_all").bind("click",function(){
			if ($(this).is(":checked")){
				$(":input:checkbox").attr("checked","checked");
			} else {
				$(":input:checkbox").removeAttr("checked");
			}
		});
	});
	//]]>
</script>

</head>
<body>

<div id="wrap">

  <div class="password">
  
<!--       <p class="title"><img src="/images/init/title.jpg" alt="비밀번호를 변경해주세요." /></p> -->
<!--         <p class="sub_title"><img src="/images/init/sub_title.jpg" alt="홍길동님의 개인정보보호를 위해 주기적(최소 3개월)으로 비밀번호를 변경해 주세요." /></p> -->
    	
			<div class="mainSection">
			<div class="width_div_1 mgt40">
				<h4 class="title_2"><img src="/images/init/agree_title.png" alt="회원이용약관" /></h4>
			</div>
			<form:form commandName="memberFrm" name="memberFrm" method="post" >	

			<!-- width_div_1 -->
			<div class="width_div_1 mgt40">
				<h4 class="title_2"><img src="/images/init/agree_title1.png" alt="회원이용약관" /></h4>
				
				<div class="jon_scroll_box">
					<h4 class="join_title">제 1장 총 칙</h4>
					
					<h5 class="join_title_s mgt20">제 1 조 (목적 등)</h5>

					<p class="black mgt10">이 이용약관(이하 ‘약관’)은 수질오염 방제정보센터와 이용고객(이하 ‘회원’)간에 수질오염 방제정보센터가 제공하는 웹사이트 waterkorea.or.kr(이하 ‘서비스’)의 이용조건 및 회원에 관한 제반 사항과 기타 필요한 절차에 관한 기본적인 사항을 구체적으로 규정함을 목적으로 합니다.</p>

					<h5 class="join_title_s mgt20">제 2 조 (약관의 효력)</h5>

					<ul class="jon_scroll_box.join_list mgt10">
					<li><span class="join_number">1.</span>본 약관은 온라인으로 수질오염 방제정보센터의 서비스 화면을 통해 게시하고, 이용자가 이에 동의함으로써 효력을 발생합니다.</li>
					<li><span class="join_number">2.</span>수질오염 방제정보센터는 합리적인 사유가 발생될 경우에는 약관의 규제 등에 관한 법률, 전기통신 사업법령, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등 관련법을 위배하지 않는 범위에서 이 약관을 변경할 수 있으며, 약관을 변경할 경우에는 이를 별도로 공지합니다.</li>
					<li><span class="join_number">3.</span>회원은 변경된 약관에 동의하지 않을 경우 회원 탈퇴(해지)를 요청할 수 있으며, 변경된 약관의 효력 발생일로부터 7일 이후에도 거부의사를 표시하지 아니하고 서비스를 계속 이용할 경우 약관의 변경 사항에 동의한 것으로 간주합니다.</li>
					<li><span class="join_number">4.</span>회이 약관에 동의하는 것은 정기적으로 웹사이트를 방문하여 약관의 변경 사항을 확인하는 것에 동의함을 의미합니다. 변경된 약관에 대한 정보를 알지 못해 발생하는 회원의 피해는 수질오염 방제정보센터에서 책임지지 않습니다.</li>
					<li><span class="join_number">5.</span>이 약관에 명시되지 아니한 사항에 대해서는 관계법령 및 서비스 별 이용안내의 취지에 의거하여 적용할 수 있습니다.</li>
					</ul>

					<h5 class="join_title_s mgt20">제 3 조 (용어의 정의)</h5>

					<ul class="jon_scroll_box.join_list mgt10">
					<li>
						<span class="join_number">1.</span>이 약관에서 사용하는 용어의 정의는 다음과 같습니다.

						<ul class="jon_scroll_box.join_list_s">
						<li><span class="join_number_s">가.</span>'회원'이라 함은 본 약관에 동의하고 본 서비스를 이용하는 이용자를 말합니다.</li>
						<li><span class="join_number_s">나.</span>'아이디(ID)'라 함은 회원의 식별과 서비스 이용을 위하여 회원이 선정하고 수질오염 방제정보센터가 부여하는 문자와 숫자의 조합을 말합니다.</li>
						<li><span class="join_number_s">다.</span>'비밀번호'라 함은 이용고객이 부여 받은 ID와 일치된 회원임을 확인하고 회원의 권익 보호를 위하여 회원이 선정한 문자와 숫자의 조합을 말합니다.</li>
						<li><span class="join_number_s">라.</span>'닉네임’라 함은 웹사이트 내에서 게시물 등록 시 등록자 부분을 표현할 수 있는 문자와 숫자의 조합을 말합니다.</li>
						<li><span class="join_number_s">마.</span>'회원탈퇴(해지)'라 함은 회원이 서비스 이용계약을 해약하는 것을 말합니다.</li>
						<li><span class="join_number_s">바.</span>'관리자 및 운영자’라 함은 서비스의 전반적인 관리와 원활한 운영을 위하여 수질오염 방제정보센터에서 선정한 사람을 말합니다.</li>
						<li><span class="join_number_s">사.</span>'컨텐츠'라 함은 수질오염 방제정보센터에서 제공하는 교육용 컨텐츠를 의미하며 치의학 각 분야별 동영상, 슬라이드, Text, 이미지, e-book, 문서 등을 말합니다.</li>
						</ul>
					</li>

					<li><span class="join_number">2.</span> 이 약관에서 사용하는 용어의 정의는 3조 1항에서 정하는 것을 제외하고는 관계법령 및 서비스 별 안내에서 정하는 바에 의합니다.</li>
					</ul>

					<h4 class="join_title mgt20">제 2 장 서비스 이용 계약</h4>

					<h5 class="join_title_s mgt20">제 4 조 (이용계약의 성립)</h5>

					<ul class="jon_scroll_box.join_list mgt10">
					<li><span class="join_number">1.</span>이용계약은 회원의 이용신청에 대하여 수질오염 방제정보센터가 승낙할 경우에 성립합니다.</li>
					<li><span class="join_number">2.</span>본 관에 대한 동의는 이용 신청 시 '약관에 동의함' 버튼을 누름으로써 의사표시를 합니다.</li>
					</ul>

					<h5 class="join_title_s mgt20">제 5 조 (이용약관의 신청)</h5>

					<ul class="jon_scroll_box.join_list mgt10">
					<li><span class="join_number">1.</span>이용신청은 실명을 원칙으로 제한을 둘 수 있으며, 1개의 회원 ID에 대해 1건의 이용신청만을 할 수 있습니다.</li>
					<li><span class="join_number">2.</span>회원으로 가입하여 본 서비스를 이용하고자 하는 경우에는, 수질오염 방제정보센터에서 요청하는 제반 정보(이름, e-Mail, 주소 등)를 제공하여야 합니다.</li>
					<li><span class="join_number">3.</span>모든 회원은 반드시 회원 본인의 이름과 주민등록번호를 제공하여야만 서비스를 이용할 수 있으며, 실명으로 등록하지 않은 사용자는 서비스 관련한 일체의 권리를 주장할 수 없습니다.</li>
					<li><span class="join_number">4.</span>계정신청은 반드시 실명으로만 가입할 수 있으며 수질오염 방제정보센터는 실명확인조치를 할 수 있습니다.</li>
					<li><span class="join_number">5.</span>타인의 명의(이름)를 도용하여 이용신청을 한 회원의 모든 ID는 삭제되며, 관계 법령에 따라 처벌을 받을 수 있습니다.</li>
					<li><span class="join_number">6.</span>수질오염 방제정보센터는 본 서비스를 이용하는 회원에 대하여 이용시간, 이용회수, 서비스 메뉴 참여도 등을 세분 하여 이용에 차등을 둘 수 있습니다.</li>
					</ul>

 
					<h5 class="join_title_s mgt20">제 6 조 (이용신청의 승낙)</h5>

					<ul class="jon_scroll_box.join_list mgt10">
					<li><span class="join_number">1.</span>수질오염 방제정보센터는 제5조에 따른 이용신청에 대하여 업무 수행상, 또는 기술상 지장이 없는 경우에 원칙적으로 접수순서에 따라 이용신청을 승낙합니다.</li>
					<li>
						<span class="join_number">2.</span>수질오염 방제정보센터는 아래 사항에 해당하는 이용신청에 대하여는 승낙을 유보할 수 있습니다.
						
						<ul class="jon_scroll_box.join_list_s">
						<li><span class="join_number_s">가.</span>설비에 여유가 없는 경우</li>
						<li><span class="join_number_s">나.</span>기술상 지장이 있는 경우</li>
						<li><span class="join_number_s">다.</span>기타 수질오염 방제정보센터가 필요하다고 인정되는 경우</li>
						</ul>
					</li>
					<li>
						<span class="join_number">3.</span>수질오염 방제정보센터는 다음에 해당하는 이용신청에 대하여는 이를 승낙하지 아니 할 수 있습니다.

						<ul class="jon_scroll_box.join_list mgt10">
						<li><span class="join_number_s">가.</span>다른 사람의 명의를 이용하여 신청하였을 경우</li>
						<li><span class="join_number_s">나.</span>이용계약 신청의 내용을 허위로 기재한 경우</li>
						<li><span class="join_number_s">다.</span>사회의 안녕과 질서, 미풍양속을 저해할 목적으로 신청한 경우</li>
						<li><span class="join_number_s">라.</span>부정한 용도로 본 서비스를 이용하고자 하는 경우</li>
						<li><span class="join_number_s">마.</span>본 서비스와 경쟁관계에 있는 이용자가 신청하는 경우</li>
						<li><span class="join_number_s">바.</span>기타 규정한 제반 사항을 위반하여 신청한 경우</li>
						</ul>
					</li>
					</ul>
					
					<h5 class="join_title_s mgt20">제 7 조 (이용자 ID 부여 및 변경)</h5>

					<ul class="jon_scroll_box.join_list mgt10">
					<li><span class="join_number">1.</span>이용고객에 대하여 약관에 정하는 바에 따라 회원 ID를 부여합니다.</li>
					<li><span class="join_number">2.</span>회원 ID는 원칙적으로 변경이 불가 하며, 부득이한 사유로 인하여 변경 하고자 하는 경우에는 해당 ID를 해지하고 재가입해야 합니다. 단, 해지 후 30일 후에 재가입이 가능합니다.</li>
					<li>
						<span class="join_number">3.</span>회원 ID는 다음 각 호에 해당하는 경우에는 이용고객의 요청으로 변경할 수 있습니다.

						<ul class="jon_scroll_box.join_list_s">
						<li><span class="join_number_s">가.</span>회원 ID가 회원의 전화번호 또는 주민등록번호 등으로 등록되어 사생활침해가 우려되는 경우</li>
						<li><span class="join_number_s">나.</span>타인에게 혐오감을 주거나 미풍양속에 어긋나는 경우</li>
						<li><span class="join_number_s">다.</span>기타 합리적인 사유가 있는 경우</li>
						</ul>
					</li>
					<li><span class="join_number">4.</span>회원 ID는 회원 본인의 동의 하에 수질오염 방제정보센터가 운영하는 자사 사이트의 회원 ID와 연결될 수 있습니다.</li>
					<li><span class="join_number">5.</span>서비스 회원 ID 및 비밀번호의 관리책임은 회원에게 있습니다. 이를 소홀이 관리하여 발생하는 서비스 이용상의 손해 또는 제3자에 의한 부정이용 등에 대한 책임은 회원에게 있으며, 수질오염 방제정보센터는 그에 대한 모든 책임을 지지 않습니다.</li>
					</ul>
					
					<h4 class="join_title mgt20">제 3 장 서비스 이용</h4>

					<h5 class="join_title_s mgt20">제 8 조 (서비스 종류)</h5>

					<ul class="jon_scroll_box.join_list mgt10">
					<li>
						<span class="join_number">1.</span>수질오염 방제정보센터는 서비스의 내용과 종류를 수시로 변경할 수 있으며, 변경사항은 공지사항을 통하여 공지합니다. 수질오염 방제정보센터는 회원에게 아래와 같은 서비스를 제공합니다.

						<ul class="jon_scroll_box.join_list_s">
						<li><span class="join_number_s">가.</span>무료 ‘디지털 컨텐츠’서비스</li>
						<li><span class="join_number_s">나.</span>유료 ‘디지털 컨텐츠’서비스</li>
						<li><span class="join_number_s">다.</span>수질오염 방제정보센터와 제휴 및 계약에 의해서 제공되는 뉴스 및 학술정보 서비스</li>
						<li><span class="join_number_s">라.</span>수질오염 방제정보센터와 제휴 및 계약에 의해서 제공되는 세미나 서비스</li>
						<li><span class="join_number_s">마.</span>수질오염 방제정보센터와 제휴 및 계약에 의해서 제공되는 상품정보 및 도서정보 서비스</li>
						<li><span class="join_number_s">바.</span>기타, 회원을 위한 맞춤 서비스</li>
						</ul>
					</li>
					</ul>
 
					<h5 class="join_title_s mgt20">제 9 조 (서비스 요금 및 이용시간 )</h5>

					<ul class="jon_scroll_box.join_list mgt10">
					<li><span class="join_number">1.</span>수질오염 방제정보센터가 제공하는 서비스는 수질오염 방제정보센터가 필요하다고 판단하는 시점에 7일간의 사전 공지를 통하여 무료 디지털 컨텐츠를 유료 디지털컨텐츠로 변경할 수 있습니다. 유료 디지털 컨텐츠의 경우에는 회원이 직접 선택한 사항에 대하여 요금을 지불하여야 합니다.</li>
					<li><span class="join_number">2.</span>회수질오염 방제정보센터가 정한 별도의 유료 정보와 유료 서비스 이용에 대해서는 해당페이지에 이용 전에 해당 유료 정보의 내용이 표시됩니다.</li>
					<li><span class="join_number">3.</span>수질오염 방제정보센터의 포인트 제도는 특정 유료서비스 이용 또는 이벤트 참여자격을 나타내는 지표로서 수질오염 방제정보센터에서 제공하는 서비스 이용 및 참여도에 따라 일정 수준의 포인트를 획득할 수 있습니다.</li>
					<li><span class="join_number">4.</span>서비스 이용은 수질오염 방제정보센터의 업무상 또는 기술상 특별한 지장이 없는 한 365일, 1일 24시간 운영을 원칙으로 합니다. 단, 수질오염 방제정보센터는 시스템 정기점검, 증설 및 교체를 위해 수질오염 방제정보센터가 정한 날이나 시간에 서비스를 일시 중단할 수 있으며, 예정되어 있는 작업으로 인한 서비스 일시 중단은 수질오염 방제정보센터의 웹사이트를 통해 사전에 공지합니다.</li>
					</ul>

					<h5 class="join_title_s mgt20">제 10 조 (서비스 제공의 중지)</h5>
					
					<ul class="jon_scroll_box.join_list mgt10">
					<li>
						<span class="join_number">1.</span>수질오염 방제정보센터는 다음에 해당하는 경우 서비스 제공을 중지할 수 있습니다.

						<ul class="jon_scroll_box.join_list_s">
						<li><span class="join_number_s">가.</span>시스템 점검, 증설 및 교체 등 부득이한 사유가 발생할 경우에는 예고 없이 일시적으로 서비스를 중단할 수 있으며, 새로운 서비스로의 교체 등 수질오염 방제정보센터가 적절하다고 판단하는 사유에 의하여 현재 제공되는 서비스를 완전히 중단 할 수 있습니다.</li>
						<li><span class="join_number_s">나.</span>국가비상사태, 정전, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 정상적인 서비스 제공이 불가능할 경우, 서비스의 전부, 또는, 일부를 제한하거나 중지할 수 있습니다. 다만 이 경우 그 사유 및 기간 등을 회원에게 사전, 또는, 사후에 공지합니다.</li>
						<li><span class="join_number_s">다.</span>스템임플란트가 통제할 수 없는 사유로 인한 서비스중단의 경우(시스템 관리자의 고의, 과실 없는 디스크 장애, 시스템다운 등)에 사전 통지가 불가능하며 타인(PC통신, 기간통신사업자 등)의 고의, 과실로 인한 시스템중단 등의 경우에는 통지하지 않을 수 있습니다.</li>
						<li><span class="join_number_s">라.</span>수질오염 방제정보센터와 제휴 및 계약에 의해서 제공되는 세미나 서비스</li>
						</ul>
					</li>
					</ul>
					
					<h5 class="join_title_s mgt20">제 11 조 (게시물 관리)</h5>

					<ul class="jon_scroll_box.join_list mgt10">
					<li>
						<span class="join_number">1.</span>수질오염 방제정보센터는 다음 각 호에 해당하는 게시물이나 자료를 사전통지 없이 삭제하거나 이동, 또는, 등록 거부를 할 수 있습니다. 

						<ul class="jon_scroll_box.join_list_s">
						<li><span class="join_number_s">가.</span>다른 회원 또는 제 3자에게 심한 모욕을 주거나 명예를 손상시키는 내용인 경우</li>
						<li><span class="join_number_s">나.</span>공공질서 및 미풍양속에 위반되는 내용을 유포하거나 링크시키는 경우</li>
						<li><span class="join_number_s">다.</span>불법복제 또는 해킹을 조장하는 내용인 경우</li>
						<li><span class="join_number_s">라.</span>영리를 목적으로 하는 광고일 경우</li>
						<li><span class="join_number_s">마.</span>범죄와 결부된다고 객관적으로 인정되는 내용일 경우</li>
						<li><span class="join_number_s">바.</span>다른 회원 또는 제 3자의 저작권 등 기타 권리를 침해하는 내용인 경우</li>
						<li><span class="join_number_s">사.</span>수질오염 방제정보센터에서 규정한 게시물 원칙에 어긋나거나, 게시판 성격에 부합하지 않는 경우</li>
						<li><span class="join_number_s">아.</span>기타 관계법령에 위배된다고 판단되는 경우</li>
						</ul>
					</li>
					</ul>
					
					<h5 class="join_title_s mgt20">제 12 조 (게시물에 대한 저작권)</h5>


					<ul class="jon_scroll_box.join_list mgt10">
					<li><span class="join_number">1.</span>회원이 서비스 화면 내에 게시한 게시물의 저작권은 게시한 회원에게 귀속됩니다. 또한 수질오염 방제정보센터는 게시물을 상업적으로 이용할 경우, 회원에게 수질오염 방제정보센터가 규정한 비율의 이익 배분액을 지급하여야 합니다. 다만 비영리 목적인 경우는 그러하지 아니하며, 또한 서비스내의 게재권을 자유로이 갖습니다.</li>
					<li><span class="join_number">2.</span>회원은 서비스를 이용하여 취득한 정보를 임의 가공, 판매하는 행위 등, 서비스에 게재된 자료를 상업적으로 사용할 수 없습니다.</li>
					</ul>
					
					<h5 class="join_title_s mgt20">제 13 조 (정보의 제공)</h5>
					
					<ul class="jon_scroll_box.join_list mgt10">
					<li><span class="join_number">1.</span>수질오염 방제정보센터는 회원에게 서비스 이용에 필요가 있다고 인정되는 각종 정보에 대해서 전자우편이나 서신우편 등의 방법으로 회원에게 제공할 수 있습니다.</li>
					<li><span class="join_number">2.</span>수질오염 방제정보센터는 서비스 개선 및 회원 대상의 서비스 소개 등의 목적으로 회원의 동의 하에 추가적인 개인 정보를 요구할 수 있습니다.</li>
					</ul>
					
					<h5 class="join_title_s mgt20">제 14조 (광고게재 및 광고주와의 거래)</h5>

					<ul class="jon_scroll_box.join_list mgt10">
					<li><span class="join_number">1.</span>수질오염 방제정보센터가 회원에게 서비스를 제공할 수 있는 서비스 투자기반의 일부는 광고게재를 통한 수익으로부터 나옵니다. 회원은 서비스 이용 시 노출되는 광고 게재에 대해 승인하는 것으로 간주합니다.</li>
					<li><span class="join_number">2.</span>수질오염 방제정보센터는 서비스상에 게재되어 있거나 본 서비스를 통한 광고주의 판촉 활동에 회원이 참여하거나 교신, 또는 거래를 함으로써 발생하는 손실과 손해에 대해 일체 책임을 지지 않습니다.</li>
					</ul>

					<h4 class="join_title mgt20">제 4 장 서비스 이용</h4>

					<h5 class="join_title_s mgt20">제 15 조 (저작권의 귀속 및 이용제한)</h5>
					
					<ul class="jon_scroll_box.join_list mgt10">
					<li><span class="join_number">1.</span>수질오염 방제정보센터가 작성한 저작물에 대한 저작권 기타 지적재산권은 수질오염 방제정보센터에 귀속합니다. 회원은 서비스를 이용함으로써 얻은 정보를 수질오염 방제정보센터의 사전승낙 없이 복제, 전송, 출판, 배포, 방송 기타 방법에 의하여 영리 목적으로 이용하거나 제3자에게 이용하게 해서는 아니 되며, 이를 어길 경우 수질오염 방제정보센터는 회원에게 손해배상을 청구할 수 있습니다.</li>
					<li>
						<span class="join_number">2.</span>오수질오염 방제정보센터는 본 약관 제18조의 내용을 위반하거나 다음 각 호에 해당하는 경우 서비스 이용을 제한할 수 있습니다.
						
						<ul class="jon_scroll_box.join_list_s">
						<li><span class="join_number_s">가.</span>서비스 운영을 고의로 방해한 경우</li>
						<li><span class="join_number_s">나.</span>타인의 명예를 손상시키거나 불이익을 주는 행위를 한 경우</li>
						<li><span class="join_number_s">다.</span>수질오염 방제정보센터의 서비스 정보를 이용하여 얻은 정보를 수질오염 방제정보센터의 사전 승낙 없이 복제 또는 유통시키거나 상업적으로 이용하는 경우</li>
						<li><span class="join_number_s">라.</span>전자적인 장치 또는 기술 등으로 타인의 정보를 도용하거나 불법적으로 타인의 금융정보를 이용한 경우</li>
						<li><span class="join_number_s">마.</span>저작권이 있는 글을 무단 복제하거나 등록한 경우</li>
						<li><span class="join_number_s">바.</span>정보통신윤리위원회 등 관련 공공기관의 시정 요구가 있을 경우</li>
						<li><span class="join_number_s">사.</span>본 약관을 포함하여 기타 수질오염 방제정보센터가 정한 이용조건에 반하는 경우</li>
						</ul>
					</li>
					<li><span class="join_number">2.</span>상기 이용제한 규정에 따라 서비스를 이용하는 회원에게 서비스 이용에 대하여 별도 공지 없이 서비스 이용의 일시 정지, 초기화, 이용계약 해지 등의 조치를 취할 수 있으며, 발생된 기회손실 및 저작권료에 해당한 비용을 청구할 수 있습니다.</li>
					</ul>
					
					<h5 class="join_title_s mgt20">제 16조 ( 계약 해지 )</h5>

					<ul class="jon_scroll_box.join_list mgt10">
					<li><span class="join_number">1.</span>수질오염 방제정보센터는 회원이 자발적으로 탈퇴를 신청했을 경우 관련법에 의거 탈퇴일로부터 1개월 내에 모든 고객정보를 삭제하며 다만, 유료 컨텐츠 등을 이용하여 당사와의 거래가 발생된 고객의 경우에는 관련 법률(상법 등)에 의거하여 관련 법률에 규정된 기본적인 사항만을 계약 해지일로부터 5년 동안 관리합니다.</li>
					<li><span class="join_number">2.</span>회원 탈퇴 후에는 재가입은 30일 후에 가능하며 동일 아이디로의 재가입은 불가능합니다.</li>
					</ul>
					
					<h4 class="join_title mgt20">제 5 장 권리와 의무</h4>

					<h5 class="join_title_s mgt20">제 17 조 (수질오염 방제정보센터의 의무)</h5>

					<ul class="jon_scroll_box.join_list mgt10">
					<li><span class="join_number">1.</span>수질오염 방제정보센터는 이용고객이 희망한 서비스 제공 개시일에 특별한 사정이 없는 한 서비스를 이용할 수 있도록 하여야 합니다.</li>
					<li><span class="join_number">2.</span>수질오염 방제정보센터는 지속적이고 안정적인 서비스의 제공을 위하여 설비에 장애가 발생될 때에는 부득이한 사유가 없는 한 지체 없이 이를 수리 또는 복구합니다.</li>
					<li><span class="join_number">3.</span>수질오염 방제정보센터는 개인정보 보호를 위해 보안시스템을 구축하며 개인정보 보호정책을 공시하고 준수합니다.</li>
					<li><span class="join_number">4.</span>수질오염 방제정보센터는 이용고객으로부터 제기되는 의견이나 불만이 정당하다고 객관적으로 인정될 경우에는 적절한 절차를 거쳐 처리하여야 합니다. 다만, 처리가 곤란한 경우는 회원에게 그 사유와 처리 일정을 통보하여야 합니다.</li>
					</ul>
					
					<h5 class="join_title_s mgt20">제 18 조 (회원의 의무)</h5>

					<ul class="jon_scroll_box.join_list mgt10">
					<li>
						<span class="join_number">1.</span>회원에게 제공되는 각종 편의 서비스의 이용 및 구매계약 이행에 필요한 최소한의 정보를 수집할 수 있도록 정보 제공합니다. 다음 사항을 필수사항으로 하며 그 외 사항은 선택사항으로 합니다.
						
						<ul class="jon_scroll_box.join_list_s">
						<li><span class="join_number_s">가.</span>성명</li>
						<li><span class="join_number_s">나.</span>주민등록번호</li>
						<li><span class="join_number_s">다.</span>희망 ID</li>
						<li><span class="join_number_s">라.</span>비밀번호</li>
						<li><span class="join_number_s">마.</span>닉네임</li>
						<li><span class="join_number_s">바.</span>주소</li>
						<li><span class="join_number_s">사.</span>연락처</li>
						<li><span class="join_number_s">아.</span>직업</li>
						</ul>
					</li>
					<li><span class="join_number">2.</span>회원은 계정신청 신청 또는 회원정보 변경 시 실명으로 모든 사항을 사실에 근거하여 작성하여야 하며, 허위 또는 타인의 정보를 등록할 경우 수질오염 방제정보센터는 책임을 지지 않으며, 회원은 일체의 권리를 주장 할 수 없습니다.</li>
					<li><span class="join_number">3.</span>회원은 본 약관에서 규정하는 사항과 기타 수질오염 방제정보센터가 정한 제반 규정, 공지사항 등 수질오염 방제정보센터가 공지하는 사항 및 관계법령을 준수하여야 하며, 기타 수질오염 방제정보센터의 업무에 방해가 되는 행위, 수질오염 방제정보센터의 명예를 손상시키는 행위를 해서는 안됩니다.</li>
					<li><span class="join_number">4.</span>회원은 주소, 연락처, 전자우편 주소 등 이용계약사항이 변경된 경우에 해당 절차를 거쳐 이를 수질오염 방제정보센터에 즉시 알려야 합니다.</li>
					<li><span class="join_number">5.</span>수질오염 방제정보센터가 관계법령 및 '개인정보 보호정책'에 의거하여 그 책임을 지는 경우를 제외하고 회원에게 부여된 ID의 비밀번호 관리소홀, 부정사용에 의하여 발생하는 모든 결과에 대한 일체의 책임은 회원에게 있습니다.</li>
					<li><span class="join_number">6.</span>회원은 수질오염 방제정보센터의 사전 승낙 없이 서비스를 이용하여 영업 활동을 할 수 없으며, 그 영업활동의 결과에 대해 수질오염 방제정보센터는 책임을 지지 않습니다. 또한 회원은 이와 같은 영업활동으로 수질오염 방제정보센터가 손해를 입은 경우, 회원은 수질오염 방제정보센터에 대해 손해배상의무를 지며, 수질오염 방제정보센터는 해당 회원에 대해 서비스 이용제한 및 적법한 절차를 거쳐 손해배상 등을 청구할 수 있습니다.</li>
					<li><span class="join_number">7.</span>회원은 수질오염 방제정보센터의 명시적 동의가 없는 한 서비스의 이용권한, 기타 이용계약상의 지위를 타인에게 양도, 증여 하거나 이를 담보로 제공할 수 없습니다.</li>
					<li><span class="join_number">8.</span>회원은 수질오염 방제정보센터 및 제 3자의 지적 재산권을 침해해서는 안됩니다.</li>
					<li>
						<span class="join_number">9.</span>회원은 다음 각 호에 해당하는 행위를 하여서는 안되며, 해당 행위를 하는 경우에 수질오염 방제정보센터는 회원의 서비스 이용제한, 손해배상 및 법적 조치를 포함한 제재를 가할 수 있습니다.

						<ul class="jon_scroll_box.join_list_s">
						<li><span class="join_number_s">가.</span>계정신청 신청 또는 회원정보 변경 시 허위내용을 등록하는 행위</li>
						<li><span class="join_number_s">나.</span>다른 회원의 ID, 비밀번호, 주민등록번호를 도용하는 행위</li>
						<li><span class="join_number_s">다.</span>회원 ID를 타인과 거래하는 행위</li>
						<li><span class="join_number_s">라.</span>수질오염 방제정보센터의 운영진, 직원 또는 관계자를 사칭하는 행위</li>
						<li><span class="join_number_s">마.</span>서비스에 위해를 가하거나 고의로 방해하는 행위</li>
						<li><span class="join_number_s">바.</span>본 서비스를 통해 얻은 정보를 수질오염 방제정보센터의 사전 승낙 없이 서비스 이용 외의 목적으로 복제하거나, 이를 출판 및 방송 등에 사용하거나, 제 3자에게 제공하는 행위</li>
						<li><span class="join_number_s">사.</span>공공질서 및 미풍양속에 위반되는 저속, 음란한 내용의 정보, 문장, 도형, 음향, 동영상을 전송, 게시, 전자우편 또는 기타의 방법으로 타인에게 유포하는 행위</li>
						<li><span class="join_number_s">아.</span>모욕적이거나 개인신상에 대한 내용이어서 타인의 명예나 프라이버시를 침해할 수 있는 내용을 전송, 게시, 전자우편 또는 기타의 방법으로 타인에게 유포하는 행위</li>
						<li><span class="join_number_s">자.</span>다른 회원을 희롱 또는 위협하거나, 특정 회원에게 지속적으로 고통 또는 불편을 주는 행위</li>
						<li><span class="join_number_s">차.</span>범죄와 결부된다고 객관적으로 판단되는 행위</li>
						<li><span class="join_number_s">카.</span>본 약관을 포함하여 기타 수질오염 방제정보센터가 정한 제반 규정 또는 이용 조건을 위반하는 행위</li>
						<li><span class="join_number_s">타.</span>기타 관계 법령에 위배되는 행위(크래킹 등)</li>
						</ul>
					</li>
					</ul>

					<h4 class="join_title mgt20">제 6 장 손해배상 및 기타 사항</h4>
					
					<h5 class="join_title_s mgt20">제 19 조 (손해배상책임)</h5>

					<ul class="jon_scroll_box.join_list mgt10">
					<li><span class="join_number">1.</span>수질오염 방제정보센터는 수질오염 방제정보센터가 제공하는 서비스의 이용과 관련하여 수질오염 방제정보센터의 고의, 또는, 중대한 과실이 없이 회원에게 발생한 손해에 대해서는 일체 책임을 지지 않습니다.</li>
					</ul>
					
					<h5 class="join_title_s mgt20">제 20 조 (면책조항)</h5>

					<ul class="jon_scroll_box.join_list mgt10">
					<li><span class="join_number">1.</span>수질오염 방제정보센터는 약관에 명시된 사유로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공의 불이행에 관하여는 책임이 면제됩니다.</li>
					<li><span class="join_number">2.</span> 수질오염 방제정보센터는 기간통신사업자가 전기통신 서비스를 중지하거나 정상적으로 제공하지 아니하여 손해가 발생한 경우 책임이 면제됩니다.</li>
					<li><span class="join_number">3.</span>수질오염 방제정보센터는 수질오염 방제정보센터의 연결 사이트에 대해 보증책임을 지지 않으며 따라서 연결 사이트와 회원간에 이루어진 어떠한 거래에 대해서도 책임을 지지 않습니다.</li>
					<li><span class="join_number">4.</span>수질오염 방제정보센터는 회원의 귀책사유로 인한 서비스 이용 장애에 대해 그 책임이 면제됩니다.</li>
					<li><span class="join_number">5.</span>수질오염 방제정보센터는 회원이 서비스에 게재한 정보, 자료, 사실의 신뢰도, 정확성 등 그 내용에 관하여 책임이 면제됩니다.</li>
					<li><span class="join_number">6.</span>수질오염 방제정보센터가 회원에게 제공하는 서비스와 관련하여 서비스의 변경이 발생할 시 수질오염 방제정보센터가 이를 미리 회원에게 공지하는 한 서비스 변경에 대한 책임이 면제됩니다.</li>
					<li><span class="join_number">7.</span>수질오염 방제정보센터는 회원이 서비스를 이용하면서 얻은 자료로 인한 손해에 대하여 책임을 지지 않습니다. 또한 수질오염 방제정보센터는 회원이 서비스를 이용하여 타 회원으로 인해 입게 되는 정신적 피해에 대하여 보상할 책임을 지지 않습니다.</li>
					<li><span class="join_number">8.</span>수질오염 방제정보센터는 회원이 서비스에 게재한 각종 정보, 자료, 사실의 신뢰도, 정확성 등 내용에 대하여 책임을 지지 않습니다.</li>
					<li><span class="join_number">9.</span>수질오염 방제정보센터는 회원간 또는 회원과 제3자간에 서비스를 매개로 하여 물품거래 등과 관련하여 어떠한 책임도 지지 않으며, 회원이 서비스 이용과 관련하여 기대하는 이익에 관하여 책임을 부담하지 않습니다.</li>
					<li><span class="join_number">10.</span>수질오염 방제정보센터는 회원에게 무료로 제공하는 서비스의 이용과 관련해서 어떠한 손해 및 불만족에 대해서 책임을 지지 않습니다.</li>
					<li><span class="join_number">11.</span>수질오염 방제정보센터는 불가 항력에 의한 경우에는 모든 책임과 의무를 면책합니다. 불가 항력이란, 화재, 폭발, 천재지변, 전쟁, 파업 또는 정부의 조치 등 수질오염 방제정보센터가 지배할 수 없는 유사 원인을 의미합니다.</li>
					</ul>
					
					<h5 class="join_title_s mgt20">제 21 조 (분쟁의 처리)</h5>

					<ul class="jon_scroll_box.join_list mgt10">
					<li><span class="join_number">1.</span>수질오염 방제정보센터의 귀책사유가 명백히 인정되는 경우, 회원은 수질오염 방제정보센터를 상대로 소송 등을 제기하기 전에 우선 수질오염 방제정보센터에 이를 알려 수질오염 방제정보센터가 별도로 운영하는 콜센터 등을 통해 신의와 성실로서 상호 원만한 합의로 해결하도록 합니다</li>
					</ul>
					
					<h5 class="join_title_s mgt20">제 21 조 (관할 법원)</h5>
					
					<ul class="jon_scroll_box.join_list mgt10">
					<li><span class="join_number">1.</span>회원과 수질오염 방제정보센터간에 서비스 또는 본 약관에 관한 분쟁이 발생하여 소송을 할 필요가 있을 때에는 수질오염 방제정보센터의 본사 소재지를 관할하는 법원을 관할법원으로 합니다.</li>
					</ul>
					
					<p class="mgt20">&lt;시행일&gt; 본 약관은 2009년 1월 1일부터 적용됩니다.</p>
				</div>
				
				<p class="agree"><input type="checkbox" id="agree_1" /> <label for="agree_1">이용약관에 동의합니다.</label></p>
				
				<h4 class="title_2 mgt30"><img src="/images/init/agree_title2.png" alt="개인정보 취급방침" /></h4>
				
				<div class="jon_scroll_box">
					<h4 class="join_title">개인정보의 수집 및 이용 목적</h4>
					
					<p class="black mgt10">개인정보란 생존하는 개인에 관한 정보로서 당해 개인을 식별할 수 있는 정보(당해 정보만으로는 특정 개인을 식별할 수 없더라도 다른 정보와 용이하게 결합하여 식별할 수 있는 것을 포함합니다)를 말합니다.</p>

					<p class="black mgt10">수질오염 방제정보센터가 회원님 개인의 정보를 수집하는 목적은 수질오염 방제정보센터 사이트를 통하여 회원님께 최적의 맞춤 서비스를 제공해 드리기 위한 것입니다. 이때 회원님께서 제공해주신 개인정보를 바탕으로 회원님께 보다 유용한 정보를 선택적으로 제공하는 것이 가능하게 됩니다.</p>

					<ul class="jon_scroll_box.join_list mgt10">
					<li><span class="join_number">1)</span>성명, 주민번호, 아이디, 비밀번호 : 회원제 서비스 이용에 따른 본인 식별 절차에 이용</li>
					<li><span class="join_number">2)</span>이메일, 전화번호, 뉴스레터 수신여부 : 공지사항 전달, 본의의사 확인 등 원활한 의사소통 경로의 확보, 최신 정보의 소개 및 안내</li>
					<li><span class="join_number">3)</span>연락처 : 경품 등의 물품 배송에 대한 정확한 배송지의 확보</li>
					<li><span class="join_number">4)</span>주민등록번호, 거주지역 : 인구통계학적분석(이용자의 연령별,성별,지역별 통계 분석)</li>
					<li><span class="join_number">5)</span>그 외 항목 : 개인맞춤 서비스를 제공하기 위한 자료</li>
					</ul>
				</div>
				
				<p class="agree"><input type="checkbox" id="agree_2" /> <label for="agree_2">개인정보의 수집 및 이용목적에 동의합니다.</label></p>
				
				<h4 class="title_2 mgt30"><img src="/images/init/agree_title3.png" alt="수집하는 개인정보의 항목" /></h4>
				
				<div class="jon_scroll_box">
					<h4 class="join_title">수집하는 개인정보의 항목</h4>
					
					<p class="black mgt10">개인정보란 생존하는 개인에 관한 정보로서 당해 개인을 식별할 수 있는 정보(당해 정보만으로는 특정 개인을 식별할 수 없더라도 다른 정보와 용이하게 결합하여 식별할 수 있는 것을 포함합니다)를 말합니다.</p>

					<p class="black mgt10">수질오염 방제정보센터가 회원님 개인의 정보를 수집하는 목적은 수질오염 방제정보센터 사이트를 통하여 회원님께 최적의 맞춤 서비스를 제공해 드리기 위한 것입니다. 이때 회원님께서 제공해주신 개인정보를 바탕으로 회원님께 보다 유용한 정보를 선택적으로 제공하는 것이 가능하게 됩니다.</p>

					<ul class="jon_scroll_box.join_list mgt10">
					<li><span class="join_number">1)</span>필수입력사항 : 아이디, 비밀번호, 성명, 주민등록번호, 생년월일, 주소, 전화번호, 이메일주소, 직업정보, 면허번호</li>
					<li><span class="join_number">2)</span> 선택입력사항 : AIC/ATC 연수 교육 신청정보, 소프트웨어 회원(두번에/하나로OK/Vceph)일 경우 인증정보(대표 원장명, 요양기관번호), 뉴스레터 수신여부, 관심사항 체크항목, 닉네임</li>
					<li>
						<span class="join_number">3)</span>연락처 : 경품 등의 물품 배송에 대한 정확한 배송지의 확보
						
						<ul class="jon_scroll_box.join_list_s">
						<li><span class="join_number_s">가.</span>신용카드 결제 : 카드사명, 카드번호, 카드유효기간 등</li>
						<li><span class="join_number_s">나.</span>신용카드 결제 : 카드사명, 카드번호, 카드유효기간 등</li>
						</ul>
					</li>
					</ul>
				</div>
				
				<p class="agree"><input type="checkbox" id="agree_3" /> <label for="agree_3">수집하는 개인정보의 항목에 동의합니다.</label></p>
				
				<h4 class="title_2 mgt30"><img src="/images/init/agree_title4.png" alt="개인정보의 보유 및 이용기간" /></h4>
				
				<div class="jon_scroll_box">
					<h4 class="join_title">개인정보의 보유 및 이용기간</h4>
					
					<ul class="jon_scroll_box.jon_scroll_box.join_list mgt10">
					<li><span class="join_number">1)</span>귀하는 언제든지 등록되어 있는 귀하의 개인정보를 열람하거나 정정하실 수 있습니다. <br />개인정보 열람 및 정정을 하고자 할 경우에는 『개인정보변경』을 클릭하여 직접 열람 또는 정정하거나, 개인정보관리책임자 및 담당자에게 서면, 전화 또는 이메일로 연락하시면 지체 없이 조치하겠습니다.</li>
					<li><span class="join_number">2)</span>귀하가 개인정보의 오류에 대한 정정을 요청한 경우, 정정을 완료하기 전까지 당해 개인 정보를 이용 또는 제공하지 않습니다.</li>
					<li><span class="join_number">3)</span>잘못된 개인정보를 제3자에게 이미 제공한 경우에는 정정 처리결과를 제3자에게 지체 없이 통지하여 정정하도록 조치하겠습니다.</li>
					<li><span class="join_number">4)</span>계정신청 등을 통해 개인정보의 수집, 이용, 제공에 대해 귀하께서 동의하신 내용을 귀하는 언제든지 철회하실 수 있습니다. 동의철회는 웹사이트 마이페이지 화면의『동의철회(회원탈퇴)』를 클릭하거나 개인정보관리책임자에게 서면, 전화, 이메일 등으로 연락하시면 즉시 개인정보의 삭제 등 필요한 조치를 하겠습니다. 동의 철회를 하고 개인정보를 파기하는 등의 조치를 취한 경우에는 그 사실을 귀하께 지체 없이 통지하도록 하겠습니다.</li>
					<li>
						<span class="join_number">5)</span>귀하의 개인정보는 다음과 같이 개인정보의 수집목적 또는 제공받은 목적이 달성되면 파기됩니다. 단, 상법 등 관련법령의 규정에 의하여 다음과 같이 거래 관련 권리 의무 관계의 확인 등을 이유로 일정기간 보유하여야 할 필요가 있을 경우에는 일정기간 보유합니다.

						<ul class="jon_scroll_box.join_list_s">
						<li><span class="join_number_s">가.</span>계정신청정보의 경우, 계정신청을 탈퇴하거나 회원에서 제명된 경우 등 일정한 사전에 보유목적, 기간 및 보유하는 개인정보항목을 명시하여 동의를 구합니다.</li>
						<li><span class="join_number_s">나.</span>계약 또는 청약철회 등에 관한 기록 : 5년</li>
						<li><span class="join_number_s">다.</span>대금결제 및 재화 등의 공급에 관한 기록 : 5년</li>
						<li><span class="join_number_s">라.</span>소비자의 불만 또는 분쟁처리에 관한 기록 : 3년</li>
						</ul>
					</li>
					</ul>
				</div>
				
				<p class="agree"><input type="checkbox" id="agree_4" /> <label for="agree_4">개인정보의 보유 및 이용기간에 동의합니다.</label></p>
				
				
				<p class="agree"><input type="checkbox" id="agree_all" /> <label for="agree_all"><strong>모든 이용약관에 동의합니다.</strong></label></p>
				
		        <p class="btn">
		          <span><img alt="동의함" src="/images/init/agree.png" style="cursor:pointer;" id="agreeImg"/></span> 
		          <span><img alt="동의안함" src="/images/init/agree_not.png"  style="cursor:pointer;" id="notImg"/></span>
		        </p>  
		</div>
	</form:form>
        <div class="footer">
        <p class="copy">Copyright &copy; <span>2010 Korea Environment</span> Coporation All rights reserved.</p>
	 </div>
  </div><!--//password-->
</div><!--//wrap-->

</body>
</html>

		
