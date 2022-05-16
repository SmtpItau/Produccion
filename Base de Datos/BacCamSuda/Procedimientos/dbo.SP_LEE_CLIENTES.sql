USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_CLIENTES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEE_CLIENTES]
AS
BEGIN
    SET NOCOUNT ON
 select  
  'Rut Cliente' = clrut,
  'Cod Cliente' = clcodigo,
  'Nombre Clie' = clnombre
  
   from VIEW_CLIENTE
    SET NOCOUNT OFF
END




GO
