USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_SWIFT]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_SWIFT](
     @numero_swift NUMERIC(10)
       )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @mt_20            CHAR(16)
  ,@mt_21            CHAR(16)
  ,@mt_32a_Fecha     CHAR(06)  --  fecha(06) , cod moneda(03) , monto(15)
  ,@mt_32a_Moneda    CHAR(03)
  ,@mt_32a_Monto     CHAR(15)
  ,@mt_52a           CHAR(60)  --         
  ,@mt_53a           CHAR(60)
  ,@mt_54a           CHAR(60)
  ,@mt_56a           CHAR(60)
  ,@mt_57a           CHAR(60)
  ,@mt_58a           CHAR(60)  --
  ,@mt_72            CHAR(35)
  ,@mt_72_1          CHAR(35)
  ,@mt_72_2          CHAR(35)
  ,@mt_72_3          CHAR(35)
  ,@mt_72_4          CHAR(35)
  ,@mt_72_5          CHAR(35)
  ,@numero           NUMERIC(07)   -- monumfut  
  ,@valuta1          DATETIME      -- movaluta1  
  ,@tipmer           CHAR(04)      -- motipmer  
  ,@codmon           CHAR(03)      -- mocodcnv - mocodmon  
  ,@ussme            NUMERIC(19,4) -- moussme   
  ,@rutcli           NUMERIC(09)   -- morutcli  
  ,@codcli           NUMERIC(09)   -- mocodcli  
  ,@numope           NUMERIC(09)   -- monumope  
  ,@Ciclo            NUMERIC(03)
  ,@Cantidad         NUMERIC(03)
  ,@Ciclo2           INTEGER
  ,@Cantidad2        NUMERIC(03)
  ,@CodNumMon        NUMERIC(03)
  ,@codSwf           VARCHAR(10)   
  ,@Rut_Corresponsal NUMERIC(09)
  ,@Nom_Corresponsal CHAR(50)
  ,@moneda           CHAR( 3)
  ,@monto            NUMERIC(19,4)
  ,@paridad          NUMERIC(19,8)
  ,@Cabeza1_3        CHAR(15)
  ,@Cabeza2_3        CHAR(30)
  ,@Cabeza3_3        CHAR(12)
  ,@tipo     CHAR(1)
 CREATE TABLE #Interfaz_swift( Registro CHAR(100) NOT NULL DEFAULT(''))
 SELECT  @mt_20   = ''
  ,@mt_21     = '.'
  ,@mt_32a_Fecha   = ''      --  fecha(06) , cod moneda(03) , monto(15)
  ,@mt_32a_Moneda  = ''
  ,@mt_32a_MOnto   = ''
  ,@mt_52a    = ''           
  ,@mt_53a    = ''           
  ,@mt_54a    = ''
  ,@mt_56a    = ''           
  ,@mt_57a    = ''
  ,@mt_58a    = ''
  ,@mt_72     = ''
  ,@mt_72_1   = ''
  ,@mt_72_2   = ''
  ,@mt_72_3   = ''
  ,@mt_72_4   = ''
  ,@mt_72_5   = ''
  ,@Rut_Corresponsal  = 0
  ,@Nom_Corresponsal  = ''
  ,@CodNumMon         = 0
  ,@codSwf            = ''
  ,@Cabeza1_3         = ''
  ,@Cabeza2_3         = ''
  ,@Cabeza3_3         = ''
  ,@Cabeza1_3   = '{1:F01BKSACLRM'
  ,@Cabeza2_3   = 'AXXX0000000000}{2:I202CHASUS33'
  ,@Cabeza3_3   = 'XXXXN020}{4:'
 SELECT  @mt_20    = RIGHT( '0000000000000000' + CONVERT( VARCHAR(16), mt_20 ), 16 )    ,
  @mt_32a_Fecha   = SUBSTRING(mt_32a_Fecha,1,2) + SUBSTRING(mt_32a_Fecha,4,2) + SUBSTRING(mt_32a_Fecha,7,2) ,
  @mt_32a_Moneda  = mt_32a_Moneda           ,
  @mt_32a_Monto   = RTRIM(RIGHT('000000000000000'+REPLACE(CONVERT(VARCHAR(19),mt_32a_Monto),'.',''), 15))  ,
  @mt_57a         = mt_57_swift  , -- mt_57_sucursal          ,
  @mt_58a    = mt_58_swift  , -- mt_58_direccion           ,
  @mt_72          = mt_72  ,
  @tipo  = tipo
 FROM tbtransferencia
 WHERE  numero_operacion = @numero_swift
 SELECT  @Cantidad2 = COUNT(*)
 FROM  tbtransferencia_detalle
 WHERE  numero_operacion = @numero_swift
 SELECT @Ciclo2 = 1
 WHILE @Cantidad2 >= @Ciclo2
  BEGIN
   SET ROWCOUNT @Ciclo2
   SELECT  @moneda  = moneda ,
    @monto   = monto ,
    @paridad = paridad
   FROM  tbtransferencia_detalle
   WHERE  numero_operacion = @numero_swift
   SET ROWCOUNT 0              
   IF @Ciclo2 = 1 
    SELECT @mt_72_1 = @moneda+' '+CONVERT(VARCHAR(19),@monto)+' '+CONVERT(VARCHAR(19),@paridad)
   ELSE 
   IF @Ciclo2 = 2 
    SELECT @mt_72_2 = @moneda+' '+CONVERT(VARCHAR(19),@monto)+' '+CONVERT(VARCHAR(19),@paridad)
   ELSE 
   IF @Ciclo2 = 3
    SELECT @mt_72_3 = @moneda+' '+CONVERT(VARCHAR(19),@monto)+' '+CONVERT(VARCHAR(19),@paridad)
   ELSE 
   IF @Ciclo2 = 4
    SELECT @mt_72_4 = @moneda+' '+CONVERT(VARCHAR(19),@monto)+' '+CONVERT(VARCHAR(19),@paridad)
   ELSE 
   IF @Ciclo2 = 5
    SELECT @mt_72_5 = @moneda+' '+CONVERT(VARCHAR(19),@monto)+' '+CONVERT(VARCHAR(19),@paridad)
                    
   SELECT @Ciclo2 = @Ciclo2 + 1                    
              END
 INSERT INTO #Interfaz_swift
 VALUES( @Cabeza1_3+@Cabeza2_3+@Cabeza3_3)
 INSERT INTO #Interfaz_swift
 VALUES('20:'+@mt_20)          
 INSERT INTO #Interfaz_swift
 VALUES('21:'+@mt_21)          
 INSERT INTO #Interfaz_swift
 VALUES ('32a:'+@mt_32a_Fecha+@mt_32a_Moneda+@mt_32a_Monto+',')          
