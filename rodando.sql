SET FEEDBACK ON;
SET PAGESIZE 5000;
SET LINESIZE 300;
SET VERIFY OFF;

COL SSE      FORMAT A11 WRAP;
COL SPID     FORMAT A6;
COL USERN    FORMAT A3  WRAP;
COL USERNAME FORMAT A17 WRAP;
COL CLIENT_INFO FORMAT A20 ;
COL SERVER   FORMAT A10 WRAP;
COL STATUS   FORMAT A8  WRAP;
COL PROGRAM  FORMAT A25 WRAP;
COL MACHINE  FORMAT A25 ;

--ACCEPT 1 CHAR PROMPT 'ORDENAR POR : '


SELECT  ''''||TO_CHAR(S.SID)||','||TO_CHAR(S.SERIAL#)||'''' SSE, 
		S.SQL_ADDRESS addr, s.process,
		S.USERNAME USERNAME, 
		TO_CHAR(S.LOGON_TIME, 'DD/MM/YY HH24:MI:SS') HORA,
		lpad(S.CLIENT_INFO, 19) CLIENT_INFO, p.spid, 
		lpad(S.MACHINE,24) MACHINE, S.STATUS STATUS,S.lockwait,
		s.server,s.program,s.osuser 
	FROM V$SESSION S, V$PROCESS P
	WHERE   P.ADDR (+) = S.PADDR AND
                S.status = 'ACTIVE' and 
		S.USERNAME IS NOT NULL
	ORDER BY S.USERNAME,HORA   ;

