USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_DATOS_BANCO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEE_DATOS_BANCO]
AS
BEGIN
   SET NOCOUNT ON
  -- SELECT acrutprop,acdigprop,acnomprop, acdirprop  FROM  mfac
     SELECT
  'cRut'    = clrut,
  'cDig'    = cldv,
  'cNombre' =clnombre,
  'cDirecc' =cldirecc,
  'cTelefo' =clfono ,
  'cFax'    =clfax
 from view_cliente 
 where clrut=97018000
   SET NOCOUNT OFF
END

GO