-- INSERT INTO #Interfaz_swift
-- VALUES ('52a:'+@mt_52a)
-- INSERT INTO #Interfaz_swift
-- VALUES ('53a:'+@mt_53a)          
         
-- INSERT INTO #Interfaz_swift
-- VALUES ('54a:'+@mt_54a)          
-- INSERT INTO #Interfaz_swift
-- VALUES ('56a:'+@mt_56a)          
 INSERT INTO #Interfaz_swift
 VALUES ('57a:'+@mt_57a)          
 INSERT INTO #Interfaz_swift
 VALUES ('58a:'+@mt_58a)          
 INSERT INTO #Interfaz_swift
 VALUES ('72:/BNF/'+@mt_72)          
 INSERT INTO #Interfaz_swift
 VALUES ('//'+@mt_72_1)          
 INSERT INTO #Interfaz_swift
 VALUES ('//'+@mt_72_2)       
 INSERT INTO #Interfaz_swift
 VALUES ('//'+@mt_72_3)          
 INSERT INTO #Interfaz_swift
 VALUES ('//'+@mt_72_4)          
 INSERT INTO #Interfaz_swift
 VALUES ('//'+@mt_72_5)          
 INSERT INTO #Interfaz_swift
 VALUES ('-}')          
 UPDATE tbtransferencia
 SET estado = 'E'
 WHERE numero_operacion = @numero_swift 
 SELECT * FROM #Interfaz_swift
     SET NOCOUNT OFF
END

GO
