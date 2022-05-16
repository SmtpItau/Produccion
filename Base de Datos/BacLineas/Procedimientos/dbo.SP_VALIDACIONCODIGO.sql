USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDACIONCODIGO]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_VALIDACIONCODIGO]
                 (
                 @clrut  NUMERIC(9) = 0
                 )
AS   
BEGIN

 SELECT clcodigo
   FROM VIEW_CLIENTE
  WHERE clrut = @clrut
 
END 
GO
