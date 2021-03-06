USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNA_NEMO]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_RETORNA_NEMO] (@nemo varchar(10),
					                     @fecha char(10))
AS
 SET NOCOUNT ON
	 declare @nemotecnico varchar(15)
	 Declare @ndia as varchar(10)
	 Declare @nmes as varchar(10)
	 Declare @nano as varchar(10)
	
/*
  select *from bacparamsuda..instrumento where inserie in('DPF','DPR')
  select *from bacparamsuda..mascara_instrumento where msfamilia in('DPF','DPR')
  select *from bacparamsuda..NOSERIE 
  select *from bacparamsuda..SERIE
  select *from bacuser.tbl_tickers_bolsa 
*/
Begin

	SELECT @ndia = SUBSTRING(@fecha,7,2)
	SELECT @nmes = SUBSTRING(@fecha,5,2)
	SELECT @nano = SUBSTRING(@fecha,3,2)

 --*********Formatea nemotecnico Pagare R(Reajustable)************--
	if @nemo ='PAGARE R  '
	   begin
        set    @nemotecnico='DPR-'++ @ndia ++ @nmes ++ @nano
        select @nemotecnico  as 'nemotecnico'
	   end
 
 --*********Formatea nemotecnico Pagare NR(No Reajustable)*********--
   if @nemo ='PAGARE NR '
      begin
       set     @nemotecnico='DPF-'++ @ndia ++ @nmes ++ @nano
       select  @nemotecnico  as 'nemotecnico'
	  end
   END  

GO
