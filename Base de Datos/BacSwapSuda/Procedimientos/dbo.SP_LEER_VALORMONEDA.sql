USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_VALORMONEDA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_VALORMONEDA]
   (   @CodMon  INTEGER 
   ,   @Fecha   CHAR(8) 
   ,   @Len     INTEGER = 8
   )
AS   
BEGIN

   SET NOCOUNT ON

   SELECT vmcodigo
   ,      vmvalor
   ,      CONVERT(CHAR(10),vmfecha,103)
   FROM   BacParamSuda..VALOR_MONEDA
   WHERE (vmcodigo = @CodMon OR @CodMon = 0)
   AND    SUBSTRING(CONVERT(CHAR(8),vmfecha,112),1,@Len) = SUBSTRING(@Fecha,1,@Len)
   ORDER BY vmcodigo , vmfecha

END

GO
