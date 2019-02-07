<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8;" />
	<title>게시판 보기</title>
	<link rel="stylesheet" type="text/css" href="../css/board.css" />
</head>
<body>
<div class="board_wrap">
	<h1><img src="../images/board/h_board.gif" alt="게시판" /></h1>
	<!-- 글보기 내용 -->
	<div class="board_view">
		<div class="innerBox">
			<h2><span>제목</span>${bean.subject}</h2><!-- //타이틀 -->
			<p class="date_name_file">
				<span>[${bean.regdate}] ${bean.username}</span>
				<a href="#" class="file">파일명</a>
			</p><!-- //날짜 이름 파일명 -->
			<p class="content">
				${bean.contents}
			</p><!-- //내용 -->
		</div>
		<!-- 버튼 메뉴 -->
		<ul class="btn_menu">
			<li class="pw"><label for="">비밀번호</label> <input name="password" type="text" id="" /></li>
			<li><a href="#" class="btn_basic btn_bgBlue"><span>수정</span></a></li>
			<li><a href="#" class="btn_basic btn_bgBlue"><span>삭제</span></a></li>
			<li><a href="#" class="btn_basic btn_bgBlue"><span>답변</span></a></li>
			<li><a href="/board/boardList.do" class="btn_basic btn_bgBlue"><span>목록</span></a></li>
		</ul>
		<!-- //버튼 메뉴 -->
	</div>
	<!-- //글보기 내용 -->
</div>
</body>
</html>