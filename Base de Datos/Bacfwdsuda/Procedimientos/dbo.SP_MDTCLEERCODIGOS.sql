USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDTCLEERCODIGOS]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDTCLEERCODIGOS]
               (
                 @ncodtab NUMERIC ( 03 )
               )
AS
BEGIN
   SET NOCOUNT ON
   SELECT   codigo_producto,
            descripcion
   FROM     view_producto
   WHERE    id_sistema = 'BFW'
   ORDER BY codigo_producto
   
SET NOCOUNT OFF
END

GO
