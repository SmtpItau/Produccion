USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Tipo_Contraparte_ODS]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  FUNCTION [dbo].[Fx_Tipo_Contraparte_ODS] --retorna
	(
	     @Contraparte		int --RutContraparte
		,@CodigoContraparte int --CodigoContraparte
	)	RETURNS varchar(max)	
AS 
BEGIN   


    DECLARE @Codigo_Cliente int 
	DECLARE @Cantidad INT
	DECLARE @Secuencia INT


   --SET @Cantidad = (Select count(clrut)  from BacParamSuda.dbo.cliente
   --Where clrut = @Contraparte
   --Group By clrut 
   --Having count(clrut) > 1)
   
   SELECT @Secuencia = secuencia FROM  BacParamSuda.dbo.cliente
   Where clrut = @Contraparte AND clcodigo = @CodigoContraparte

  --SET @Codigo_Cliente = ISNULL( Case When @Secuencia = 0 Then  @CodigoContraparte  Else  @Secuencia  END,0)
  
   SET @Codigo_Cliente = ISNULL(@Secuencia,0)


  RETURN @Codigo_Cliente

END  







GO
