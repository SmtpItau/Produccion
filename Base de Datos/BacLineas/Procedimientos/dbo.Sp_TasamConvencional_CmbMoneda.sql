USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TasamConvencional_CmbMoneda]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_TasamConvencional_CmbMoneda    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_TasamConvencional_CmbMoneda    fecha de la secuencia de comandos: 14/02/2001 09:58:31 ******/
CREATE PROCEDURE [dbo].[Sp_TasamConvencional_CmbMoneda]
 as
 begin
 set nocount on
 select "mnnemo" =convert(char(8),mnnemo),
  mncodmon
  from  MONEDA
 WHERE (mnmx <>'C')
 set nocount off
 end






GO
