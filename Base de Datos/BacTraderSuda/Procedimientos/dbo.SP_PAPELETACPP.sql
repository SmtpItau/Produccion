USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELETACPP]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_PAPELETACPP]
            (   @nRutcart FLOAT  ,
  @nNumoper FLOAT  ,
  @cTipoImp CHAR (01)    )
AS
BEGIN
 DECLARE @cFecEmi VARCHAR (40) ,
  @nDiaSem INTEGER  ,
  @nDia  INTEGER  ,
  @nMes  INTEGER  ,
  @nAnn  INTEGER  ,
  @tipcart CHAR (25) ,
  @Forpa  CHAR (25) ,
  @Tipocli CHAR (25) ,
  @Tipcli  NUMERIC (05) ,
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
  @Nompro  VARCHAR (40) ,
  @Rutpro  CHAR (12) ,
  @Fecpro  VARCHAR (10) ,
  @Dirpro  VARCHAR (40) ,
  @Cust  CHAR (15) ,
  @claveDCV CHAR (15) ,
  @Total  NUMERIC (19,2) ,   
  @NumSol  NUMERIC (9,0) ,
  @linea1  CHAR (255) ,
  @linea2  CHAR (255) ,
  @linea3  CHAR (255) ,
  @linea4  CHAR (255) ,
  @linea5  CHAR (255) ,
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
  @cEmisorInstPlazo CHAR(255) ,
  @MtoEsc  VARCHAR (100) ,
  @EstadoPeracion VARCHAR (100)
   SET NOCOUNT ON

/*=======================================================================*/
  DECLARE @firma1 char(15)
  DECLARE @firma2 char(15)

	  Select @firma1=res.Firma1,
		 @firma2=res.Firma2
	   From BacLineas..detalle_aprobaciones res
	   Where res.Numero_Operacion=@nNumoper
 /*=======================================================================*/



   SELECT 'acfecproc' = acfecproc,
       'acfecprox' = acfecprox,
       'uf_hoy'    = CONVERT(FLOAT, 0),
       'uf_man'    = CONVERT(FLOAT, 0),
       'ivp_hoy'   = CONVERT(FLOAT, 0),
       'ivp_man'   = CONVERT(FLOAT, 0),
       'do_hoy'    = CONVERT(FLOAT, 0),
       'do_man'    = CONVERT(FLOAT, 0),
       'da_hoy'    = CONVERT(FLOAT, 0),
       'da_man'    = CONVERT(FLOAT, 0),
       'pmnomprop' = acnomprop,
       'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrutprop)) + '-' + acdigprop
  INTO #PARAMETROS
  FROM MDAC
/* RESCATA VALOR DE UF -------------------------------------------------------------- */
 UPDATE #PARAMETROS SET uf_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
  FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
  WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc
   AND VIEW_VALOR_MONEDA.vmcodigo = 998
 UPDATE #PARAMETROS SET uf_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                 AND VIEW_VALOR_MONEDA.vmcodigo = 998
/* RESCATA VALOR DE IVP ------------------------------------------------------------- */
 UPDATE #PARAMETROS SET ivp_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                 AND VIEW_VALOR_MONEDA.vmcodigo = 997
 UPDATE #PARAMETROS SET ivp_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                 AND VIEW_VALOR_MONEDA.vmcodigo = 997
/* RESCATA VALOR DE DO -------------------------------------------------------------- */
 UPDATE #PARAMETROS SET do_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                 AND VIEW_VALOR_MONEDA.vmcodigo = 994
 UPDATE #PARAMETROS SET do_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                 AND VIEW_VALOR_MONEDA.vmcodigo = 994
/* RESCATA VALOR DE DA -------------------------------------------------------------- */
 UPDATE #PARAMETROS SET da_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                 AND VIEW_VALOR_MONEDA.vmcodigo = 995
