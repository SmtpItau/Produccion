USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_ObtieneValoresDefecto]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_ObtieneValoresDefecto]

@moneda as varchar(10),
@producto as varchar(10)

as

select * from valoresdefecto where moneda = @moneda and producto = @producto

GO
