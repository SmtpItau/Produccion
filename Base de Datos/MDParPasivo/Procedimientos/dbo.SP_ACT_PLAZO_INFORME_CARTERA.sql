USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_PLAZO_INFORME_CARTERA]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_ACT_PLAZO_INFORME_CARTERA](@ndesde Numeric(5),
                                             @nHasta Numeric(5),
                                             @cTipo  CHAR(1),
                                             @indice NUMERIC(5))
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


        IF @indice = 2 BEGIN
            DELETE PLAZO_INFORME_CARTERA
        END

        INSERT PLAZO_INFORME_CARTERA(plazo_desde,plazo_hasta,tipo_plazo)
        VALUES(@ndesde,@nhasta,@ctipo)
    
END




GO
