<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Q&A 게시판</title>
    <link rel="stylesheet" href="../resources/css/reportPageStyle.css"> <!-- 여기에 CSS 파일 링크 추가 -->
</head>
<body>
    <!-- 헤더 -->
    <header>
        <div id="header-container">
            <h1><a href="index.jsp">Q&A 게시판</a></h1>
            <form action="search.jsp" method="get" id="search-form">
                <input type="text" name="query" placeholder="검색...">
                <button type="submit">검색</button>
            </form>
            <div id="user-menu">
                <a href="login.jsp">로그인</a> | <a href="register.jsp">회원가입</a>
            </div>
        </div>
    </header>

    <!-- 네비게이션 바 -->
    <nav>
        <ul>
            <li><a href="index.jsp">홈</a></li>
            <li><a href="qa.jsp">Q&A</a></li>
            <li><a href="recent.jsp">최근 질문</a></li>
            <li><a href="popular.jsp">인기 질문</a></li>
            <li><a href="categories.jsp">카테고리</a></li>
            <li><a href="myquestions.jsp">내 질문</a></li>
            <li><a href="myanswers.jsp">내 답변</a></li>
        </ul>
    </nav>

    <!-- 메인 콘텐츠 영역 -->
    <main>
        <!-- 질문 목록 -->
        <section id="questions-list">
            <h2>질문 목록</h2>
            <ul>
                <li>
                    <a href="questionDetail.jsp?id=1">질문 제목 1</a>
                    <span>작성자1 | 작성일1 | 답변 수 | 조회수</span>
                    <button>추천</button>
                </li>
                <li>
                    <a href="questionDetail.jsp?id=2">질문 제목 2</a>
                    <span>작성자2 | 작성일2 | 답변 수 | 조회수</span>
                    <button>추천</button>
                </li>
                <!-- 추가 질문 항목들 -->
            </ul>
        </section>

        <!-- 질문 작성 -->
        <section id="ask-question">
            <h2>질문 작성하기</h2>
            <form action="submitQuestion.jsp" method="post">
                <label for="title">제목:</label>
                <input type="text" id="title" name="title" required><br>
                <label for="content">내용:</label>
                <textarea id="content" name="content" rows="5" required></textarea><br>
                <label for="tags">태그:</label>
                <input type="text" id="tags" name="tags"><br>
                <button type="submit">제출</button>
            </form>
        </section>

        <!-- 사이드바 -->
        <aside>
            <section id="popular-questions">
                <h2>인기 질문</h2>
                <ul>
                    <li><a href="questionDetail.jsp?id=3">인기 질문 제목 1</a></li>
                    <li><a href="questionDetail.jsp?id=4">인기 질문 제목 2</a></li>
                    <!-- 추가 인기 질문 항목들 -->
                </ul>
            </section>

            <section id="recent-questions">
                <h2>최근 질문</h2>
                <ul>
                    <li><a href="questionDetail.jsp?id=5">최근 질문 제목 1</a></li>
                    <li><a href="questionDetail.jsp?id=6">최근 질문 제목 2</a></li>
                    <!-- 추가 최근 질문 항목들 -->
                </ul>
            </section>

            <section id="recommended-questions">
                <h2>추천 질문</h2>
                <ul>
                    <li><a href="questionDetail.jsp?id=7">추천 질문 제목 1</a></li>
                    <li><a href="questionDetail.jsp?id=8">추천 질문 제목 2</a></li>
                    <!-- 추가 추천 질문 항목들 -->
                </ul>
            </section>

            <section id="categories">
                <h2>카테고리 목록</h2>
                <ul>
                    <li><a href="category.jsp?id=1">카테고리 1</a></li>
                    <li><a href="category.jsp?id=2">카테고리 2</a></li>
                    <!-- 추가 카테고리 항목들 -->
                </ul>
            </section>
        </aside>
    </main>

    <!-- 풋터 -->
   
</body>
</html>
