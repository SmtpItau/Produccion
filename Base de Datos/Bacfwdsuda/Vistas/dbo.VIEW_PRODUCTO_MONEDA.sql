USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_PRODUCTO_MONEDA]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_PRODUCTO_MONEDA]
AS
 SELECT mpsistema ,
  mpproducto , 
  mpcodigo , 
  mpestado , 
  mptipoper , 
  mpmoneda
   FROM BACPARAMSUDA..PRODUCTO_MONEDA

GO
