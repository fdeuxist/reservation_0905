//대시보드 dummy데이터
-- 예약 1
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202309230101001', 'kimminsu@example.com', '김민수', '010-1234-5678', 'vendor@example.com', 'gsgs252511', 'GS25 부평대림점', '032-123-4567', 'GS25 부평대림점', '21404', '인천 부평구 경원대로 1360', '대림빌딩 1층', TO_DATE('2023-09-23', 'YYYY-MM-DD'), TO_DATE('2023-10-01', 'YYYY-MM-DD'), '09:00~11:00', '09:00', '서비스 A', 100000, 120, '도착 시 연락 부탁드립니다.', '3');

-- 예약 2
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202309240202002', 'parkjiwoo@example.com', '박지우', '010-2345-6789', 'vendor1@example.com', '11111', 'CU 부평북부역점', '032-234-5678', 'CU 부평북부역점', '21389', '인천 부평구 경원대로 1367', '1층', TO_DATE('2023-09-24', 'YYYY-MM-DD'), TO_DATE('2023-10-02', 'YYYY-MM-DD'), '12:00~14:00', '12:00', '서비스 B', 120000, 150, '특별한 지원이 필요합니다.', '3');

-- 예약 3
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202309250303003', 'leejiho@example.com', '이치호', '010-3456-7890', 'vendor2@example.com', '22222', '이마트24 부평제일점', '032-345-6789', '이마트24 부평제일점', '21404', '인천 부평구 광장로4번길 32', '', TO_DATE('2023-09-25', 'YYYY-MM-DD'), TO_DATE('2023-10-03', 'YYYY-MM-DD'), '15:00~17:00', '15:00', '서비스 C', 150000, 180, '추가 설정이 필요합니다.', '3');

-- 예약 4
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310081717017', 'kate@example.com', '케이트 리', '010-3333-4444', 'vendor3@example.com', '33333', '샴푸호텔', '032-456-7890', '샴푸호텔', '21404', '인천 부평구 광장로4번길 23', '', TO_DATE('2023-10-08', 'YYYY-MM-DD'), TO_DATE('2023-10-16', 'YYYY-MM-DD'), '16:00~18:00', '16:00', '서비스 D', 180000, 130, '빠른 처리 부탁드립니다.', '3');

-- 예약 5
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310091818018', 'laura@example.com', '로라 김', '010-4444-5555', 'vendor4@example.com', '44444', '토요코인호텔 인천부평점', '032-567-8901', '토요코인호텔 인천부평점', '21404', '인천 부평구 광장로 10', '', TO_DATE('2023-10-09', 'YYYY-MM-DD'), TO_DATE('2023-10-17', 'YYYY-MM-DD'), '18:00~20:00', '18:00', '서비스 E', 200000, 140, '예약 시간 조정 요청.', '3');

-- 예약 6
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310101919019', 'mike@example.com', '마이크 윌슨', '010-5555-6666', 'vendor5@example.com', '55555', '신의의원 부평점', '032-678-9012', '신의의원 부평점', '21389', '인천 부평구 경원대로 1355', '성우빌딩 4층', TO_DATE('2023-10-10', 'YYYY-MM-DD'), TO_DATE('2023-10-18', 'YYYY-MM-DD'), '10:00~12:00', '10:00', '서비스 A', 220000, 150, '추가 요청 사항 확인.', '3');

-- 예약 7
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310111010010', 'olivia@example.com', '올리비아 테일러', '010-6666-7777', 'vendor@example.com', 'gsgs252511', 'GS25 부평대림점', '032-890-1234', 'GS25 부평대림점', '21404', '인천 부평구 경원대로 1360', '대림빌딩 1층', TO_DATE('2023-10-11', 'YYYY-MM-DD'), TO_DATE('2023-10-19', 'YYYY-MM-DD'), '11:00~13:00', '11:00', '서비스 B', 230000, 160, '예약 시간 확인 부탁드립니다.', '3');

