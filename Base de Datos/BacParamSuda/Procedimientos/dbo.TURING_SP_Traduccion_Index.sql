USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[TURING_SP_Traduccion_Index]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TURING_SP_Traduccion_Index] (	 
	@TagXMLIndex [VarChar](50) ,
	@TagXMLIndexPeriod [VarChar](20) 
					)
AS
BEGIN 
    declare @Esta varchar(1)
	declare @IndexBAC   numeric(5)
    set nocount on
    select  @Esta = 'N'
    select  @IndexBAC = -1
    select  @IndexBAC = IndexBAC  from BacParamSuda..TURING_MATRIZ_INDEX
    where  TagXMLIndex = @TagXMLIndex
       and TagXMLIndexPeriod = @TagXMLIndexPeriod
    select IndexBAC = @IndexBAC
END

/* TURING_SP_Traduccion_Index 'LIBOR USD', '1M' */
GO
