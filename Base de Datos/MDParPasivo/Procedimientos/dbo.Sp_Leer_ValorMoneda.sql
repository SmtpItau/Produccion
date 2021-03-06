USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_ValorMoneda]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Sp_Leer_ValorMoneda]( @codmon  integer ,
                                      @fecha   char(8) ,
                                      @len     integer = 8)
AS   
BEGIN
    


   	SET DATEFORMAT DMY
	SET NOCOUNT ON

     SELECT vmcodigo,vmvalor,CONVERT(CHAR(10),vmfecha,103)
       FROM VALOR_MONEDA
      WHERE (vmcodigo = @codmon OR @codmon = 0)
        AND SUBSTRING(CONVERT(CHAR(8),vmfecha,112),1,@Len) = SUBSTRING(@fecha,1,@len)
      ORDER BY vmcodigo,vmfecha

END





GO
