<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- 부트스트랩 CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">   
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.5.2/dist/sketchy/bootstrap.min.css" integrity="sha384-RxqHG2ilm4r6aFRpGmBbGTjsqwfqHOKy1ArsMhHusnRO47jcGqpIQqlQK/kmGy9R" crossorigin="anonymous">

<style>
a {
	text-decoration: none;
}
</style>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="home">Good Shopping</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor03" aria-controls="navbarColor03" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarColor03">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link active" href="goodsList?gCategory=top">top</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="goodsList?gCategory=dress">dress</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="goodsList?gCategory=outer">outer</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="goodsList?gCategory=bottom">bottom</a>
        </li>
      </ul>
      <div class="d-flex">
        <!-- 로그인 안 된 경우 -->
		<c:if test="${empty login}"><!-- login 없는 경우 -->
			<a href="loginForm">Login</a>&nbsp;&nbsp;<!-- xml에 주소 설정 -->
			<a href="loginCheck/cartList">Cart</a>&nbsp;&nbsp;
			<a href="memberForm">SignUP</a>&nbsp;&nbsp;<!-- xml에 주소 설정 -->
		</c:if>
		
		<!-- 로그인 된 경우 -->
		<c:if test="${!empty login}"><!-- login 있는 경우 -->
		안녕하세요,   ${login.userid}님!&nbsp;&nbsp;&nbsp;
			<a href="loginCheck/logout">Logout</a>&nbsp;&nbsp;<!-- 인터셉터 활용 : login여부 확인 -->
			<a href="loginCheck/mypage">MyPage</a>&nbsp;&nbsp;
			<a href="loginCheck/cartList">Cart</a>&nbsp;&nbsp;
		</c:if>
      </div>
    </div>
  </div>
</nav>