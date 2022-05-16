USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTAERROR]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONTAERROR]
    (
    @dFecha DATETIME
    )
AS
BEGIN
 SELECT mensaje
 FROM BAC_CNT_ERRORES
 WHERE fecha_proceso=@dFecha
END


GO
