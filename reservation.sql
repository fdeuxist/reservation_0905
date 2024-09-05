
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
    email varchar2(255),		-- pk, email(id)
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
    times varchar2(50),             --예약등록 시간48개단위
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
                                                --       4이용자취소(회원요청,사업자승인필요)/
                                                --       5사업자취소(사업자요청,회원승인불필요)/6환불대기/7환불완료 등 상태
    );


-- 주문시 주문번호와 주문한 아이템의 id와 주문당시 아이템들의 데이터들이 복사저장되어 
-- 이후 아이템들이 수정되어도 주문내역에는 영향이 없음
-- 3개 예약했으면 3행 insert에 reservation_number 3개 다 같고 이하 내용은 각각 다름
drop table reservation_items;
create table reservation_items (
    reservation_number varchar2(20) not null,   --주문번호 user_reservation fk
    item_id number not null,                    --service_items              복사저장
    email varchar2(255) not null,               --주문당시 사업자의 이메일         복사저장
    business_regi_num varchar2(20) not null,    --주문당시 사업자의 사업자번호       복사저장
    service_name varchar2(255),                 --주문당시 서비스 이름(service_items)      복사저장
    service_description varchar2(255),          --주문당시 설명 (service_items)           복사저장
    required_time number,                       --주문당시 제공(필요)시간 (몇칸짜리인지)  복사저장
    service_price number                       --주문당시 서비스 가격(service_items)               복사저장
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
    required_time number,                   --제공(필요)시간 (몇칸짜리인지)
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
    place_img_path  varchar2(255)
    );
    
--=================================================================================================================
--=================================================================================================================
--=======위 내용 먼저 작업 후 이하 진행===============================================================================
--=================================================================================================================
--=================================================================================================================
--여기까지 하고 sts로 구동 후 http://localhost:자기포트/ex/user/insert 에서 
--아래 기본 4가지 계정 가입 (비밀번호 1111 통일)
-- (이메일/비밀번호/이름/전화번호)
-- admin/1111/1/1
-- manager/1111/1/1
-- vendor/1111/1/1
-- member/1111/1/1
-- vendor1/1111/1/1
-- vendor2/1111/1/1
-- vendor3/1111/1/1
-- vendor4/1111/1/1
-- vendor5/1111/1/1
-- 위 계정 가입 후 이하 sql developer 에서 실행

update authorities set authority='ROLE_ADMIN' where email='admin';
update authorities set authority='ROLE_VENDOR' where email='vendor';
update authorities set authority='ROLE_VENDOR' where email='vendor1';
update authorities set authority='ROLE_VENDOR' where email='vendor2';
update authorities set authority='ROLE_VENDOR' where email='vendor3';
update authorities set authority='ROLE_VENDOR' where email='vendor4';
update authorities set authority='ROLE_VENDOR' where email='vendor5';
update authorities set authority='ROLE_MANAGER' where email='manager';
insert into vendor values('vendor', 'gsgs252511', 'GS25 부평대림점', '21404', '인천 부평구 경원대로 1360', '대림빌딩 1층', '편의점');
insert into vendor values('vendor1', '11111',      'CU 부평북부역점',   '21389', '인천 부평구 경원대로 1367', '1층', '편의점');
insert into vendor values('vendor2', '22222',      '이마트24 부평제일점',   '21404', '인천 부평구 광장로4번길 32', '', '편의점');
insert into vendor values('vendor3', '33333',      '샴푸호텔 ',        '21404', '인천 부평구 광장로4번길 23', '', '호텔');
insert into vendor values('vendor4', '44444', '토요코인호텔 인천부평점', '21404', '인천 부평구 광장로 10', '', '호텔');
insert into vendor values('vendor5', '55555', '신의의원 부평점',        '21389', '인천 부평구 경원대로 1355', '성우빌딩 4층', '병원');
insert into business_place_info(email, business_regi_num, place_info) values ('vendor','gsgs252511', '~~~편의점 gs25 부평대림점~~~');
insert into business_place_info(email, business_regi_num, place_info) values ('vendor1','11111', '편의점 cu cu cu ~');
insert into business_place_info(email, business_regi_num, place_info) values ('vendor2','22222', '이마트 편의점 짠커피 맛있음~~~');
insert into business_place_info(email, business_regi_num, place_info) values ('vendor3','33333', '린스는 안주는 이상한 호텔~~~');
insert into business_place_info(email, business_regi_num, place_info) values ('vendor4','44444', '일요코인은 안타는 호텔~~~');
insert into business_place_info(email, business_regi_num, place_info) values ('vendor5','55555', '병을 다스리는 신의 의원~~~');
update users set name='윤영자' , phone='01063188216' where email='admin';
update users set name='이회원' , phone='01063188216' where email='member';
update users set name='김벤또' , phone='01063188216' where email='vendor';
update users set name='벤더명1' , phone='01063188216' where email='vendor1';
update users set name='벤더명2' , phone='01063188216' where email='vendor2';
update users set name='벤더명3' , phone='01063188216' where email='vendor3';
update users set name='벤더명4' , phone='01063188216' where email='vendor4';
update users set name='벤더명5' , phone='01063188216' where email='vendor5';
update users set name='송실장' , phone='01063188216' where email='manager';
insert into service_items values(item_id.nextval, 'vendor5', '55555', '병원장의 잔소리', '단거 짠거 줄이시고 운동하시고', 1, 20000, '1' );
insert into service_items values(item_id.nextval, 'vendor5', '55555', '5병원메뉴제목1', '5병원메뉴설명', 2, 50000, '1' );
insert into service_items values(item_id.nextval, 'vendor5', '55555', '5노출금지', 'status0 보이면 안되는 메뉴', 2, 50000, '0' );
insert into service_items values(item_id.nextval, 'vendor5', '55555', '5병원메뉴제목2', '5병원메뉴설명2', 1, 20000, '1' );
insert into service_items values(item_id.nextval, 'vendor5', '55555', '5병원메뉴제목3', '5병원메뉴설명3', 2, 30000, '1' );
insert into service_items values(item_id.nextval, 'vendor5', '55555', '5병원메뉴제목4', '5병원메뉴설명4', 3, 40000, '1' );
insert into business_place_image_path values('vendor5','55555','imgpath111');
insert into business_place_image_path values('vendor5','55555','imgpath222');
insert into business_place_image_path values('vendor5','55555','imgpath333');
select * from business_place_image_path;
select * from business_place_info;
select * from service_items;
commit;
--=================================================================================================================
--=================================================================================================================
--=================================================================================================================
--=================================================================================================================
--=================================================================================================================