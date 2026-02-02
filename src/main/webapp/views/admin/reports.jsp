<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Báo Cáo Quản Trị</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<style>
		.sidebar-scroll { max-height: 75vh; overflow-y: auto; }
		.card-header { font-size: 0.85rem; letter-spacing: 0.5px; }
		.badge-count { font-size: 0.75rem; padding: 0.35em 0.65em; }
	</style>
</head>
<body class="bg-light">

<c:if test="${empty sessionScope.authUser || !sessionScope.authUser.role}">
	<c:redirect url="/login"/>
</c:if>

<div class="container-fluid py-4">

	<!-- ===== HEADER (FIXED) ===== -->
	<div class="d-flex justify-content-between align-items-center mb-4 px-2">
		<div class="d-flex align-items-center gap-2">
			<a href="${pageContext.request.contextPath}/home"
			   class="btn btn-outline-dark btn-sm">
				⬅️ Quay về trang chủ
			</a>
			<h2 class="text-primary fw-bold mb-0">REPORT DASHBOARD</h2>
		</div>

		<a href="${pageContext.request.contextPath}/admin/reports"
		   class="btn btn-primary shadow-sm">
			Làm mới dữ liệu
		</a>
	</div>
	<!-- ===== END HEADER ===== -->

	<div class="row g-4">
		<div class="col-md-3">
			<div class="card shadow-sm border-0">
				<div class="card-header bg-dark text-white fw-bold">
					Danh Sách Nhà Hàng
				</div>
				<div class="list-group list-group-flush sidebar-scroll">
					<c:forEach var="r" items="${allRestaurants}">
						<a href="?restaurantId=${r.restaurantId}"
						   class="list-group-item list-group-item-action
						   ${param.restaurantId == r.restaurantId ? 'active' : ''}">
								${r.name}
						</a>
					</c:forEach>
				</div>
			</div>
		</div>

		<div class="col-md-9">
			<c:choose>
				<c:when test="${not empty selectedRest}">
					<div class="bg-white p-3 rounded shadow-sm mb-4 border-start border-primary border-5">
						<h4 class="mb-0 fw-bold">
							Nhà hàng: ${selectedRest.name}
						</h4>
						<small class="text-muted">
							ID: ${selectedRest.restaurantId}
							| Tổng lượt xem: ${selectedRest.viewCount}
						</small>
					</div>

					<div class="row g-3">
						<div class="col-md-4">
							<div class="card h-100 border-0 shadow-sm">
								<div class="card-header bg-danger text-white fw-bold d-flex justify-content-between align-items-center">
									USERS ĐÃ LIKE
									<span class="badge rounded-pill bg-white text-danger badge-count">
											${countLikes}
									</span>
								</div>
								<ul class="list-group list-group-flush">
									<c:forEach var="u" items="${likedUsers}">
										<li class="list-group-item small">
											<strong>${u.username}</strong><br>
											<span class="text-muted" style="font-size: 0.7rem;">
													${u.email}
											</span>
										</li>
									</c:forEach>
									<c:if test="${empty likedUsers}">
										<div class="p-4 text-center text-muted small">
											Chưa có lượt thích
										</div>
									</c:if>
								</ul>
							</div>
						</div>

						<div class="col-md-4">
							<div class="card h-100 border-0 shadow-sm">
								<div class="card-header bg-info text-white fw-bold d-flex justify-content-between align-items-center">
									EMAIL NHẬN CHIA SẺ
									<span class="badge rounded-pill bg-white text-info badge-count">
											${countShares}
									</span>
								</div>
								<ul class="list-group list-group-flush">
									<c:forEach var="mail" items="${sharedEmails}">
										<li class="list-group-item small text-truncate text-secondary">
												${mail}
										</li>
									</c:forEach>
									<c:if test="${empty sharedEmails}">
										<div class="p-4 text-center text-muted small">
											Chưa có lượt chia sẻ
										</div>
									</c:if>
								</ul>
							</div>
						</div>

						<div class="col-md-4">
							<div class="card h-100 border-0 shadow-sm">
								<div class="card-header bg-warning text-dark fw-bold d-flex justify-content-between align-items-center">
									BÌNH LUẬN GẦN ĐÂY
									<span class="badge rounded-pill bg-dark text-white badge-count">
											${countComms}
									</span>
								</div>
								<div class="list-group list-group-flush">
									<c:forEach var="cm" items="${comments}">
										<c:if test="${not empty cm}">
											<div class="list-group-item border-0 border-bottom">
												<strong class="small text-primary">
													<c:out value="${cm[0]}" default="Guest"/>
												</strong>
												<p class="mb-0 small text-secondary mt-1">
													"<c:out value="${cm[1]}" default="..."/>"
												</p>
											</div>
										</c:if>
									</c:forEach>
									<c:if test="${empty comments}">
										<div class="p-4 text-center text-muted small">
											Không có bình luận
										</div>
									</c:if>
								</div>
							</div>
						</div>
					</div>
				</c:when>

				<c:otherwise>
					<div class="card border-0 shadow-sm p-5 text-center">
						<h5 class="text-muted">
							Vui lòng chọn nhà hàng ở danh sách bên trái để xem chi tiết.
						</h5>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
</body>
</html>
