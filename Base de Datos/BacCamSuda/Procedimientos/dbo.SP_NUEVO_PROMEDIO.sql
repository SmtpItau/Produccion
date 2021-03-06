USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NUEVO_PROMEDIO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_NUEVO_PROMEDIO]  --1,'EMPR','USD'
  (@ENTIDAD INT    ,
   @MERCADO CHAR(4),
   @MONEDA  CHAR(3))
AS
BEGIN
CREATE TABLE #PASO2(
   CCORRELATIVO   INT   NOT NULL DEFAULT (0),
         
   CNombreCliente     CHAR(70) NOT NULL DEFAULT (''),
   CNoOpera  INT  NOT NULL DEFAULT (0),
   CTipoOpera  CHAR(1)  NOT NULL DEFAULT (''),
          CTipoMerc  CHAR(10) NOT NULL DEFAULT (''),
          CMonedaOpera  CHAR(3)  NOT NULL DEFAULT (''),
          CMontoOpera  FLOAT  NOT NULL DEFAULT (0),
          CTipoCamCie  FLOAT  NOT NULL DEFAULT (0),
   CMontoUSD  FLOAT  NOT NULL DEFAULT (0),
          CMontoclp  FLOAT  NOT NULL DEFAULT (0),
   CPosicionInicio  FLOAT  NOT NULL DEFAULT (0),
   CPrecioPosicion  FLOAT  NOT NULL DEFAULT (0),
   CDatos   INT  NOT NULL DEFAULT (0),
   CMin   FLOAT  NOT NULL DEFAULT (0),
   VNombreCliente     CHAR(70) NOT NULL DEFAULT (''),
   VNoOpera  INT  NOT NULL DEFAULT (0),
   VTipoOpera  CHAR(1)  NOT NULL DEFAULT (''),
          VTipoMerc  CHAR(10) NOT NULL DEFAULT (''),
          VMonedaOpera  CHAR(3)  NOT NULL DEFAULT (''),
          VMontoOpera  FLOAT  NOT NULL DEFAULT (0),
          VTipoCamCie  FLOAT  NOT NULL DEFAULT (0),
   VMontoUSD  FLOAT  NOT NULL DEFAULT (0),
          VMontoclp  FLOAT  NOT NULL DEFAULT (0),
   VPosicionInicio  FLOAT  NOT NULL DEFAULT (0),
   VPrecioPosicion  FLOAT  NOT NULL DEFAULT (0),
      VDatos   INT  NOT NULL DEFAULT (0),
   VMin   FLOAT  NOT NULL DEFAULT (0),
                        nombrebanco             CHAR(20) NOT NULL DEFAULT (''), 
   Hora     CHAR(10) NOT NULL DEFAULT ('') 
 )
DECLARE @TOTALC  INT
DECLARE @TOTALV  INT
DECLARE @CONTADOR  INT
DECLARE @COMPRAS  INT
DECLARE @VENTAS  INT
DECLARE @CMIN   FLOAT
DECLARE @VMIN   FLOAT
--DECLARE @HORA DATETIME
DECLARE @CNombreCliente     CHAR(70)
DECLARE @CNoOpera  INT  
DECLARE @CTipoOpera  CHAR(1)
DECLARE @CTipoMerc  CHAR(10) 
DECLARE @CMonedaOpera  CHAR(3) 
DECLARE @CMontoOpera  FLOAT 
DECLARE @CTipoCamCie  FLOAT 
DECLARE @CMontoUSD  FLOAT 
DECLARE @CMontoclp  FLOAT  
DECLARE @CPosicionInicio FLOAT
DECLARE @CPrecioPosicion FLOAT 
DECLARE @VNombreCliente     CHAR(70)
DECLARE @VNoOpera  INT  
DECLARE @VTipoOpera  CHAR(1)
DECLARE @VTipoMerc  CHAR(10) 
DECLARE @VMonedaOpera  CHAR(3) 
DECLARE @VMontoOpera  FLOAT 
DECLARE @VTipoCamCie  FLOAT 
DECLARE @VMontoUSD  FLOAT 
DECLARE @VMontoclp  FLOAT  
DECLARE @VPosicionInicio FLOAT
DECLARE @VPrecioPosicion FLOAT 
DECLARE @CODMON                 CHAR(3)
DECLARE @nombrebanco           CHAR(20)  
SELECT  @CODMON = 'USD'
SELECT  @TOTALC = 0
SELECT  @TOTALV = 0
SELECT  @COMPRAS=0
SELECT  @VENTAS =0
SELECT  @CMIN=0
SELECT  @VMIN=0
SELECT  @TOTALC = @TOTALC + 1  FROM MEMO WHERE motipope = 'C' AND mocodmon = @MONEDA AND moestatus <> 'A' AND motipmer = @MERCADO
SELECT  @TOTALV = @TOTALV + 1  FROM MEMO WHERE motipope = 'V' AND mocodmon = @MONEDA AND moestatus <> 'A' AND motipmer = @MERCADO
SET     @COMPRAS = @TOTALC
SET     @VENTAS  = @TOTALV
select @nombrebanco= acnombre from meac
SELECT
 'correlativo'  = identity(int),
 'VNombreCliente' = a.clnombre,
 'VNoOpera'       = monumope,
 'VTipoOpera'     = motipope,
        'VTipoMerc'      = (select glosa from VIEW_AYUDA_PLANILLA where codigo_caracter=@mercado),
        'VMonedaOpera'   = mocodmon,
        'VMontoOpera'    = momonmo,
        'VTipoCamCie'    = moticam,
 'VMontoUSD'  = moussme,
        'VMontoCLP'      = momonpe,
 'VPosicionInicio'= vmposini,
 'VPrecioPosicion'= vmpreini
