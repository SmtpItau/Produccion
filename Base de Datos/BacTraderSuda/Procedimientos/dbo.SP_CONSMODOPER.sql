USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSMODOPER]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[SP_CONSMODOPER]
    (
    @nNumoper NUMERIC (10,0)
    )
AS
BEGIN
 SET NOCOUNT ON
 CREATE TABLE
 #TMPTC
  (
  codigo  NUMERIC (4,0) ,
  glosa  CHAR (30) ,
  contador INTEGER IDENTITY(1,1) NOT NULL
  )
 INSERT #TMPTC 
 SELECT codigo ,
  glosa  
 FROM VIEW_FORMA_DE_PAGO
 --IF EXISTS(SELECT monumoper FROM MDMO WHERE monumoper=@nnumoper) --AND (motipoper='RC' OR motipoper='RV'))
 --BEGIN
 -- SELECT 'NO', 'NUMERO DE OPERACION CORRESPONDE A VCTO. DE PACTO'
 -- SET NOCOUNT OFF
 -- RETURN
 --END
 IF EXISTS(SELECT monumoper FROM MDMO WHERE monumoper=@nnumoper AND mostatreg='')
 BEGIN
  SELECT 'numoper'  = @nnumoper     ,-- 1
   'numdocu'  = monumdocu     ,-- 2
   'correla'  = mocorrela      ,-- 3
   'tipoper'  = motipoper     ,-- 4
   'tipopal'  = CASE MOTIPOPER
       WHEN 'CI' THEN 'COMPRA CON PACTO'
       WHEN 'CP' THEN 'COMPRA DEFINITIVA'
       WHEN 'VP' THEN 'VENTA DEFINITIVA'
       WHEN 'IB' THEN 'INTERBANCARIO'
       WHEN 'ST' THEN 'SORTEO DE LETRAS'
       WHEN 'IC' THEN 'CAPTACION'
       ELSE 'VENTA CON PACTO'
        END      ,-- 5
   'rutcart'  = RTRIM(CONVERT(CHAR(9),morutcart))+'-'+rcdv ,-- 6
   'nomcart'  = rcnombre     ,-- 7
   'valinip'  = CONVERT(NUMERIC(19,4),0)   ,-- 8
   'valinium'   = CONVERT(NUMERIC(19,4),0)   ,-- 9
   'taspact'  = ISNULL(motaspact,0)    ,--10
   'baspact'  = ISNULL(mobaspact,0)    ,--11
   'plapact'  = DATEDIFF(DAY,mofecinip,mofecvenp)  ,--12
   'umpacto'  = ISNULL(mnnemo,'')    ,--13
   'monpact'  = ISNULL(momonpact,0)    ,--14
   'fecvenp'  = CONVERT(CHAR(10),mofecvenp,103)  ,--15
   'valvenp'  = CONVERT(NUMERIC(19,4),0)   ,--16
   'FORPAGi'  = ISNULL(moforpagi,0)    ,--17
   'FORPAGv'  = ISNULL(moforpagv,0)    ,--18
   'rutcli'  = CONVERT(CHAR(9),morutcli)   ,--19
   'digcli'  = cldv      ,--20
   'nomcli'  = clnombre     ,--21
   'serie'   = moinstser     ,--22
   'emisor'  = ISNULL(emgeneric,'')    ,--23
   'moneda'  = CONVERT(CHAR(3),momonemi)   ,--24
   'nominal'  = monominal     ,--25
   'tircomp'  = ISNULL(motir,0)    ,--26
   'valpres'  = CASE
			WHEN motipoper='VP' THEN ISNULL(movalven,0)
			ELSE ISNULL(movpreseni,0)
		END ,--27
   'valorum'  = CONVERT(NUMERIC(19,4),0)   ,--28
   'valoper'  = CONVERT(NUMERIC(19,4),0)   ,--29
   'tipcli'  = cltipcli     ,--30
   'fecpcup'  = CONVERT(CHAR(10),mofecven,103)  ,--31
   'tipopero'  = motipopero     ,--32
   'codcli'  = mocodcli     ,--33
   'mtopfe'  = momtopfe     ,--34
   'mtocce'  = momtocce     ,--35
   'contadorp'             = 0 , --36
   'Ejecutivo' = MDMO.Ejecutivo, --37
   'TIPO_RENTABILIDAD' = TIPO_RENTABILIDAD, --38
   'LAMINA' = LAMINAS, -- 39
   'RETIRO' = MOTIPRET, --40
   'MODINVERSION'=motipcart, --41
   'SubFPInicio' = sub_forma_ini,		-- 42
	'SubFPVcto'   = sub_forma_venc,		  --43
	'Comision'	= (CASE WHEN momtocomi>0 THEN	'S' ELSE 'N' END)	-- 44
  INTO #TMP
  FROM --  REQ. 7619
       MDMO LEFT OUTER JOIN VIEW_CLIENTE ON morutcli = clrut 
            LEFT OUTER JOIN VIEW_MONEDA ON  momonpact = mncodmon 
            LEFT OUTER JOIN VIEW_EMISOR ON  morutemi = emrut 
     , VIEW_ENTIDAD 
