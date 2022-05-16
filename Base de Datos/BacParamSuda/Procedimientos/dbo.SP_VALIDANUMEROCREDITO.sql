USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDANUMEROCREDITO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_VALIDANUMEROCREDITO]( @nrocredito numeric )
as
Begin
	select 1 existe from creditos_ibs
	where Numero_Credito = @nrocredito
End 
GO