-- 예약 8
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310121212012', 'nina@example.com', '니나 브라운', '010-7777-8888', 'vendor1@example.com', '11111', 'CU 부평북부역점', '032-9012-1234', 'CU 부평북부역점', '21389', '인천 부평구 경원대로 1367', '1층', TO_DATE('2023-10-12', 'YYYY-MM-DD'), TO_DATE('2023-10-20', 'YYYY-MM-DD'), '14:00~16:00', '14:00', '서비스 C', 240000, 170, '특별 요청 사항 있음.', '3');

-- 예약 9
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310131313013', 'james@example.com', '제임스 김', '010-8888-9999', 'vendor2@example.com', '22222', '이마트24 부평제일점', '032-012-3456', '이마트24 부평제일점', '21404', '인천 부평구 광장로4번길 32', '', TO_DATE('2023-10-13', 'YYYY-MM-DD'), TO_DATE('2023-10-21', 'YYYY-MM-DD'), '16:00~18:00', '16:00', '서비스 D', 250000, 180, '시간 조정이 필요합니다.', '3');

-- 예약 10
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310141414014', 'sophie@example.com', '소피 리', '010-9999-0000', 'vendor4@example.com', '44444', '토요코인호텔 인천부평점', '032-123-4567', '토요코인호텔 인천부평점', '21404', '인천 부평구 광장로 10', '', TO_DATE('2023-10-14', 'YYYY-MM-DD'), TO_DATE('2023-10-22', 'YYYY-MM-DD'), '10:00~12:00', '10:00', '서비스 E', 260000, 190, '예약 확인 바랍니다.', '3');

-- 예약 11
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310151515015', 'lucas@example.com', '루카스 박', '010-0000-1111', 'vendor5@example.com', '55555', '신의의원 부평점', '032-234-5678', '신의의원 부평점', '21389', '인천 부평구 경원대로 1355', '성우빌딩 4층', TO_DATE('2023-10-15', 'YYYY-MM-DD'), TO_DATE('2023-10-23', 'YYYY-MM-DD'), '09:00~11:00', '09:00', '서비스 A', 270000, 200, '추가 정보 필요.', '3');

-- 예약 12
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310161616016', 'emma@example.com', '엠마 리', '010-1111-2222', 'vendor@example.com', 'gsgs252511', 'GS25 부평대림점', '032-345-6789', 'GS25 부평대림점', '21404', '인천 부평구 경원대로 1360', '대림빌딩 1층', TO_DATE('2023-10-16', 'YYYY-MM-DD'), TO_DATE('2023-10-24', 'YYYY-MM-DD'), '11:00~13:00', '11:00', '서비스 B', 280000, 210, '예약 시간 조정 요청.', '3');

-- 예약 13
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310171717017', 'david@example.com', '데이비드 김', '010-2222-3333', 'vendor1@example.com', '11111', 'CU 부평북부역점', '032-456-7890', 'CU 부평북부역점', '21389', '인천 부평구 경원대로 1367', '1층', TO_DATE('2023-10-17', 'YYYY-MM-DD'), TO_DATE('2023-10-25', 'YYYY-MM-DD'), '12:00~14:00', '12:00', '서비스 C', 290000, 220, '추가 정보 필요.', '3');

-- 예약 14
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310181818018', 'sara@example.com', '사라 조', '010-3333-4444', 'vendor2@example.com', '22222', '이마트24 부평제일점', '032-567-8901', '이마트24 부평제일점', '21404', '인천 부평구 광장로4번길 32', '', TO_DATE('2023-10-18', 'YYYY-MM-DD'), TO_DATE('2023-10-26', 'YYYY-MM-DD'), '13:00~15:00', '13:00', '서비스 D', 300000, 230, '예약 변경 사항 있음.', '3');

-- 예약 15
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310191919019', 'noah@example.com', '노아 리', '010-4444-5555', 'vendor3@example.com', '33333', '샴푸호텔', '032-678-9012', '샴푸호텔', '21404', '인천 부평구 광장로4번길 23', '', TO_DATE('2023-10-19', 'YYYY-MM-DD'), TO_DATE('2023-10-27', 'YYYY-MM-DD'), '14:00~16:00', '14:00', '서비스 E', 310000, 240, '빠른 확인 부탁드립니다.', '3');

