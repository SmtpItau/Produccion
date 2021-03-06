USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_PERIODO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_PERIODO]( 
                                  @Codigo   NUMERIC(9) = 0 ,
                                  @Sistema     CHAR(3) = '' )
AS
BEGIN

     SET NOCOUNT ON

     SELECT codigo  ,
            glosa   ,
            dias    ,
            meses
	FROM VIEW_PERIODO_AMORTIZACION  
      WHERE (    ( tabla   = @Codigo and tabla   <> 1043   OR @Codigo  =  0 )  
              OR ( tabla   = 1043 and tabla = @codigo and codigo in (5,6) )) 
              AND (sistema = @Sistema OR @Sistema = '')  
      ORDER BY codigo

      SET NOCOUNT OFF	
END
GO
