USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_SISTAMA_CNT]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEER_SISTAMA_CNT]
AS BEGIN
 
SET NOCOUNT ON
 SELECT id_sistema, 
        nombre_sistema,
               operativo FROM VIEW_SISTEMA_CNT 
  WHERE operativo='S' AND gestion ='N'
  ORDER BY nombre_sistema
SET NOCOUNT OFF
END


GO
