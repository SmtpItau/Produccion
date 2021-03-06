USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_PERIODO]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Leer_Periodo    fecha de la secuencia de comandos: 03/04/2001 15:18:07 ******/
CREATE PROCEDURE [dbo].[SP_LEER_PERIODO]( @Codigo   NUMERIC(9) = 0 ,
                                  @Sistema     CHAR(3) = '' )
AS
BEGIN
     SET NOCOUNT ON
     SELECT codigo  ,
            glosa   ,
            dias    ,
            meses
       FROM PERIODO_AMORTIZACION
      WHERE (tabla   = @Codigo  OR @Codigo  =  0)
        AND (sistema = @Sistema OR @Sistema = '')
      ORDER BY codigo
      SET NOCOUNT OFF 
END

GO
