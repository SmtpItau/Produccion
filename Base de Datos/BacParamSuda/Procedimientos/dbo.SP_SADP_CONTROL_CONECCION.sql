USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_CONTROL_CONECCION]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_CONTROL_CONECCION]
AS
	SELECT bConeccionListener FROM bacparamsuda.dbo.SADP_CONTROL sc;
GO
