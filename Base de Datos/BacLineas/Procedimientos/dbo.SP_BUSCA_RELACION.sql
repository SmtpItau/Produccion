USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_RELACION]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_RELACION]
		(	@nRut  	NUMERIC(9)	,
			@codigo	NUMERIC(9)
		)
AS BEGIN

	--+++CONTROL IDD, jcamposd 20170814 no debe preguntar por relaciones las lineas las valida IDD ahora
	SELECT 0
	RETURN
	-----CONTROL IDD, jcamposd 20170814 no debe preguntar por relaciones las lineas las valida IDD ahora

	SET NOCOUNT ON
	DECLARE @nAfectaCli  INTEGER
	IF EXISTS (SELECT 1 FROM CLIENTE_RELACIONADO WHERE @nrut=clrut_padre AND clcodigo_padre=@codigo AND Afecta_Lineas_Hijo=0)
	BEGIN
             SELECT 11
	END ELSE
	BEGIN
		IF EXISTS (SELECT 1 FROM CLIENTE_RELACIONADO WHERE @nrut=clrut_hijo AND clcodigo_hijo=@codigo and Afecta_Lineas_Hijo=0)
			SELECT 12
			
		ELSE
				SELECT 0
	END
SET NOCOUNT OFF

END
--> +++ cvegasan 2017.08.08 Control Lineas IDD
GO
