USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRANSFERENCIA_GRABA]    Script Date: 11-05-2022 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_TRANSFERENCIA_GRABA]
            (
               @CORRDESDE     CHAR(10)
              ,@CORRPARA      CHAR(10)
              ,@VALUTA        DATETIME
              ,@MONTO         NUMERIC(19,4)
              ,@APODDER       NUMERIC(9)
              ,@APODIZQ       NUMERIC(9)
              ,@OPERADOR      CHAR(10)          
              ,@FECHA         DATETIME           
              ,@HORA          CHAR(8)
              ,@TERMINAL      CHAR(12)
              ,@FPagoE        numeric(3)
              ,@FPagoR        numeric(3)
              ,@xSistema      char(3)
              ,@OMA           NUMERIC(5)      
              ,@Comercio      char(6)
              ,@Consepto      char(3)
              ,@Area          char(5)
              ,@Contabiliza   char(1)
            )
AS 
BEGIN
   SET NOCOUNT ON
   DECLARE @RUTCLI    NUMERIC(9)
   DECLARE @NUMOPE    NUMERIC(10)
   DECLARE @NOMCLI    CHAR(35)
   DECLARE @CODCLI    NUMERIC(5)
   DECLARE @OBSERV    NUMERIC(19,3)
   DECLARE @ENTIDAD   NUMERIC(9)               
   DECLARE @TIPMER    CHAR(4)
   DECLARE @TIPOPE    CHAR(1)
   DECLARE @CODMON    CHAR(3)
   DECLARE @CODM0NC   CHAR(3)
   DECLARE @MONTOCLP  NUMERIC(19,4)
   DECLARE @FPENTRE   NUMERIC(3)
   DECLARE @FPRECIB   NUMERIC(3)
   DECLARE @DIASV1    NUMERIC(2)
   DECLARE @DIASV2    NUMERIC(2)
   DECLARE @VALENTRE  DATETIME
   DECLARE @VALRECIB  DATETIME
   BEGIN TRANSACTION
   
   SELECT       @FPENTRE  = acfpeempc,
                @FPRECIB  = acfprempc,
                @RUTCLI   = acrut,
                @OBSERV   = acobser,
                @ENTIDAD  = accodigo
          FROM  MEAC
          WHERE acentida  = 'ME'
   SELECT       @DIASV1   = diasvalor
          FROM  VIEW_FORMA_DE_PAGO 
          WHERE codigo    = @FPENTRE
   SELECT       @DIASV2   = diasvalor
          FROM  VIEW_FORMA_DE_PAGO
          WHERE codigo    = @FPRECIB
   SELECT @VALENTRE = ISNULL(DATEADD ( DAY, @DIASV1 , @VALUTA ), @FECHA )
   SELECT @VALRECIB = ISNULL(DATEADD ( DAY, @DIASV2 , @VALUTA ), @FECHA )
   SELECT       @NOMCLI   = clnombre,
                @CODCLI   = clcodigo
          FROM  VIEW_CLIENTE
          WHERE clrut = @RUTCLI
   SELECT @TIPMER   = 'TRAN'  -- TIPO MERCADO
   SELECT @TIPOPE   = 'C'     -- TIPO OPERACION
   SELECT @CODMON   = 'USD'   -- CODIGO MONEDA
   SELECT @CODM0NC  = 'USD'   -- CODIGO MONEDA CNV
   SELECT @MONTOCLP = ( @MONTO * @OBSERV )
   EXECUTE Sp_Gmovto 0,
                     @TIPMER,
                     @TIPOPE,
                     @RUTCLI,
                     @CODCLI,
                     @NOMCLI,
                     @CODM0NC,
                     @CODM0NC,
                     @MONTO,
                     @OBSERV,
                     @OBSERV,
                     1,
                     1,
                     @MONTO,
                     @MONTO,
                     @MONTOCLP,
                     @FPENTRE,
                     @FPRECIB,
                     @OPERADOR,
                     @TERMINAL,
                     @FECHA,
                     @OMA,
                     '',
                     0,
                     @VALENTRE,            -- entregamos
                     @VALRECIB,            -- recibimos
                     0,
                     '',
                     @ENTIDAD,
                     @OBSERV,
                     @OBSERV,
                     0,
                     @xSistema,
                     @Contabiliza,
                     '',
                     '',      --@swift_corrdonde  varchar(10)
                     '',      --@swift_corrquien  varchar(10)
                     '',      --@swift_corrdesde  varchar(10)
                     0,       --@plaza_corrdonde  numeric(5)
                     0,       --@plaza_corrquien  numeric(5)
                     0,       --@plaza_corrdesde  numeric(5)
                     0,       --@fpagomxcli  numeric(5)    --14 Canjes
                     0,       --@fpagomncli       numeric(5)    --15 Canjes
                     '',      --@valuta3          datetime      --18 Canjes
                     '',      --@valuta4          datetime      --19 Canjes
                     @Area,
                     @Comercio,
                     @Consepto,
                     0,
                     0,
                     0,
                     0,
       0,
       0,
       0,
              ''
  
   SELECT      @NUMOPE = accorope
   FROM meac
 UPDATE MEMO 
 SET    swift_corresponsal  = @CORRDESDE,
                swift_recibimos     = @CORRPARA,
                apoderado_izquierda = @APODIZQ,  
                apoderado_derecha   = @APODDER
 WHERE monumope            = @NUMOPE
                           
   IF @@ERROR <> 0 BEGIN
      ROLLBACK TRANSACTION
   END ELSE BEGIN
      COMMIT TRANSACTION
   END   
   SET NOCOUNT OFF
--   SELECT @NUMOPE
   RETURN
END 
/*
sp_Transferencia_Graba '', '', '20010628',  100000, 11551817,  11551817, 'ADMINISTRA', '20010628',  '07:25:09', 'BAC0159_LABARCA', 5,  8,  'BCC',  220,  '151300', '016', 'EMPR', 'S'
sp_help memo
*/



GO
