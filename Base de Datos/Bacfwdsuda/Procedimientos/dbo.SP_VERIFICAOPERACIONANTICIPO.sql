USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VERIFICAOPERACIONANTICIPO]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_VERIFICAOPERACIONANTICIPO]
   (   @nnumoper   NUMERIC(10,00) 
   ,   @Verifica   NUMERIC(1,0) 
   )
AS
BEGIN
  
   SET NOCOUNT ON

   DECLARE @acfecproc             DATETIME
   DECLARE @Resp                  NUMERIC(1,0)
   DECLARE @NumeroContratoCliente NUMERIC(10)

      SET  @acfecproc = (SELECT acfecproc FROM MFAC with (nolock) )
      SET  @Resp      = 0

   IF @Verifica = 1 -- Verifica si  ya existe anticipo relacionado a Operación durante el día -- La operacionde de parametro es Contrato Original origina
   BEGIN 
      IF EXISTS(SELECT 1 FROM MFCA WHERE numerocontratocliente = @nnumoper AND cafecvcto = @acfecproc AND caantici = 'A' )
         SET @Resp = 1
      ELSE
         SET @Resp = 0
   END 

   IF  @Verifica = 2  -- Verifica si  Operación anticipada ya fue enviada al Motor de Pago
   BEGIN 
      -- @nnumoper en este contexto es la operacion Anexo
      -- Las operaciones son mandadas siempre con el numero de Contrato Original al motor de pagos
      -- al motor de pagos
      
      SET @NumeroContratoCliente = 0
      SET @NumeroContratoCliente = ( SELECT NumeroContratoCliente FROM MFCA with (nolock) WHERE Canumoper = @nnumoper )

      IF EXISTS(SELECT 1 FROM bacparamsuda..MDLBTR with (nolock) WHERE numero_operacion = @NumeroContratoCliente AND estado_envio = 'E' AND sistema = 'BFW' )
         SET @Resp = 1
      ELSE
         SET @Resp = 0
   END 

   SELECT @Resp

END

GO
