USE SN_ETC_2014

SELECT *
FROM dbo.ETCExit2014
WHERE EXITSTATION LIKE '740102%'


CREATE VIEW TR AS
SELECT ENTRYSTATION,EXITSTATION,COUNT(*) AS NUM
FROM dbo.ETCExit2014
GROUP BY ENTRYSTATION,EXITSTATION
ORDER BY ENTRYSTATION

%%%��̬ת��
SELECT ENTRYSTATION,
SUM(CASE WHEN EXITSTATION='10001' THEN NUM ELSE 0 END) AS '10001', 
SUM(CASE WHEN EXITSTATION='10002' THEN NUM ELSE 0 END) AS '10002', 
SUM(case WHEN EXITSTATION='10003' THEN NUM ELSE 0 END) AS '10003'
from TR 
GROUP BY ENTRYSTATION
ORDER BY ENTRYSTATION



SELECT *
FROM TR
ORDER BY ENTRYSTATION,EXITSTATION

%%%��̬ת��
DECLARE @sql_str VARCHAR(8000)
DECLARE @sql_col VARCHAR(8000)
SELECT @sql_col = ISNULL(@sql_col + ',','') + QUOTENAME(EXITSTATION) FROM [TR] GROUP BY [EXITSTATION] ORDER BY [EXITSTATION]
SET @sql_str = '
SELECT * FROM (
    SELECT [ENTRYSTATION],[EXITSTATION],[NUM] FROM [TR]) p PIVOT 
    (SUM([NUM]) FOR [EXITSTATION] IN ( '+ @sql_col +') ) AS pvt 
ORDER BY pvt.[ENTRYSTATION]'
PRINT (@sql_str)
EXEC (@sql_str)


