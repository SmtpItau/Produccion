USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_PRECIO_CUO_FM]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_GRABAR_PRECIO_CUO_FM]  
   (   	@rut_adm 			NUMERIC(9)
   ,    @cod_adm 			NUMERIC(9)
   ,    @instrumento    VARCHAR(20)  
   ,    @fec_venc  DATETIME  
   ,    @cuotas  NUMERIC(19,4)  
   ,    @prec_cuota  NUMERIC(19,4)  
   ,    @iCodigoCliente NUMERIC(9)  
   ,	@nDocumento			NUMERIC(9)
   ,	@nCorrelativo		NUMERIC(5)
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @fec_proc         DATETIME  
   DECLARE @rut_emi         VARCHAR(10)  
   DECLARE @@control_error	INT
       SET @@control_error      = 0  
  
       SET @rut_emi  = @rut_adm --> SUBSTRING(@rut_adm,1,(len(@rut_adm)-2))  
       SET @fec_proc = (SELECT acfecproc FROM MDAC )  
  
  DECLARE @iFound   INT
      SET @iFound   = 0  
   SELECT @iFound   = 1  
   FROM   PRECIO_CUOTA  
   WHERE  rut_emi     = @rut_emi   
   AND    cod_cli     = @iCodigoCliente  
   AND    instrumento = @instrumento   
   AND    fec_venc    = @fec_venc   
   AND    fec_proc    = @fec_proc  
  
   AND    num_docu	  = @nDocumento
   AND    num_corr	  = @nCorrelativo

   IF @iFound = 1  
   BEGIN  
  
      UPDATE PRECIO_CUOTA  
         SET precio_mercado = @prec_cuota  
       WHERE rut_emi     = @rut_emi   
         AND cod_cli        = @iCodigoCliente  
         and instrumento    = @instrumento   
         and fec_venc       = @fec_venc  
         and fec_proc       = @fec_proc  
  
	     and num_docu		= @nDocumento
	     and num_corr		= @nCorrelativo

      SET @@control_error = @@error  
   END  
  
END  
GO
