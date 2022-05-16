USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDRCEliminaCar]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_MDRCEliminaCar]
       ( 
        @ncodpro    CHAR(5),
        @Id_Sistema CHAR(3),
        @ncodigo    NUMERIC ( 9, 0 )
       )
AS
BEGIN      
SET NOCOUNT ON 
  /*=======================================================================*/
   /*=======================================================================*/
   DELETE FROM TIPO_CARTERA WHERE rcsistema = @Id_Sistema AND rccodpro =  @ncodpro AND rcrut = @ncodigo
   /*=======================================================================*/
   /*=======================================================================*/
SET NOCOUNT OFF
SELECT 0
END






GO
