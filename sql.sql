//��ú��� dummy������
-- ���� 1
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202309230101001', 'kimminsu@example.com', '��μ�', '010-1234-5678', 'vendor@example.com', 'gsgs252511', 'GS25 ����븲��', '032-123-4567', 'GS25 ����븲��', '21404', '��õ ���� ������ 1360', '�븲���� 1��', TO_DATE('2023-09-23', 'YYYY-MM-DD'), TO_DATE('2023-10-01', 'YYYY-MM-DD'), '09:00~11:00', '09:00', '���� A', 100000, 120, '���� �� ���� ��Ź�帳�ϴ�.', '3');

-- ���� 2
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202309240202002', 'parkjiwoo@example.com', '������', '010-2345-6789', 'vendor1@example.com', '11111', 'CU ����Ϻο���', '032-234-5678', 'CU ����Ϻο���', '21389', '��õ ���� ������ 1367', '1��', TO_DATE('2023-09-24', 'YYYY-MM-DD'), TO_DATE('2023-10-02', 'YYYY-MM-DD'), '12:00~14:00', '12:00', '���� B', 120000, 150, 'Ư���� ������ �ʿ��մϴ�.', '3');

-- ���� 3
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202309250303003', 'leejiho@example.com', '��ġȣ', '010-3456-7890', 'vendor2@example.com', '22222', '�̸�Ʈ24 ����������', '032-345-6789', '�̸�Ʈ24 ����������', '21404', '��õ ���� �����4���� 32', '', TO_DATE('2023-09-25', 'YYYY-MM-DD'), TO_DATE('2023-10-03', 'YYYY-MM-DD'), '15:00~17:00', '15:00', '���� C', 150000, 180, '�߰� ������ �ʿ��մϴ�.', '3');

-- ���� 4
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310081717017', 'kate@example.com', '����Ʈ ��', '010-3333-4444', 'vendor3@example.com', '33333', '��Ǫȣ��', '032-456-7890', '��Ǫȣ��', '21404', '��õ ���� �����4���� 23', '', TO_DATE('2023-10-08', 'YYYY-MM-DD'), TO_DATE('2023-10-16', 'YYYY-MM-DD'), '16:00~18:00', '16:00', '���� D', 180000, 130, '���� ó�� ��Ź�帳�ϴ�.', '3');

-- ���� 5
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310091818018', 'laura@example.com', '�ζ� ��', '010-4444-5555', 'vendor4@example.com', '44444', '�������ȣ�� ��õ������', '032-567-8901', '�������ȣ�� ��õ������', '21404', '��õ ���� ����� 10', '', TO_DATE('2023-10-09', 'YYYY-MM-DD'), TO_DATE('2023-10-17', 'YYYY-MM-DD'), '18:00~20:00', '18:00', '���� E', 200000, 140, '���� �ð� ���� ��û.', '3');

-- ���� 6
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310101919019', 'mike@example.com', '����ũ ����', '010-5555-6666', 'vendor5@example.com', '55555', '�����ǿ� ������', '032-678-9012', '�����ǿ� ������', '21389', '��õ ���� ������ 1355', '������� 4��', TO_DATE('2023-10-10', 'YYYY-MM-DD'), TO_DATE('2023-10-18', 'YYYY-MM-DD'), '10:00~12:00', '10:00', '���� A', 220000, 150, '�߰� ��û ���� Ȯ��.', '3');

-- ���� 7
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310111010010', 'olivia@example.com', '�ø���� ���Ϸ�', '010-6666-7777', 'vendor@example.com', 'gsgs252511', 'GS25 ����븲��', '032-890-1234', 'GS25 ����븲��', '21404', '��õ ���� ������ 1360', '�븲���� 1��', TO_DATE('2023-10-11', 'YYYY-MM-DD'), TO_DATE('2023-10-19', 'YYYY-MM-DD'), '11:00~13:00', '11:00', '���� B', 230000, 160, '���� �ð� Ȯ�� ��Ź�帳�ϴ�.', '3');