-- 예약 16
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310202020020', 'isabella@example.com', '이사벨라 박', '010-5555-6666', 'vendor4@example.com', '44444', '토요코인호텔 인천부평점', '032-789-0123', '토요코인호텔 인천부평점', '21404', '인천 부평구 광장로 10', '', TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_DATE('2023-10-28', 'YYYY-MM-DD'), '15:00~17:00', '15:00', '서비스 A', 320000, 250, '예약 변경 요청.', '3');

-- 예약 17
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310212121021', 'mia@example.com', '미아 최', '010-6666-7777', 'vendor5@example.com', '55555', '신의의원 부평점', '032-890-1234', '신의의원 부평점', '21389', '인천 부평구 경원대로 1355', '성우빌딩 4층', TO_DATE('2023-10-21', 'YYYY-MM-DD'), TO_DATE('2023-10-29', 'YYYY-MM-DD'), '16:00~18:00', '16:00', '서비스 B', 330000, 260, '예약 확인 바랍니다.', '3');

-- 예약 17
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310171717017', 'david@example.com', '데이비드 김', '010-2222-3333', 'vendor1@example.com', '11111', 'CU 부평북부역점', '032-456-7890', 'CU 부평북부역점', '21389', '인천 부평구 경원대로 1367', '1층', TO_DATE('2023-10-17', 'YYYY-MM-DD'), TO_DATE('2023-10-25', 'YYYY-MM-DD'), '12:00~14:00', '12:00', '서비스 C', 290000, 220, '추가 정보 필요.', '3');

-- 예약 18
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310181818018', 'sara@example.com', '사라 조', '010-3333-4444', 'vendor2@example.com', '22222', '이마트24 부평제일점', '032-567-8901', '이마트24 부평제일점', '21404', '인천 부평구 광장로4번길 32', '', TO_DATE('2023-10-18', 'YYYY-MM-DD'), TO_DATE('2023-10-26', 'YYYY-MM-DD'), '13:00~15:00', '13:00', '서비스 D', 300000, 230, '예약 변경 사항 있음.', '3');

-- 예약 19
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310191919019', 'noah@example.com', '노아 리', '010-4444-5555', 'vendor3@example.com', '33333', '샴푸호텔', '032-678-9012', '샴푸호텔', '21404', '인천 부평구 광장로4번길 23', '', TO_DATE('2023-10-19', 'YYYY-MM-DD'), TO_DATE('2023-10-27', 'YYYY-MM-DD'), '14:00~16:00', '14:00', '서비스 E', 310000, 240, '빠른 확인 부탁드립니다.', '3');

-- 예약 20
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310202020020', 'isabella@example.com', '이사벨라 박', '010-5555-6666', 'vendor4@example.com', '44444', '토요코인호텔 인천부평점', '032-789-0123', '토요코인호텔 인천부평점', '21404', '인천 부평구 광장로 10', '', TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_DATE('2023-10-28', 'YYYY-MM-DD'), '15:00~17:00', '15:00', '서비스 A', 320000, 250, '예약 변경 요청.', '3');

-- 예약 21
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310212121021', 'mia@example.com', '미아 최', '010-6666-7777', 'vendor5@example.com', '55555', '신의의원 부평점', '032-890-1234', '신의의원 부평점', '21389', '인천 부평구 경원대로 1355', '성우빌딩 4층', TO_DATE('2023-10-21', 'YYYY-MM-DD'), TO_DATE('2023-10-29', 'YYYY-MM-DD'), '16:00~18:00', '16:00', '서비스 B', 330000, 260, '예약 확인 바랍니다.', '3');

-- 예약 22
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310222323022', 'alice@example.com', '앨리스 김', '010-7777-8888', 'vendor3@example.com', '33333', '샴푸호텔', '032-678-9012', '샴푸호텔', '21404', '인천 부평구 광장로4번길 23', '', TO_DATE('2023-10-22', 'YYYY-MM-DD'), TO_DATE('2023-10-30', 'YYYY-MM-DD'), '17:00~19:00', '17:00', '서비스 C', 340000, 270, '빠른 처리 부탁드립니다.', '3');