INTO
 #TMPV
FROM  
 MEMO  ,
 VIEW_CLIENTE A,
 VIEW_POSICION_SPT,
 VIEW_ENTIDAD D,
 MEAC 
WHERE 
 morutcli   = a.clrut  
   AND  mocodcli   = a.clcodigo
   AND  (@ENTIDAD  = 0 OR @ENTIDAD = moentidad)
   AND  d.rccodcar = moentidad
   AND  CONVERT(CHAR(8),vmfecha,112) = CONVERT(CHAR(8),acfecpro,112) 
   AND  mocodmon=@MONEDA
   AND  vmcodigo = @CODMON
-- AND  vmcodigo = 'USD'
   AND  motipope = 'V'
   AND  moestatus <> 'A'
   AND  motipmer = @MERCADO
-- AND  vmcodigo = mocodmon
order by monumope
SELECT  @VMIN=min(vtipocamcie) FROM #tmpv 
SELECT 
 'correlativo'  =  identity(int),
 'CNombreCliente' = a.clnombre,
 'CNoOpera'       = monumope,
 'CTipoOpera'     = motipope,
 'CTipoMerc'      = (select glosa from view_ayuda_planilla where codigo_caracter=@mercado),
 'CMonedaOpera'   = mocodmon,
 'CMontoOpera'    = momonmo,
 'CTipoCamCie'    = moticam,
 'CMontoUSD'  = moussme,
 'CMontoCLP'      = momonpe,
 'CPosicionInicio'= vmposini,
 'CPrecioPosicion'= vmpreini
 
INTO
 #TMPC
FROM  
 MEMO  ,
  VIEW_CLIENTE A,
 VIEW_POSICION_SPT,
 VIEW_ENTIDAD D,
 MEAC 
WHERE 
 morutcli   = a.clrut  
    AND mocodcli   = a.clcodigo
    AND (@ENTIDAD  = 0 OR @ENTIDAD = moentidad)
    AND d.rccodcar = moentidad
    AND CONVERT(CHAR(8),vmfecha,112) = CONVERT(CHAR(8),acfecpro,112) 
    AND vmcodigo = @CODMON
    AND mocodmon=@MONEDA
--  AND vmcodigo = 'USD'
    AND moestatus <> 'A'
    AND motipmer = @MERCADO
    AND motipope='C'
