USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RTECNICA_DESMARCA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RTECNICA_DESMARCA]
AS
BEGIN
 SET NOCOUNT ON
 --borro asignaciones anteriores
 UPDATE mdcp
 SET  cpreserva_tecnica = ''
 
 SET NOCOUNT OFF
END

GO