UPDATE #PARAMETROS SET da_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                 AND VIEW_VALOR_MONEDA.vmcodigo = 995
 IF @cTipoImp='P'
  SELECT @nCopia = papapimp FROM MDPA WHERE panumoper=@nNumoper
        ELSE
  SELECT @nCopia = paconimp FROM MDPA WHERE panumoper=@nNumoper
 IF @cTipoImp='P'
 SELECT @nTotPagina = 16
 ELSE
  SELECT @nTotPagina = 23
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
 SELECT 
  @Obser  = ISNULL(moobserv,'')     ,
  @linea1  = ISNULL(moobserv2,'')     ,
  @Rutcli  = ISNULL(morutcli,0)     ,
  @Codcli  = ISNULL(mocodcli,0)     ,
  @Tipret  = CASE motipret
              WHEN 'I' THEN 'VIENEN'
     ELSE 'VAMOS'
      END       ,
  @Nomoper = nombre      ,
  @Nompro  = ISNULL(acnomprop,'')     ,
  @Rutpro  = STR(acrutprop)+'-'+acdigprop    ,
  @Dirpro  = ISNULL(acdirprop,'')     ,
  @Fecpro  = CONVERT(CHAR(10),acfecproc,103)   ,
  @nMtoComi = ISNULL(momtocomi,0)     ,
  @fComision = accomision/CONVERT(FLOAT,100)    ,
  @nIva  = ISNULL(momtocomi,0)     ,
  @hora   = mohora      ,
  @EstadoPeracion = CASE mostatreg
              WHEN 'P' THEN 'OPERACION PENDIENTE DE APROBACION'
     ELSE ''
      END 
 FROM MDMO, VIEW_USUARIO, MDAC
 WHERE 
  monumoper=@nNumoper 
 AND  morutcart=@nRutcart 
 AND  motipoper='CP' 
 AND  SUBSTRING(USUARIO,1,12) = mousuario
 SELECT @Total = (SELECT SUM(movalcomp)  
 FROM MDMO
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='CP')

 SELECT Distinct @tipcart =  IsNull(rcnombre,'')
 FROM BacParamSuda..TIPO_CARTERA, MDMO
 WHERE rcsistema = 'BTR' And rcrut = motipcart AND monumoper=@nNumoper AND 
 morutcart=@nRutcart AND motipoper='CP'

 SELECT @Forpa  = glosa
 FROM VIEW_FORMA_DE_PAGO, MDMO
 WHERE codigo=moforpagi --Forma de Pago
          AND monumoper=@nNumoper AND
  morutcart=@nRutcart AND motipoper='CP'
 SELECT @nDiaSem = DATEPART(WEEKDAY,mofecpro) ,
  @nDia  = DATEPART(DAY,mofecpro) , 
  @nMes  = DATEPART(MONTH,mofecpro) ,
  @nAnn  = DATEPART(YEAR,mofecpro)
 FROM MDMO
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='CP'
 IF @nMes= 1 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Enero de '     + CONVERT(CHAR(4),@nAnn)
 IF @nMes= 2 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Febrero de '   + CONVERT(CHAR(4),@nAnn)
 IF @nMes= 3 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Marzo de '     + CONVERT(CHAR(4),@nAnn)
 IF @nMes= 4 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Abril de '     + CONVERT(CHAR(4),@nAnn)
 IF @nMes= 5 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Mayo de '      + CONVERT(CHAR(4),@nAnn)
 IF @nMes= 6 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Junio de '     + CONVERT(CHAR(4),@nAnn)
 IF @nMes= 7 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Julio de '     + CONVERT(CHAR(4),@nAnn)
 IF @nMes= 8 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Agosto de '    + CONVERT(CHAR(4),@nAnn)
 IF @nMes= 9 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Septiembre de '+ CONVERT(CHAR(4),@nAnn)
 IF @nMes=10 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Octubre de '   + CONVERT(CHAR(4),@nAnn)
 IF @nMes=11 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Noviembre de ' + CONVERT(CHAR(4),@nAnn)
 IF @nMes=12 SELECT @cFecEmi = CONVERT(CHAR(2),@nDia)+' de Diciembre de ' + CONVERT(CHAR(4),@nAnn)
 IF @nDiaSem=1 SELECT @cFecEmi = 'Domingo '  + @cFecEmi
 IF @nDiaSem=2 SELECT @cFecEmi = 'Lunes '    + @cFecEmi
 IF @nDiaSem=3 SELECT @cFecEmi = 'Martes '   + @cFecEmi
 IF @nDiaSem=4 SELECT @cFecEmi = 'Miercoles '+ @cFecEmi
 IF @nDiaSem=5 SELECT @cFecEmi = 'Jueves '   + @cFecEmi
 IF @nDiaSem=6 SELECT @cFecEmi = 'Viernes '  + @cFecEmi
 IF @nDiaSem=7 SELECT @cFecEmi = 'Sabado '   + @cFecEmi
 SELECT @NumSol = monsollin FROM MDMO WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='CP'
 SELECT @linea2 = ' ' ,
  @linea3 = ' ' ,
  @linea4 = ' '
 SELECT @Nomcli  = clnombre ,
  @Dircli  = cldirecc ,
  @Foncli  = clfono ,
  @Faxcli  = clfax  ,
