USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELETAVI_2]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PAPELETAVI_2]  ---97029000 ,40639 ,'C'
    (
    @nRutcart FLOAT  ,
    @nNumoper FLOAT  ,
    @cTipoImp CHAR (01)
    )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @tipcart VARCHAR (25) ,
         @nDiaSem INTEGER  ,
         @nDia  INTEGER  ,
         @nMes  INTEGER  ,
         @nAnn  INTEGER  ,
         @cFecEmi VARCHAR (40) ,
         @Forpac  VARCHAR (20) ,
         @Forpav  VARCHAR (20) ,
         @Tipocli VARCHAR (25) ,
         @Tipcli  NUMERIC (05) ,
         @Cust  VARCHAR (01) ,
         @Custodia VARCHAR (25) ,
         @Rutcli  NUMERIC (9,0) ,
         @Dig  VARCHAR (01) ,
         @Codcli  NUMERIC (9,0) ,
         @Nomcli  VARCHAR (40) ,
         @Dircli  VARCHAR (40) ,
         @Foncli  VARCHAR (15) ,
         @Faxcli  VARCHAR (15) ,
         @Nomoper VARCHAR (40) ,
         @Ret  VARCHAR (01) ,
         @hora  CHAR (08) ,
         @Retiro  VARCHAR (15) ,
         @Totalc  NUMERIC (19,4) ,
         @Totalv  NUMERIC (19,4) ,
         @Monpact CHAR (05) ,
         @monpacto NUMERIC (03,0) ,
         @monglo  CHAR (20) ,
         @Observ  CHAR (70) ,
         @valmon  NUMERIC (19,4) ,
         @nValIniP FLOAT  ,
         @nValVenP FLOAT  ,
         @nMtoVenta FLOAT  ,
         @MtoEsc  VARCHAR (200) ,
         @MtoEscf VARCHAR (200) ,
         @MtoRecompra FLOAT  ,
         @cFecVen VARCHAR (100) ,
         @comcli  CHAR (20) ,
         @Pagina  INTEGER  ,
         @nTotPagina INTEGER  ,
         @contador NUMERIC (19,0) ,
         @contador2 NUMERIC (19,0) ,
         @NumSol  NUMERIC (9,0) , 
         @linea1  CHAR (255) ,
         @linea2  CHAR (255) ,
         @linea3  CHAR (255) ,
         @linea4  CHAR (255) ,
         @linea5  CHAR (255) ,
         @glocopia CHAR (25) ,
         @nCopia  INTEGER  ,
         @cSettlement CHAR (50) ,
         @cPFE  CHAR (50) ,
         @cCCE  CHAR (50) ,
         @cEmisorInstPlazo CHAR (255) ,
         @CodForpac INTEGER  ,
         @Sucursal CHAR (50) ,
         @EstadoPeracion VARCHAR (100)

 SELECT 'acfecproc' = acfecproc  ,
        'acfecprox' = acfecprox  ,
        'uf_hoy'    = CONVERT(FLOAT,0) ,
        'uf_man'    = CONVERT(FLOAT,0) ,
        'ivp_hoy'   = CONVERT(FLOAT,0) ,
        'ivp_man' = CONVERT(FLOAT,0) ,
        'do_hoy' = CONVERT(FLOAT,0) ,
        'do_man' = CONVERT(FLOAT,0) ,
        'da_hoy' = CONVERT(FLOAT,0) ,
        'da_man' = CONVERT(FLOAT,0) ,
        'pmnomprop' = acnomprop  ,
        'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrutprop))+'-'+acdigprop
 INTO #PARAMETROS
 FROM MDAC
 UPDATE #PARAMETROS
 SET uf_hoy = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA
 WHERE vmfecha=acfecproc AND vmcodigo=998
 UPDATE #PARAMETROS
 SET uf_man = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA
 WHERE vmfecha=acfecprox AND vmcodigo=998
 UPDATE #PARAMETROS
 SET ivp_hoy = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA
 WHERE vmfecha=acfecproc AND vmcodigo=997
 UPDATE #PARAMETROS
 SET ivp_man = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA
 WHERE vmfecha=acfecprox AND vmcodigo=997
 UPDATE #PARAMETROS
 SET do_hoy = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA
 WHERE vmfecha=acfecproc AND vmcodigo=994
 UPDATE #PARAMETROS
 SET do_man = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA
 WHERE vmfecha=acfecprox AND vmcodigo=994
 UPDATE #PARAMETROS
 SET da_hoy = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA
 WHERE vmfecha=acfecproc AND vmcodigo=995
 UPDATE #PARAMETROS
 SET da_man = ISNULL(vmvalor,0.0)
 FROM VIEW_VALOR_MONEDA
 WHERE vmfecha=acfecprox AND vmcodigo=995
 IF @cTipoImp='P'
  SELECT @nCopia = papapimp FROM MDPA WHERE panumoper=  @nNumoper
 ELSE
  SELECT @nCopia = paconimp FROM MDPA WHERE panumoper= @nNumoper
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
  SELECT @nTotPagina = 9
 ELSE
  SELECT @nTotPagina = 15
  SELECT @Monpact  = ISNULL(mnnemo,'') ,
         @Monpacto = momonpact
  FROM MDMO LEFT OUTER JOIN VIEW_MONEDA ON momonpact = mncodmon
  WHERE monumoper = @nNumoper AND morutcart = @nRutcart AND motipoper = 'VI' 

