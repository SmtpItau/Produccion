USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDPELeer]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[Sp_MDPELeer]
AS
BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy

   SELECT pecodigo, peperiodo, penumero, petipo, peglosa FROM PERIODO_TASA_BIDASK
SET NOCOUNT OFF
END





GO
