USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_LIMITE_TASA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABA_LIMITE_TASA]
    (
    @tipo  CHAR (03) ,
    @moneda  NUMERIC (03) ,
    @Tasa_inferior NUMERIC (19,4) ,
    @Tasa_superior NUMERIC (19,4)
    )
AS
BEGIN
 
 SET NOCOUNT ON
 
 UPDATE limites_tasas
 SET Tasa_inf = @tasa_inferior ,
  Tasa_sup = @tasa_superior
 WHERE operacion=@tipo AND moneda=@moneda
 SELECT 'OK'
 SET NOCOUNT OFF 
END
GO
