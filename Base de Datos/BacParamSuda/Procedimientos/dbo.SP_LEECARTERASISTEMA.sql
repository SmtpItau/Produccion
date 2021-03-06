USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEECARTERASISTEMA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEECARTERASISTEMA]
       (
        @Id_Sistema CHAR(3)
       )
AS
BEGIN
SET NOCOUNT ON 
 /*=======================================================================*/
   /*=======================================================================*/
   SELECT Distinct
	  rcrut     	,
          rcnombre  		
   FROM   TIPO_CARTERA
   WHERE  rcsistema = @Id_Sistema 
   ORDER BY rcrut
   /*=======================================================================*/
   /*=======================================================================*/
   
SET NOCOUNT OFF
END

GO
