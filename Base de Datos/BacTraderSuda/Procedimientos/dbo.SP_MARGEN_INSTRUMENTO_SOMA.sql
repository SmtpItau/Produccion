USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MARGEN_INSTRUMENTO_SOMA]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MARGEN_INSTRUMENTO_SOMA](@tipo_opsoma char(3),
													@serie char(3)
													) 
as 
begin

--************************************************************************/
--procedimiento TRAE MARGEN PARA INTRUMENTO SOMA						 */
--creado:25-10-2011														 */	
--************************************************************************/
  Declare @codigo_instrumento int

  select @codigo_instrumento = incodigo
  from bacparamsuda..INSTRUMENTO
  where inserie=@serie


  select margen from bacparamsuda..MARGEN_INSTRUMENTO_SOMA
  WHERE  Tipo_OpSoma = @tipo_opsoma 
  and    Codigo_instrumento=@codigo_instrumento



END
GO
