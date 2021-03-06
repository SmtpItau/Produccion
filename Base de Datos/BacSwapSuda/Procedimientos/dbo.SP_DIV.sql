USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DIV]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_DIV]( 
	@num       FLOAT,  
                         @den       FLOAT,
                         @resultado FLOAT = 0.0 OUTPUT )
AS
BEGIN
     IF @den <> 0		
          SELECT @resultado = (@num / (@den * 1.0))  -- por 1.0 para retornar valor con decimales

     ELSE
          SELECT @resultado = 0.0

END -- PROCEDURE

GO
