USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_ATRIBUTO_CONTABLE]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_CON_ATRIBUTO_CONTABLE]
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy

   SELECT Campo_Atributo
        , Descripcion
        , Orden
        , Largo
        , Tabla_Relacion
        , Descripcion_Tabla
        , Campo_Consulta
        , estado
     FROM ATRIBUTO_CONTABLE
    WHERE Campo_Atributo <> 'N/C'
    ORDER BY Orden   



   SET NOCOUNT OFF

END

GO
