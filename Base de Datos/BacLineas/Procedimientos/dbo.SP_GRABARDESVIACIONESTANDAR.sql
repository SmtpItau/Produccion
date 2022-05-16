USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARDESVIACIONESTANDAR]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABARDESVIACIONESTANDAR] ( @ndesviacionestandar NUMERIC ( 9,3 ) )
AS
BEGIN
   SET NOCOUNT ON
   UPDATE VIEW_MFAC
   SET     acdesviacionestandar = @ndesviacionestandar
   SET NOCOUNT OFF
END
----SELECT * FROM VIEW_MFAC
---SP_GRABARDESVIACIONESTANDAR 625551.6
--- sp_help VIEW_MFAC
GO
