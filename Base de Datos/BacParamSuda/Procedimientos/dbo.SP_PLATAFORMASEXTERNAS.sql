USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PLATAFORMASEXTERNAS]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_PLATAFORMASEXTERNAS]
( 
	@BankDealinkCoded varchar(20) = Null
)
AS 
BEGIN 
select 
	SourceBac 
	,BankDealinkCoded    
	,Terminal             
	,System                                             
	,SOfData     
	,CodigoSwifth         
	,PlataformaExterna 
  from bacparamsuda..sinacofi
 Where PlataformaExterna = 1
   and (BankDealinkCoded = @BankDealinkCoded OR @BankDealinkCoded is Null)

END 

GO
