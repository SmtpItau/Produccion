USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SRV_Verifica_Fixing_Pendientes]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SRV_Verifica_Fixing_Pendientes]
AS
BEGIN

    SET NOCOUNT ON

    SELECT cf.*
      INTO #tmpPaso 
      FROM OpcionesGeneral og
           INNER JOIN CaFixing cf  ON CaFixFecha  = fechaproc
                                  AND CaFixEstado <> 'F'

    IF @@ROWCOUNT = 0
    BEGIN
    	SELECT 'STATUS' = 'OK'

    END ELSE
    BEGIN
    	SELECT 'STATUS' = 'FALTA QUE SE REALICE LA FIJACION DE ALGUNAS OPERACIONES'  

    END

    DROP TABLE #tmpPaso
    SET NOCOUNT OFF

END
GO
