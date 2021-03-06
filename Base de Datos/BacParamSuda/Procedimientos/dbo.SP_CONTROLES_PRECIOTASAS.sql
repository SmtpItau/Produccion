USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROLES_PRECIOTASAS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CONTROLES_PRECIOTASAS]    
	(	 
   @codModulo	CHAR(3)
  ,@codProducto VARCHAR(5)    
  ,@codMonFam VARCHAR(5)    
  ,@tipoMonFam CHAR(1)    
  ,@tipoOper CHAR(1)=''    
  ,@plazo  INTEGER    
  ,@tasa  NUMERIC(19,4)    
  ,@valor1 NUMERIC(19,4)=0.0    
  ,@diferencia NUMERIC(19,4)    
  ,@Leyenda VARCHAR(255)     
 )    
AS    
BEGIN    
    
   SET NOCOUNT ON    
    
   DECLARE @bandaInf    NUMERIC(19,4)    
   DECLARE @bandaSup    NUMERIC(19,4),
			@ErrorCF	CHAR(1)		--- Indica si el error va a Control Financiero

    
      SET @diferencia  = 0    
      SET @Leyenda     = ''    
      SET @bandaInf    = 0.0    
      SET @bandaSup    = 0.0    
      SET @ErrorCF     = 'S'
		  
    
   IF @codModulo NOT IN (SELECT id_sistema FROM BACPARAMSUDA..SISTEMA_CNT WHERE operativo = 'S' AND gestion ='N')  
   BEGIN    
      SELECT	@diferencia = -1    
      ,			@Leyenda = 'El código del Módulo de la operación ('+@codModulo+') es inválido.'    
	  ,			@ErrorCF = 'N'
    
      SELECT	@diferencia AS	diferencia
      ,			@Leyenda AS		Leyenda
      ,			@ErrorCF AS		ErrorCF
      RETURN 0    
   END    
    
   IF @codModulo = 'BEX'    
      EXECUTE Bacparamsuda..SP_CONTROL_PRECIOTASAS_BEX @codProducto, @codMonFam, @tipoMonFam, @plazo, @tasa, @diferencia OUTPUT, @Leyenda OUTPUT, @bandaInf OUTPUT, @bandaSup OUTPUT, @ErrorCF OUTPUT 
    
   IF @codModulo = 'BTR'    
      EXECUTE Bacparamsuda..SP_CONTROL_PRECIOTASAS_BTR @codProducto, @codMonFam, @tipoMonFam, @plazo, @tasa, @diferencia OUTPUT, @Leyenda OUTPUT, @bandaInf OUTPUT, @bandaSup OUTPUT, @ErrorCF OUTPUT  
    
   IF @codModulo = 'PCS'    
      EXECUTE Bacparamsuda..SP_CONTROL_PRECIOTASAS_PCS @codProducto, @plazo, @tasa, @diferencia OUTPUT, @Leyenda OUTPUT, @bandaInf OUTPUT, @bandaSup OUTPUT, @ErrorCF OUTPUT  
    
   IF @codModulo = 'BCC'    
      EXECUTE Bacparamsuda..SP_CONTROL_PRECIOTASAS_BCC @codProducto, @codMonFam, @tipoMonFam, @tipoOper, @plazo, @tasa, @diferencia OUTPUT, @Leyenda OUTPUT, @bandaInf OUTPUT, @bandaSup OUTPUT, @ErrorCF OUTPUT 
    
   IF @codModulo = 'BFW'    
      EXECUTE Bacparamsuda..SP_CONTROL_PRECIOTASAS_FWD @codProducto, @codMonFam, @tipoOper, @plazo, @tasa, @valor1, @diferencia OUTPUT, @Leyenda OUTPUT, @bandaInf OUTPUT, @bandaSup OUTPUT, @ErrorCF OUTPUT  
    
   SELECT @diferencia    AS Diferencia
      ,   @Leyenda       AS  Leyenda
      ,   ISNULL(@bandaInf, 0.0)  AS   BandaInf
      ,   ISNULL(@bandaSup, 0.0)  AS   BandaSup  
      ,	  @ErrorCF AS ErrorCF
END	

GO