order by monumope
SELECT  @cMIN=min(ctipocamcie) FROM #tmpc 
IF @TOTALC >= @TOTALV
 BEGIN
  SELECT @CONTADOR = 1
  WHILE @CONTADOR <= @TOTALC 
   BEGIN
    SELECT   
     @CNombreCliente     = CNombreCliente,
     @CNoOpera  = CNoOpera,
     @CTipoOpera  = 'C',
     @CTipoMerc  = CTipoMerc,
     @CMonedaOpera  = CMonedaOpera,
     @CMontoOpera  = CMontoOpera,
     @CTipoCamCie  = CTipoCamCie,
     @CMontoUSD  = CMontoUSD, 
     @CMontoclp  = CMontoCLP,  
     @CPosicionInicio = CPosicionInicio,
     @CPrecioPosicion = CPrecioPosicion 
     FROM 
     #TMPC
     WHERE
     correlativo = @CONTADOR 
    
    INSERT INTO #PASO2(
     CCORRELATIVO   ,
           CNombreCliente     ,
     CNoOpera  ,
     CTipoOpera  ,                                        
            CTipoMerc  ,
            CMonedaOpera  ,
            CMontoOpera  ,
            CTipoCamCie  ,
     CMontoUSD  ,
            CMontoclp  ,
     CPosicionInicio  ,
     CPrecioPosicion  ,
     CDatos   ,
     CMin
      )
    VALUES
      (
     @CONTADOR   ,
     ISNULL(@CNombreCliente,'  ') ,
     ISNULL(@CNoOpera,0)  , 
     ISNULL(@CTipoOpera,'C')  ,
     ISNULL(@CTipoMerc,' ')  ,
     ISNULL(@CMonedaOpera,' ') ,
     ISNULL(@CMontoOpera,0)  ,
     ISNULL(@CTipoCamCie,0)  ,
     ISNULL(@CMontoUSD,0)  ,
     ISNULL(@CMontoclp,0)  ,
     ISNULL(@CPosicionInicio,0) ,
     ISNULL(@CPrecioPosicion,0) ,
     ISNULL(@COMPRAS,0)  ,
     ISNULL(@CMIN,0)
        )
           SELECT @CONTADOR =  @CONTADOR + 1
   END
   
   SELECT @CONTADOR = 1  
                        WHILE @CONTADOR <= @TOTALC
    BEGIN 
                                IF @CONTADOR <= @TOTALV
                                BEGIN 
    SELECT   
     @VNombreCliente     = VNombreCliente,
     @VNoOpera  = VNoOpera,
       @VTipoOpera  = 'V',                                                                              
     @VTipoMerc  = VTipoMerc,
     @VMonedaOpera  = VMonedaOpera,
     @VMontoOpera  = VMontoOpera,
     @VTipoCamCie  = VTipoCamCie,
     @VMontoUSD  = VMontoUSD, 
     @VMontoclp  = VMontoCLP,  
     @VPosicionInicio = VPosicionInicio,
     @VPrecioPosicion = VPrecioPosicion 
     FROM 
     #TMPV
     WHERE
     correlativo = @CONTADOR 
                                END
                                ELSE
                                BEGIN  
     SELECT  @VNombreCliente     = ' ',
      @VNoOpera  = 0,      
        @VTipoOpera  = 'V',                                                                              
      @VTipoMerc  = ' ',
      @VMonedaOpera  = ' ',
      @VMontoOpera  = 0,
      @VTipoCamCie  = 0,
      @VMontoUSD  = 0, 
      @VMontoclp  = 0,  
      @VPosicionInicio = 0,
      @VPrecioPosicion = 0 
    END
   
    UPDATE #PASO2 SET
      VNombreCliente  = ISNULL(@VNombreCliente,'') ,
      VNoOpera = ISNULL(@VNoOpera,0)         , 
      CTipoOpera = ISNULL(@VTipoOpera,'')     ,
      VTipoMerc = ISNULL(@VTipoMerc,'')  ,
      VMonedaOpera = ISNULL(@VMonedaOpera,'')   ,
      VMontoOpera = ISNULL(@VMontoOpera,0)        ,
      VTipoCamCie = ISNULL(@VTipoCamCie,0)        ,
      VMontoUSD = ISNULL(@VMontoUSD,0)   ,
      VMontoclp = ISNULL(@VMontoclp,0)   ,
      VPosicionInicio = ISNULL(@VPosicionInicio,0) ,
                 VPrecioPosicion = ISNULL(@VPrecioPosicion,0) ,
                                                Vdatos          = ISNULL(@VENTAS,0)   ,
      VMin  = ISNULL(@VMIN,0) 
    WHERE CCORRELATIVO = @CONTADOR 
    SELECT @CONTADOR = @CONTADOR + 1
   END
 END
