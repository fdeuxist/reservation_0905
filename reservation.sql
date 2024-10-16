
--=================================================================================================================
--=================================================================================================================
--전체 내용 sql developer에 복붙
--=================================================================================================================
--=================================================================================================================
/*
윈도우키+R
cmd 우클릭 관리자권한 실행
sqlplus /nolog
conn sys as sysdba;
create user c##reser identified by vation;
grant connect, resource, dba to c##reser;
conn c##reser/vation;
show user;
exit
exit

sql developer 실행
접속 밑에 녹색 십자가 아이콘 클릭
Name : reservation
사용자 이름 : c##reser
비밀번호 : vation
비밀번호 오른쪽에 저장 체크박스 체크
테스트 눌러서 상태에 성공 뜨는거 확인하고 저장
reservation에 접속 하고 이하 실행
*/

--=================================================================================================================
--=================================================================================================================
--=======위 내용 먼저 작업 후 이하 진행===============================================================================
--=================================================================================================================
--=================================================================================================================
drop table users;
create table users(
    email varchar2(255) primary key,		-- pk, email(id)
    password varchar2(255),		--
    name varchar2(255),			--
    phone varchar2(20),			--
    enable integer default 1 not null 	-- 
    );

drop table authorities;
create table authorities(
    email varchar2(255) not null,				--fk
    authority varchar2(20) default 'ROLE_MEMBER' not null
);

drop table vendor;
create table vendor (
    email varchar2(255) not null,   --fk, email(id)
    business_regi_num varchar2(20), --사업자등록번호
    business_name varchar2(255),    --사업명(간판)
    zipcode varchar2(10),           --우편번호
    basic_address varchar2(255),    --기본주소
    detail_address varchar2(255),   --상세주소
    business_type varchar2(255)     --업종코드
    );

drop table vendor_reservation;
create table vendor_reservation (
    email varchar2(255) not null,   --사업자이메일 ┐
    business_regi_num varchar2(20), --사업자번호　 ┴ 복합키 
    open_date date,                 --예약등록 년월일 (예약을 받겠다는)
    times varchar2(50),             --예약등록 시간 48개 0101
    status_flag varchar2(4),         --해당년월일 예약 비활성화(수정중,예약불가)/활성화(수정완료,예약가능)등 상태. 수정중이라면 일반유저가 예약을 못함
    constraint vendor_reservation_unique
        unique (email, business_regi_num, open_date)
);

drop table user_reservation;
create table user_reservation (
    reservation_number varchar2(20) not null,   --예약(주문)번호 pk (년4 월2 일2 시2 분2 초2 ms3) 17자리숫자
    user_email varchar2(255) not null,          --유저이메일 fk (예악자)    (users)
    user_name varchar2(255) not null,           --유저이름 (예악자)         (users)
    user_phone  varchar2(20) not null,          --예약 당시 유저의 전화번호 (예악자)    (users)
    vendor_email varchar2(255) not null,        --사업자이메일 ┐                (vendor)
    business_regi_num varchar2(20),             --사업자번호　 ┴ 복합키 fk       (vendor)
    vendor_name  varchar2(255) not null,        --예약 당시 사업자의 이름 (사업자)    (vendor)
    vendor_phone  varchar2(20) not null,        --예약 당시 사업자의 전화번호 (사업자)    (vendor)
    business_name varchar2(255),                --예약 당시 사업명(간판) --0829추가
    zipcode varchar2(10),                       --예약 당시 이용 예정 장소 우편번호(vendor)
    basic_address varchar2(255),                --예약 당시 이용 예정 장소 기본주소(vendor)
    detail_address varchar2(255),               --예약 당시 이용 예정 장소 상세주소(vendor)
    reservation_date date,                      --예약 발생 년월일
    reservation_use_date date,                  --이용 예정 년월일
    times varchar2(50),                         --이용 예정 시간 48개단위
    times_hhmm varchar2(20),                    --이용 예정 시간 HH:mm   --0829추가
    total_service_name varchar2(4000),          --예약 당시 이용 예정 서비스 이름들(service_items)
    total_service_price number,                 --예약 당시 이용 예정 서비스 가격 총 합 (service_items)
    total_required_time number,                 --예약 당시 이용 예정 제공(필요)시간 총 합 (service_items)
    user_request_memo varchar2(4000),           --유저 요청사항 메모. 주문자와 방문자가 다를때 연락처를 적는다거나 기타 요청사항 등
    status varchar2(50)                         --주문 상태. 1입금대기/2입금완료/3이용완료/
                                                --       4(취소요청)이용자취소(회원요청,사업자승인필요)/
                                                --       5(취소완료)사업자취소(사업자요청,회원승인불필요)/6환불대기/7환불완료 등 상태
    );

