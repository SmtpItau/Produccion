USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDRCEliminaCar]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_MDRCEliminaCar]
       ( 
        @ncodpro    CHAR(5),
        @Id_Sistema CHAR(3),
        @ncodigo    CHAR(5)
       )
AS
BEGIN      
SET NOCOUNT ON 
SET DATEFORMAT dmy
   DELETE FROM TIPO_CARTERA WHERE Id_Sistema = @Id_Sistema AND Codigo_producto = @ncodpro 
SET NOCOUNT OFF
SELECT 0
END

GO
