-- TABLE

CREATE TABLE TBL_BOARD 
(
        BOARD_NUM NUMBER PRIMARY KEY,
        BOARD_TITLE VARCHAR2(100) NOT NULL,
        BOARD_CONTENT VARCHAR2(2000) NOT NULL,
        WRITER VARCHAR2(100),
        WRITER_DATE VARCHAR2(20)
);


-- �Խ��� ���� 5������ �߰��غ���
--INSERT INTO TBL_BOARD (BOARD_NUM, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITER_DATE) VALUES ('010', 'X', 'X', 'X', 'X')
INSERT INTO TBL_BOARD (BOARD_NUM, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITER_DATE) 
               VALUES ('05', 'titlE2', '����', '������', '5/10');
               
INSERT INTO TBL_BOARD (BOARD_NUM, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITER_DATE) 
               VALUES ('02', '����', '����', '������', '5/10');
               
INSERT INTO TBL_BOARD (BOARD_NUM, BOARD_TITLE, BOARD_CONTENT, WRITER, WRITER_DATE) 
               VALUES ('03', '����', '����', '������', '5/10');              
               
COMMIT;
SELECT * FROM TBL_BOARD WHERE UPPER(BOARD_TITLE) LIKE UPPER('%e2%');  -- e2 E2 ���� �˻��ǰ�

-- UPDATE TABLE�� SET �ٲ��÷� = �ٲܰ� WHERE ����
-- UPDATE & DELETE�� ������ ������ ������ ������ ��ü�࿡ ���� ������ �߻���. (����)
-- WHERE������ �ſ� �߿���.
UPDATE TBL_BOARD SET BOARD_TITLE = '����', BOARD_CONTENT = '����', WRITER = '������', WRITER_DATE = '2023-05-12';
DELETE FROM TBL_BOARD      
rollback;

SELECT * FROM TBL_BOARD;


SELECT max(board_num) from tbl_board;



SELECT *                   -- 2�� ���ִ� �׸�� �������ϱ�
FROM TBL_BOARD 
WHERE BOARD_NUM LIKE '%2%'
OR BOARD_TITLE LIKE '%2%';


               
               

               
               
               
               
               
               