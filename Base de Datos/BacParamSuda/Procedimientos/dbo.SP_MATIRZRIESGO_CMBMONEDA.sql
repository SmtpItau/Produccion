USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MATIRZRIESGO_CMBMONEDA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MATIRZRIESGO_CMBMONEDA]
as
begin
 set nocount on
 select 'mnnemo' =convert(char(8),mnnemo),
  mncodmon
 from MONEDA
 WHERE (mnmx ='C')
 set nocount off
end

GO
