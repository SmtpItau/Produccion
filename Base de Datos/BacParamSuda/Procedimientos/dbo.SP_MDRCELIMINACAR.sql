USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDRCELIMINACAR]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MDRCELIMINACAR]
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