IF @TOTALC < @TOTALV
 BEGIN
  SELECT @CONTADOR = 1
  WHILE @CONTADOR <= @TOTALV 
   BEGIN
    SELECT   
     @VNombreCliente     = VNombreCliente,
     @VNoOpera  = VNoOpera,
                                        @VTipoOpera  = 'V',
     @VTipoMerc  = VTipoMerc,
     @VMonedaOpera  = VMonedaOpera,
     @VMontoOpera  = VMontoOpera,
     @VTipoCamCie  = VTipoCamCie,
     @VMontoUSD  = VMontoUSD, 
     @VMontoclp  = VMontoCLP,  
     @VPosicionInicio = VPosicionInicio,
     @VPrecioPosicion = VPrecioPosicion 
      
     FROM 
     #TMPV
     WHERE
     correlativo = @CONTADOR 
    
    INSERT INTO #PASO2(
      CCORRELATIVO ,
      VNombreCliente  ,
      VNoOpera ,
      VTipoOpera ,
      VTipoMerc ,
      VMonedaOpera ,
      VMontoOpera ,
      VTipoCamCie ,
      VMontoUSD , 
      VMontoclp ,  
      VPosicionInicio ,
      VPrecioPosicion , 
      VDatos  ,
      VMin  
 --     hora
      )
    VALUES
      (
      @CONTADOR    ,
      ISNULL(@VNombreCliente,'  ') ,
      ISNULL(@VNoOpera,0)  , 
      ISNULL(@VTipoOpera,'V')  ,
      ISNULL(@VTipoMerc,'  ')  ,
      ISNULL(@VMonedaOpera,'  ') ,
      ISNULL(@VMontoOpera,0)  ,
      ISNULL(@VTipoCamCie,0)  ,
      ISNULL(@VMontoUSD,0)  ,
      ISNULL(@VMontoclp,0)  ,
      ISNULL(@VPosicionInicio,0) ,
      ISNULL(@VPrecioPosicion,0) ,
      ISNULL(@VENTAS,0)  ,
      ISNULL(@VMIN,0)   
--      @hora
      )
   SELECT @CONTADOR =  @CONTADOR + 1
   END
   
   SELECT @CONTADOR = 1 
   
                        WHILE @CONTADOR <= @TOTALV
    BEGIN 
    IF @CONTADOR <= @TOTALC
                                   BEGIN
                                   SELECT   
     @CNombreCliente     = CNombreCliente,
     @CNoOpera  = CNoOpera,
             @CTipoOpera  = 'C',                                   
     @CTipoMerc  = CTipoMerc,
     @CMonedaOpera  = CMonedaOpera,
     @CMontoOpera  = CMontoOpera,
     @CTipoCamCie  = CTipoCamCie,
     @CMontoUSD  = CMontoUSD, 
     @CMontoclp  = CMontoCLP,  
     @CPosicionInicio = CPosicionInicio,
     @CPrecioPosicion = CPrecioPosicion 
            FROM 
         #TMPC
            WHERE
         correlativo = @CONTADOR 
                                   END
                                ELSE
                                   BEGIN
                                        SELECT @CNombreCliente  = ' ',
             @CNoOpera = 0,
                                               @CTipoOpera = ' ',                                   
            @CTipoMerc = ' ',
            @CMonedaOpera = ' ',
            @CMontoOpera = 0,
            @CTipoCamCie = 0,
            @CMontoUSD = 0, 
            @CMontoclp = 0,  
                    @CPosicionInicio = 0,
                     @CPrecioPosicion = 0 
                                   END
                                
   
       UPDATE #PASO2 SET 
      CNombreCliente  = ISNULL(@CNombreCliente,'')    ,
      CNoOpera = ISNULL(@CNoOpera,0)           , 
      CTipoOpera = ISNULL(@CTipoOpera,'')       ,
      CTipoMerc = ISNULL(@CTipoMerc,'')         ,
      CMonedaOpera = ISNULL(@CMonedaOpera,'')      ,
      CMontoOpera = ISNULL(@CMontoOpera,0) ,
      CTipoCamCie = ISNULL(@CTipoCamCie,0)        ,
      CMontoUSD = ISNULL(@CMontoUSD,0)  ,
      CMontoclp = ISNULL(@CMontoclp,0)  ,
      CPosicionInicio = ISNULL(@CPosicionInicio,0) ,
          CPrecioPosicion = ISNULL(@CPrecioPosicion,0) ,
                                                Cdatos          = ISNULL(@COMPRAS,0)  ,
      CMin  = ISNULL(@CMIN,0)               ,
                                                Hora            = CONVERT( CHAR(10) , GETDATE() , 108 )   ,
                                                nombrebanco     = @nombrebanco                                
       WHERE CCORRELATIVO = @CONTADOR 
    
                                   SELECT @CONTADOR = @CONTADOR + 1
    
   END
END
SELECT  *,'FecPro'=a.acfecpro FROM #PASO2,meac a
END

GO
