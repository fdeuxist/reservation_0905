<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>반응형 레이아웃</title>
    <style>
        body, html {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        /* 기본 레이아웃 설정 */
        .container {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 20%; /* 폭을 2/12~3/12로 설정 (화면의 1/4) */
            max-width: 250px; /* 최대 폭 */
            min-width: 150px; /* 최소 폭 */
            background-color: #333;
            color: white;
            padding: 20px;
            transition: transform 0.3s ease;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
        }

        .sidebar ul li {
            margin-bottom: 20px;
        }

        .sidebar ul li a {
            color: white;
            text-decoration: none;
        }

        .content {
            flex: 1;
            padding: 20px;
        }

        /* 우측 상단 로그인/로그아웃 */
        .header {
            display: flex;
            justify-content: flex-end;
            background-color: #f1f1f1;
            padding: 10px 20px;
        }

        .header a {
            margin-left: 15px;
            text-decoration: none;
            color: #333;
        }

        .hamburger {
            display: none;
            font-size: 30px;
            cursor: pointer;
            color: white;
        }

        @media (max-width: 768px) {
            .sidebar {
                position: fixed;
                top: 0;
                left: 0;
                height: 100%;
                transform: translateX(-100%);
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .hamburger {
                display: block;
            }

            .container {
                flex-direction: column;
            }

            .content {
                padding-top: 60px;
            }
        }
    </style>
</head>
<body>

<div class="header">
    <!-- 로그인 상태에 따른 링크 표시 -->
    <div id="auth-links">
        <a href="#">로그인</a>
        <a href="#">회원가입</a>
    </div>
    <!-- 로그인 상태 예시 (자바스크립트로 로그인 상태에 따라 변경 가능) -->
    <!--
    <div id="auth-links">
        <span>user@example.com</span>
        <a href="#">로그아웃</a>
    </div>
    -->
</div>

<div class="container">
    <div class="sidebar" id="sidebar">
        <span class="hamburger" id="hamburger">&#9776;</span>
        <ul>
            <li><a href="#">메뉴 1</a></li>
            <li><a href="#">메뉴 2</a></li>
            <li><a href="#">메뉴 3</a></li>
            <li><a href="#">메뉴 4</a></li>
        </ul>
    </div>

    <div class="content">
        <h1>메인 콘텐츠 영역</h1>
        <p>이곳에 메인 콘텐츠가 들어갑니다.</p>
    </div>
</div>

<script>
    // 햄버거 메뉴 클릭 이벤트
    document.getElementById('hamburger').addEventListener('click', function () {
        var sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('active');
    });
</script>

</body>
</html>
