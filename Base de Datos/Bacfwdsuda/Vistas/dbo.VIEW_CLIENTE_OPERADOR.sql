USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_CLIENTE_OPERADOR]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

----------------------------------------------------------- * ---------------------------------------------------------------
CREATE VIEW [dbo].[VIEW_CLIENTE_OPERADOR]
AS
   SELECT
         oprutcli ,
         opcodcli ,
         oprutope ,
         opdvope ,
         opnombre
   FROM BACPARAMSUDA..CLIENTE_OPERADOR

GO