-- 예약 23
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310232424023', 'oliver@example.com', '올리버 스미스', '010-8888-9999', 'vendor4@example.com', '44444', '토요코인호텔 인천부평점', '032-789-0123', '토요코인호텔 인천부평점', '21404', '인천 부평구 광장로 10', '', TO_DATE('2023-10-23', 'YYYY-MM-DD'), TO_DATE('2023-10-31', 'YYYY-MM-DD'), '09:00~11:00', '09:00', '서비스 D', 350000, 280, '예약 변경 필요.', '3');

-- 예약 24
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310242525024', 'mia@example.com', '미아 최', '010-6666-7777', 'vendor5@example.com', '55555', '신의의원 부평점', '032-890-1234', '신의의원 부평점', '21389', '인천 부평구 경원대로 1355', '성우빌딩 4층', TO_DATE('2023-10-24', 'YYYY-MM-DD'), TO_DATE('2023-11-01', 'YYYY-MM-DD'), '10:00~12:00', '10:00', '서비스 E', 360000, 290, '추가 요청 사항 확인.', '3');

-- 예약 26
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310262727026', 'alice@example.com', '앨리스 김', '010-7777-8888', 'vendor3@example.com', '33333', '샴푸호텔', '032-678-9012', '샴푸호텔', '21404', '인천 부평구 광장로4번길 23', '', TO_DATE('2023-10-26', 'YYYY-MM-DD'), TO_DATE('2023-11-03', 'YYYY-MM-DD'), '12:00~14:00', '12:00', '서비스 B', 380000, 310, '예약 변경 사항 있음.', '3');

-- 예약 27
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310272828027', 'emma@example.com', '엠마 리', '010-1111-2222', 'vendor4@example.com', '44444', '토요코인호텔 인천부평점', '032-789-0123', '토요코인호텔 인천부평점', '21404', '인천 부평구 광장로 10', '', TO_DATE('2023-10-27', 'YYYY-MM-DD'), TO_DATE('2023-11-04', 'YYYY-MM-DD'), '13:00~15:00', '13:00', '서비스 C', 390000, 320, '추가 정보 필요.', '3');

-- 예약 28
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310282929028', 'sophia@example.com', '소피아 윌슨', '010-2222-3333', 'vendor5@example.com', '55555', '신의의원 부평점', '032-890-1234', '신의의원 부평점', '21389', '인천 부평구 경원대로 1355', '성우빌딩 4층', TO_DATE('2023-10-28', 'YYYY-MM-DD'), TO_DATE('2023-11-05', 'YYYY-MM-DD'), '14:00~16:00', '14:00', '서비스 D', 400000, 330, '예약 시간 조정 요청.', '3');

-- 예약 29
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310292020029', 'ava@example.com', '아바 리', '010-3333-4444', 'vendor1@example.com', '11111', 'CU 부평북부역점', '032-456-7890', 'CU 부평북부역점', '21389', '인천 부평구 경원대로 1367', '1층', TO_DATE('2023-10-29', 'YYYY-MM-DD'), TO_DATE('2023-11-06', 'YYYY-MM-DD'), '15:00~17:00', '15:00', '서비스 E', 410000, 340, '추가 요청 사항 있음.', '3');

-- 예약 30
INSERT INTO user_reservation (reservation_number, user_email, user_name, user_phone, vendor_email, business_regi_num, vendor_name, vendor_phone, business_name, zipcode, basic_address, detail_address, reservation_date, reservation_use_date, times, times_hhmm, total_service_name, total_service_price, total_required_time, user_request_memo, status) VALUES 
('202310303131030', 'liam@example.com', '리암 모', '010-4444-5555', 'vendor2@example.com', '22222', '이마트24 부평제일점', '032-567-8901', '이마트24 부평제일점', '21404', '인천 부평구 광장로4번길 32', '', TO_DATE('2023-10-30', 'YYYY-MM-DD'), TO_DATE('2023-11-07', 'YYYY-MM-DD'), '16:00~18:00', '16:00', '서비스 A', 420000, 350, '시간 조정 필요.', '3');


commit;


--더미데이터 삭제 쿼리
--delete from user_reservation where vendor_email like '%example%';







