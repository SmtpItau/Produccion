USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MANTENEDOR_INSTRUMENTOSSOMA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MANTENEDOR_INSTRUMENTOSSOMA]									
	(									
	@InCodigo  NUMERIC(5,0),									
	@InTipSOMA CHAR(3),									
	@Opc       INTEGER									
	)									
	AS									
	BEGIN									
										
		IF @Opc = 1									
		SELECT InCodigo, InTipSOMA FROM BacParamSuda..INSTRUMENTOS_SOMA	where InCodigo = @InCodigo			
											
		IF @Opc = 2									
		SELECT tbcodigo1,tbglosa FROM BacParamSuda..TABLA_GENERAL_DETALLE WHERE TbCateg = 860								
										
		IF @Opc = 3									
		DELETE FROM BacParamSuda..INSTRUMENTOS_SOMA WHERE InCodigo =  @InCodigo								
										
		IF @Opc = 4									
		INSERT INTO BacParamSuda..INSTRUMENTOS_SOMA (InCodigo, InTipSOMA) VALUES (@InCodigo, @InTipSOMA)								
										
		RETURN 0									
										
	END									

GO
