USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[sp_papeleta_FPD]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_papeleta_FPD]
      ( 
	@nRutcart  NUMERIC (09,0) ,
	@nNumoper  NUMERIC (10,0) ,
    	@cTipoImp  CHAR(01)       ,
        @Operacion CHAR(05)       ,
        @xfecha    CHAR(10)       
      )
AS
BEGIN

   SET TRANSACTION ISOLATION LEVEL READ COMMITTED
   SET DATEFORMAT dmy
   SET DATEFIRST 1
   SET NOCOUNT ON

   DECLARE @Fecha_proceso      CHAR   (10)
      ,    @Fecha_proxima      CHAR   (10)
      ,    @Nombre_entidad      CHAR   (40)
      ,    @rut_empresa    CHAR   (12)
      ,    @hora1          CHAR   (08)
      ,    @TipoEvento     CHAR   (10)
      ,    @uf_hoy         NUMERIC(21,04)
      ,    @uf_man         NUMERIC(21,04)
      ,    @ivp_hoy        NUMERIC(21,04)
      ,    @ivp_man        NUMERIC(21,04)
      ,    @do_hoy         NUMERIC(21,04)
      ,    @do_man         NUMERIC(21,04)
      ,    @da_hoy         NUMERIC(21,04)
      ,    @da_man         NUMERIC(21,04)
      ,    @TotalPaginas   INTEGER
      ,    @fecha          DATETIME
      ,    @Fecha_Vcto     DATETIME
      ,    @cAquien        VARCHAR(50)
      ,    @cDesde         VARCHAR(50)
   
   DECLARE 	@nDiaSem 		INTEGER  ,
  		@nDia  			INTEGER  ,
  		@nMes  			INTEGER  ,
  		@nAnn  			INTEGER  ,
		@nDia1  		INTEGER  ,
  		@nMes1  		INTEGER  ,
		@nAnn1  		INTEGER  ,
		@cFecEmis 		CHAR (40) ,
		@cFecVens 		CHAR (40) ,
		@cFecEmi 		CHAR (40) ,
		@cFecVen 		CHAR (40) ,
		@Forpai  		CHAR (25)  ,
                @apoderado1             char (40),
                @apoderado2             char (40),
                @rutapo1                numeric(9),
                @rutapo2                numeric(9),
                @dvapo1                 char(1),
                @dvapo2                 char(1),
                @apoderado              char (40),
		@Forpav  		CHAR (25) ,
		@Cust  			CHAR (01) ,
		@Custodia 		CHAR (25) ,
		@Rutcli 		NUMERIC (9,0) ,
                @codcli 		NUMERIC (1) ,
		@Dig  			CHAR (01) ,
		@Nomcli  		CHAR (40) ,
		@Dircli  		CHAR (40) ,
                @Tipocli 	        VARCHAR (25) 	,
  		@Tipcli  	        NUMERIC (05) 	,
                @fono                   char (30),
                @fax                    char (30),
		@Nomoper 		CHAR (40) ,
		@Ret  			CHAR (01) ,
		@Retiro  		CHAR (15) ,
		@nRutcar 		NUMERIC (09,0) ,
		@nomemp  		CHAR (40) ,
		@rutpro  		NUMERIC(11) ,
                @dvpro                  CHAR(1),
		@fecpro  		CHAR (10) ,
		@monpac  		CHAR (05) ,
  		@mtoesc  		CHAR (170) ,
  		@mtoescI 		CHAR (170) ,
  		@TotalC  		NUMERIC (19,4) ,
		@IntESC  		CHAR (170) ,
  		@Interes 		NUMERIC (19,4) ,
		@Obser  		CHAR (58) ,
		@NumSol  		NUMERIC (9,0) ,
		@linea1  		CHAR (65) ,
		@linea2  		CHAR (65) ,
		@linea3  		CHAR (65) ,
		@linea4  		CHAR (65) ,
		@linea5  		CHAR (65) ,
		@glocopia		CHAR (25) ,
		@nCopia  		INTEGER  ,
		@nMoneda 		INTEGER  ,
                @valmon  	        NUMERIC (19,4),
		@nValinip 		NUMERIC (19,4) ,
		@nValvtop 		NUMERIC (19,4) ,
		@hora  			CHAR(8) ,
		@nValmon 		NUMERIC (19,4) ,
		@dFecinip 		DATETIME ,
		@cMonLet 		CHAR (120) ,
		@cPalab1 		CHAR (115) ,
		@cPalab2 		CHAR (115) ,
		@cValinip		CHAR (20) ,
		@cInteres		CHAR (20) ,
		@cDato  		CHAR (01) ,
		@nLargo  		INTEGER  ,
		@nMtopal 		NUMERIC (19,4) ,
		@cSettlement 		CHAR(50) ,
		@cPFE  			CHAR(50) ,
		@cCCE  			CHAR(50) ,
		@cEmisorInstPlazo 	CHAR(255),
		@xMiinstser 		CHAR(12),
  		@fecven 		DATETIME,
		@Diremp 		CHAR(40),
                @sector          char(10),
                @oficina                char(10),
                @centrocosto            char(10),
                @fechaproceso DATETIME

   SELECT @fecha          =  CONVERT(DATETIME,@xfecha,112)

   EXECUTE Sp_Base_Del_Informe
           @Fecha_proceso   	OUTPUT  ,
           @Fecha_proxima   	OUTPUT  ,
           @uf_hoy      	OUTPUT  ,
	   @uf_man      	OUTPUT  ,
           @ivp_hoy     	OUTPUT  ,
           @ivp_man     	OUTPUT  ,
           @do_hoy      	OUTPUT  ,
           @do_man      	OUTPUT  ,
           @da_hoy      	OUTPUT  ,
	   @da_man      	OUTPUT  ,
           @Nombre_entidad   	OUTPUT  ,
           @rut_empresa 	OUTPUT  ,
           @hora1        	OUTPUT ,
           @fecha
                   

   /*======================================== MENSAJES LINEAS ==========================================*/


   DECLARE   @nNum_Opera   NUMERIC(9)
         ,   @cSistema     CHAR(3)
         ,   @cMargen_1    CHAR(100) 
         ,   @cMargen_2    CHAR(100) 
         ,   @cTraspaso_1  CHAR(100) 
         ,   @cTraspaso_2  CHAR(100) 
         ,   @cSobreGiro_1 CHAR(100) 
         ,   @cSobreGiro_2 CHAR(100) 


    SELECT   @cMargen_1    = ''
         ,   @cMargen_2    = ''
         ,   @cTraspaso_1  = ''
         ,   @cTraspaso_2  = ''
         ,   @cSobreGiro_1 = ''
         ,   @cSobreGiro_2 = ''

         ,   @cSistema     = 'BTR'
         ,   @nNum_Opera   = @nNumOper

   IF @fecha = ( SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES ) 
   BEGIN

       EXEC Sp_Papeletas_Mensajes_Lineas
                                        @nNum_Opera   
                                    ,   @cSistema     
                                    ,   @cMargen_1    OUTPUT
                                    ,   @cMargen_2    OUTPUT
                                    ,   @cTraspaso_1  OUTPUT
                                    ,   @cTraspaso_2  OUTPUT
                                    ,   @cSobreGiro_1 OUTPUT
                                    ,   @cSobreGiro_2 OUTPUT
   END 



   /*===================================================================================================*/



   SET @fechaproceso = ( SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES ) 




 		IF @cTipoImp='P'
  			SELECT @nCopia = 1
		ELSE
			SELECT @nCopia = 1
 
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
 			SELECT 	@nDiaSem	= DATEPART(WEEKDAY,mofecinip) ,
 				@nDia  		= DATEPART(DAY,mofecinip) ,
  				@nMes  		= DATEPART(MONTH,mofecinip) ,
  				@nAnn  		= DATEPART(YEAR,mofecinip) ,
  				@nDia1  	= DATEPART(DAY,mofecinip) ,
  				@nMes1  	= DATEPART(MONTH,mofecinip) ,
	  			@nAnn1  	= DATEPART(YEAR,mofecinip) ,
  				@dFecinip 	= mofecinip   ,
				@NumSol  	= monsollin   ,
  				@Obser  	= moobserv   ,
  				@nMoneda	= momonpact   ,
				@hora  		= mohora   ,
				@xMiinstser 	= moinstser 
			FROM 	MOVIMIENTO_TRADER WITH (NOLOCK) 
			WHERE 	monumoper	= @nNumoper 
			   AND  morutcart	= @nRutcart 
			   AND  motipoper	= @Operacion
                           AND   CONVERT(CHAR(10),mofecpro,112)  = CONVERT(CHAR(10),@fecha,112)
	
 IF @nMes =  1   SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Enero de '      + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  2   SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Febrero de '    + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  3   SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Marzo de '      + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  4   SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Abril de '      + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  5   SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Mayo de '       + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  6   SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Junio de '      + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  7   SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Julio de '      + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  8   SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Agosto de '     + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  9   SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Septiembre de ' + CONVERT(CHAR(4),@nAnn)
 IF @nMes = 10   SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Octubre de '    + CONVERT(CHAR(4),@nAnn)
 IF @nMes = 11   SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Noviembre de '  + CONVERT(CHAR(4),@nAnn)
 IF @nMes = 12   SELECT @cFecEmis = CONVERT(CHAR(2),@nDia) + ' de Diciembre de '  + CONVERT(CHAR(4),@nAnn)

 IF @nDiaSem = 7 SELECT @cFecEmis = 'Domingo '   + @cFecEmis
 IF @nDiaSem = 1 SELECT @cFecEmis = 'Lunes '     + @cFecEmis
 IF @nDiaSem = 2 SELECT @cFecEmis = 'Martes '    + @cFecEmis
 IF @nDiaSem = 3 SELECT @cFecEmis = 'Miercoles ' + @cFecEmis
 IF @nDiaSem = 4 SELECT @cFecEmis = 'Jueves '    + @cFecEmis
 IF @nDiaSem = 5 SELECT @cFecEmis = 'Viernes '   + @cFecEmis
 IF @nDiaSem = 6 SELECT @cFecEmis = 'Sabado '  + @cFecEmis





	SELECT  @nDiaSem = DATEPART(WEEKDAY,mofecvenp) ,
  		@nDia    = DATEPART(DAY,mofecvenp) ,
		@nMes    = DATEPART(MONTH,mofecvenp) ,
  		@nAnn    = DATEPART(YEAR,mofecvenp) ,
		@nDia1   = DATEPART(DAY,mofecvenp) ,
		@nMes1   = DATEPART(MONTH,mofecvenp) ,
		@nAnn1   = DATEPART(YEAR,mofecvenp) ,
		@fecven  = MOFECVENP
	FROM    MOVIMIENTO_TRADER WITH (NOLOCK) 
 	WHERE   monumoper= @nNumoper 
 	 AND    morutcart= @nRutcart 
	 AND    motipoper= @Operacion
         AND   CONVERT(CHAR(10),mofecpro,112)  = CONVERT(CHAR(10),@fecha,112)

 IF @nMes =  1  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Enero de '      + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  2  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Febrero de '    + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  3  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Marzo de '      + CONVERT(CHAR(4),@nAnn) 
 IF @nMes =  4  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Abril de '      + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  5  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Mayo de '       + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  6  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Junio de '      + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  7  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Julio de '      + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  8  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Agosto de '     + CONVERT(CHAR(4),@nAnn)
 IF @nMes =  9  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Septiembre de ' + CONVERT(CHAR(4),@nAnn)
 IF @nMes = 10  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Octubre de '    + CONVERT(CHAR(4),@nAnn)
 IF @nMes = 11  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Noviembre de '  + CONVERT(CHAR(4),@nAnn)
 IF @nMes = 12  SELECT @cFecVens = CONVERT(CHAR(2),@nDia) + ' de Diciembre de '  + CONVERT(CHAR(4),@nAnn)

 IF @nDiaSem = 7 SELECT @cFecVens = 'Domingo '   + @cFecVens
 IF @nDiaSem = 1 SELECT @cFecVens = 'Lunes '     + @cFecVens
 IF @nDiaSem = 2 SELECT @cFecVens = 'Martes '    + @cFecVens
 IF @nDiaSem = 3 SELECT @cFecVens = 'Miercoles ' + @cFecVens
 IF @nDiaSem = 4 SELECT @cFecVens = 'Jueves '    + @cFecVens
 IF @nDiaSem = 5 SELECT @cFecVens = 'Viernes '   + @cFecVens
 IF @nDiaSem = 6 SELECT @cFecVens = 'Sabado '    + @cFecVens
        

    SELECT @cAquien = '',@cDesde = ''
 
    SELECT @cAquien = a.nombre,
           @cDesde  = b.nombre
    FROM VIEW_CORRESPONSAL A,MOVIMIENTO_TRADER WITH (NOLOCK) ,VIEW_CORRESPONSAL B ,VIEW_DATOS_GENERALES
    WHERE morutcli         = a.rut_cliente
    AND   mocodcli         = a.codigo_cliente
    AND   a.codigo_swift   = swift_pagamos
    AND   b.rut_cliente    = rut_entidad
    AND   b.codigo_cliente = codigo_entidad 
    AND   b.codigo_swift   = swift_corresponsal
    AND   monumoper        = @nnumoper        
      
 SELECT @TotalC   = movalinip,
  	@nValinip = movalinip,
  	@Cust     = mocondpacto,
  	@Rutcli   = morutcli,
        @codcli   = mocodcli,
	@Ret      = motipret,

	@Interes  = CASE WHEN momonpact = 999  THEN ROUND(movalvenp - movalinip,0)
                         WHEN momonpact <> 999 THEN ROUND(movalvenp - movalinip,4)
          END,
	@nValvtop = movalvenp
 FROM   MOVIMIENTO_TRADER WITH (NOLOCK) 
 WHERE  monumoper = @nNumoper 
 AND    morutcart = @nRutcart 
 AND    motipoper = @Operacion
 AND    mofecpro  = @fecha

 SELECT @Monpac   = mnnemo
 FROM 	VIEW_MONEDA, MOVIMIENTO_TRADER WITH (NOLOCK) 
 WHERE 	morutcart = @nRutcart 
  AND   monumoper = @nNumoper 
  AND   motipoper = @Operacion
  AND   momonpact = mncodmon
  AND   CONVERT(CHAR(10),mofecpro,112)  = CONVERT(CHAR(10),@fecha,112)

 IF @nmoneda  = 999 
  	SELECT @cMonLet  = 'pesos   m/l,   por  concepto   de   intereses,   que   me   obligo   a   pagar    en   esta   ciudad,  calle' 
 ELSE
 IF @nmoneda  = 13 
   	SELECT @cMonLet  = 'dolares  m/l,  por concepto   de   intereses,  que   me   obligo   a   pagar   en   esta  ciudad,  calle'
 	SELECT  @nMtopal = @TotalC
 
 IF @nMoneda<>999 AND @nmoneda <>13
 BEGIN
  	SELECT @nValmon  = ISNULL(vmvalor,0.0) FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nMoneda AND vmfecha=@dfecinip
  	SELECT @nValinip = ROUND(@TotalC/@nValmon,4)
  	SELECT @Interes  = @nValvtop - @nValinip  ,
   		@nMtopal = @nValinip
	IF @nmoneda=998
   		SELECT @cMonlet = 'unidades de fomento m/l,  por concepto de  intereses,  que  me  obligo  a  pagar  en  esta  ciudad, calle'
  	ELSE
   		SELECT @cMonLet = 'dolares  m/l,  por concepto   de   intereses,  que   me   obligo   a   pagar   en   esta  ciudad,  calle'
 	END
 	SELECT @cValinip = CONVERT(CHAR,@nValinip)
	SELECT @nLargo   = DATALENGTH(SUBSTRING(@cValinip,1,CHARINDEX('.',@cValinip)-1))
	SELECT @cValinip = STUFF(@cValinip,CHARINDEX('.',@cValinip),1,',')
 	WHILE  @nLargo-3>0
 	BEGIN 
  		SELECT @cDato = SUBSTRING(@cValinip,@nLargo-3,1)
  	IF @cDato<>''
   		SELECT @cValinip = STUFF(@cValinip, @nLargo-3,1,@cDato+'.')
  		SELECT @nLargo   = DATALENGTH(SUBSTRING(@cValinip,1,CHARINDEX('.',@cValinip)-1))
 	END
 		SELECT @cInteres = CONVERT(CHAR,@Interes)
 		SELECT @nLargo   = DATALENGTH(SUBSTRING(@cInteres,1,CHARINDEX('.',@cInteres)-1))
                SELECT @cInteres = STUFF(@cInteres,CHARINDEX('.',@cInteres),1,',')
        WHILE  @nLargo-3>0
 	BEGIN
  		SELECT @cDato    = SUBSTRING(@cInteres,@nLargo-3,1)
  		IF @cDato<>''
   			SELECT @cInteres = STUFF(@cInteres, @nLargo-3,1,@cDato+'.')
  			SELECT @nLargo = DATALENGTH(SUBSTRING(@cInteres,1,CHARINDEX('.',@cInteres)-1))
	END
	IF @nMoneda=999  
        BEGIN
           SELECT @cPalab1 = 'la suma de $ '+@cValinip+'.-'
              ,   @cPalab2 = 'pesos m/l,por concepto de capital, más la suma de $  ' + @cInteres
        END ELSE BEGIN
           SELECT @cPalab1 = 'la suma de dinero equivalente en pesos moneda legal de ' + RTRIM(@Monpac) + ' ' + @cValinip + '.-'
              ,   @cPalab2 = CASE WHEN @nMoneda = 998 THEN
   			        'unidades de fomento, por concepto de capital, más la suma de  UF ' + @cInteres
                             ELSE
   			        'dólares, por concepto de capital, más la suma de U$ '+@cInteres
                             END
	END               

   SELECT @Forpai = glosa
   FROM   VIEW_FORMA_DE_PAGO
      ,   MOVIMIENTO_TRADER WITH (NOLOCK) 
   WHERE  codigo    = moforpagi
     AND  monumoper = @nNumoper 
     AND  morutcart = @nRutcart 
     AND  motipoper = @Operacion
     AND  mofecpro  = @fecha

   SELECT @Forpav = glosa
   FROM   VIEW_FORMA_DE_PAGO
      ,   MOVIMIENTO_TRADER WITH (NOLOCK) 
   WHERE  codigo    = moforpagv 
     AND  monumoper = @nNumoper 
     AND  morutcart = @nRutcart 
     AND  motipoper = @Operacion
     AND  mofecpro  = @fecha

   SELECT @Custodia = CASE WHEN @Cust = 'S' THEN
                         'Con Custodia'
                      ELSE
                         'Sin Custodia'
                      END         
 
   SELECT @Nomcli  = clnombre
      ,   @Dircli  = cldirecc
      ,   @Dig     = cldv
      ,   @Fono    = clfono
      ,   @fax     = clfax
      ,   @tipcli  = cltipcli
   FROM   VIEW_CLIENTE
   WHERE  clrut    = @Rutcli
     AND  clcodigo = @codcli
