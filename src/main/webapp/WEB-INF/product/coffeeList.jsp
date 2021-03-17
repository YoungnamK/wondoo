<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="./../common/common.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록</title>
<script type="text/javascript" src="${contextPath}/js/product.js"></script>
<link rel="stylesheet" href="${contextPath}/css/product.css">
<style type="text/css">
.pro_picture{
	max-width: 350px;
	max-height: 236.56px;
}
</style>
</head>
<body onload="list_loading();" class="top">
	<!-- 
        ================================================== 
            사진 Section Start
        ================================================== -->
	<section class="works service-page">

		<div class="container">
			<div id="top">
				<h2 class="wow fadeInLeft animated portfolio-item"
					data-wow-duration="500ms" data-wow-delay="0ms">COFFEE</h2>
				<span class="subtitle-des wow fadeInDown" data-wow-duration="500ms"
					data-wow-delay="0.1s" id="search_btn" data-toggle="tooltip"
					title="클릭하세요!" onclick="search();"> <i class="fas fa-search"></i>
					검색
				</span> <br>
			</div>


			<%-- [검색 모드] ==== 시작 ==== --%>
			<form id="contact-form search" method="get"
				action="${contextPath}/cfList.pr" role="form">
				<div id="search">
					<select class="form-control" name="mode" id="mode"
						data-toggle="tooltip" title="검색할 조건을 선택하세요!">
						<option class="form-control" value="all">전체</option>
						<option class="form-control" value="pro_type">타입</option>
						<option class="form-control" value="pro_name">이름</option>
					</select> <input type="text" class="form-control"
						placeholder="타입은 싱글오리진, 블렌딩, 캡슐 중에 입력하세요" id="keyword" name="keyword">
					<button type="submit">
						<i class="fas fa-search"></i>
					</button>
				</div>
			</form>
			<%-- ==== 끝 ==== --%>
			<p id="list_top">${requestScope.totalCount}개의 상품</p>
			<c:forEach var="bean" items="${requestScope.lists}" varStatus="status">
				<input id="status" type="hidden" value="${status.count}">
				<c:if test="${status.count % 3 == 0}"> <!-- 현재 반복 순서가 3의 배수 인 경우  -->
					<div class="row">
						<div class="col-md-4">
							<!-- 검색 모드에서 활용 [시작]-->
							<input type="hidden" value="${bean.pro_type}">
							<input type="hidden" value="${bean.pro_name}">
							<!-- 검색 모드에서 활용 [끝] -->
							<input type="hidden" id="products_seq" value="${bean.products_seq}">
							<!--  시퀀스 -->
							<figure class="wow fadeInLeft animated portfolio-item" data-wow-duration="500ms" data-wow-delay="0ms">
								<div class="img-wrapper">
									<img src="./upload/${bean.pro_pic}" class="img-responsive pro_picture" alt="image">
									<div class="overlay">
										<div class="buttons">
											<a href="${contextPath}/prDetail.pr?products_seq=${bean.products_seq}">자세히 보기</a>
											<c:if test="${bean.pro_sell_email eq sessionScope.loginfo_seller.sell_Email}">
												<a href="${contextPath}/prUpdate.pr?products_seq=${bean.products_seq}">수정</a>
												<a data-toggle="modal" data-target="#myModal">삭제</a>
											</c:if>
										</div>
									</div>
								</div>
								<figcaption>
									<h4>
										<a href="#detail.jsp">${bean.pro_name}</a>
									</h4>
									<div class="list_bottom">
										<p id="list_price">
											<i class="fas fa-won-sign"></i>&nbsp;
											<fmt:formatNumber pattern="###,###" value="${bean.pro_price}" />
										</p>
									</div>
								</figcaption>
							</figure>
						</div>
					</div>
				</c:if>
				<c:if test="${status.count % 3 != 0}"> <!-- 현재 반복 순서가 3의 배수가 아닌 인 경우  -->
					<div class="col">
						<div class="col-md-4">
							<!-- 검색 모드에서 활용 [시작]-->
							<input type="hidden" value="${bean.pro_type}">
							<input type="hidden" value="${bean.pro_name}">
							<!-- 검색 모드에서 활용 [끝] -->
							<input type="hidden" id="products_seq" value="${bean.products_seq}">
							<figure class="wow fadeInLeft animated portfolio-item" data-wow-duration="500ms" data-wow-delay="0ms">
								<div class="img-wrapper">
									<img src="./upload/${bean.pro_pic}" class="img-responsive pro_picture" alt="image">
									<div class="overlay">
										<div class="buttons">
											<a href="${contextPath}/prDetail.pr?products_seq=${bean.products_seq}">자세히 보기</a>
											<c:if test="${bean.pro_sell_email eq sessionScope.loginfo_seller.sell_Email}">
												<a href="${contextPath}/prUpdate.pr?products_seq=${bean.products_seq}">수정</a>
												<a data-toggle="modal" data-target="#myModal">삭제</a>
											</c:if>
										</div>
									</div>
								</div>
								<figcaption>
									<h4>
										<a href="#detail.jsp">${bean.pro_name}</a>
									</h4>
									<div class="list_bottom">
										<p id="list_price">
											<i class="fas fa-won-sign"></i>&nbsp;
											<fmt:formatNumber pattern="###,###" value="${bean.pro_price}" />
										</p>
									</div>
								</figcaption>
							</figure>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>
		<div align="center">
			<footer>${requestScope.pagingHtml}</footer>
		</div>
	</section>


	<!-- ------------------------------------- [모달 section]--------------------------------------- -->
	<div class="container">

		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog modal-sm">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 id="modal-title" class="modal-title" style="font-size: 35px">
							<i class="fas fa-exclamation-circle"></i>
						</h4>
					</div>
					<div class="modal-body">
						<p id="modal-body" style="font-size: 13px">정말 삭제 하시겠습니까?</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal"
							style="font-size: 13px" onclick="del_check();">예</button>
						<button type="button" class="btn btn-default" data-dismiss="modal"
							style="font-size: 13px">아니오</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>