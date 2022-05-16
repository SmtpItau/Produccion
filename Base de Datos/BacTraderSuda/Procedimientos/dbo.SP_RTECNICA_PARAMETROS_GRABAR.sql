USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RTECNICA_PARAMETROS_GRABAR]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RTECNICA_PARAMETROS_GRABAR] ( @codigo INTEGER, @monto NUMERIC )
AS
BEGIN
 SET NOCOUNT ON
 UPDATE  tbtr_pra_rsv_tcn
 SET monto = @monto 
 WHERE  codigo = @codigo
 SET NOCOUNT OFF
END


GO
