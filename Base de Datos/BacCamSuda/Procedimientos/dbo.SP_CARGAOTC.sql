USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGAOTC]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARGAOTC]
   (
       @CODIGOOTC      CHAR(3)
      ,@MONTO          NUMERIC(19,4)
      ,@TIPOCAMBIO     NUMERIC(19,4)
      ,@HORA           CHAR(8)
      ,@IDENTIFICADOR  CHAR(1)
      ,@OPERADOR       CHAR(15)
      ,@TERMINAL       CHAR(15)
      ,@FECHA          DATETIME
      ,@NINTERFAZ      VARCHAR(16)
   )
AS
BEGIN
SET NOCOUNT On
DECLARE @MENSAJE       VARCHAR(255)  
DECLARE @RUT           NUMERIC(9)
DECLARE @RUTC          NUMERIC(9)
DECLARE @CODIGOCLI     NUMERIC(9)
DECLARE @NOMCLIENTE    CHAR(35)
DECLARE @TIPOOPERA     CHAR(1)
DECLARE @MONTOUSD      NUMERIC(19,4)
DECLARE @FPAGOENTRE    NUMERIC(1)
DECLARE @FPAGORECIB    NUMERIC(1)    
DECLARE @VALUTA1       DATETIME
DECLARE @VALUTA2       DATETIME
DECLARE @DIASVE        NUMERIC(1)
DECLARE @DIASVR        NUMERIC(1)
DECLARE @NUMOPERAUX    NUMERIC(9)
SELECT @RUT        = ( SELECT acrut FROM MEAC )
SELECT @CODIGOCLI  = ( SELECT clcodigo  FROM VIEW_CLIENTE WHERE codigo_otc = @CODIGOOTC )
SELECT @NOMCLIENTE = ( SELECT clnombre  FROM VIEW_CLIENTE WHERE codigo_otc = @CODIGOOTC )
SELECT @RUTC       = ( SELECT clrut     FROM VIEW_CLIENTE WHERE codigo_otc = @CODIGOOTC )
SELECT @MONTOUSD   = ( @MONTO * @TIPOCAMBIO )
IF EXISTS ( SELECT numerointerfaz from MEMO WHERE @NINTERFAZ = numerointerfaz AND @IDENTIFICADOR <> 'E')
BEGIN
   SELECT 'OK','EXISTE'
   RETURN
END
IF @RUT = @RUTC
BEGIN
   SELECT @FPAGOENTRE   = ( SELECT acfpeempc   FROM MEAC )
   SELECT @FPAGORECIB   = ( SELECT acfprempc   FROM MEAC )
   SELECT @DIASVE       = ( SELECT diasvalor   FROM VIEW_FORMA_DE_PAGO WHERE codigo = @FPAGOENTRE )
   SELECT @DIASVR       = ( SELECT diasvalor   FROM VIEW_FORMA_DE_PAGO WHERE codigo = @FPAGOENTRE )
   SELECT @VALUTA1      = ( DATEADD(DAY, @DIASVE, @FECHA ))
   SELECT @VALUTA2      = ( DATEADD(DAY, @DIASVR, @FECHA ))
   SELECT @TIPOOPERA    = 'C'
END ELSE BEGIN
   SELECT @FPAGOENTRE   = ( SELECT acfpeempv   from MEAC )
   SELECT @FPAGORECIB   = ( SELECT acfprempv   from MEAC )
   SELECT @DIASVE       = ( SELECT diasvalor   FROM VIEW_FORMA_DE_PAGO WHERE codigo = @FPAGOENTRE )
   SELECT @DIASVR       = ( SELECT diasvalor   FROM VIEW_FORMA_DE_PAGO WHERE codigo = @FPAGOENTRE )
   
   SELECT @VALUTA1      = ( DATEADD(DAY, @DIASVE, @FECHA ))
   SELECT @VALUTA2      = ( DATEADD(DAY, @DIASVR, @FECHA ))
   SELECT @TIPOOPERA    = 'V'
END 
IF @IDENTIFICADOR = 'I'
BEGIN
  EXECUTE Sp_Gmovto
          0           --NumOpera
         ,'PTAS'      --TipoMerc
         ,@TIPOOPERA  --TipoOpera
         ,@RUTC       --RutCli
         ,@CODIGOCLI  --CodCli 
         ,@NOMCLIENTE --NomCli  
         ,'USD'       --CodMon
         ,'CLP'       --CodMonCnv
         ,@MONTO      --Monto
         ,@TIPOCAMBIO --TCambio
         ,@TIPOCAMBIO --TCambioCnv
         ,1           --Paridad 
         ,1           --ParidadCnv
         ,@MONTO      --MontoUSD
         ,@MONTO      --UssTR
         ,@MONTOUSD   --MontoCLP
         ,@FPAGOENTRE --Entre
         ,@FPAGORECIB --Recib
         ,@OPERADOR   --Operador
         ,'BOLSA'     --@TERMINAL   --Terminal
         ,@HORA       --Hora
         ,@FECHA      --Fecha
         ,0           -- CodOMA
         ,''          --Estado
         ,0           --CodEject
         ,@VALUTA1    --Valuta1
         ,@VALUTA2    --Valuta2
         ,0           --Rentab
         ,''          --Linea
         ,1           --Entidad
         ,@TIPOCAMBIO --Precio
         ,@TIPOCAMBIO --PrecioCnv
         ,0           --Estado
         ,'BCC'       --Responsable
         ,'S'         --Contabilidad
         ,@IDENTIFICADOR --Obserbaciones GUARDA EL IDNTIFICADOR DE LA OPERACION
         ,''          --SwiftCorresponsDonde
         ,''          --SwiftCorresponsQuien
         ,''          --SwiftCorresponsDesde
         ,0           --PlazaCorresponsalDonde
         ,0           --PlazaCorresponsalQuien
         ,0           --PlazaCorresponsalDesde
 	 ,0           --FpagoMXCL
         ,0           --FpagoMNCL
         ,''          --Valuta3
         ,''          --Valuta4
   
   SELECT @NUMOPERAUX = ( SELECT ACCOROPE FROM MEAC )          
   UPDATE MEMO SET numerointerfaz  = @NINTERFAZ WHERE monumope = @NUMOPERAUX
   IF @@ERROR <> 0
      SELECT 'ERROR','ERROR'
   ELSE
      SELECT 'OK','INSERTADO'
END ELSE BEGIN
   DECLARE @NUMOPERACION   NUMERIC(9)
   
   SELECT @NUMOPERACION    = ( SELECT monumope FROM MEMO WHERE moterm = 'BOLSA' AND Observacion = 'I' AND mohora = @HORA )
--   SELECT 'Numero' = @NUMOPERACION
   EXECUTE Sp_Elimina_Operacion @NUMOPERACION
   IF @@ERROR <> 0
      SELECT 'ERROR','ERROR'
   ELSE
      SELECT 'OK','ELIMINADO'
END
SET NOCOUNT OFF
END



GO
