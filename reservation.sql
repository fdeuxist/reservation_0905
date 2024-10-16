
--=================================================================================================================
--=================================================================================================================
--��ü ���� sql developer�� ����
--=================================================================================================================
--=================================================================================================================
/*
������Ű+R
cmd ��Ŭ�� �����ڱ��� ����
sqlplus /nolog
conn sys as sysdba;
create user c##reser identified by vation;
grant connect, resource, dba to c##reser;
conn c##reser/vation;
show user;
exit
exit

sql developer ����
���� �ؿ� ��� ���ڰ� ������ Ŭ��
Name : reservation
����� �̸� : c##reser
��й�ȣ : vation
��й�ȣ �����ʿ� ���� üũ�ڽ� üũ
�׽�Ʈ ������ ���¿� ���� �ߴ°� Ȯ���ϰ� ����
reservation�� ���� �ϰ� ���� ����
*/

--=================================================================================================================
--=================================================================================================================
--=======�� ���� ���� �۾� �� ���� ����===============================================================================
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
    business_regi_num varchar2(20), --����ڵ�Ϲ�ȣ
    business_name varchar2(255),    --�����(����)
    zipcode varchar2(10),           --�����ȣ
    basic_address varchar2(255),    --�⺻�ּ�
    detail_address varchar2(255),   --���ּ�
    business_type varchar2(255)     --�����ڵ�
    );

drop table vendor_reservation;
create table vendor_reservation (
    email varchar2(255) not null,   --������̸��� ��
    business_regi_num varchar2(20), --����ڹ�ȣ�� �� ����Ű 
    open_date date,                 --������ ����� (������ �ްڴٴ�)
    times varchar2(50),             --������ �ð� 48�� 0101
    status_flag varchar2(4),         --�ش����� ���� ��Ȱ��ȭ(������,����Ұ�)/Ȱ��ȭ(�����Ϸ�,���డ��)�� ����. �������̶�� �Ϲ������� ������ ����
    constraint vendor_reservation_unique
        unique (email, business_regi_num, open_date)
);

drop table user_reservation;
create table user_reservation (
    reservation_number varchar2(20) not null,   --����(�ֹ�)��ȣ pk (��4 ��2 ��2 ��2 ��2 ��2 ms3) 17�ڸ�����
    user_email varchar2(255) not null,          --�����̸��� fk (������)    (users)
    user_name varchar2(255) not null,           --�����̸� (������)         (users)
    user_phone  varchar2(20) not null,          --���� ��� ������ ��ȭ��ȣ (������)    (users)
    vendor_email varchar2(255) not null,        --������̸��� ��                (vendor)
    business_regi_num varchar2(20),             --����ڹ�ȣ�� �� ����Ű fk       (vendor)
    vendor_name  varchar2(255) not null,        --���� ��� ������� �̸� (�����)    (vendor)
    vendor_phone  varchar2(20) not null,        --���� ��� ������� ��ȭ��ȣ (�����)    (vendor)
    business_name varchar2(255),                --���� ��� �����(����) --0829�߰�
    zipcode varchar2(10),                       --���� ��� �̿� ���� ��� �����ȣ(vendor)
    basic_address varchar2(255),                --���� ��� �̿� ���� ��� �⺻�ּ�(vendor)
    detail_address varchar2(255),               --���� ��� �̿� ���� ��� ���ּ�(vendor)
    reservation_date date,                      --���� �߻� �����
    reservation_use_date date,                  --�̿� ���� �����
    times varchar2(50),                         --�̿� ���� �ð� 48������
    times_hhmm varchar2(20),                    --�̿� ���� �ð� HH:mm   --0829�߰�
    total_service_name varchar2(4000),          --���� ��� �̿� ���� ���� �̸���(service_items)
    total_service_price number,                 --���� ��� �̿� ���� ���� ���� �� �� (service_items)
    total_required_time number,                 --���� ��� �̿� ���� ����(�ʿ�)�ð� �� �� (service_items)
    user_request_memo varchar2(4000),           --���� ��û���� �޸�. �ֹ��ڿ� �湮�ڰ� �ٸ��� ����ó�� ���´ٰų� ��Ÿ ��û���� ��
    status varchar2(50)                         --�ֹ� ����. 1�Աݴ��/2�ԱݿϷ�/3�̿�Ϸ�/
                                                --       4(��ҿ�û)�̿������(ȸ����û,����ڽ����ʿ�)/
                                                --       5(��ҿϷ�)��������(����ڿ�û,ȸ�����κ��ʿ�)/6ȯ�Ҵ��/7ȯ�ҿϷ� �� ����
    );

