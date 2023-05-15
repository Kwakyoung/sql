-- TABLE

CREATE TABLE TBL_BOARD 
(
        BOARD_NUM NUMBER PRIMARY KEY,
        BOARD_TITLE VARCHAR2(100) NOT NULL,
        BOARD_CONTENT VARCHAR2(2000) NOT NULL,
        WRITER VARCHAR2(100),
        WRITER_DATE VARCHAR2(20)
);


-- 게시판 글을 5건정도 추가해보기
--INSERT INTO TBL_BOARD (BOARD_NUM, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITER_DATE) VALUES ('010', 'X', 'X', 'X', 'X')
INSERT INTO TBL_BOARD (BOARD_NUM, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITER_DATE) 
               VALUES ('05', 'titlE2', '내용', '곽영균', '5/10');
               
INSERT INTO TBL_BOARD (BOARD_NUM, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITER_DATE) 
               VALUES ('02', '제목', '내용', '곽영균', '5/10');
               
INSERT INTO TBL_BOARD (BOARD_NUM, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITER_DATE) 
               VALUES ('03', '제목', '내용', '곽영균', '5/10');              
               
COMMIT;
SELECT * FROM TBL_BOARD WHERE UPPER(BOARD_TITLE) LIKE UPPER('%e2%');  -- e2 E2 같이 검색되게

-- UPDATE TABLE명 SET 바꿀컬럼 = 바꿀값 WHERE 조건
-- UPDATE & DELETE는 조건을 별도로 만들지 않으면 전체행에 대한 수정이 발생함. (삭제)
-- WHERE조건이 매우 중요함.
UPDATE TBL_BOARD SET BOARD_TITLE = '제목', BOARD_CONTENT = '내용', WRITER = '곽영균', WRITER_DATE = '2023-05-12';
DELETE FROM TBL_BOARD      
rollback;

SELECT * FROM TBL_BOARD;


SELECT max(board_num) from tbl_board;



SELECT *                   -- 2가 들어가있는 항목들 나오게하기
FROM TBL_BOARD 
WHERE BOARD_NUM LIKE '%2%'
OR BOARD_TITLE LIKE '%2%';


               
               

               
               
               
               
               
               