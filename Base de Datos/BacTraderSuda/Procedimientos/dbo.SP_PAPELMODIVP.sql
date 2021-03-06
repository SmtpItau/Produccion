USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELMODIVP]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PAPELMODIVP]
    (
    @nRutcart NUMERIC (09,0) ,
    @nNumoper NUMERIC (10,0) ,
    @cTipoImp CHAR (01) ,
    @cTipoper CHAR (02)
    )
AS
BEGIN
SET NOCOUNT ON
 DECLARE @cFecEmi VARCHAR (40) ,
  @nDiaSem INTEGER  ,  
  @nDia  INTEGER  ,   
  @nMes  INTEGER  ,
  @nAnn  INTEGER  ,
  @tipcart CHAR (25) ,
  @Forpa  CHAR (25) ,
  @Tipocli CHAR (25) ,
  @Tipcli  numeric (05) ,
  @Tipret  CHAR (15) ,
  @Rutcli  NUMERIC (9,0) ,
  @Codcli  NUMERIC (9,0) ,
  @Nomcli  CHAR (40) ,
  @Dircli  CHAR (40) ,
  @Foncli  CHAR (15) ,
  @Faxcli  CHAR (15) ,
  @Obser  CHAR (70) ,
  @Nomoper CHAR (40) ,
  @DigVeri CHAR (01) ,
  @Nompro  CHAR (40) ,
  @Dirpro  CHAR (40) ,
  @Rutpro  CHAR (12) ,
  @Fecpro  CHAR (10) ,
  @Total  NUMERIC (19,2) ,
  @Cust  CHAR (20) ,
  @NumSol  NUMERIC (9,0) ,
  @linea1  CHAR (70) ,
  @linea2  CHAR (65) ,
  @linea3  CHAR (65) ,
  @linea4  CHAR (65) ,
  @linea5  CHAR (65) ,
  @glocopia CHAR (25) ,
  @nCopia  INTEGER  ,
  @Pagina  INTEGER  ,
  @nTotPagina INTEGER  ,
  @contador NUMERIC (19,0) ,
  @contador2 NUMERIC (19,0) ,
  @nMtoComi NUMERIC (19,0) ,
  @fComision FLOAT  ,
  @nIva  NUMERIC (19,0) ,
  @hora  CHAR(8)  ,
  @cSettlement CHAR(50) ,
  @cPFE  CHAR(50) ,
  @cCCE  CHAR(50) ,
  @cEmisorInstPlazo CHAR(255)
 IF @cTipoImp='P'
  SELECT @nCopia = papapimp FROM MDPA WHERE panumoper=@nNumoper
 ELSE
  SELECT @nCopia = paconimp FROM MDPA WHERE panumoper=@nNumoper
 IF @cTipoImp='P'
  SELECT @glocopia = CASE
      WHEN @nCopia=1 THEN 'COPIA MESA'
      WHEN @nCopia=2 THEN 'COPIA INVERSIONES'
      WHEN @nCopia=3 THEN 'COPIA CUSTODIA'
      ELSE ' '
       END
 ELSE
  SELECT @glocopia = CASE
      WHEN @nCopia=1 THEN 'ORIGINAL CLIENTE'
      WHEN @nCopia=2 THEN 'COPIA CLIENTE'
      ELSE ' '
       END
 IF @cTipoImp='P'
  SELECT @nTotPagina = 16
 ELSE
  SELECT @nTotPagina = 23
 SELECT @Total = (SELECT SUM(ROUND(movalven,2))
 FROM MDMO
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper=@cTipoper)
 SELECT 
  @tipcart = tbglosa
 FROM 
  MDTC ,
  MDMO
 WHERE 
  tbcateg=204 
 AND CONVERT(NUMERIC(6),tbcodigo1)=motipcart
 AND monumoper=@nNumoper 
 AND morutcart=@nRutcart
 AND motipoper=@cTipoper
 SELECT @Forpa = glosa
 FROM VIEW_FORMA_DE_PAGO , MDMO
 WHERE codigo=moforpagi 
           AND monumoper=@nNumoper AND
  morutcart=@nRutcart AND motipoper=@cTipoper
 SELECT @Obser  = ISNULL(moobserv,'')     ,
  @linea1  = ISNULL(moobserv2,'')     ,
  @nDiaSem = DATEPART(WEEKDAY,mofecpro)    ,
  @nDia  = DATEPART(DAY,mofecpro)    ,
  @nMes  = DATEPART(MONTH,mofecpro)    ,
  @nAnn  = DATEPART(YEAR,mofecpro)    ,
  @NumSol  = monsollin      ,
  @Rutcli  = morutcli      ,
  @codcli  = mocodcli      ,
  @Tipret  = CASE motipret
     WHEN 'I' THEN 'VIENEN'
     ELSE 'VAMOS'
      END       ,
  @Nompro  = ISNULL(acnomprop,'')     ,
  @Dirpro  = ISNULL(acDirprop,'')     ,
  @Rutpro  = STR(acrutprop)+'-'+acdigprop    ,
  @Fecpro  = CONVERT(CHAR(10),acfecproc,103)   ,
  @Nomoper = nombre      ,
  @nMtoComi = ISNULL(momtocomi,0)     ,
  @fComision = accomision/CONVERT(FLOAT,100)    ,
  @nIva  = ISNULL(momtocomi,0)     ,
  @hora  = mohora
 FROM 
  MDMO  ,
  VIEW_USUARIO ,
  MDAC
 WHERE 
  monumoper=@nNumoper 
 AND morutcart=@nRutcart
 AND motipoper=@cTipoper
 AND mousuario=SUBSTRING(usuario,1,12)
 IF @nMes= 1 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Enero de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 2 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Febrero de '   +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 3 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Marzo de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 4 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Abril de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 5 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Mayo de '      +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 6 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Junio de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 7 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Julio de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 8 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Agosto de '    +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 9 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Septiembre de '+CONVERT(CHAR(4),@nAnn)
        IF @nMes=10 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Octubre de '   +CONVERT(CHAR(4),@nAnn)
        IF @nMes=11 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Noviembre de ' +CONVERT(CHAR(4),@nAnn)
        IF @nMes=12 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Diciembre de ' +CONVERT(CHAR(4),@nAnn)
 IF @nDiaSem=1 SELECT @cFecEmi = 'Domingo '  +@cFecEmi
 IF @nDiaSem=2 SELECT @cFecEmi = 'Lunes '    +@cFecEmi 
 IF @nDiaSem=3 SELECT @cFecEmi = 'Martes '   +@cFecEmi
 IF @nDiaSem=4 SELECT @cFecEmi = 'Miercoles '+@cFecEmi
 IF @nDiaSem=5 SELECT @cFecEmi = 'Jueves '   +@cFecEmi
 IF @nDiaSem=6 SELECT @cFecEmi = 'Viernes '  +@cFecEmi
 IF @nDiaSem=7 SELECT @cFecEmi = 'Sabado '   +@cFecEmi
       
 SELECT @Nomcli  = clnombre  ,
  @Dircli  = cldirecc  ,
  @Foncli  = clfono  ,
  @Faxcli  = clfax   ,
  @Tipcli  = cltipcli  ,
  @Digveri = ISNULL(cldv,'')
 FROM VIEW_CLIENTE
 WHERE clrut=@rutcli 
 AND clcodigo=@codcli
 IF @nMtoComi=0
  SELECT @nIva  = 0 ,
   @nMtoComi = 0 ,
   @fComision = 0
 SELECT @Tipocli = tbglosa   ,
  @nMtoComi = ROUND(@Total*@fComision,0)
 FROM MDTC
 WHERE tbcateg=207 AND CONVERT(INTEGER,tbcodigo1)=CONVERT(INTEGER,@Tipcli)
 EXECUTE SP_PAPELETA_LIMITES @cTipoper    ,
     @nNumoper    ,
     @cSettlement  OUTPUT  ,
     @cPFE   OUTPUT  ,
     @cEmisorInstPlazo OUTPUT  ,
     @cCCE   OUTPUT  
 SELECT 'cnompro' = ISNULL(@Nompro,'')     ,--1
  'nrutpro' = ISNULL(@Rutpro,'')     ,--2
  'dfecpro' = ISNULL(@Fecpro,'')     ,--3
  'tipocart' = ISNULL(@Tipcart,'')     ,--4
  'fecemi' = ISNULL(@cFecemi,'')     ,--5
  'näoper' = ISNULL(monumoper,0)     ,--6
  'totalg' = ISNULL(@Total,0)     ,--7 
  'fpago'  = ISNULL(@Forpa,'')     ,--8
  'correla' = ISNULL(mocorrela,0)     ,--9
  'i_seri' = ISNULL(moinstser,'')     ,--10
  'nominal' = ISNULL(monominal,0)     ,--11
  'tir'  = ISNULL(motir,0)     ,--12
  'mtps'  = ISNULL(movalven,0)     ,--13
  'custodia' = CASE modcv WHEN  'C' THEN 'CLIENTE' WHEN 'P' THEN 'PROPIA' WHEN 'D' THEN 'DCV' END ,--14
  'tipcli' = ISNULL(@TipoCli,'')     ,--15
  'tipret' = ISNULL(@Tipret,'')     ,--16
  'rutcli' = STR(@Rutcli)+'-'+@Digveri    ,--17
  'codcli' = ISNULL(CONVERT(CHAR(9),@Codcli),'')   ,--18
  'nomcli' = ISNULL(@Nomcli,'')     ,--19
  'dircli' = ISNULL(@Dircli,'')     ,--20
  'foncli' = ISNULL(@FonCli,'')     ,--21
  'faxcli' = ISNULL(@Faxcli,'')     ,--22
  'obser'  = ISNULL(@Obser,'')     ,--23
  'operador' = ISNULL(@Nomoper,'')     ,--24
  'emisor' = ISNULL(emgeneric,'')     ,--25
  'moneda' = ISNULL(mnnemo,'')     ,--26 
  'linea1' = ISNULL(@linea1,'')     ,--27
  'linea2' = ISNULL(@linea2,'')     ,--28
  'linea3' = ISNULL(@linea3,'')     ,--29
  'linea4' = ISNULL(@linea4,'')     ,--30
  'linea5' = ISNULL(@linea5,'')     ,--31
  'vpb'  = ISNULL(mopvp,0)     ,--32
  'vpc'  = ISNULL(movpar,0)           ,--33
  'cdirpro' = ISNULL(@Dirpro,'')          ,--34
  'copia'  = ISNULL(@glocopia,'')     ,--35
  'pagina' = 0       ,--36
  'contador' = ISNULL(mocorvent,0)     ,--37
  'numdocu' = ISNULL(monumdocu,0)     ,--38
  'totalpag' = 0       ,--39
  'comision' = @nMtoComi      ,--40
  'iva'  = @nIva-@nMtoComi     ,--41
  'vvcomi' = ISNULL(movviscom,0)     ,--42
  'hora'  = @hora       ,--43
  'clavedcv' = moclave_dcv       ,--44
  'lim_settle' = @cSettlement       --45
 INTO 
  #TEMP
 FROM --  REQ. 7619
  MDMO LEFT OUTER JOIN VIEW_EMISOR ON morutemi = emrut
       LEFT OUTER JOIN VIEW_MONEDA ON momonemi = mncodmon
/*, VIEW_EMISOR  
, VIEW_MONEDA 
*/
 WHERE 
  monumoper=@nNumoper 
 AND  morutcart=@nRutcart 
 AND motipoper=@cTipoper
--  REQ. 7619
/* AND morutemi*=emrut 
 AND momonemi*=mncodmon
*/
 ORDER BY 
  mocorrela
 SELECT @contador = 0 ,
  @contador2 = 0 ,
  @pagina  = 1
 WHILE @pagina<>0
 BEGIN
  SET ROWCOUNT 1
  SELECT @nompro  = '*'
  SELECT @nompro  = cnompro ,
   @contador = contador
  FROM #TEMP
  WHERE contador>@contador
  ORDER BY contador 
  SET ROWCOUNT 0
  IF @nompro='*'
   BREAK
  SELECT @contador2 = @contador2 + 1
  UPDATE #TEMP SET pagina   = @pagina WHERE contador=@Contador
  UPDATE #TEMP SET TotalPag = @pagina 
  IF @contador2=@nTotPagina
   SELECT @pagina  = @pagina + 1 ,
 
    @contador2 = 0
 END
 
 SELECT * FROM #TEMP
        SET NOCOUNT OFF
 RETURN
END

GO