drop sequence item_id;
CREATE SEQUENCE item_id;
drop table service_items;
create table service_items (
    item_id number not null,         --pk 
    email varchar2(255) not null,   --������̸��� ��
    business_regi_num varchar2(20) not null, --����ڹ�ȣ�� �� ����Ű
    service_name varchar2(255),             --��ǰ��
    service_description varchar2(255),      --����
    required_time number,                   --����(�ʿ�)�ð� (1�� 30��)
    service_price number,                   --����
    item_status varchar2(10) default '1' not null                --item ����, (��밡�� ���� ��)  (1:���, 0:�̻�� ��)
    );

drop table business_place_info;
create table business_place_info (
    email varchar2(255) not null,   --������̸��� ��
    business_regi_num varchar2(20), --����ڹ�ȣ�� �� ����Ű
    place_info varchar2(4000)      --���� �Ұ�
    );

drop table business_place_image_path;
create table business_place_image_path (
    email varchar2(255) not null,   --������̸��� ��
    business_regi_num varchar2(20), --����ڹ�ȣ�� �� ����Ű
    place_img_path  varchar2(255),
    is_main char(1) default 'N',         -- ��ǥ �̹��� ���� (Y/N)
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
    reservation_number varchar2(20) not null,   --����(�ֹ�)��ȣ pk (����Ͻú���ms)
    review_date date,                           --�����ۼ� �����
    star_point number,                          --����
    member_content varchar2(4000),              --ȸ�� ���� ����
    vendor_content varchar2(4000)              --����� ��� ����
    );
    
--=================================================================================================================
--=================================================================================================================
--=======�� ���� ���� �۾� �� ���� ����===============================================================================
--=================================================================================================================
--=================================================================================================================
--������� �ϰ� sts�� ���� �� http://localhost:�ڱ���Ʈ/ex/user/insert_init �� ���� 
--�������� TEST account insert OK ��� ���ڿ��� ���̸�
--�Ʒ� �׽�Ʈ�� �⺻ 7���� ���� ���Ե� �� (��й�ȣ 1111 ����)
-- (�̸���/��й�ȣ/�̸�/��ȭ��ȣ)
-- admin/1111/1/1
-- manager/1111/1/1
-- member1/1111/1/1
-- member2/1111/1/1
-- vendor1/1111/1/1
-- vendor2/1111/1/1
-- vendor3/1111/1/1
-- ���� sql developer ���� ����

update authorities set authority='ROLE_ADMIN' where email='admin';
update authorities set authority='ROLE_VENDOR' where email='vendor1';
update authorities set authority='ROLE_VENDOR' where email='vendor2';
update authorities set authority='ROLE_VENDOR' where email='vendor3';
update authorities set authority='ROLE_MANAGER' where email='manager';
insert into vendor values('vendor1', '111-11-11111',      '�ϸ������',   '21404', '��õ ���� ������ 1368', '1��', '�̿��');
insert into vendor values('vendor2', '222-22-22222',      '�������',   '21404', '��õ ���� ������ 1358-1', '', '�̿��');
insert into vendor values('vendor3', '333-33-33333',      '�����ƶ㸮�� ������',        '21389', '��õ ���� ������1367���� 4', '2��', '�̿��');
insert into business_place_info(email, business_regi_num, place_info) values ('vendor1','111-11-11111', 
    '����õ��ü�� ������(�ް�Ŀ�ǰ�����)�̸� ���� ���� 5�� , ���������� ����or���ѱ��� ���� 1���Դϴ� ! ( * ���������� ���� �����ص帮�� �ʽ��ϴ� ! )');