/* 
   SELECT @apoderado1 = apnombre
      ,   @rutapo1    = aprutapo
      ,   @dvapo1     = apdvapo
   FROM   VIEW_CLIENTE_APODERADO
      ,   VIEW_ENTIDAD
   WHERE  rcrut       = aprutcli
     AND  rccodcar    = apcodcli
     AND  aprutapo    = @Rut_Apo1

   SELECT @apoderado2 = apnombre
      ,   @rutapo2    = aprutapo
      ,   @dvapo2     = apdvapo
   FROM   VIEW_CLIENTE_APODERADO
      ,   VIEW_ENTIDAD
   WHERE  rcrut       = aprutcli
     AND  rccodcar    = apcodcli
     AND  aprutapo    = @Rut_Apo2
*/  
   SELECT @Tipocli = ISNULL(descripcion ,'')
   FROM VIEW_TIPO_CLIENTE
   WHERE CONVERT(INTEGER,codigo_tipo_cliente)=CONVERT(INTEGER,@Tipcli)

 SELECT @Nomoper = mousuario
 FROM   MOVIMIENTO_TRADER WITH (NOLOCK) 
 WHERE  morutcart = @nRutcart 
 AND    monumoper = @nNumoper 
 AND    motipoper = @Operacion
 AND   CONVERT(CHAR(10),mofecpro,112)  = CONVERT(CHAR(10),@fecha,112)
         
 IF @Ret='V'
  SELECT @Retiro = 'Vamos'
 ELSE
  SELECT @Retiro = 'Vienen'

        
 SELECT @nomemp = ISNULL(Nombre_entidad,'')      ,
	@Diremp = ISNULL(Direccion_entidad,''), 
  	@rutpro = ISNULL(Rut_entidad,0),
        @dvpro  = ISNULL(Digito_entidad,''), 
  	@fecpro = ISNULL(CONVERT(CHAR(10),Fecha_proceso,103),''),
        @sector = 0,
        @oficina= 0,
        @centrocosto= 0
 FROM VIEW_DATOS_GENERALES

