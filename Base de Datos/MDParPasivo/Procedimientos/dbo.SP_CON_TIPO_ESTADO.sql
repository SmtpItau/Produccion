USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_TIPO_ESTADO]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CON_TIPO_ESTADO]
AS
BEGIN    

    CREATE TABLE #TEMPORAL( CARACTER CHAR(40) )



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

    INSERT #TEMPORAL VALUES('A;Anulado'        )
    INSERT #TEMPORAL VALUES('B;Control Backoffice')
    INSERT #TEMPORAL VALUES('N;Normal'         )
    INSERT #TEMPORAL VALUES('S;Seleccionado'   )
    INSERT #TEMPORAL VALUES('P;Pendiente'      )
    INSERT #TEMPORAL VALUES('E;Emitido'        )
    INSERT #TEMPORAL VALUES('F;Entrega Fisica' )
    INSERT #TEMPORAL VALUES('R;Rechazado'      )
    INSERT #TEMPORAL VALUES('G;Generado'       )
    INSERT #TEMPORAL VALUES('C;Calzada'        )


    SET NOCOUNT OFF

    SELECT * FROM #TEMPORAL

END



GO
