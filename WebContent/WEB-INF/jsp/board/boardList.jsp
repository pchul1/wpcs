<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8;" />
	<title>게시판 목록</title>
	<link rel="stylesheet" type="text/css" href="../css/board.css" />
</head>
<body>
<div class="board_wrap">
	<h1 class="listTit"><img src="../images/board/h_board.gif" alt="게시판" /></h1>
	<div class="board_list">
		<form action="">
			<fieldset>
				<legend class="hidden">게시판 목록 검색</legend>
				<div class="searchForm">
					<ul>
						<li><input type="checkbox" class="inputCheck" id="" /><label for="">제목</label></li>
						<li><input type="checkbox" class="inputCheck" id="" /><label for="">내용</label></li>
						<li><input type="checkbox" class="inputCheck" id="" /><label for="">게시자</label></li>
						<li><input type="checkbox" class="inputCheck" id="" /><label for="">날짜</label></li>
					</ul>
					<p>
						<label for="" class="hidden">입력</label><input type="text" class="inputText" id="" /> 
						<input type="image" src="../images/board/btn_search.gif" alt ="검색" /> 
					</p>
				</div>
			</fieldset>
		</form>
		<!-- 글목록 내용 -->
		<div class="innerBox">
			<table class="listTable" summary="게시판 리스트. 번호, 제목, 날짜, 조회, 파일이 담김">
				<colgroup>
					<col width="50px" />
					<col />
					<col width="120px" />
					<col width="70px" />
					<col width="50px" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">날짜</th>
						<th scope="col">조회</th>
						<th scope="col">파일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="result" items="${boardList}" varStatus="status">
						<tr>
							<td><c:out value="${status.count}"/></td>
							<td class="con">
								<a href="/board/boardRead.do?boardNum=${result.boardnum}">
									<c:out value="${result.subject}"/>
								</a>
							</td>
							<td><c:out value="${result.regdate}"/></td>
							<td><c:out value="${result.hitcount}"/></td>
							<td class="file"><c:out value="${result.filecnt}"/></td>
						</tr>
					</c:forEach>
					<!-- 일반글
					<tr>
						<td>472</td>
						<td class="con"><strong>[기술지원]</strong>수질 TMS 전문기술교육 참가신청은 어디에?</td>
						<td>2010.05.06</td>
						<td>34</td>
						<td class="file"><a href="#"><img src="../images/board/ico_file.gif" alt="파일" /></a></td>
					</tr>
					-->
					
					<!-- 답글
					<tr>
						<td colspan="5" class="con">
							<div class="reply" style="margin-left:53px">
								Re: 초기값은 margin-left:53px
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="5" class="con">
							<div class="reply" style="margin-left:63px">
								Re: 순차적으로 margin-left:10px 씩 증가
							</div>
						</td>
					</tr>
					-->
				</tbody>
			</table>
		</div>
		<!-- 페이징 -->
		<ul class="paginate">
			<li><a href="">이전...</a></li>
			<li><em>1</em></li><!-- 현재 페이지는 a태그 대신 em태그 사용 -->
			<li><a href="">2</a></li>
			<li><a href="">...다음</a></li>
		</ul>
		<!-- //페이징 -->
		<!-- 버튼 메뉴 -->
		<ul class="btn_menu">
			<li><a href="/board/boardWrite?mode=write" class="btn_basic btn_bgBlue"><span>글쓰기</span></a></li>
		</ul>
		<!-- //버튼 메뉴 -->
	</div>
	<!-- //글목록 내용 -->
</div>
</body>
</html>