--  @Codcli   = clcodigo ,
  @Tipcli  = cltipcli ,
  @Digveri = ISNULL(cldv,' ')
 FROM VIEW_CLIENTE
 WHERE clrut=@Rutcli
 AND clcodigo=@Codcli
 IF @nMtoComi=0
  SELECT @nIva  = 0 ,
   @nMtoComi = 0 ,
   @fComision = 0
 SELECT @Tipocli = tbglosa   ,
  @nMtoComi = ROUND(@Total*@fComision,0)
 FROM VIEW_TABLA_GENERAL_DETALLE
 WHERE tbcateg=207 AND CONVERT(INTEGER,tbcodigo1)=CONVERT(INTEGER,@Tipcli)
 EXECUTE Sp_Papeleta_Limites 'CP'    ,
     @nNumoper   ,
     @cSettlement  OUTPUT ,
     @cPFE   OUTPUT ,
     @cEmisorInstPlazo OUTPUT ,
     @cCCE   OUTPUT 
 
        EXECUTE SP_MONTOESCRITO_MONEDA @Total, @MtoEsc OUTPUT, 999
 CREATE TABLE #paso_error ( Mensaje_Error VARCHAR(255),
     NumeroCorre_Detalle NUMERIC(19,0) Identity(1,1))
 INSERT INTO #paso_error
 SELECT Mensaje_Error
 FROM view_linea_transaccion_detalle
 WHERE NumeroOperacion = @nnumoper
 AND id_sistema = 'BTR'
 AND Mensaje_Error <> ''
 INSERT INTO #paso_error
 SELECT Mensaje
 FROM view_limite_transaccion_error
 WHERE NumeroOperacion = @nnumoper
 AND id_sistema = 'BTR'
 SELECT @linea1 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 1
 SELECT @linea2 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 2
 SELECT @linea3 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 3
-- SELECT @linea4 = operador FROM view_linea_transaccion WHERE NumeroOperacion = @nnumoper and NumeroCorrelativo = 1 and id_sistema = "BTR"
 IF EXISTS(SELECT Operador_Ap_Lineas FROM view_aprobacion_operaciones, mdac WHERE id_sistema = 'BTR' AND NumeroOperacion = @nNumoper AND FechaOperacion = acfecproc)
 BEGIN
  SELECT @EstadoPeracion = CASE Estado
      WHEN 'A' THEN 'OPERACION APROBADA POR :   '  + Operador_Ap_Lineas
      WHEN 'P' THEN 'OPERACION RECHAZADA POR :   ' + Operador_Ap_Lineas
      Else ''
      END
  FROM view_aprobacion_operaciones,
   mdac
  WHERE id_sistema = 'BTR'
  AND NumeroOperacion = @nNumoper
  AND FechaOperacion = acfecproc
 END
 SELECT 'cNompro' = ISNULL(@Nompro,'')     ,
  'nRutpro' = ISNULL(@Rutpro,'')     ,
  'dFecpro' = ISNULL(@Fecpro,'')     ,
  'TipoCart' = ISNULL(@Tipcart,'')     ,
  'fecemi' = ISNULL(@cFecemi,'')     ,
  'nooper' = ISNULL(monumoper,0)     ,
  'Total'  = ISNULL(@Total,0)     ,
  'fpago'  = ISNULL(@Forpa,'')     ,
  'Correla' = ISNULL(mocorrela,0)     ,
  'I_Seri' = ISNULL(moinstser,'')     ,
  'Nominal' = ISNULL(monominal,0)        ,
  'tir'  = ISNULL(motir,0)     ,
  'MtPs'  = ISNULL(movalcomp,0)     ,
  'custodia' = CASE modcv  WHEN 'P' THEN 'PROPIA' WHEN 'C' THEN 'CLIENTE' WHEN 'D' THEN 'DCV' ELSE '' END,
  'Tipcli' = ISNULL(@TipoCli,'')     ,
  'Tipret' = ISNULL(@Tipret,'')     ,
  'Rutcli' = STR(@Rutcli)+'-'+@Digveri    ,
  'Codcli' = ISNULL(CONVERT(CHAR(9),@Codcli),'')   ,
  'Nomcli' = ISNULL(@Nomcli,'')     ,
  'Dircli' = ISNULL(@Dircli,'')     ,
  'Foncli' = ISNULL(@FonCli,'')     ,
  'Faxcli' = ISNULL(@Faxcli,'')     ,
  'Obser'  = ISNULL(@Obser,'')     ,
  'Operador' = ISNULL(@Nomoper,'')     ,
