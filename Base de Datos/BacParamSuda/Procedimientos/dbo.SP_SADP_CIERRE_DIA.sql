USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_CIERRE_DIA]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[SP_SADP_CIERRE_DIA]
AS 
	UPDATE SADP_CONTROL  sET bCierreDia  =1, bInicioDia = 0;
	
GO
