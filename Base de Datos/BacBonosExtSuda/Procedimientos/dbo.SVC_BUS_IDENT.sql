USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_BUS_IDENT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[SVC_BUS_IDENT] 
(
          @Cod_Nemo char(20)
)
AS 
     select cod_id,
	isnull(sIsin,''),
	isnull(sCusip,''),
	isnull(sBBNumber,''),
	isnull(sMercado,''),
	isnull(sSerie,'')
	from text_ident
	where cod_nemo=@Cod_Nemo


GO
