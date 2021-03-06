USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_IMPGRUPO_OPCIONES_TURING]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_IMPGRUPO_OPCIONES_TURING]    
     (    
          @NumOperacion    NUMERIC(8,0)     
		, @Usuario         VARCHAR(15) 
		
     )    
AS    
BEGIN    
    
	SET NOCOUNT ON    


	DECLARE @id      INT
	DECLARE @NumFolio NUMERIC(8,0)

	SELECT @id = ISNULL( MAX(ImpGrupo), 0 ) + 1 FROM dbo.IMPRESION

	SELECT @NumFolio = ISNULL(CaNumFolio,0) FROM CaEncContrato  WHERE CaNumContrato = @NumOperacion

	SET @NumFolio = ISNULL(@NumFolio,0)

	IF @NumFolio > 0 and @id > 0
	BEGIN	
		INSERT INTO dbo.IMPRESION ( ImpGrupo, ImpNumContrato, ImpFolio, ImpUsuario ) VALUES ( @id, @NumOperacion, @NumFolio, @Usuario )
	END 
	ELSE
	BEGIN
		SET @id = 0 
	END

	SELECT 'ID' = @id

END

--SP_CONSULTA_IMPGRUPO_OPCIONES_TURING 1873,IHAMEL








GO