-- ���� 8
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310121212012', 'nina@example.com', '�ϳ� ����', '010-7777-8888', 'vendor1@example.com', '11111', 'CU ����Ϻο���', '032-9012-1234', 'CU ����Ϻο���', '21389', '��õ ���� ������ 1367', '1��', TO_DATE('2023-10-12', 'YYYY-MM-DD'), TO_DATE('2023-10-20', 'YYYY-MM-DD'), '14:00~16:00', '14:00', '���� C', 240000, 170, 'Ư�� ��û ���� ����.', '3');

-- ���� 9
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310131313013', 'james@example.com', '���ӽ� ��', '010-8888-9999', 'vendor2@example.com', '22222', '�̸�Ʈ24 ����������', '032-012-3456', '�̸�Ʈ24 ����������', '21404', '��õ ���� �����4���� 32', '', TO_DATE('2023-10-13', 'YYYY-MM-DD'), TO_DATE('2023-10-21', 'YYYY-MM-DD'), '16:00~18:00', '16:00', '���� D', 250000, 180, '�ð� ������ �ʿ��մϴ�.', '3');

-- ���� 10
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310141414014', 'sophie@example.com', '���� ��', '010-9999-0000', 'vendor4@example.com', '44444', '�������ȣ�� ��õ������', '032-123-4567', '�������ȣ�� ��õ������', '21404', '��õ ���� ����� 10', '', TO_DATE('2023-10-14', 'YYYY-MM-DD'), TO_DATE('2023-10-22', 'YYYY-MM-DD'), '10:00~12:00', '10:00', '���� E', 260000, 190, '���� Ȯ�� �ٶ��ϴ�.', '3');

-- ���� 11
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310151515015', 'lucas@example.com', '��ī�� ��', '010-0000-1111', 'vendor5@example.com', '55555', '�����ǿ� ������', '032-234-5678', '�����ǿ� ������', '21389', '��õ ���� ������ 1355', '������� 4��', TO_DATE('2023-10-15', 'YYYY-MM-DD'), TO_DATE('2023-10-23', 'YYYY-MM-DD'), '09:00~11:00', '09:00', '���� A', 270000, 200, '�߰� ���� �ʿ�.', '3');

-- ���� 12
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310161616016', 'emma@example.com', '���� ��', '010-1111-2222', 'vendor@example.com', 'gsgs252511', 'GS25 ����븲��', '032-345-6789', 'GS25 ����븲��', '21404', '��õ ���� ������ 1360', '�븲���� 1��', TO_DATE('2023-10-16', 'YYYY-MM-DD'), TO_DATE('2023-10-24', 'YYYY-MM-DD'), '11:00~13:00', '11:00', '���� B', 280000, 210, '���� �ð� ���� ��û.', '3');

-- ���� 13
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310171717017', 'david@example.com', '���̺�� ��', '010-2222-3333', 'vendor1@example.com', '11111', 'CU ����Ϻο���', '032-456-7890', 'CU ����Ϻο���', '21389', '��õ ���� ������ 1367', '1��', TO_DATE('2023-10-17', 'YYYY-MM-DD'), TO_DATE('2023-10-25', 'YYYY-MM-DD'), '12:00~14:00', '12:00', '���� C', 290000, 220, '�߰� ���� �ʿ�.', '3');

-- ���� 14
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310181818018', 'sara@example.com', '��� ��', '010-3333-4444', 'vendor2@example.com', '22222', '�̸�Ʈ24 ����������', '032-567-8901', '�̸�Ʈ24 ����������', '21404', '��õ ���� �����4���� 32', '', TO_DATE('2023-10-18', 'YYYY-MM-DD'), TO_DATE('2023-10-26', 'YYYY-MM-DD'), '13:00~15:00', '13:00', '���� D', 300000, 230, '���� ���� ���� ����.', '3');

-- ���� 15
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310191919019', 'noah@example.com', '��� ��', '010-4444-5555', 'vendor3@example.com', '33333', '��Ǫȣ��', '032-678-9012', '��Ǫȣ��', '21404', '��õ ���� �����4���� 23', '', TO_DATE('2023-10-19', 'YYYY-MM-DD'), TO_DATE('2023-10-27', 'YYYY-MM-DD'), '14:00~16:00', '14:00', '���� E', 310000, 240, '���� Ȯ�� ��Ź�帳�ϴ�.', '3');

