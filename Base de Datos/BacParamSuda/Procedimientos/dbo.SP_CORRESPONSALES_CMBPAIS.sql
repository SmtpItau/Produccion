USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CORRESPONSALES_CMBPAIS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CORRESPONSALES_CMBPAIS]
 as
BEGIN
 set nocount on
  select nombre ,codigo_pais
        from  PAIS order by nombre
 set nocount off
END
GO
