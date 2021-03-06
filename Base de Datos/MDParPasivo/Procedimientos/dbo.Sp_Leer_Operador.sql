USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_Operador]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Sp_Leer_Operador]( @Codigo  NUMERIC(9) = 0 ,
                                   @RutCli  NUMERIC(9) = 0 ,
                                   @CodCli  NUMERIC(9) = 0 )
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

     SELECT oprutcli   ,
            opcodcli   ,
            oprutope   ,   -- Codigo o Rut del Operador
            opdvope    ,
            opnombre
          
       FROM CLIENTE_OPERADOR

      WHERE (oprutope = @Codigo OR @Codigo = 0)
        AND (oprutcli = @RutCli OR @RutCli = 0)
        AND (opcodcli = @CodCli OR @CodCli = 0)
END



GO