-- ���� 16
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310202020020', 'isabella@example.com', '�̻级�� ��', '010-5555-6666', 'vendor4@example.com', '44444', '�������ȣ�� ��õ������', '032-789-0123', '�������ȣ�� ��õ������', '21404', '��õ ���� ����� 10', '', TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_DATE('2023-10-28', 'YYYY-MM-DD'), '15:00~17:00', '15:00', '���� A', 320000, 250, '���� ���� ��û.', '3');

-- ���� 17
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310212121021', 'mia@example.com', '�̾� ��', '010-6666-7777', 'vendor5@example.com', '55555', '�����ǿ� ������', '032-890-1234', '�����ǿ� ������', '21389', '��õ ���� ������ 1355', '������� 4��', TO_DATE('2023-10-21', 'YYYY-MM-DD'), TO_DATE('2023-10-29', 'YYYY-MM-DD'), '16:00~18:00', '16:00', '���� B', 330000, 260, '���� Ȯ�� �ٶ��ϴ�.', '3');

-- ���� 17
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310171717017', 'david@example.com', '���̺�� ��', '010-2222-3333', 'vendor1@example.com', '11111', 'CU ����Ϻο���', '032-456-7890', 'CU ����Ϻο���', '21389', '��õ ���� ������ 1367', '1��', TO_DATE('2023-10-17', 'YYYY-MM-DD'), TO_DATE('2023-10-25', 'YYYY-MM-DD'), '12:00~14:00', '12:00', '���� C', 290000, 220, '�߰� ���� �ʿ�.', '3');

-- ���� 18
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310181818018', 'sara@example.com', '��� ��', '010-3333-4444', 'vendor2@example.com', '22222', '�̸�Ʈ24 ����������', '032-567-8901', '�̸�Ʈ24 ����������', '21404', '��õ ���� �����4���� 32', '', TO_DATE('2023-10-18', 'YYYY-MM-DD'), TO_DATE('2023-10-26', 'YYYY-MM-DD'), '13:00~15:00', '13:00', '���� D', 300000, 230, '���� ���� ���� ����.', '3');

-- ���� 19
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310191919019', 'noah@example.com', '��� ��', '010-4444-5555', 'vendor3@example.com', '33333', '��Ǫȣ��', '032-678-9012', '��Ǫȣ��', '21404', '��õ ���� �����4���� 23', '', TO_DATE('2023-10-19', 'YYYY-MM-DD'), TO_DATE('2023-10-27', 'YYYY-MM-DD'), '14:00~16:00', '14:00', '���� E', 310000, 240, '���� Ȯ�� ��Ź�帳�ϴ�.', '3');

-- ���� 20
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310202020020', 'isabella@example.com', '�̻级�� ��', '010-5555-6666', 'vendor4@example.com', '44444', '�������ȣ�� ��õ������', '032-789-0123', '�������ȣ�� ��õ������', '21404', '��õ ���� ����� 10', '', TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_DATE('2023-10-28', 'YYYY-MM-DD'), '15:00~17:00', '15:00', '���� A', 320000, 250, '���� ���� ��û.', '3');

-- ���� 21
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310212121021', 'mia@example.com', '�̾� ��', '010-6666-7777', 'vendor5@example.com', '55555', '�����ǿ� ������', '032-890-1234', '�����ǿ� ������', '21389', '��õ ���� ������ 1355', '������� 4��', TO_DATE('2023-10-21', 'YYYY-MM-DD'), TO_DATE('2023-10-29', 'YYYY-MM-DD'), '16:00~18:00', '16:00', '���� B', 330000, 260, '���� Ȯ�� �ٶ��ϴ�.', '3');

-- ���� 22
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310222323022', 'alice@example.com', '�ٸ��� ��', '010-7777-8888', 'vendor3@example.com', '33333', '��Ǫȣ��', '032-678-9012', '��Ǫȣ��', '21404', '��õ ���� �����4���� 23', '', TO_DATE('2023-10-22', 'YYYY-MM-DD'), TO_DATE('2023-10-30', 'YYYY-MM-DD'), '17:00~19:00', '17:00', '���� C', 340000, 270, '���� ó�� ��Ź�帳�ϴ�.', '3');