drop sequence item_id;
CREATE SEQUENCE item_id;
drop table service_items;
create table service_items (
    item_id number not null,         --pk 
    email varchar2(255) not null,   --사업자이메일 ┐
    business_regi_num varchar2(20) not null, --사업자번호　 ┴ 복합키
    service_name varchar2(255),             --상품명
    service_description varchar2(255),      --설명
    required_time number,                   --제공(필요)시간 (1당 30분)
    service_price number,                   --가격
    item_status varchar2(10) default '1' not null                --item 상태, (사용가능 여부 등)  (1:사용, 0:미사용 등)
    );

drop table business_place_info;
create table business_place_info (
    email varchar2(255) not null,   --사업자이메일 ┐
    business_regi_num varchar2(20), --사업자번호　 ┴ 복합키
    place_info varchar2(4000)      --업소 소개
    );

drop table business_place_image_path;
create table business_place_image_path (
    email varchar2(255) not null,   --사업자이메일 ┐
    business_regi_num varchar2(20), --사업자번호　 ┴ 복합키
    place_img_path  varchar2(255),
    is_main char(1) default 'N',         -- 대표 이미지 여부 (Y/N)
    file_data BLOB
    );

drop view search_place;
create view search_place as
select 
    u.email, u.phone, v.business_regi_num, v.business_name, 
    v.basic_address, v.detail_address, v.business_type, b.place_info
from users u
join vendor v on u.email = v.email
join business_place_info b on v.email = b.email 
    and v.business_regi_num = b.business_regi_num
    and u.enable <> 0;

drop sequence bId;
create sequence bId;
drop table board;
CREATE TABLE board (
	bGroupKind VARCHAR2(255),
	bId NUMBER PRIMARY KEY,
	bName VARCHAR2(255) NOT NULL,
	bTitle VARCHAR2(255) NOT NULL,
	bContent VARCHAR2(4000) NOT NULL,
	bEtc VARCHAR2(4000) NULL,
	bWriteTime DATE DEFAULT sysdate,
	bUpdateTime DATE DEFAULT null,
	bHit NUMBER DEFAULT 0,
	bGroup NUMBER ,
	bStep NUMBER DEFAULT 0,
	bIndent NUMBER DEFAULT 0,
	bDelete VARCHAR2(1) DEFAULT 'Y',
	bLike NUMBER DEFAULT 0,
	bDislike NUMBER DEFAULT 0
);

drop sequence rId;
create sequence rId;
drop table reply;
CREATE TABLE reply (
	rId NUMBER PRIMARY KEY,
	bId NUMBER NOT NULL,
	rContent VARCHAR2(1000) NOT NULL,
	rName VARCHAR2(100) NOT NULL,
	rWriteTime date DEFAULT sysdate,
	rUpdateTime date,
	rEtc VARCHAR2(1000),
	rGroup NUMBER NOT NULL,
	rStep NUMBER DEFAULT 0,
	rIndent NUMBER DEFAULT 0,
	rDelete CHAR(1) DEFAULT 'N'
);


drop TABLE tbl_reply;
--=======

--CREATE TABLE tbl_reply (
    --rId        NUMBER  GENERATED BY DEFAULT AS IDENTITY,
    --writer     VARCHAR2(30) NOT NULL,
    --content    CLOB NOT NULL,
    --writeTime    DATE DEFAULT SYSDATE NOT NULL,
    --rGroup NUMBER default 0,
    --rStep NUMBER default 0,
    --rIndent NUMBER default 0,
    --reservation_number varchar2(20) not null
--);

--desc image_storage;
--select * from image_storage;
--commit;
--delete from image_storage;
--create table image_storage (
    --id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    --file_name VARCHAR2(255),
    --file_data BLOB
--);

drop table reviews;
create table reviews (
    reservation_number varchar2(20) not null,   --예약(주문)번호 pk (년월일시분초ms)
    review_date date,                           --리뷰작성 년월일
    star_point number,                          --별점
    member_content varchar2(4000),              --회원 리뷰 내용
    vendor_content varchar2(4000)              --사업자 답글 내용
    );
    
