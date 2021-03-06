USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUNCION_MXRECPSMX]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FUNCION_MXRECPSMX] 
AS
BEGIN
declare  @aux_mncodmon  numeric(5)
declare  @aux_mnnemo    char(8) 
declare MxRecPsMx_cursor cursor for   --sp_help  VIEW_MONEDA 
      Select mncodmon
            ,mnnemo
      from   VIEW_MONEDA
      open MxRecPsMx_cursor
      fetch MxRecPsMx_cursor
      into  @aux_mncodmon
    ,@aux_mnnemo
      while (@@fetch_status = 0)
      Begin
          execute sp_funcion_RecalPosMon  @aux_mncodmon,@aux_mnnemo
           
      fetch MxRecPsMx_cursor
      into  @aux_mncodmon
    ,@aux_mnnemo
      End  --while
      Close MxRecPsMx_cursor
      Deallocate MxRecPsMx_cursor
End

GO
