USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_1]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_1]  (
   @fecha char(10),
   @cod   numeric
   )
AS
BEGIN
set nocount on
 SELECT vmvalor 
 FROM VIEW_VALOR_MONEDA 
 WHERE vmcodigo = @cod AND
         convert(char(08),vmfecha,103) = convert(char(08),@fecha,103)
set nocount off
END

GO
