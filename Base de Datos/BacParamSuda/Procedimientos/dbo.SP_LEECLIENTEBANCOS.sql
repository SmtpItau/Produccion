USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEECLIENTEBANCOS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEECLIENTEBANCOS]
AS
BEGIN

   SELECT clrut
   ,      cldv
   ,      clcodigo
   ,      clnombre
   ,      clgeneric
   ,      cldirecc
   ,      clcomuna
   ,      clregion
   ,      clcompint
   ,      cltipcli
   ,      clfecingr
   ,      clctacte
   ,      clfono
   ,      clfax
   ,      mxcontab
   ,      clpais
   ,      clciudad
   ,      clswift
   FROM   CLIENTE
   WHERE cltipcli  = 1 AND clvigente = 'S'
   ORDER BY clnombre

END

GO
