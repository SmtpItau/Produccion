USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FLUJOINTERBANCARIOS_PROCESO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FLUJOINTERBANCARIOS_PROCESO] 
            (
            @rut_cliente      NUMERIC(9),
            @codigo_producto  CHAR(5),
            @fecha_desde      DATETIME,
            @fecha_hasta      DATETIME
            )
AS
BEGIN
      
      SET NOCOUNT ON
      SELECT 
              'mofecpro'  = ( SELECT MAX(m.mofecpro) )
             ,'monominal' = ( SELECT SUM(m.monominal))
             ,'mofecven'  = ( SELECT DISTINCT MAX(m.mofecven))              
      FROM MDMH m
      WHERE m.morutcli  = @rut_cliente
      AND m.moinstser   = @codigo_producto
      AND m.mofecpro   >= @fecha_desde
      AND m.mofecpro   <= @fecha_hasta
      AND m.motipoper  = 'IB'
      SET NOCOUNT OFF
END 


GO