-- REQ.7619 CASS 26-01-2011
-- FROM MDMO, VIEW_MONEDA
-- WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='VI' AND
--       momonpact*=mncodmon

 IF @monpacto=999
    SELECT @monglo = 'PESOS'
 IF @monpacto=998
    SELECT @monglo = 'UNIDADES DE FOMENTO'
 IF @monpacto=994
    SELECT @monglo = 'DOLARES'
 IF @monpacto=995
    SELECT @monglo = 'DOLARES'
 SELECT @Totalc = SUM(movalinip) ,
        @Totalv = SUM(movalvenp)
 FROM MDMO
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='VI'
 SELECT @tipcart = tbglosa 
 FROM VIEW_TABLA_GENERAL_DETALLE, MDMO
 WHERE tbcateg=204 AND CONVERT(NUMERIC(6),tbcodigo1)= motipcart AND monumoper=@nNumoper AND
        morutcart=@nRutcart AND motipoper='VI'
 SELECT @nDiaSem = DATEPART(WEEKDAY,mofecinip) ,
        @nDia    = DATEPART(DAY,mofecinip) ,
        @nMes    = DATEPART(MONTH,mofecinip) ,
        @nAnn    = DATEPART(YEAR,mofecinip)
 FROM MDMO
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='VI'
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

 SELECT @NumSol = monsollin
 FROM MDMO
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='VI'
 SELECT @linea2 = ' ' ,
        @linea3 = ' ' ,
        @linea4 = ' '
 SELECT @Forpac = glosa 
 FROM VIEW_FORMA_DE_PAGO, MDMO
 WHERE codigo=moforpagi AND monumoper=@nNumoper AND morutcart=@nRutcart AND
       motipoper='VI'

 SELECT @CodForpac = moforpagi
 FROM VIEW_FORMA_DE_PAGO, MDMO
 WHERE codigo=moforpagi AND monumoper=@nNumoper AND morutcart=@nRutcart AND
       motipoper='VI'

 SELECT @Forpav = glosa 
 FROM VIEW_FORMA_DE_PAGO, MDMO
 WHERE codigo=moforpagv AND monumoper=@nNumoper AND morutcart=@nRutcart AND
       motipoper='VI'

 SELECT @Cust        = ISNULL(mocondpacto,'')  ,
        @Observ      = ISNULL(moobserv,'')  ,
        @linea1      = ISNULL(moobserv2,'')  ,
        @Ret         = motipret   ,
        @nDiaSem     = DATEPART(WEEKDAY,mofecvenp) ,
        @nDia        = DATEPART(DAY,mofecvenp) ,
        @nMes        = DATEPART(MONTH,mofecvenp) ,
        @nAnn        = DATEPART(YEAR,mofecvenp) ,
        @Rutcli      = morutcli   ,
        @Codcli      = mocodcli   ,
        @Nomoper     = nombre ,
        @EstadoPeracion = CASE mostatreg
                                WHEN 'P' THEN 'OPERACION PENDIENTE DE APROBACION'
                            ELSE ''
                           END 
 FROM MDMO, VIEW_USUARIO
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='VI' AND
       mousuario=SUBSTRING(usuario,1,12)

 IF @Cust='S'
  SELECT @Custodia = 'Con Custodia'
 ELSE
  SELECT @Custodia = 'Sin Custodia'
        
 SELECT @Nomcli = clnombre  , 
        @Dircli = cldirecc  ,
        @Foncli = clfono    ,
        @Faxcli = clfax     ,
        @Codcli = clcodigo  ,
        @Tipcli = cltipcli  ,
        @Dig    = ISNULL(cldv,'') ,
        @comcli = (SELECT nom_ciu FROM VIEW_CIUDAD_COMUNA WHERE cod_pai=clpais AND cod_ciu=clciudad AND cod_com=clcomuna)
 FROM VIEW_CLIENTE
 WHERE clrut=@Rutcli AND clcodigo=@codcli

 SELECT @Tipocli = ISNULL(tbglosa ,'')
 FROM VIEW_TABLA_GENERAL_DETALLE
 WHERE tbcateg=207 AND CONVERT(INTEGER,tbcodigo1)=CONVERT(INTEGER,@Tipcli)

 IF @Ret='V'
  SELECT @Retiro = 'Vamos'
 ELSE
  SELECT @Retiro = 'Vienen'
  SELECT @nMtoVenta   = ISNULL(SUM(mocapitali),0) ,
         @MtoRecompra = ISNULL(SUM(movalvenp),0)
 FROM MDMO
 WHERE monumoper=@nNumoper AND morutcart=@nRutcart AND motipoper='VI'

        set @MtoEsc = ''

        if  @nMtoVenta > 0 
           EXECUTE SP_MONTOESCRITO_MONEDA @nMtoVenta, @MtoEsc OUTPUT, 999
        set @MtoEscf = ''        
        if  @MtoRecompra > 0 
            EXECUTE SP_MONTOESCRITO_MONEDA @MtoRecompra, @MtoEscf OUTPUT, @Monpacto 
       
        IF @nMes= 1 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Enero de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 2 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Febrero de '   +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 3 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Marzo de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 4 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Abril de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 5 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Mayo  de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 6 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Junio de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 7 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Julio de '     +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 8 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Agosto de '    +CONVERT(CHAR(4),@nAnn)
        IF @nMes= 9 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Septiembre de '+CONVERT(CHAR(4),@nAnn)
        IF @nMes=10 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Octubre de '   +CONVERT(CHAR(4),@nAnn) 
        IF @nMes=11 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Noviembre de ' +CONVERT(CHAR(4),@nAnn)
        IF @nMes=12 SELECT @cFecVen = CONVERT(CHAR(2),@nDia)+' de Diciembre de ' +CONVERT(CHAR(4),@nAnn)
        IF @nDiaSem=1 SELECT @cFecVen = 'Domingo '  + @cFecVen
        IF @nDiaSem=2 SELECT @cFecVen = 'Lunes '    + @cFecVen
        IF @nDiaSem=3 SELECT @cFecVen = 'Martes '   + @cFecVen
        IF @nDiaSem=4 SELECT @cFecVen = 'Miercoles '+ @cFecVen
        IF @nDiaSem=5 SELECT @cFecVen = 'Jueves '   + @cFecVen
        IF @nDiaSem=6 SELECT @cFecVen = 'Viernes '  + @cFecVen
        IF @nDiaSem=7 SELECT @cFecVen = 'Sabado '   + @cFecVen

 SELECT @valmon = 1.0
 SELECT @valmon = vmvalor
 FROM VIEW_VALOR_MONEDA, MDMO
 WHERE vmcodigo=momonpact AND vmfecha=mofecinip AND monumoper=@nNumoper AND
  morutcart=@nRutcart AND motipoper='VI'

 IF @valmon = NULL
  SELECT @valmon = 1
 CREATE TABLE #paso_error (  Mensaje_Error       VARCHAR(255),
                             Monto               NUMERIC(19,4),
                             sw                  CHAR(1),
                             NumeroCorre_Detalle NUMERIC(19,0) Identity(1,1))
 INSERT INTO #paso_error
 SELECT Mensaje_Error, MontoExceso, 'N'
 FROM view_linea_transaccion_detalle
 WHERE NumeroOperacion = @nnumoper
       AND id_sistema = 'BTR'
       AND Mensaje_Error <> ''
 INSERT INTO #paso_error
 SELECT Mensaje, Monto, 'N'
 FROM view_limite_transaccion_error
 WHERE NumeroOperacion = @nnumoper
       AND id_sistema = 'BTR'
 DECLARE @NumeroCorre_Detalle INTEGER
 DECLARE @nMontoError         NUMERIC(19,4)
 DECLARE @cMontoFMT           CHAR(20)
 WHILE 1=1
 BEGIN
  SET ROWCOUNT 1
  SELECT @NumeroCorre_Detalle = 0
  SELECT @NumeroCorre_Detalle = NumeroCorre_Detalle,
         @nMontoError         = Monto
  FROM #paso_error
  WHERE sw='N'
  SET ROWCOUNT 0
  IF @NumeroCorre_Detalle = 0 BREAK
  EXECUTE sp_retorna_monto_formateado @nMontoError, 0, @cMontoFMT OUTPUT
  UPDATE #paso_error
  SET  Mensaje_Error = LTRIM(RTRIM(Mensaje_Error)) + '  ' + @cMontoFMT,
       sw='S'
  WHERE @NumeroCorre_Detalle = NumeroCorre_Detalle
 END

 SELECT @linea1 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 1
 SELECT @linea2 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 2
 SELECT @linea3 = Mensaje_Error FROM #paso_error WHERE NumeroCorre_Detalle = 3

 IF EXISTS(SELECT operador_ap_LINEAS FROM VIEW_APROBACION_OPERACIONES, MDAC WHERE id_sistema='BTR' AND NumeroOperacion=@nNumoper AND FechaOperacion=acfecproc)
 BEGIN
  SELECT @EstadoPeracion = CASE Estado
                              WHEN 'A' THEN 'OPERACION APROBADA POR :   '  + Operador_Ap_LINEAS
                              WHEN 'P' THEN 'OPERACION RECHAZADA POR :   ' + Operador_Ap_LINEAS
                             ELSE ''
                            END
  FROM VIEW_APROBACION_OPERACIONES, MDAC
  WHERE id_sistema='BTR' AND NumeroOperacion=@nNumoper AND FechaOperacion=acfecproc
 END
 SELECT @Sucursal = CASE WHEN @CodForpac > 20 THEN @Forpac ELSE '' END

 SELECT 'serie'         = ISNULL(moinstser,'')      ,
        'nomemp'        = ISNULL(acnomprop,'')      ,
        'nominal'       = ISNULL(SUM(monominal),0)  ,
        'ValInip'       = ISNULL(SUM(movalinip),0)  ,
        'Pagina'        = 0        
        
 INTO #TEMP
 FROM MDAC
