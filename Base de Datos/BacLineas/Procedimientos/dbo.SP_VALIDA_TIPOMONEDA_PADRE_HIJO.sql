USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_TIPOMONEDA_PADRE_HIJO]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_VALIDA_TIPOMONEDA_PADRE_HIJO] 
   (   @rut1      NUMERIC(10,0)
	,@Moneda		NUMERIC(3)
   )
AS
BEGIN

	SET NOCOUNT ON


	IF EXISTS (SELECT 1 FROM CLIENTE_RELACIONADO WHERE CLRUT_PADRE = @RUT1 AND Afecta_Lineas_Hijo = 1)
	BEGIN
		if exists (select 1 FROM CLIENTE_RELACIONADO , LINEA_GENERAL LG, LINEA_GENERAL LG1 WHERE CLRUT_PADRE = @rut1 and  lg.Rut_Cliente = CLRUT_PADRE
			and  lg1.Rut_Cliente = clrut_HIJO and  LG1.MONEDA <> @Moneda)
  	 		BEGIN
     	 			SELECT -7 , 'El tipo de moneda del Padre es distinta al de los  hijos, debera modificarlos'
     	 			RETURN 0
   			END 	

	END

	IF EXISTS (SELECT 1 FROM CLIENTE_RELACIONADO WHERE CLRUT_HIJO = @RUT1 AND Afecta_Lineas_Hijo = 1)
	BEGIN
		if exists (select 1 FROM CLIENTE_RELACIONADO , LINEA_GENERAL LG, LINEA_GENERAL LG1 WHERE CLRUT_HIJO = @rut1 and  lg.Rut_Cliente = CLRUT_HIJO
		and  lg1.Rut_Cliente = clrut_PADRE and  @Moneda <> LG1.MONEDA) 
   		BEGIN
	      		SELECT -8 , 'El tipo de moneda debe se igual a la del Padre'
      			RETURN 0
		END
	END 

	SET NOCOUNT OFF

	SELECT 0 , 'OK'      	
END
GO
