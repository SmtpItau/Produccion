USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESERVAROPERACIONESENVIOBOLSA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RESERVAROPERACIONESENVIOBOLSA]
AS
BEGIN
	update TxOnlineCorredora set Reserva = '*' where EstadoEnvio <> '*'
END
GO
