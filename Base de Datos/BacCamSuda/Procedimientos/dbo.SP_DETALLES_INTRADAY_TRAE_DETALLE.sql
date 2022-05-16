USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DETALLES_INTRADAY_TRAE_DETALLE]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_DETALLES_INTRADAY_TRAE_DETALLE]
 ( @numero numeric(7) )
as
begin
set nocount on
 select 
  contabiliza
  ,moentre
  ,morecib
  ,movamos
  ,moticam
  ,observacion
 from MEMO
 where monumope =   @numero
set nocount off
end

GO
