USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAECLASIFICACIONRIESGO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAECLASIFICACIONRIESGO]
AS
BEGIN

   SET NOCOUNT ON

   SELECT tbcodigo1, tbvalor
   FROM   Bacparamsuda.dbo.TABLA_GENERAL_DETALLE with(nolock)
   WHERE  tbcateg = 103
   ORDER BY tbvalor ASC

END
GO
