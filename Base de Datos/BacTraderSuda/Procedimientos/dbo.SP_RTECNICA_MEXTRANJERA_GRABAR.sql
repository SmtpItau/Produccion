USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RTECNICA_MEXTRANJERA_GRABAR]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RTECNICA_MEXTRANJERA_GRABAR]
( @codigo INTEGER, @monto1 NUMERIC, @monto2 NUMERIC )
AS
BEGIN
 SET NOCOUNT ON 
 UPDATE  tbtr_mnl_me
 SET  monto_exigible = @monto1,
  monto_ocupado  = @monto2
 WHERE  codigo = @codigo
 SET NOCOUNT OFF
END


GO
