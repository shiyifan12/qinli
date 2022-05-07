USE studentsdb;
ALTER TABLE student_info DROP PRIMARY KEY;
ALTER TABLE curriculum DROP PRIMARY KEY;
ALTER TABLE grade DROP PRIMARY KEY;

CREATE UNIQUE INDEX cno_idx ON curriculum(课程编号);

CREATE INDEX grade_idx ON grade(分数);

CREATE INDEX grade_sid_cid_idx ON grade(学号,课程编号);

SHOW INDEX FROM grade;

DROP INDEX grade_idx ON grade;
SHOW INDEX FROM grade;

CREATE VIEW v_stu_c
 AS
 SELECT s.学号,姓名,课程编号 FROM student_info s,grade g
  WHERE s.学号=g.学号;
	SELECT * FROM v_stu_c
 WHERE 学号='0003';
 
 CREATE VIEW v_stu_g
AS
 SELECT s.学号,姓名,课程名称,分数 
  FROM student_info s,grade g,curriculum c
  WHERE s.学号=g.学号 and g.课程编号=c.课程编号;
	SELECT AVG(分数) 平均分 FROM v_stu_g  WHERE 学号='0001';
	
	ALTER VIEW v_stu_g
AS
 SELECT 学号,姓名,性别 FROM student_info;
 
 INSERT INTO v_stu_g(学号,姓名,性别)
 VALUES('0010','陈婷婷','女');
 
 DELETE FROM v_stu_g WHERE 学号='0010';
 
 UPDATE grade SET 分数=87
 WHERE 学号=(SELECT 学号 FROM v_stu_g WHERE 姓名='张青平') and
  课程编号=(SELECT 课程编号 FROM curriculum WHERE 课程名称='高等数学');
	
	DROP VIEW v_stu_c,v_stu_g;