--  EXECUTE Sp_montoescrito @nMtopal, @Mtoesc OUTPUT

 EXECUTE Sp_montoescrito @totalc,  @mtoesc OUTPUT
 EXECUTE Sp_montoescrito @interes, @Intesc OUTPUT

 
      SELECT @cFecVens = RTRIM(CONVERT(CHAR(2),@nDia1)) + '/'  + RTRIM(CONVERT(CHAR(4),@NMES1))+ '/' + RTRIM(CONVERT(CHAR(4),@NANN1))
         
   SELECT @Fecha_Vcto = mofecvenp
      ,   @TipoEvento = CASE WHEN mofecvenp > @fecha THEN --AL INICIO
                           CASE WHEN @Operacion = 'IB' THEN
                                   CASE WHEN moinstser = 'ICOL' THEN
                                      CASE WHEN moforpagi = 2 THEN 'EGRESO'  WHEN moforpagi = 1 THEN 'EGRESO'  ELSE '' END
                                   ELSE
                                      CASE WHEN moforpagi = 2 THEN 'INGRESO' WHEN moforpagi = 1 THEN 'INGRESO' ELSE '' END
                                   END
                                WHEN @Operacion = 'LBC' THEN
                                   CASE WHEN moforpagi = 7 THEN 'TRASPASO' ELSE '' END
                                WHEN @Operacion = 'TD' THEN
                                    ''
                           END

                        ELSE                             --AL VCTO.

                           CASE WHEN @Operacion = 'IB' THEN
                                   CASE WHEN moinstser = 'ICOL' THEN
                                      CASE WHEN moforpagv = 2 THEN 'INGRESO' WHEN moforpagv = 1 THEN 'INGRESO' ELSE '' END
                                 ELSE
                        CASE WHEN moforpagv = 2 THEN 'EGRESO'  WHEN moforpagv = 1 THEN 'EGRESO'  ELSE '' END
                                   END
                                WHEN @Operacion = 'LBC' THEN
                                   CASE WHEN moforpagv = 7 THEN 'TRASPASO' ELSE '' END
                                WHEN @Operacion = 'TD' THEN
                                    ''
                           END
                        END
   FROM   MOVIMIENTO_TRADER WITH (NOLOCK) 
   WHERE  morutcart = @nRutcart 
     AND  monumoper = @nNumoper
     AND  motipoper = @Operacion
     AND  mofecpro  = @fecha

   SELECT 'nomemp' 	= ISNULL(@nomemp,' ')
      ,   'rutemp' 	= ISNULL(@rutpro,' ')
      ,   'dvemp' 	= ISNULL(@dvpro,' ')
      ,   'diremp' 	= ISNULL(@diremp,' ')
      ,   'fecpro' 	= CONVERT(CHAR(10),mofecpro,103) 
      ,   'nomope' 	= ISNULL(@Nomoper,' ')
      ,   'nominal'	= ISNULL(movpresen,0)
      ,   'Mtoesc' 	= ISNULL(SUBSTRING(@mtoesc,1,120),' ')
      ,   'numdocu'	= CONVERT(CHAR(12),REPLICATE('0', 8 - LEN(LTRIM(STR(monumoper)))) + LTRIM(STR(monumoper)) + '-'
                              + REPLICATE('0', 3 - LEN(LTRIM(STR(mocorrela)))) + LTRIM(STR(mocorrela)))
      ,   'mtofin' 	= ISNULL(movalvenp,0)/*CASE WHEN momonpact = 998 THEN
                                  ISNULL(movalvenp,0) * (CASE WHEN (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE mofecvenp = vmfecha and momonpact = vmcodigo) = 0 THEN @uf_hoy
                                                         ELSE (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE mofecvenp = vmfecha and momonpact = vmcodigo)
                                                         END)
                               WHEN momonpact = 994 THEN
                                  ISNULL(movalvenp,0) * (CASE WHEN (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE mofecvenp=vmfecha and momonpact=vmcodigo)=0 THEN @do_hoy
                                                         ELSE (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE mofecvenp=vmfecha and momonpact=vmcodigo)
                                                         END)
                               WHEN momonpact = 995 THEN
                                  ISNULL(movalvenp,0) * (CASE WHEN (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE mofecvenp=vmfecha and momonpact=vmcodigo)=0 THEN @do_hoy
                                                         ELSE (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE mofecvenp=vmfecha and momonpact=vmcodigo)
                                                         END)
                               ELSE ISNULL(movalvenp,0)
                          END*/
      ,   'montofin'    = (SELECT SUM(ISNULL(movalvenp,0)) FROM MOVIMIENTO_TRADER WITH (NOLOCK)  WHERE monumoper = @nNumoper AND mofecpro = @fecha)
      ,   'Tir'  	= ISNULL(motaspact,0)
      ,   'fecvto' 	= ISNULL(CONVERT(CHAR(10),mofecvenp,103),' ')
      ,   'plazo'       = CONVERT(CHAR(05),ISNULL(DATEDIFF(DAY,mofecinip,mofecvenp),0) )
      ,   'interes' 	= ISNULL(@Interes,0)
      ,   'nomcli' 	= ISNULL(@Nomcli,' ')
      ,   'dircli' 	= ISNULL(@Dircli,' ')
      ,   'fonocli'     = ISNULL(@fono,' ')
      ,   'faxcli'      = ISNULL(@fax,' ')
      ,   'tipcli' 	= ISNULL(@Tipocli,' ')
      ,   'forpai' 	= ISNULL(@forpai,' ')
      ,   'CtaCte' 	= CONVERT(CHAR(10),'0')
      ,   'rutcli' 	= ISNULL(@Rutcli,0)
      ,   'dig'         = ISNULL(@Dig,' ')
      ,   'custodia' 	= ISNULL(@Custodia,' ')
      ,   'apoderado'   = ISNULL(@apoderado1,' ')
      ,   'rutapo'      = ISNULL(@rutapo1,0)
      ,   'dvapo'       = ISNULL(@dvapo1,' ')
      ,   'forpav' 	= ISNULL(@forpav,' ')
      ,   'tipret' 	= ISNULL( @Retiro,' ')
      ,   'Numoper' 	= monumoper
      ,   'serie'  	= ISNULL(moinstser,' ')
      ,   'titulo' 	= 'FACILIDAD PERMANENTE DE DEPOSITO'
      ,   'Monpacto' 	= ISNULL(mnnemo,' ')
      ,   'glomon' 	= ISNULL(mnglosa,' ')
      ,   'Base'  	= ISNULL(CONVERT(CHAR(03),mobaspact),' ')
      ,   'fecemi' 	= ISNULL(@cFecEmis,' ')
      ,   'fecven' 	= ISNULL(CONVERT(char(10),@Fecven,103),' ')
      ,   'interesesc' 	= ISNULL(@intesc,' ')
      ,   'Obser'  	= ISNULL(@Obser,' ')
      ,   'Linea1' 	= ISNULL(@linea1,' ')
      ,   'Linea2' 	= ISNULL(@linea2,' ')
      ,   'Linea3' 	= ISNULL(@linea3,' ')
      ,   'Linea4' 	= ISNULL(@linea4,' ')
      ,   'Linea5' 	= ISNULL(@linea5,' ')
      ,   'copia'  	= ISNULL(@glocopia,' ')
      ,   'valinium' 	= ISNULL(movalinip / (CASE WHEN mnextranj = "0" or momonpact = 999 THEN 1 ELSE 
                          (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE mofecinip = vmfecha and momonpact = vmcodigo)END) ,0)
      ,   'valor'   = (SELECT SUM(ISNULL(movalinip,0.0)) FROM MOVIMIENTO_TRADER WITH (NOLOCK)  WHERE monumoper = @nNumoper AND mofecpro = @fecha)
      ,   'palabras' 	= ISNULL(@cMonlet,' ')
      ,   'palab1' 	= ISNULL(@cPalab1,' ')
      ,   'palab2' 	= ISNULL(@cPalab2,' ')
      ,   'hora'  	= CONVERT(CHAR(10),GETDATE(),108)
      ,   'Lim_Settle' 	= @cSettlement
      ,   'Lim_EMIPLZ' 	= @cEmisorInstPlazo
      ,   'Estado'	= CASE mostatreg WHEN 'A' THEN 'ANULADO' ELSE CASE WHEN @fecven = @fecha /*@fechaproceso*/ THEN 'VENCIMIENTO' ELSE ' ' END END
      ,   'sector'      = @sector
      ,   'oficina'     = @oficina
      ,   'centrocosto' = @centrocosto
      ,   'apoderado2'  = ISNULL(@apoderado2,' ')
      ,   'rut_apod2'   = ISNULL(@rutapo2,0)
 ,   'dv_apo2'     = ISNULL(@dvapo2,' ')
      ,   'tipo'        = @TipoEvento
      ,   'NumReg'      = IDENTITY(INT)
      ,   'Corte'       = CONVERT(INTEGER,0)
      ,   'fech_opera'  = SUBSTRING(mohora,1,8)
      ,   'fech_emision'= CONVERT(CHAR(10),GETDATE(),103)
      ,   'cMargen_1'          = @cMargen_1    

      ,   'cMargen_2'          = @cMargen_2    
      ,   'cTraspaso_1'        = @cTraspaso_1  
      ,   'cTraspaso_2'        = @cTraspaso_2  
      ,   'cSobreGiro_1'       = @cSobreGiro_1 
      ,   'cSobreGiro_2'       = @cSobreGiro_2 
      ,   'cAquien'      = @cAquien
      ,   'cDesde'       = @cDesde
   INTO   #TEMP1
   FROM   MOVIMIENTO_TRADER WITH (NOLOCK) 
      ,   VIEW_MONEDA
   WHERE  morutcart = @nRutcart 
     AND  monumoper = @nNumoper 
     AND  motipoper = @Operacion
     AND  momonpact = mncodmon
     AND  mofecpro  = @fecha

   IF (SELECT Monpacto FROM #TEMP1) = 'UF'
      SELECT @interes = ROUND(montofin - valor,4) 
      FROM   #TEMP1
   ELSE
      SELECT @interes = ROUND(montofin - valor,0) 
      FROM #TEMP1

   EXECUTE Sp_montoescrito @interes, @Intesc OUTPUT 

   UPDATE #TEMP1
   SET    interesesc =  ISNULL(@Intesc,' ')

   SELECT @TotalPaginas = CASE WHEN (@@ROWCOUNT % 15) = 0 THEN @@ROWCOUNT / 15 ELSE (@@ROWCOUNT / 15) + 1 END

   UPDATE #TEMP1 SET Corte = CASE WHEN (NumReg % 15) = 0 THEN NumReg / 15 ELSE (NumReg / 15) + 1 END

   SELECT *,'TotalPag' = @TotalPaginas FROM #Temp1


END



GO
