create TABLE USER_PICK
(RES_NAME	VARCHAR2(30 BYTE),
 USER_ID	VARCHAR2(30 BYTE)
 );
 
DROP TABLE USER_;



 
 
 
 INSERT INTO RESTAURANTS(RES_ID,RES_NAME,COUSINE,OPEN_TIME,CLOSE_TIME,ADD1,DISTANCE)
 VALUES((select nvl(max(RES_ID),0)+1 as new from RESTAURANTS)
 ,'신가네매운떡볶이 대흥은행점','분식','10:30','21:00','대전 중구 선화서로 4',73);
 
 
 
 INSERT INTO RESTAURANTS(RES_ID,RES_NAME,COUSINE,OPEN_TIME,CLOSE_TIME,ADD1,DISTANCE)
 VALUES((select nvl(max(RES_ID),0)+1 as new from RESTAURANTS)
 ,'','','','','',100);