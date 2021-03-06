USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_ValorMoneda]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_Leer_ValorMoneda    fecha de la secuencia de comandos: 03/04/2001 15:18:07 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Leer_ValorMoneda    fecha de la secuencia de comandos: 14/02/2001 09:58:28 ******/
CREATE PROCEDURE [dbo].[Sp_Leer_ValorMoneda]( @codmon  integer ,
                                      @fecha   char(8) ,
                                      @len     integer = 8)
AS   
BEGIN
    
     SELECT vmcodigo,vmvalor,CONVERT(CHAR(10),vmfecha,103)
       FROM VALOR_MONEDA
      WHERE (vmcodigo = @codmon OR @codmon = 0)
        AND SUBSTRING(CONVERT(CHAR(8),vmfecha,112),1,@Len) = SUBSTRING(@fecha,1,@len)
      ORDER BY vmcodigo,vmfecha
END






GO