--  'emisor' = ISNULL(emgeneric,'')     ,
  'emisor' = CASE WHEN mocodigo = 98 THEN ( SELECT clgeneric FROM view_cliente WHERE clrut=morutcli AND clcodigo=mocodcli )
     ELSE ( SELECT emgeneric FROM view_emisor WHERE emrut=morutemi )
      END       ,
  'Moneda' = ISNULL(mnnemo,'')     ,
  'Linea1' = ISNULL(@linea1,'')     ,
  'Linea2' = ISNULL(@linea2,'')     ,
  'Linea3' = ISNULL(@linea3,'')     ,
  'Linea4' = ISNULL(@linea4,'')      ,
  'Linea5' = ISNULL(@linea5,'')     ,
  'vpb'  = ISNULL(mopvp,0)     ,
  'vpc'  = ISNULL(movpar,0)     ,
  'cDirpro' = ISNULL(@Dirpro,'')     ,
  'copia'  = ISNULL(@glocopia,'')     ,
  'Pagina' = 0       ,
  'contador' = ISNULL(mocorrela,0)      ,
  'vvista' = ISNULL(movvista,0)     ,
  'TotalPag' = 0       ,
  'comision' = @nMtoComi      ,
  'iva'  = @nIva-@nMtoComi     ,
  'vvcomi' = ISNULL(movviscom,0)     ,
  'hora'  = @hora       ,
  'clavedcv' = moclave_dcv      ,
  'Lim_PFE' = @cPFE       ,
  'Lim_Settle' = @cSettlement      ,
  'Lim_EmiPlz' = @cEmisorInstPlazo     ,
  'Lim_CCE' = @cCCE       ,
  'Valor Par' = isnull(mdmo.mopvp,0)     ,
  'Fecha_inicio' = CONVERT(CHAR(10), mdmo.mofecemi,103)   ,
  'Fecha_vencim' = CONVERT(CHAR(10), mdmo.mofecven,103)   ,
  'MtoEscrito' = @MtoEsc      ,
  'EstadoPeracion'= @EstadoPeracion,
  'Firma1'=@firma1,
  'Firma2'=@firma2	
 INTO #TEMP
 FROM --  REQ. 7619 
     MDMO  LEFT OUTER JOIN  VIEW_MONEDA ON momonemi = mncodmon
--  VIEW_EMISOR ,
--  REQ. 7619
--  VIEW_MONEDA
 WHERE monumoper=@nNumoper
 AND  morutcart=@nRutcart
 AND motipoper='CP'
-- AND morutemi*=emrut
--  REQ. 7619
-- AND momonemi*=mncodmon
 ORDER BY mocorrela
 SELECT @contador = 0 ,
  @contador2 = 0 ,
  @pagina  = 1
 WHILE @pagina<>0
 BEGIN
 SET ROWCOUNT 1
  SELECT @nompro = '*'
  SELECT @nompro  = cNompro ,
    @contador = contador
  FROM #Temp
  WHERE contador>@contador
  ORDER BY contador
  SET ROWCOUNT 0
  IF @nompro='*'
   BREAK
  SELECT @contador2 = @contador2 + 1
  UPDATE #TEMP SET pagina = @pagina WHERE contador=@Contador
  UPDATE #TEMP SET TotalPag = @pagina 
  IF @contador2=@nTotPagina
   SELECT @pagina  = @pagina + 1 ,
    @contador2 = 0
 END
  SELECT * FROM #TEMP, #PARAMETROS
  SET NOCOUNT ON
END
--select * from mdmo where motipoper = 'CP'
-- select * from view_aprobacion_operaciones order by Id_Sistema, NumeroOperacion 
--select * from view_aprobacion_operaciones  where Id_Sistema = 'BTR'
--delete view_aprobacion_operaciones  where Id_Sistema = 'BTR'
-- Sp_Papeletacp 97018000,49449,"P"

GO