-- ���� 23
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310232424023', 'oliver@example.com', '�ø��� ���̽�', '010-8888-9999', 'vendor4@example.com', '44444', '�������ȣ�� ��õ������', '032-789-0123', '�������ȣ�� ��õ������', '21404', '��õ ���� ����� 10', '', TO_DATE('2023-10-23', 'YYYY-MM-DD'), TO_DATE('2023-10-31', 'YYYY-MM-DD'), '09:00~11:00', '09:00', '���� D', 350000, 280, '���� ���� �ʿ�.', '3');

-- ���� 24
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310242525024', 'mia@example.com', '�̾� ��', '010-6666-7777', 'vendor5@example.com', '55555', '�����ǿ� ������', '032-890-1234', '�����ǿ� ������', '21389', '��õ ���� ������ 1355', '������� 4��', TO_DATE('2023-10-24', 'YYYY-MM-DD'), TO_DATE('2023-11-01', 'YYYY-MM-DD'), '10:00~12:00', '10:00', '���� E', 360000, 290, '�߰� ��û ���� Ȯ��.', '3');

-- ���� 26
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310262727026', 'alice@example.com', '�ٸ��� ��', '010-7777-8888', 'vendor3@example.com', '33333', '��Ǫȣ��', '032-678-9012', '��Ǫȣ��', '21404', '��õ ���� �����4���� 23', '', TO_DATE('2023-10-26', 'YYYY-MM-DD'), TO_DATE('2023-11-03', 'YYYY-MM-DD'), '12:00~14:00', '12:00', '���� B', 380000, 310, '���� ���� ���� ����.', '3');

-- ���� 27
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310272828027', 'emma@example.com', '���� ��', '010-1111-2222', 'vendor4@example.com', '44444', '�������ȣ�� ��õ������', '032-789-0123', '�������ȣ�� ��õ������', '21404', '��õ ���� ����� 10', '', TO_DATE('2023-10-27', 'YYYY-MM-DD'), TO_DATE('2023-11-04', 'YYYY-MM-DD'), '13:00~15:00', '13:00', '���� C', 390000, 320, '�߰� ���� �ʿ�.', '3');

-- ���� 28
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310282929028', 'sophia@example.com', '���Ǿ� ����', '010-2222-3333', 'vendor5@example.com', '55555', '�����ǿ� ������', '032-890-1234', '�����ǿ� ������', '21389', '��õ ���� ������ 1355', '������� 4��', TO_DATE('2023-10-28', 'YYYY-MM-DD'), TO_DATE('2023-11-05', 'YYYY-MM-DD'), '14:00~16:00', '14:00', '���� D', 400000, 330, '���� �ð� ���� ��û.', '3');

-- ���� 29
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310292020029', 'ava@example.com', '�ƹ� ��', '010-3333-4444', 'vendor1@example.com', '11111', 'CU ����Ϻο���', '032-456-7890', 'CU ����Ϻο���', '21389', '��õ ���� ������ 1367', '1��', TO_DATE('2023-10-29', 'YYYY-MM-DD'), TO_DATE('2023-11-06', 'YYYY-MM-DD'), '15:00~17:00', '15:00', '���� E', 410000, 340, '�߰� ��û ���� ����.', '3');

-- ���� 30
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310303131030', 'liam@example.com', '���� ��', '010-4444-5555', 'vendor2@example.com', '22222', '�̸�Ʈ24 ����������', '032-567-8901', '�̸�Ʈ24 ����������', '21404', '��õ ���� �����4���� 32', '', TO_DATE('2023-10-30', 'YYYY-MM-DD'), TO_DATE('2023-11-07', 'YYYY-MM-DD'), '16:00~18:00', '16:00', '���� A', 420000, 350, '�ð� ���� �ʿ�.', '3');


commit;


--���̵����� ���� ����
--delete from user_reservation where vendor_email like '%example%';