--  REQ. 7619
--     , VIEW_CLIENTE
--     , VIEW_EMISOR
--     , VIEW_MONEDA 
     , #TMPTC
  WHERE (motipoper='CI' OR motipoper='VI' OR motipoper='CP' OR motipoper='VP' OR motipoper='IB' OR motipoper='IC' OR motipoper='RC' OR motipoper='RV' ) 
     AND mostatreg='' 
     AND monumoper=@nnumoper 
     AND morutcart=rcrut 
--  REQ. 7619
--     AND morutcli*=clrut 
--     AND momonpact*=mncodmon 
--     AND morutemi*=emrut 
     AND moforpagi=codigo



  UPDATE #TMP
  SET valinip  = ISNULL((SELECT SUM(movalinip) FROM MDMO WHERE monumoper=@nnumoper),0) ,
   valvenp  = ISNULL((SELECT SUM(movalvenp) FROM MDMO WHERE monumoper=@nnumoper),0) ,
   valinium = ISNULL((SELECT SUM(movalinip) FROM MDMO WHERE monumoper=@nnumoper),0) ,
   valoper  = ISNULL((SELECT SUM(movalinip) FROM MDMO WHERE monumoper=@nnumoper),0) ,
--   contadorp = contador        ,
    moneda  = mnnemo
  FROM VIEW_MONEDA, #TMPTC
  WHERE CONVERT(INTEGER,moneda)=mncodmon --and contadorp=codigo
  UPDATE #TMP
  SET valinium = ROUND(valinip/ISNULL(vmvalor,1),4) ,
   valorum  = ISNULL(vmvalor,1.0)
  FROM VIEW_VALOR_MONEDA, MDAC
  WHERE monpact<>999 AND (monpact=vmcodigo AND acfecproc=vmfecha)
  UPDATE #TMP
  SET tipopal  = CASE serie
      WHEN 'ICAP' THEN 'CAPTACION'
      ELSE 'COLOCACION'
       END     ,
   valpres  = movalcomp
  FROM MDMO
  WHERE tipoper='IB' AND (numoper=monumoper)
  UPDATE #TMP
  SET valoper  = ISNULL((SELECT SUM(movalven) FROM MDMO WHERE monumoper=@nnumoper),0)
  WHERE tipoper='VP' OR tipoper='VI'
 UPDATE #TMP
  SET valoper  = ISNULL((SELECT SUM(movalcomp) FROM MDMO WHERE monumoper=@nnumoper),0)
  WHERE tipoper='CP' 
  UPDATE #TMP
  SET valoper  = ISNULL((SELECT SUM(movpresen) FROM MDMO WHERE monumoper=@nnumoper),0)
  WHERE tipoper='IC'
  UPDATE #TMP
  SET fecpcup = CONVERT(CHAR(10),difecsal,103)
  FROM MDDI
  WHERE (dinumdocu=numdocu AND dicorrela=correla) AND tipopero='CI'
  UPDATE #TMP
  SET fecpcup = CONVERT(CHAR(10),cpfecpcup,103)
  FROM MDCP
  WHERE (cpnumdocu=numdocu AND cpcorrela=correla) AND tipopero='CP'
  SELECT * FROM #TMP
 END
 ELSE
  SELECT 'NO', 'NUMERO DE OPERACION '+RTRIM(CONVERT(CHAR(10),@nnumoper))+' NO EXISTE'
 SET NOCOUNT OFF
 
END
/*select mostatreg,* from MDMO
 select * from MDMH
 sp_consmodoper 48827
 SP_AUTORIZA_EJECUTAR 'BACUSER'
*/


-- Base de Datos --
GO
