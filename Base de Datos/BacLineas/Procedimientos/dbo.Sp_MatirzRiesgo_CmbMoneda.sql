USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MatirzRiesgo_CmbMoneda]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_MatirzRiesgo_CmbMoneda]
as
begin
 set nocount on
 select "mnnemo" =convert(char(8),mnnemo),
  mncodmon
 from MONEDA
 WHERE (mnmx ='C')
 set nocount off
end






GO
