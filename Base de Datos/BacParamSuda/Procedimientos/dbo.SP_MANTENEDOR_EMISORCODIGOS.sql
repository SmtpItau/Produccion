USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MANTENEDOR_EMISORCODIGOS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MANTENEDOR_EMISORCODIGOS]								
(								
	@EmRut  NUMERIC(9,0),								
	@EmCod  CHAR(3),								
	@Opc    INTEGER								
								
)								
AS								
BEGIN								
								
IF @Opc = 1 -->VALIDA QUE EL CODIGO INGRESADO NO ESTE ASIGNADO A OTRO EMISOR 								
BEGIN								
	IF EXISTS (SELECT 1 FROM BacParamSuda..EMISORCodigos WHERE EmCod = @EmCod and EmRut<>@EmRut)							
	BEGIN							
		SELECT -1, 'Código Fue Asignado a Otro Usuario'						
		RETURN						
	END							
END								
								
IF @Opc = 2 								
	INSERT INTO BacParamSuda..EMISORCodigos (EmRut,EmCod) VALUES (@EmRut, @EmCod)							
								
IF @Opc = 3								
	DELETE BacParamSuda..EMISORCodigos WHERE EmRut = @EmRut 							
								
IF @Opc = 4								
	SELECT EmRut,EmCod FROM BacParamSuda..EMISORCodigos WHERE EmRut = @EmRut 							
								
								
RETURN 0								
								
END								

GO