insert into business_place_info(email, business_regi_num, place_info) values ('vendor2','222-22-22222', 
    '����õ��ü�� ������ ������� ���±���⿡�� �λ����Ʈ�������� ��ġ ���ּ������� �޹��Դϴ�');
insert into business_place_info(email, business_regi_num, place_info) values ('vendor3','333-33-33333', 
    '�Ｚ������ 2���� ��ġ�ϰ� �ֽ��ϴ�^^ ��Ȯ�� �Ա��� ���ݴ� �������� �����žߵǿ�! ���������� �̿�ÿ��� ���������� �Ա��� �ö���ø� 2������� �ٷ� ���Դϴ�^^');
update users set name='������' , phone='01026592541' where email='admin';
update users set name='��ȸ��' , phone='01026592541' where email='member1';
update users set name='��ȸ��' , phone='01026592541' where email='member2';
update users set name='������1' , phone='01026592541' where email='vendor1';
update users set name='������2' , phone='01026592541' where email='vendor2';
update users set name='������3' , phone='01026592541' where email='vendor3';
update users set name='�Ŵ���1' , phone='01026592541' where email='manager';
insert into service_items values(item_id.nextval, 'vendor1', '111-11-11111', 'Man_��������', '�Ϲ���', 3, 77000, '1' );
insert into service_items values(item_id.nextval, 'vendor1', '111-11-11111', 'Ż���ƿ����+�ϸ���ũ����', '����', 4, 207000, '1' );
insert into service_items values(item_id.nextval, 'vendor1', '111-11-11111', '��+�ϸ���ũ����', '����', 4, 172000, '1' );
insert into service_items values(item_id.nextval, 'vendor2', '222-22-22222', '������', '������', 2, 15000, '1' );
insert into service_items values(item_id.nextval, 'vendor2', '222-22-22222', '������', '������', 3, 18000, '1' );
insert into service_items values(item_id.nextval, 'vendor2', '222-22-22222', '�Ϲ���', '����', 4, 50000, '1' );
insert into service_items values(item_id.nextval, 'vendor3', '333-33-33333', '���� ��', '', 3, 25000, '1' );
insert into service_items values(item_id.nextval, 'vendor3', '333-33-33333', '���� ��', '', 2, 22000, '1' );
insert into service_items values(item_id.nextval, 'vendor3', '333-33-33333', '�ϹݷԵ���', '', 4, 100000, '1' );
insert into service_items values(item_id.nextval, 'vendor3', '333-33-33333', '����', '', 4, 180000, '1' );
insert into service_items values(item_id.nextval, 'vendor3', '333-33-33333', '�⺻����', '', 4, 80000, '1' );
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
INSERT INTO user_reservation VALUES ('20240815000000001', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000002', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000003', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000004', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000005', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000006', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000007', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000008', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000009', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000010', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000011', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000012', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000013', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000014', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000015', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000016', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000017', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000018', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000019', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000020', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000021', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000022', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000023', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000024', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000025', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000026', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000027', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000028', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000029', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000030', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000031', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000032', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000033', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000034', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000035', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000036', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000037', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000038', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000039', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000040', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000041', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000042', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000043', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000044', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000045', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000046', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000047', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000048', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000049', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000050', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000051', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000052', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000053', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000054', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000055', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000056', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000057', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000058', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000059', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000060', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000061', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000062', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000063', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000064', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000065', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000066', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000067', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000068', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000069', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000070', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000071', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000072', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000073', 'member2', '��ȸ��', '01063188216', 'vendor3', '333-33-33333', '������3', '01063188216','�����ƶ㸮�� ������', '21389', '��õ ���� ������1367���� 4', '2��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
select * from user_reservation;
commit;
--���� ���� ���̵�����=================================================================================================================
delete from reviews;
--����� 8�� ����4.5
insert into reviews values ('20240815000000001', '2024-08-16', 4, '�̿��ı�', '�ı�亯');
insert into reviews values ('20240815000000002', '2024-08-16', 5, '�̿��ı�', '�ı�亯');
insert into reviews values ('20240815000000003', '2024-08-16', 5, '�̿��ı�', '�ı�亯');
insert into reviews values ('20240815000000004', '2024-08-16', 4, '�̿��ı�', '�ı�亯');
insert into reviews values ('20240815000000005', '2024-08-16', 4, '�̿��ı�', '�ı�亯');
insert into reviews values ('20240815000000006', '2024-08-16', 5, '�̿��ı�', '�ı�亯');
insert into reviews values ('20240815000000007', '2024-08-16', 5, '�̿��ı�', '�ı�亯');
insert into reviews values ('20240815000000008', '2024-08-16', 4, '�̿��ı�', '�ı�亯');

--������� 6�� ����4.0
INSERT INTO user_reservation VALUES ('20240815000000101', 'member2', '��ȸ��', '01063188216', 'vendor2', '222-22-22222', '������2', '01063188216','�������', '21404', '��õ ���� ������ 1358-1', '', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000102', 'member2', '��ȸ��', '01063188216', 'vendor2', '222-22-22222', '������2', '01063188216','�������', '21404', '��õ ���� ������ 1358-1', '', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000103', 'member2', '��ȸ��', '01063188216', 'vendor2', '222-22-22222', '������2', '01063188216','�������', '21404', '��õ ���� ������ 1358-1', '', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000104', 'member2', '��ȸ��', '01063188216', 'vendor2', '222-22-22222', '������2', '01063188216','�������', '21404', '��õ ���� ������ 1358-1', '', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000105', 'member2', '��ȸ��', '01063188216', 'vendor2', '222-22-22222', '������2', '01063188216','�������', '21404', '��õ ���� ������ 1358-1', '', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000106', 'member2', '��ȸ��', '01063188216', 'vendor2', '222-22-22222', '������2', '01063188216','�������', '21404', '��õ ���� ������ 1358-1', '', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
--INSERT INTO user_reservation VALUES ('20240815000000107', 'member2', '��ȸ��', '01063188216', 'vendor2', '222-22-22222', '������2', '01063188216','�������', '21404', '��õ ���� ������ 1358-1', '', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
--INSERT INTO user_reservation VALUES ('20240815000000108', 'member2', '��ȸ��', '01063188216', 'vendor2', '222-22-22222', '������2', '01063188216','�������', '21404', '��õ ���� ������ 1358-1', '', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
--INSERT INTO user_reservation VALUES ('20240815000000109', 'member2', '��ȸ��', '01063188216', 'vendor2', '222-22-22222', '������2', '01063188216','�������', '21404', '��õ ���� ������ 1358-1', '', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
--INSERT INTO user_reservation VALUES ('20240815000000110', 'member2', '��ȸ��', '01063188216', 'vendor2', '222-22-22222', '������2', '01063188216','�������', '21404', '��õ ���� ������ 1358-1', '', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
--delete from user_reservation where reservation_number='20240815000000110';
insert into reviews values ('20240815000000101', '2024-08-16', 4, '�̿��ı�', '�ı�亯');
insert into reviews values ('20240815000000102', '2024-08-16', 4, '�̿��ı�', '�ı�亯');
insert into reviews values ('20240815000000103', '2024-08-16', 5, '�̿��ı�', '�ı�亯');
insert into reviews values ('20240815000000104', '2024-08-16', 5, '�̿��ı�', '�ı�亯');
insert into reviews values ('20240815000000105', '2024-08-16', 3, '�̿��ı�', '�ı�亯');
insert into reviews values ('20240815000000106', '2024-08-16', 3, '�̿��ı�', '�ı�亯');
--insert into reviews values ('20240815000000107', '2024-08-16', 5, '�̿��ı�', '�ı�亯');
--insert into reviews values ('20240815000000108', '2024-08-16', 3, '�̿��ı�', '�ı�亯');
--insert into reviews values ('20240815000000109', '2024-08-16', 4, '�̿��ı�', '�ı�亯');
--insert into reviews values ('20240815000000110', '2024-08-16', 5, '�̿��ı�', '�ı�亯');
--delete from reviews where reservation_number='20240815000000110';

--�ϸ������ 10�� ���� 4.2
INSERT INTO user_reservation VALUES ('20240815000000201', 'member2', '��ȸ��', '01063188216', 'vendor1', '111-11-11111', '������1', '01063188216','�ϸ������', '21404', '��õ ���� ������ 1368', '1��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000202', 'member2', '��ȸ��', '01063188216', 'vendor1', '111-11-11111', '������1', '01063188216','�ϸ������', '21404', '��õ ���� ������ 1368', '1��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000203', 'member2', '��ȸ��', '01063188216', 'vendor1', '111-11-11111', '������1', '01063188216','�ϸ������', '21404', '��õ ���� ������ 1368', '1��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000204', 'member2', '��ȸ��', '01063188216', 'vendor1', '111-11-11111', '������1', '01063188216','�ϸ������', '21404', '��õ ���� ������ 1368', '1��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000205', 'member2', '��ȸ��', '01063188216', 'vendor1', '111-11-11111', '������1', '01063188216','�ϸ������', '21404', '��õ ���� ������ 1368', '1��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000206', 'member2', '��ȸ��', '01063188216', 'vendor1', '111-11-11111', '������1', '01063188216','�ϸ������', '21404', '��õ ���� ������ 1368', '1��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000207', 'member2', '��ȸ��', '01063188216', 'vendor1', '111-11-11111', '������1', '01063188216','�ϸ������', '21404', '��õ ���� ������ 1368', '1��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000208', 'member2', '��ȸ��', '01063188216', 'vendor1', '111-11-11111', '������1', '01063188216','�ϸ������', '21404', '��õ ���� ������ 1368', '1��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000209', 'member2', '��ȸ��', '01063188216', 'vendor1', '111-11-11111', '������1', '01063188216','�ϸ������', '21404', '��õ ���� ������ 1368', '1��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
INSERT INTO user_reservation VALUES ('20240815000000210', 'member2', '��ȸ��', '01063188216', 'vendor1', '111-11-11111', '������1', '01063188216','�ϸ������', '21404', '��õ ���� ������ 1368', '1��', TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-16', 'YYYY-MM-DD'), '001000000000000000000000000000000000000000000000', '01:00', '�׽�Ʈ��ǰ', 10000, 2, '��ȸ���� �޸�', '3');
insert into reviews values ('20240815000000201', '2024-08-16', 3, '�̿��ı�', '�ı�亯');
insert into reviews values ('20240815000000202', '2024-08-16', 3, '�̿��ı�', '�ı�亯');
insert into reviews values ('20240815000000203', '2024-08-16', 3, '�̿��ı�', '�ı�亯');
insert into reviews values ('20240815000000204', '2024-08-16', 4, '�̿��ı�', '�ı�亯');
insert into reviews values ('20240815000000205', '2024-08-16', 5, '�̿��ı�', '�ı�亯');
insert into reviews values ('20240815000000206', '2024-08-16', 5, '�̿��ı�', '�ı�亯');
insert into reviews values ('20240815000000207', '2024-08-16', 5, '�̿��ı�', '�ı�亯');
insert into reviews values ('20240815000000208', '2024-08-16', 5, '�̿��ı�', '�ı�亯');
insert into reviews values ('20240815000000209', '2024-08-16', 4, '�̿��ı�', '�ı�亯');
insert into reviews values ('20240815000000210', '2024-08-16', 5, '�̿��ı�', '�ı�亯');
commit;
select * from user_reservation;
select * from reviews;
--=================================================================================================================
--=================================================================================================================
--=================================================================================================================