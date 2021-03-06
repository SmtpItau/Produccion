USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_OPERADOR]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_OPERADOR]( @Codigo  NUMERIC(9) = 0 ,  
                                   @RutCli  NUMERIC(9) = 0 ,
                                   @CodCli  NUMERIC(9) = 0 )
AS
BEGIN

     SET NOCOUNT ON	
     SELECT oprutcli   ,
            opcodcli   ,
            oprutope   ,   -- Codigo o Rut del Operador
            opdvope    ,
            opnombre
          
       FROM View_Cliente_Operador

      WHERE (oprutope = @Codigo OR @Codigo = 0)
        AND (oprutcli = @RutCli OR @RutCli = 0)
        AND (opcodcli = @CodCli OR @CodCli = 0)
     SET NOCOUNT OFF	
END
GO