, MDMO LEFT OUTER JOIN VIEW_EMISOR ON morutemi = emrut
	   LEFT OUTER JOIN VIEW_MONEDA ON momonemi = mncodmon
 WHERE morutcli = @nRutcart 
AND monumoper = @nNumoper 
AND motipoper ='VI' 


-- REQ .7619 CASS 26-01-2011
-- FROM MDAC, MDMO, VIEW_EMISOR , VIEW_MONEDA
-- WHERE morutcli = @nRutcart AND monumoper=@nNumoper AND motipoper='VI' AND
--       morutemi*=emrut AND momonemi*=mncodmon

GROUP BY moinstser,acnomprop


/*
SELECT NOMEMP,
       SUM(NOMINAL),
       SUM(ValInip),
       serie
INTO #TEMP_2
FROM #TEMP
GROUP BY NOMEMP,serie
*/
-- ORDER BY mocorrela
-- SELECT @contador   = 0 ,
--        @contador2  = 0 ,
--        @pagina     = 1

 /*
 WHILE @pagina<>0
 BEGIN
  SET ROWCOUNT 1
  SELECT @tipcart = '*'
  SELECT @tipcart  = tipcart ,
         @contador = contador
  FROM #TEMP 
  WHERE contador>@contador 
  ORDER BY contador
  SET ROWCOUNT 0
  IF @tipcart='*'
   BREAK
  
  SELECT @contador2 = @contador2 + 1
  UPDATE #TEMP SET pagina = @pagina WHERE contador=@Contador
  UPDATE #TEMP SET TotalPag = @pagina
  IF @contador2 = @nTotPagina
   SELECT  @pagina    = @pagina + 1 ,
           @contador2 = 0
 END
*/
 SELECT * FROM #TEMP, #PARAMETROS
        

END
-- sp_papeletavi 97018000,49239,'C'
-- sp_autoriza_ejecutar 'BACUSER'
  
--  dbo.Sp_Papeletavi_2  97029000,40633,'C'

--  dbo.Sp_Papeletavi_2  97029000 ,40639 ,'C'

GO