--=================================================================================================================
--=================================================================================================================
--=======위 내용 먼저 작업 후 이하 진행===============================================================================
--=================================================================================================================
--=================================================================================================================
--여기까지 하고 sts로 구동 후 http://localhost:자기포트/ex/user/insert_init 에 접근 
--페이지에 TEST account insert OK 라는 문자열이 보이면
--아래 테스트용 기본 7가지 계정 가입된 것 (비밀번호 1111 통일)
-- (이메일/비밀번호/이름/전화번호)
-- admin/1111/1/1
-- manager/1111/1/1
-- member1/1111/1/1
-- member2/1111/1/1
-- vendor1/1111/1/1
-- vendor2/1111/1/1
-- vendor3/1111/1/1
-- 이하 sql developer 에서 실행

update authorities set authority='ROLE_ADMIN' where email='admin';
update authorities set authority='ROLE_VENDOR' where email='vendor1';
update authorities set authority='ROLE_VENDOR' where email='vendor2';
update authorities set authority='ROLE_VENDOR' where email='vendor3';
update authorities set authority='ROLE_MANAGER' where email='manager';
insert into vendor values('vendor1', '111-11-11111',      '하르르헤어',   '21404', '인천 부평구 경원대로 1368', '1층', '미용실');
insert into vendor values('vendor2', '222-22-22222',      '혜영헤어',   '21404', '인천 부평구 경원대로 1358-1', '', '미용실');
insert into vendor values('vendor3', '333-33-33333',      '모리헤어아뜰리에 부평본점',        '21389', '인천 부평구 경원대로1367번길 4', '2층', '미용실');
insert into business_place_info(email, business_regi_num, place_info) values ('vendor1','111-11-11111', 
    '북인천우체국 맞은편(메가커피가기전)이며 부평역 도보 5분 , 버스정류장 부평역or대한극장 도보 1분입니다 ! ( * 주차공간이 없어 지원해드리지 않습니다 ! )');
insert into business_place_info(email, business_regi_num, place_info) values ('vendor2','222-22-22222', 
    '북인천우체국 맞은편 부평공원 가는길방향에서 두산아파트가기전에 위치 매주수요일은 휴무입니다');
insert into business_place_info(email, business_regi_num, place_info) values ('vendor3','333-33-33333', 
    '삼성리빙텔 2층에 위치하고 있습니다^^ 정확한 입구는 조금더 안쪽으로 들어오셔야되요! 지하주차장 이용시에는 차량들어오는 입구로 올라오시면 2층계단이 바로 보입니다^^');
update users set name='윤영자' , phone='01026592541' where email='admin';
update users set name='이회원' , phone='01026592541' where email='member1';
update users set name='박회원' , phone='01026592541' where email='member2';
update users set name='벤더명1' , phone='01026592541' where email='vendor1';
update users set name='벤더명2' , phone='01026592541' where email='vendor2';
update users set name='벤더명3' , phone='01026592541' where email='vendor3';
update users set name='매니저1' , phone='01026592541' where email='manager';
insert into service_items values(item_id.nextval, 'vendor1', '111-11-11111', 'Man_디자인펌', '일반펌', 3, 77000, '1' );
insert into service_items values(item_id.nextval, 'vendor1', '111-11-11111', '탈색아우라펌+하르르크리닉', '열펌', 4, 207000, '1' );
insert into service_items values(item_id.nextval, 'vendor1', '111-11-11111', '펌+하르르크리닉', '열펌', 4, 172000, '1' );
insert into service_items values(item_id.nextval, 'vendor2', '222-22-22222', '남성컷', '남성컷', 2, 15000, '1' );
insert into service_items values(item_id.nextval, 'vendor2', '222-22-22222', '여성컷', '여성컷', 3, 18000, '1' );
insert into service_items values(item_id.nextval, 'vendor2', '222-22-22222', '일반펌', '열펌', 4, 50000, '1' );
insert into service_items values(item_id.nextval, 'vendor3', '333-33-33333', '여성 컷', '', 3, 25000, '1' );
insert into service_items values(item_id.nextval, 'vendor3', '333-33-33333', '남성 컷', '', 2, 22000, '1' );
insert into service_items values(item_id.nextval, 'vendor3', '333-33-33333', '일반롯드펌', '', 4, 100000, '1' );
insert into service_items values(item_id.nextval, 'vendor3', '333-33-33333', '열펌', '', 4, 180000, '1' );
insert into service_items values(item_id.nextval, 'vendor3', '333-33-33333', '기본염색', '', 4, 80000, '1' );
insert into vendor_reservation values ('vendor1', '111-11-11111', '2024-11-01', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor1', '111-11-11111', '2024-11-04', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor1', '111-11-11111', '2024-11-05', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor1', '111-11-11111', '2024-11-06', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor1', '111-11-11111', '2024-11-07', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor1', '111-11-11111', '2024-11-08', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor1', '111-11-11111', '2024-11-11', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor1', '111-11-11111', '2024-11-12', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor1', '111-11-11111', '2024-11-13', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor1', '111-11-11111', '2024-11-14', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor1', '111-11-11111', '2024-11-15', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor1', '111-11-11111', '2024-11-18', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor1', '111-11-11111', '2024-11-19', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor1', '111-11-11111', '2024-11-20', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor1', '111-11-11111', '2024-11-21', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor1', '111-11-11111', '2024-11-22', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor1', '111-11-11111', '2024-11-25', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor1', '111-11-11111', '2024-11-26', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor1', '111-11-11111', '2024-11-27', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor1', '111-11-11111', '2024-11-28', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor1', '111-11-11111', '2024-11-29', '000000000000000000101010001010101010101000000000', '1');

insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-01', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-02', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-03', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-04', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-05', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-07', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-08', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-09', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-10', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-11', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-12', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-14', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-15', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-16', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-17', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-18', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-19', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-21', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-22', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-23', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-24', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-25', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-26', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-28', '000000000000000000101010001010101010101000000000', '1');
insert into vendor_reservation values ('vendor2', '222-22-22222', '2024-11-29', '000000000000000000101010001010101010101000000000', '1');

insert into vendor_reservation values ('vendor3', '333-33-33333', '2024-11-01', '000000000000000000001010001010101010101010000000', '1');
insert into vendor_reservation values ('vendor3', '333-33-33333', '2024-11-04', '000000000000000000001010001010101010101010000000', '1');
insert into vendor_reservation values ('vendor3', '333-33-33333', '2024-11-05', '000000000000000000001010001010101010101010000000', '1');
insert into vendor_reservation values ('vendor3', '333-33-33333', '2024-11-06', '000000000000000000001010001010101010101010000000', '1');
insert into vendor_reservation values ('vendor3', '333-33-33333', '2024-11-07', '000000000000000000001010001010101010101010000000', '1');
insert into vendor_reservation values ('vendor3', '333-33-33333', '2024-11-08', '000000000000000000001010001010101010101010000000', '1');
insert into vendor_reservation values ('vendor3', '333-33-33333', '2024-11-11', '000000000000000000001010001010101010101010000000', '1');
insert into vendor_reservation values ('vendor3', '333-33-33333', '2024-11-12', '000000000000000000001010001010101010101010000000', '1');
insert into vendor_reservation values ('vendor3', '333-33-33333', '2024-11-13', '000000000000000000001010001010101010101010000000', '1');
insert into vendor_reservation values ('vendor3', '333-33-33333', '2024-11-14', '000000000000000000001010001010101010101010000000', '1');
insert into vendor_reservation values ('vendor3', '333-33-33333', '2024-11-15', '000000000000000000001010001010101010101010000000', '1');
insert into vendor_reservation values ('vendor3', '333-33-33333', '2024-11-18', '000000000000000000001010001010101010101010000000', '1');
insert into vendor_reservation values ('vendor3', '333-33-33333', '2024-11-19', '000000000000000000001010001010101010101010000000', '1');
insert into vendor_reservation values ('vendor3', '333-33-33333', '2024-11-20', '000000000000000000001010001010101010101010000000', '1');
insert into vendor_reservation values ('vendor3', '333-33-33333', '2024-11-21', '000000000000000000001010001010101010101010000000', '1');
insert into vendor_reservation values ('vendor3', '333-33-33333', '2024-11-22', '000000000000000000001010001010101010101010000000', '1');
insert into vendor_reservation values ('vendor3', '333-33-33333', '2024-11-25', '000000000000000000001010001010101010101010000000', '1');
insert into vendor_reservation values ('vendor3', '333-33-33333', '2024-11-26', '000000000000000000001010001010101010101010000000', '1');
insert into vendor_reservation values ('vendor3', '333-33-33333', '2024-11-27', '000000000000000000001010001010101010101010000000', '1');
insert into vendor_reservation values ('vendor3', '333-33-33333', '2024-11-28', '000000000000000000001010001010101010101010000000', '1');
insert into vendor_reservation values ('vendor3', '333-33-33333', '2024-11-29', '000000000000000000001010001010101010101010000000', '1');
select * from business_place_image_path;
select * from business_place_info;
select * from service_items;
commit;
--=================================================================================================================
-- vendor myorders pagenation test sql=============================================================================
INSERT INTO user_reservation VALUES ('20240815000000001', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000002', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000003', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000004', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000005', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000006', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000007', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000008', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000009', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000010', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000011', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000012', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000013', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000014', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000015', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000016', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000017', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000018', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000019', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000020', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000021', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000022', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000023', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000024', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000025', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000026', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000027', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000028', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000029', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000030', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000031', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000032', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000033', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000034', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000035', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000036', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000037', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000038', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000039', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000040', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000041', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000042', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000043', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000044', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000045', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000046', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000047', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000048', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000049', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000050', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000051', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000052', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000053', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000054', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000055', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000056', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000057', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000058', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000059', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000060', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000061', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000062', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000063', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000064', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000065', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000066', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000067', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000068', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000069', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000070', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000071', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000072', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000073', 'member2', '박회원', '01063188216', 'vendor3', '333-33-33333', '벤더명3', '01063188216','모리헤어아뜰리에 부평본점', '21389', '인천 부평구 경원대로1367번길 4', '2층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
select * from user_reservation;
commit;
--별점 정렬 더미데이터=================================================================================================================
delete from reviews;
--모리헤어 8개 평점4.5
insert into reviews values ('20240815000000001', '2024-08-16', 4, '이용후기', '후기답변');
insert into reviews values ('20240815000000002', '2024-08-16', 5, '이용후기', '후기답변');
insert into reviews values ('20240815000000003', '2024-08-16', 5, '이용후기', '후기답변');
insert into reviews values ('20240815000000004', '2024-08-16', 4, '이용후기', '후기답변');
insert into reviews values ('20240815000000005', '2024-08-16', 4, '이용후기', '후기답변');
insert into reviews values ('20240815000000006', '2024-08-16', 5, '이용후기', '후기답변');
insert into reviews values ('20240815000000007', '2024-08-16', 5, '이용후기', '후기답변');
insert into reviews values ('20240815000000008', '2024-08-16', 4, '이용후기', '후기답변');

--혜영헤어 6개 별점4.0
INSERT INTO user_reservation VALUES ('20240815000000101', 'member2', '박회원', '01063188216', 'vendor2', '222-22-22222', '벤더명2', '01063188216','혜영헤어', '21404', '인천 부평구 경원대로 1358-1', '', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000102', 'member2', '박회원', '01063188216', 'vendor2', '222-22-22222', '벤더명2', '01063188216','혜영헤어', '21404', '인천 부평구 경원대로 1358-1', '', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000103', 'member2', '박회원', '01063188216', 'vendor2', '222-22-22222', '벤더명2', '01063188216','혜영헤어', '21404', '인천 부평구 경원대로 1358-1', '', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000104', 'member2', '박회원', '01063188216', 'vendor2', '222-22-22222', '벤더명2', '01063188216','혜영헤어', '21404', '인천 부평구 경원대로 1358-1', '', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000105', 'member2', '박회원', '01063188216', 'vendor2', '222-22-22222', '벤더명2', '01063188216','혜영헤어', '21404', '인천 부평구 경원대로 1358-1', '', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000106', 'member2', '박회원', '01063188216', 'vendor2', '222-22-22222', '벤더명2', '01063188216','혜영헤어', '21404', '인천 부평구 경원대로 1358-1', '', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
--INSERT INTO user_reservation VALUES ('20240815000000107', 'member2', '박회원', '01063188216', 'vendor2', '222-22-22222', '벤더명2', '01063188216','혜영헤어', '21404', '인천 부평구 경원대로 1358-1', '', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
--INSERT INTO user_reservation VALUES ('20240815000000108', 'member2', '박회원', '01063188216', 'vendor2', '222-22-22222', '벤더명2', '01063188216','혜영헤어', '21404', '인천 부평구 경원대로 1358-1', '', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
--INSERT INTO user_reservation VALUES ('20240815000000109', 'member2', '박회원', '01063188216', 'vendor2', '222-22-22222', '벤더명2', '01063188216','혜영헤어', '21404', '인천 부평구 경원대로 1358-1', '', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
--INSERT INTO user_reservation VALUES ('20240815000000110', 'member2', '박회원', '01063188216', 'vendor2', '222-22-22222', '벤더명2', '01063188216','혜영헤어', '21404', '인천 부평구 경원대로 1358-1', '', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
--delete from user_reservation where reservation_number='20240815000000110';
insert into reviews values ('20240815000000101', '2024-08-16', 4, '이용후기', '후기답변');
insert into reviews values ('20240815000000102', '2024-08-16', 4, '이용후기', '후기답변');
insert into reviews values ('20240815000000103', '2024-08-16', 5, '이용후기', '후기답변');
insert into reviews values ('20240815000000104', '2024-08-16', 5, '이용후기', '후기답변');
insert into reviews values ('20240815000000105', '2024-08-16', 3, '이용후기', '후기답변');
insert into reviews values ('20240815000000106', '2024-08-16', 3, '이용후기', '후기답변');
--insert into reviews values ('20240815000000107', '2024-08-16', 5, '이용후기', '후기답변');
--insert into reviews values ('20240815000000108', '2024-08-16', 3, '이용후기', '후기답변');
--insert into reviews values ('20240815000000109', '2024-08-16', 4, '이용후기', '후기답변');
--insert into reviews values ('20240815000000110', '2024-08-16', 5, '이용후기', '후기답변');
--delete from reviews where reservation_number='20240815000000110';

--하르르헤어 10개 별점 4.2
INSERT INTO user_reservation VALUES ('20240815000000201', 'member2', '박회원', '01063188216', 'vendor1', '111-11-11111', '벤더명1', '01063188216','하르르헤어', '21404', '인천 부평구 경원대로 1368', '1층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000202', 'member2', '박회원', '01063188216', 'vendor1', '111-11-11111', '벤더명1', '01063188216','하르르헤어', '21404', '인천 부평구 경원대로 1368', '1층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000203', 'member2', '박회원', '01063188216', 'vendor1', '111-11-11111', '벤더명1', '01063188216','하르르헤어', '21404', '인천 부평구 경원대로 1368', '1층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000204', 'member2', '박회원', '01063188216', 'vendor1', '111-11-11111', '벤더명1', '01063188216','하르르헤어', '21404', '인천 부평구 경원대로 1368', '1층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000205', 'member2', '박회원', '01063188216', 'vendor1', '111-11-11111', '벤더명1', '01063188216','하르르헤어', '21404', '인천 부평구 경원대로 1368', '1층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000206', 'member2', '박회원', '01063188216', 'vendor1', '111-11-11111', '벤더명1', '01063188216','하르르헤어', '21404', '인천 부평구 경원대로 1368', '1층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000207', 'member2', '박회원', '01063188216', 'vendor1', '111-11-11111', '벤더명1', '01063188216','하르르헤어', '21404', '인천 부평구 경원대로 1368', '1층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000208', 'member2', '박회원', '01063188216', 'vendor1', '111-11-11111', '벤더명1', '01063188216','하르르헤어', '21404', '인천 부평구 경원대로 1368', '1층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000209', 'member2', '박회원', '01063188216', 'vendor1', '111-11-11111', '벤더명1', '01063188216','하르르헤어', '21404', '인천 부평구 경원대로 1368', '1층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
INSERT INTO user_reservation VALUES ('20240815000000210', 'member2', '박회원', '01063188216', 'vendor1', '111-11-11111', '벤더명1', '01063188216','하르르헤어', '21404', '인천 부평구 경원대로 1368', '1층', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '테스트상품', 10000, 2, '김회원의 메모', '3');
insert into reviews values ('20240815000000201', '2024-08-16', 3, '이용후기', '후기답변');
insert into reviews values ('20240815000000202', '2024-08-16', 3, '이용후기', '후기답변');
insert into reviews values ('20240815000000203', '2024-08-16', 3, '이용후기', '후기답변');
insert into reviews values ('20240815000000204', '2024-08-16', 4, '이용후기', '후기답변');
insert into reviews values ('20240815000000205', '2024-08-16', 5, '이용후기', '후기답변');
insert into reviews values ('20240815000000206', '2024-08-16', 5, '이용후기', '후기답변');
insert into reviews values ('20240815000000207', '2024-08-16', 5, '이용후기', '후기답변');
insert into reviews values ('20240815000000208', '2024-08-16', 5, '이용후기', '후기답변');
insert into reviews values ('20240815000000209', '2024-08-16', 4, '이용후기', '후기답변');
insert into reviews values ('20240815000000210', '2024-08-16', 5, '이용후기', '후기답변');
commit;
select * from user_reservation;
select * from reviews;
--=================================================================================================================
--=================================================================================================================
--=================================================================================================================